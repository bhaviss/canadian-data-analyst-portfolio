-- ==========================================================
-- models/staging/stg_sales.sql
-- Staging model: clean and standardize raw sales transactions
-- Materialization: view (cheap to rebuild, used upstream)
-- ==========================================================
{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('raw', 'sales') }}
),

cleaned AS (
    SELECT
        -- Keys
        transaction_id::VARCHAR                          AS sale_id,
        customer_id::VARCHAR                             AS customer_id,
        product_id::VARCHAR                              AS product_id,
        store_id::VARCHAR                                AS store_id,

        -- Dates
        transaction_date::DATE                           AS sale_date,

        -- Measures
        quantity::INTEGER                                AS quantity,
        unit_price::DECIMAL(10, 2)                       AS unit_price,
        COALESCE(discount_pct, 0)::DECIMAL(5, 4)        AS discount_pct,

        -- Derived revenue (net of discount)
        ROUND(
            quantity * unit_price * (1 - COALESCE(discount_pct, 0)),
            2
        )                                                AS net_revenue,

        -- Gross revenue (before discount)
        ROUND(quantity * unit_price, 2)                  AS gross_revenue,

        -- Audit columns
        CURRENT_TIMESTAMP                                AS _loaded_at,
        '{{ run_started_at }}'                           AS _dbt_run_at

    FROM source

    -- Data quality filters
    WHERE transaction_date IS NOT NULL
      AND quantity > 0
      AND unit_price > 0
      AND customer_id IS NOT NULL
)

SELECT * FROM cleaned
