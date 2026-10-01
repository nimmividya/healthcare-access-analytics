# Healthcare Access & Outcomes Analytics

An end-to-end U.S. healthcare analytics project built to demonstrate practical **Analytics Engineering** skills using **Snowflake, dbt, SQL, Python, Git, and Tableau**.

The project transforms healthcare and socioeconomic source data into tested, documented analytical datasets and Tableau dashboards for state-level analysis.

---

## Business Question

> **Which U.S. states have greater healthcare access challenges, and what measurable factors are associated with those challenges?**

The project examines healthcare access through several independent measures rather than combining them into a single score.

### Measures include

* Healthcare provider workforce density
* Primary-care Health Professional Shortage Area (HPSA) designations
* Uninsured rate
* Poverty rate
* Relationships between provider access and socioeconomic measures
* Pearson correlations between selected indicators

**No composite healthcare-access score is used.**

---

## Project Architecture

```text
Authoritative Sources
        ↓
       RAW
        ↓
    STAGING
        ↓
  INTERMEDIATE
        ↓
      MARTS
        ↓
    ANALYTICS
        ↓
       CSV
        ↓
     Tableau
```

The project follows a layered Analytics Engineering approach in which raw source data is progressively transformed into reusable analytical models.

---

## Technology Stack

* **Snowflake** — cloud data warehouse
* **dbt Core** — transformation, testing, documentation, and modeling
* **SQL** — data transformation and analytical queries
* **Python** — data preparation and analytical support
* **Tableau** — visualization and dashboards
* **Git / GitHub** — version control and portfolio management

---

## Data Sources

### Area Health Resources Files (AHRF)

Used for healthcare workforce analysis, including:

* Physicians
* Physician Assistants
* Registered Nurses
* Advanced Practice Registered Nurses
* Population

Provider counts are converted into densities per 100,000 population.

### HRSA Health Professional Shortage Areas (HPSA)

Used to analyze primary-care shortage designations, including:

* Total primary-care HPSA designations
* Facility HPSAs
* Population-group HPSAs
* Geographic-area HPSAs

### U.S. Census Bureau — American Community Survey

Used for socioeconomic and healthcare coverage measures:

* Insured population
* Uninsured population
* Uninsured rate
* Population below poverty
* Poverty rate

### State Reference

A controlled state reference seed provides:

* State FIPS
* State abbreviation
* State name

---

## dbt Data Model

### Staging

The staging layer standardizes source data and prepares it for downstream transformations.

Models include:

```text
stg_ahrf_workforce
stg_hpsa_primary_care
stg_acs_health_insurance
stg_acs_poverty
```

### Intermediate

The intermediate layer creates reusable business-level transformations.

Models include:

```text
int_ahrf_workforce
int_hpsa_primary_care
int_acs_health_insurance
int_acs_poverty
```

### Marts

The mart layer organizes the data into analytical structures.

```text
DIM_STATE
FACT_HEALTHCARE_ACCESS
```

The fact table brings together the major healthcare-access measures at the state level.

### Analytics

The analytics layer produces purpose-built datasets for visualization and statistical analysis.

```text
analytics_provider_access
analytics_healthcare_burden
analytics_access_relationships
analytics_access_correlations
```

---

## Analytics

The project intentionally separates descriptive measures from statistical relationships.

### Provider Access

Provider density is calculated as:

```text
Provider Density =
Provider Count / Population × 100,000
```

This allows provider workforce measures to be compared across states with different population sizes.

### Healthcare Burden

The project separately examines:

* Primary-care HPSA designations
* Uninsured rate
* Poverty rate

These measures are not combined into a single burden score.

### Relationships

Scatterplots and linear trend lines are used to examine relationships between:

* Provider density
* HPSA density
* Uninsured rate
* Poverty rate

Statistical significance is evaluated using regression p-values.

### Correlations

Pearson correlations are calculated for selected relationships.

| Relationship                      | Correlation | Observations |
| --------------------------------- | ----------: | -----------: |
| Poverty vs Uninsured Rate         |        0.37 |           50 |
| Physician Density vs HPSA Density |       -0.11 |           51 |
| Poverty vs HPSA Density           |       -0.05 |           50 |
| Uninsured Rate vs HPSA Density    |        0.20 |           50 |

