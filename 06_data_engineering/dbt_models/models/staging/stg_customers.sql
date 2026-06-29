-- ==========================================================
-- models/staging/stg_customers.sql
-- Staging model: clean and standardize raw customer records
-- Materialization: view
-- ==========================================================
{{ config(materialized='view') }}

WITH source AS (
    SELECT * FROM {{ source('raw', 'customers') }}
),

cleaned AS (
    SELECT
        -- Keys
        customer_id::VARCHAR                             AS customer_id,

        -- Name standardization (INITCAP handles inconsistent casing)
        INITCAP(first_name)                              AS first_name,
        INITCAP(last_name)                               AS last_name,
        INITCAP(first_name) || ' ' || INITCAP(last_name) AS full_name,

        -- Contact
        LOWER(email)                                     AS email,

        -- Location
        UPPER(province_code)                             AS province_code,
        UPPER(REPLACE(postal_code, ' ', ''))             AS postal_code_raw,
        -- Reformat to standard Canadian format: A1A 1A1
        UPPER(LEFT(postal_code, 3)) || ' '
            || UPPER(RIGHT(postal_code, 3))              AS postal_code_formatted,
        -- Validate Canadian postal code format: A1A 1A1
        (postal_code ~ '^[A-Za-z][0-9][A-Za-z][ ]?[0-9][A-Za-z][0-9]$')
                                                         AS is_valid_postal,

        -- Dates
        registration_date::DATE                          AS registration_date,

        -- Loyalty
        COALESCE(loyalty_tier, 'Standard')               AS loyalty_tier,

        -- Audit
        CURRENT_TIMESTAMP                                AS _loaded_at

    FROM source

    WHERE customer_id IS NOT NULL
      AND email IS NOT NULL
)

SELECT * FROM cleaned
