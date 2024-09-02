CREATE TABLE dim_temporal (
    id_temporal SERIAL PRIMARY KEY,
    year INTEGER not null
);

CREATE TABLE dim_location (
    id_location SERIAL PRIMARY KEY,
    country_name VARCHAR(50),
    geo_region VARCHAR(50)
);


CREATE TABLE fact (
    fk_temporal INTEGER NOT NULL,
    fk_location INTEGER NOT NULL,

    gmc_prohibitive INTEGER,
    gmc_physiological INTEGER,
    gmc_psychological INTEGER,
    gmc_divorce INTEGER,

    has_direct_criminalization BOOLEAN,
    has_indirect_criminalization BOOLEAN,
    has_gender_marker_change BOOLEAN,
    has_non_binary BOOLEAN,
    has_antidiscrimination_protection BOOLEAN,
    has_constitutional_protection BOOLEAN,
    has_employment_protection BOOLEAN,
    has_education_protection BOOLEAN,
    has_healthcare_protection BOOLEAN,
    has_housing_protection BOOLEAN,

    trip_score INTEGER,
    trip_percent REAL,

    regime_type VARCHAR(50),
    gdp_per_capita DOUBLE PRECISION,
    percent_religious REAL,
    percent_christian REAL,
    percent_muslim REAL,
    percent_non_religious REAL,
      
    PRIMARY KEY (fk_temporal, fk_location),
    FOREIGN KEY (fk_temporal) REFERENCES dim_temporal(id_temporal),
    FOREIGN KEY (fk_location) REFERENCES dim_location(id_location)
);