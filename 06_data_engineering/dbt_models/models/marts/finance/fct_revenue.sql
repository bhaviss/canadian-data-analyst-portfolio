-- ==========================================================
-- models/marts/finance/fct_revenue.sql
-- Finance fact table — grain: one row per sale transaction
-- Materialization: incremental (only loads new rows each run)
-- ==========================================================
{{
    config(
        materialized = 'incremental',
        unique_key   = 'sale_id',
        on_schema_change = 'fail'
    )
}}

WITH sales AS (
    SELECT * FROM {{ ref('stg_sales') }}
    {% if is_incremental() %}
        -- Only load rows newer than what's already in the table
        WHERE sale_date > (SELECT MAX(sale_date) FROM {{ this }})
    {% endif %}
),

products AS (
    SELECT * FROM {{ source('raw', 'products') }}
),

stores AS (
    SELECT * FROM {{ source('raw', 'stores') }}
),

provinces AS (
    SELECT * FROM {{ source('raw', 'provinces') }}
),

final AS (

    SELECT
        -- Keys
        s.sale_id,
        s.customer_id,
        s.product_id,
        s.store_id,

        -- Date dimensions
        s.sale_date,
        EXTRACT(YEAR  FROM s.sale_date)::INT              AS year,
        EXTRACT(QUARTER FROM s.sale_date)::INT            AS quarter,
        EXTRACT(MONTH FROM s.sale_date)::INT              AS month,
        TO_CHAR(s.sale_date, 'IYYY-IW')                  AS iso_week,
        EXTRACT(DOW FROM s.sale_date)::INT                AS day_of_week,
        (EXTRACT(DOW FROM s.sale_date) IN (0, 6))         AS is_weekend,

        -- Product dimensions
        p.product_name,
        p.category,
        p.subcategory,
        p.sku,

        -- Location dimensions
        st.store_name,
        st.city,
        st.store_type,
        pr.province_code,
        pr.province_name,
        pr.region,

        -- Financial measures
        s.quantity,
        s.unit_price,
        s.discount_pct,
        s.gross_revenue,
        s.net_revenue,

        -- Cost & profit (requires cost in products table)
        ROUND(s.quantity * p.unit_cost, 2)                AS total_cost,
        ROUND(s.net_revenue - (s.quantity * p.unit_cost), 2)
                                                          AS gross_profit,
        ROUND(
            (s.net_revenue - (s.quantity * p.unit_cost))
            / NULLIF(s.net_revenue, 0),
            4
        )                                                 AS margin_pct,

        -- Audit
        s._loaded_at

    FROM sales s
    LEFT JOIN products  p  ON s.product_id = p.product_id::VARCHAR
    LEFT JOIN stores    st ON s.store_id   = st.store_id::VARCHAR
    LEFT JOIN provinces pr ON st.province_code = pr.province_code

)

SELECT * FROM final
