select
    STATE,
    COUNTY,
    HPSA_DISCIPLINE,
    HPSA_TYPE,
    HPSA_NAME
from {{ source('healthcare_raw', 'HRSA_HPSA_PRIMARY_CARE') }}