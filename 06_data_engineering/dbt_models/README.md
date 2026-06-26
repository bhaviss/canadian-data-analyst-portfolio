# dbt Project — Canadian Analytics Engineering
## Project 16 | Target Role: Analytics Engineer | Data Engineer (Canada)
## Tools: dbt Core, Snowflake/PostgreSQL, Git

---

## PROJECT STRUCTURE

```
models/
├── staging/
│   ├── stg_sales.sql
│   ├── stg_customers.sql
│   ├── stg_products.sql
│   └── stg_stores.sql
├── intermediate/
│   ├── int_customer_orders.sql
│   ├── int_product_revenue.sql
│   └── int_store_performance.sql
├── marts/
│   ├── finance/
│   │   ├── fct_revenue.sql
│   │   ├── fct_orders.sql
│   │   └── dim_date.sql
│   └── customers/
│       ├── dim_customers_scd2.sql
│       └── fct_customer_activity.sql
tests/
├── generic/
└── singular/
    ├── test_revenue_positive.sql
    └── test_province_codes_valid.sql
```

---

## STAGING MODELS

### stg_sales.sql
```sql
-- models/staging/stg_sales.sql
{{ config(materialized='view') }}

SELECT
    transaction_id::VARCHAR AS sale_id,
    customer_id::VARCHAR AS customer_id,
    product_id::VARCHAR AS product_id,
    store_id::VARCHAR AS store_id,
    transaction_date::DATE AS sale_date,
    quantity::INTEGER AS quantity,
    unit_price::DECIMAL(10,2) AS unit_price,
    discount_pct::DECIMAL(5,4) AS discount_pct,
    quantity * unit_price * (1 - discount_pct) AS net_revenue,
    -- Audit columns
    CURRENT_TIMESTAMP AS _loaded_at,
    '{{ run_started_at }}' AS _run_at
FROM {{ source('raw', 'sales') }}
WHERE transaction_date IS NOT NULL
  AND quantity > 0
  AND unit_price > 0
```

### stg_customers.sql
```sql
-- models/staging/stg_customers.sql
{{ config(materialized='view') }}

SELECT
    customer_id::VARCHAR AS customer_id,
    INITCAP(first_name) AS first_name,
    INITCAP(last_name) AS last_name,
    LOWER(email) AS email,
    UPPER(province_code) AS province_code,
    postal_code,
    -- Validate Canadian postal code format: A1A 1A1
    REGEXP_LIKE(postal_code, '^[A-Z][0-9][A-Z] [0-9][A-Z][0-9]$') AS is_valid_postal,
    registration_date::DATE AS registration_date,
    CURRENT_TIMESTAMP AS _loaded_at
FROM {{ source('raw', 'customers') }}
WHERE customer_id IS NOT NULL
```

---

## INTERMEDIATE MODELS

### int_customer_orders.sql
```sql
-- models/intermediate/int_customer_orders.sql
{{ config(materialized='table') }}

WITH customer_orders AS (
      SELECT
          s.customer_id,
          COUNT(DISTINCT s.sale_id) AS total_orders,
          SUM(s.net_revenue) AS total_revenue,
          AVG(s.net_revenue) AS avg_order_value,
          MIN(s.sale_date) AS first_order_date,
          MAX(s.sale_date) AS last_order_date,
          COUNT(DISTINCT s.sale_date) AS active_days,
          DATEDIFF('day', MIN(s.sale_date), MAX(s.sale_date)) AS customer_lifespan_days
      FROM {{ ref('stg_sales') }} s
      GROUP BY s.customer_id
  )
SELECT
    co.*,
    c.province_code,
    c.registration_date,
    -- RFM components
    CURRENT_DATE - co.last_order_date AS recency_days,
    co.total_orders AS frequency,
    co.total_revenue AS monetary_value,
    -- CLV estimate (24-month horizon)
    co.avg_order_value * 
        (co.total_orders / NULLIF(co.customer_lifespan_days, 0) * 30) * 24 AS est_clv_24mo
FROM customer_orders co
LEFT JOIN {{ ref('stg_customers') }} c ON co.customer_id = c.customer_id
```

---

## MART MODELS

### fct_revenue.sql (Finance Mart)
```sql
-- models/marts/finance/fct_revenue.sql
{{ config(
      materialized='incremental',
      unique_key='sale_id',
      on_schema_change='fail'
  ) }}

SELECT
    s.sale_id,
    s.customer_id,
    s.product_id,
    s.store_id,
    s.sale_date,
    d.year,
    d.quarter,
    d.month,
    d.week_of_year,
    d.is_weekend,
    d.is_canadian_holiday,
    p.category,
    p.subcategory,
    st.province_code,
    st.city,
    s.quantity,
    s.unit_price,
    s.discount_pct,
    s.net_revenue,
    s.net_revenue - (s.quantity * p.cost_price) AS gross_profit,
    (s.net_revenue - (s.quantity * p.cost_price)) / NULLIF(s.net_revenue, 0) AS margin_pct
FROM {{ ref('stg_sales') }} s
LEFT JOIN {{ ref('dim_date') }} d ON s.sale_date = d.date_day
LEFT JOIN {{ ref('stg_products') }} p ON s.product_id = p.product_id
LEFT JOIN {{ ref('stg_stores') }} st ON s.store_id = st.store_id

{% if is_incremental() %}
WHERE s.sale_date > (SELECT MAX(sale_date) FROM {{ this }})
{% endif %}
```

### dim_customers_scd2.sql (SCD Type 2)
```sql
-- models/marts/customers/dim_customers_scd2.sql
-- Slowly Changing Dimension Type 2: track historical changes
{{ config(materialized='table') }}

WITH source AS (
      SELECT * FROM {{ ref('stg_customers') }}
  ),
final AS (
      SELECT
          {{ dbt_utils.surrogate_key(['customer_id', 'province_code']) }} AS customer_key,
          customer_id,
          first_name,
          last_name,
          email,
          province_code,
          postal_code,
          registration_date,
          TRUE AS is_current,
          registration_date AS valid_from,
          '9999-12-31'::DATE AS valid_to
      FROM source
  )
SELECT * FROM final
```

---

## DATA QUALITY TESTS

### schema.yml
```yaml
version: 2

models:
  - name: stg_sales
    description: "Cleaned sales transactions from raw source"
    columns:
      - name: sale_id
        tests:
          - unique
          - not_null
      - name: net_revenue
        tests:
          - not_null
          - dbt_utils.accepted_range:
              min_value: 0
      - name: sale_date
        tests:
          - not_null

  - name: fct_revenue
    description: "Revenue fact table for finance mart"
    columns:
      - name: sale_id
        tests:
          - unique
          - not_null
      - name: province_code
        tests:
          - accepted_values:
              values: ['ON', 'QC', 'BC', 'AB', 'MB', 'SK', 'NS', 'NB', 'NL', 'PE', 'YT', 'NT', 'NU']
      - name: margin_pct
        tests:
          - dbt_utils.accepted_range:
              min_value: -1
              max_value: 1
```

---

## RUNNING THE PROJECT

```bash
# Install dbt
pip install dbt-postgres  # or dbt-snowflake, dbt-bigquery

# Configure profiles.yml
dbt init canadian_analytics

# Run all models
dbt run

# Test data quality
dbt test

# Generate documentation
dbt docs generate
dbt docs serve

# Run specific model + dependencies
dbt run --select +fct_revenue

# Incremental refresh
dbt run --select fct_revenue --full-refresh
```

---
*Portfolio: github.com/bhaviss/canadian-data-analyst-portfolio*
