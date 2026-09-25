{{ config(
    materialized='view'
) }}

select
    STATE_FIPS,
    STATE_NAME,
    TOTAL_POPULATION,

    PCT_INSURED,
    PCT_UNINSURED,

    ROUND(
        TOTAL_POPULATION * PCT_UNINSURED / 100,
        0
    ) AS UNINSURED_POPULATION

from {{ ref('stg_acs_health_insurance') }}