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




-- average trip score over geographical region
SELECT 
	l.geo_region, AVG(f.trip_score) AS avg_trip_score
FROM 
    dim_location l
INNER JOIN 
    fact f 
ON 
    l.id_location = f.fk_location
GROUP by l.geo_region
ORDER by avg_trip_score DESC; 


SELECT 
	l.id_location, l.geo_region, f.trip_score
FROM 
    dim_location l
INNER JOIN 
    fact f 
ON 
    l.id_location = f.fk_location;

-- average trip score per year
SELECT 
	tp.year, AVG(trip_score)
FROM 
    dim_location l
INNER JOIN 
    fact f 
ON 
    l.id_location = f.fk_location
INNER JOIN
	dim_temporal tp
ON
	tp.id_temporal = f.fk_temporal
GROUP by tp.year
ORDER BY tp.year ASC;

-- binary metrics
SELECT 
	l.id_location, tp.id_temporal, l.country_name, tp.year,
	has_direct_criminalization,has_indirect_criminalization,
	has_gender_marker_change, has_non_binary,
	has_antidiscrimination_protection, has_constitutional_protection
	has_employmentl_protection, has_education_protection
	has_healthcare_protection, has_housing_protection,
 	percent_religious, percent_christian, percent_muslim,
	percent_non_religious, gdp_per_capita, regime_type,
	trip_score
FROM 
    dim_location l
INNER JOIN 
    fact f 
ON 
    l.id_location = f.fk_location
INNER JOIN
	dim_temporal tp
ON
	tp.id_temporal = f.fk_temporal;