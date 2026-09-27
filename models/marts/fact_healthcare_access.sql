{{ config(
    materialized='table'
) }}

SELECT
    d.state_key,
    d.state_fips,
    d.state_name,
    d.state_abbrev,

    a.population AS ahrf_population,
    a.physician_workforce,
    a.physician_office,
    a.pa_office,
    a.rn_office,
    a.aprn_office,
    a.physicians_per_100k,
    a.office_physicians_per_100k,
    a.pa_per_100k,
    a.rn_per_100k,
    a.aprn_per_100k,
    a.office_physician_share_pct,

    h.total_hpsa_designations,
    h.facility_hpsa_count,
    h.population_group_hpsa_count,
    h.geographic_area_hpsa_count,

    i.total_population AS acs_insurance_population,
    i.pct_insured,
    i.pct_uninsured,
    i.uninsured_population,

    p.total_population AS acs_poverty_population,
    p.pct_below_poverty,
    p.estimated_population_below_poverty

FROM {{ ref('dim_state') }} d

LEFT JOIN {{ ref('int_ahrf_workforce') }} a
    ON d.state_fips = a.state_fips

LEFT JOIN {{ ref('int_hpsa_primary_care') }} h
    ON d.state_abbrev = h.state

LEFT JOIN {{ ref('int_acs_health_insurance') }} i
    ON d.state_fips = i.state_fips

LEFT JOIN {{ ref('int_acs_poverty') }} p
    ON d.state_fips = p.state_fips