These correlations describe **linear statistical associations and do not establish causation**.

---

## Selected Statistical Results

Several relationships were tested using state-level data.

| Relationship                        |  p-value | Interpretation                                           |
| ----------------------------------- | -------: | -------------------------------------------------------- |
| Physician Density vs Uninsured Rate | < 0.0001 | Statistically significant negative linear association    |
| Physician Density vs Poverty Rate   |    0.019 | Statistically significant negative linear association    |
| Physician Density vs HPSA Density   |    0.425 | No statistically significant linear association detected |
| RN Density vs HPSA Density          |    0.087 | No statistically significant linear association detected |

These results should be interpreted as **state-level statistical relationships**, not causal effects.

---

## Tableau Dashboards

The project includes four analytical dashboards plus a navigation landing page.

### 1. Healthcare Provider Access by State

Examines provider workforce density per 100,000 population:

* Physician Density
* Physician Assistant Density
* Registered Nurse Density
* Advanced Practice Registered Nurse Density

### 2. Healthcare Burden by State

Shows independent measures:

* Primary-care HPSA designations
* Uninsured rate
* Poverty rate

### 3. Healthcare Access Relationships

Uses scatterplots and linear trend lines to examine relationships between provider access and other healthcare or socioeconomic measures.

### 4. Healthcare Access Correlations

Summarizes selected Pearson correlations and observation counts.

### Analytical Approach

> The dashboards examine independent healthcare access and socioeconomic measures. No composite healthcare-access score is used. Correlations and regression relationships describe statistical associations and do not establish causation.

---

## Data Quality

Data quality was treated as part of the Analytics Engineering workflow.

The project includes validation and dbt tests covering areas such as:

* State reference integrity
* Primary keys
* Uniqueness
* Not-null requirements
* Source row counts
* State matching
* Provider and population data
* Healthcare access measures

Missing source values are preserved or excluded from specific analyses where appropriate rather than being silently replaced.

---

## Repository Structure

```text
healthcare-access-analytics/
│
├── models/
│   ├── staging/
│   │   ├── stg_ahrf_workforce.sql
│   │   ├── stg_hpsa_primary_care.sql
│   │   ├── stg_acs_health_insurance.sql
│   │   └── stg_acs_poverty.sql
│   │
│   ├── intermediate/
│   │   ├── int_ahrf_workforce.sql
│   │   ├── int_hpsa_primary_care.sql
│   │   ├── int_acs_health_insurance.sql
│   │   └── int_acs_poverty.sql
│   │
│   ├── marts/
│   │   ├── dim_state.sql
│   │   ├── fact_healthcare_access.sql
│   │   └── schema.yml
│   │
│   └── analytics/
│       ├── analytics_provider_access.sql
│       ├── analytics_healthcare_burden.sql
│       ├── analytics_access_relationships.sql
│       ├── analytics_access_correlations.sql
│       └── schema.yml
│
├── seeds/
│   └── state_reference.csv
│
├── macros/
│   └── generate_schema_name.sql
│
├── tests/
├── analyses/
├── snapshots/
│
├── dbt_project.yml
├── .gitignore
└── README.md
```

---

## Analytics Engineering Skills Demonstrated

This project demonstrates practical experience with:

* Designing layered dbt transformations
* Working with multiple external data sources
* Building staging, intermediate, mart, and analytics models
* Dimensional modeling
* Creating reusable SQL transformations
* Data validation and testing
* Handling missing source data
* Creating analytical datasets for downstream users
* Statistical analysis with Python/SQL
* Building Tableau dashboards from analytical outputs
* Version control with Git
* Managing a reproducible Analytics Engineering workflow

---

## Project Outcome

This project demonstrates an end-to-end workflow from **raw healthcare data to analytical insights**:

```text
Source Data
    ↓
Snowflake
    ↓
dbt Transformations
    ↓
Tested Data Models
    ↓
Analytical Datasets
    ↓
Tableau Dashboards
```

The primary goal was not to produce a single ranking of states, but to build a transparent analytical pipeline where individual healthcare-access measures and their relationships can be examined independently.

---

## Author

**Nimmi Vidya**

Transitioning into Analytics Engineering

**Core tools:** SQL • dbt • Snowflake • Python • Tableau • Git
