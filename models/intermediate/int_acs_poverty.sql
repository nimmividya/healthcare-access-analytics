{{ config(
    materialized='table'
) }}

SELECT
    STATE_FIPS,
    STATE_NAME,
    TOTAL_POPULATION,
    PCT_BELOW_POVERTY,

    TOTAL_POPULATION * PCT_BELOW_POVERTY / 100
        AS ESTIMATED_POPULATION_BELOW_POVERTY

FROM {{ ref('stg_acs_poverty') }}