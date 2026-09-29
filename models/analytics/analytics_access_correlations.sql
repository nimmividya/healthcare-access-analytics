{{ config(
    materialized='view'
) }}

WITH source_data AS (

    SELECT
        STATE_NAME,
        PHYSICIANS_PER_100K,
        HPSA_DESIGNATIONS_PER_100K,
        PCT_UNINSURED,
        PCT_BELOW_POVERTY

    FROM {{ ref('analytics_access_relationships') }}

),

correlations AS (

    SELECT
        'Poverty vs Uninsured Rate' AS RELATIONSHIP,
        CORR(
            PCT_BELOW_POVERTY,
            PCT_UNINSURED
        ) AS CORRELATION,
        COUNT_IF(
            PCT_BELOW_POVERTY IS NOT NULL
            AND PCT_UNINSURED IS NOT NULL
        ) AS OBSERVATION_COUNT

    FROM source_data

    UNION ALL

    SELECT
        'Physician Density vs HPSA Density' AS RELATIONSHIP,
        CORR(
            PHYSICIANS_PER_100K,
            HPSA_DESIGNATIONS_PER_100K
        ) AS CORRELATION,
        COUNT_IF(
            PHYSICIANS_PER_100K IS NOT NULL
            AND HPSA_DESIGNATIONS_PER_100K IS NOT NULL
        ) AS OBSERVATION_COUNT

    FROM source_data

    UNION ALL

    SELECT
        'Poverty vs HPSA Density' AS RELATIONSHIP,
        CORR(
            PCT_BELOW_POVERTY,
            HPSA_DESIGNATIONS_PER_100K
        ) AS CORRELATION,
        COUNT_IF(
            PCT_BELOW_POVERTY IS NOT NULL
            AND HPSA_DESIGNATIONS_PER_100K IS NOT NULL
        ) AS OBSERVATION_COUNT

    FROM source_data

    UNION ALL

    SELECT
        'Uninsured Rate vs HPSA Density' AS RELATIONSHIP,
        CORR(
            PCT_UNINSURED,
            HPSA_DESIGNATIONS_PER_100K
        ) AS CORRELATION,
        COUNT_IF(
            PCT_UNINSURED IS NOT NULL
            AND HPSA_DESIGNATIONS_PER_100K IS NOT NULL
        ) AS OBSERVATION_COUNT

    FROM source_data

)

SELECT
    RELATIONSHIP,
    CORRELATION,
    OBSERVATION_COUNT

FROM correlations