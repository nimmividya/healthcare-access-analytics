{{ config(
    materialized='table'
) }}

SELECT
    ROW_NUMBER() OVER (ORDER BY STATE_FIPS) AS STATE_KEY,
    STATE_FIPS,
    STATE_NAME,
    STATE_ABBREV

FROM {{ ref('state_reference') }}