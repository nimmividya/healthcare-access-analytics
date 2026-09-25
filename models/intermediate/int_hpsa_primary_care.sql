select
    state,

    count(*) as total_hpsa_designations,

    count_if(trim(hpsa_type) = 'Facility') as facility_hpsa_count,

    count_if(trim(hpsa_type) = 'Population Group') as population_group_hpsa_count,

    count_if(trim(hpsa_type) = 'Geographic Area') as geographic_area_hpsa_count

from {{ ref('stg_hpsa_primary_care') }}

group by state