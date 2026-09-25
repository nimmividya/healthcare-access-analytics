select
    STATE_FIPS,
    STATE_NAME,
    TOTAL_POPULATION,
    PCT_BELOW_POVERTY
from {{ source('healthcare_raw', 'ACS_S1701_POVERTY') }}