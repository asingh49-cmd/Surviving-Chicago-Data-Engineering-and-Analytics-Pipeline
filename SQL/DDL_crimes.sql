CREATE SCHEMA crime_analysis;
USE crime_analysis;

DROP TABLE IF EXISTS dim_iucr;

CREATE TABLE dim_iucr (
    iucr_code VARCHAR(10) PRIMARY KEY,
    primary_description VARCHAR(255) NOT NULL,
    secondary_description VARCHAR(255)
);


CREATE TABLE dim_district (
    district_id INT PRIMARY KEY,
    district_name VARCHAR(100),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(10),
    zip VARCHAR(20),
    website VARCHAR(255),
    phone VARCHAR(50),
    x_coordinate DECIMAL(15,4),
    y_coordinate DECIMAL(15,4),
    latitude DECIMAL(12,6),
    longitude DECIMAL(12,6)
);



CREATE TABLE dim_community_area (
    community_area_id INT NOT NULL,
    community_name VARCHAR(100) NOT NULL,
    shape_area VARCHAR(50),
    shape_length VARCHAR(50),
    PRIMARY KEY (community_area_id)
);

CREATE TABLE dim_ward (
    ward_id INT PRIMARY KEY,
    alderman_first_name VARCHAR(100),
    alderman_last_name VARCHAR(100),
    address VARCHAR(255),
    address_2 VARCHAR(255),   -- corrected spelling
    city VARCHAR(100),
    state VARCHAR(10),
    zip VARCHAR(20),
    phone VARCHAR(50),
    email VARCHAR(255),
    website VARCHAR(255)
);


DROP TABLE IF EXISTS fact_crime;

CREATE TABLE fact_crime (
    crime_id BIGINT PRIMARY KEY,
    case_number VARCHAR(20),
    date DATETIME,
    iucr_code VARCHAR(10),
    location_description VARCHAR(255),
    arrest BOOLEAN,
    domestic BOOLEAN,
    district_id INT,
    ward_id INT,
    community_area_id INT,
    updated_on DATETIME,
    
    -- Foreign Keys
    CONSTRAINT fk_iucr
        FOREIGN KEY (iucr_code) REFERENCES dim_iucr(iucr_code),

    CONSTRAINT fk_district
        FOREIGN KEY (district_id) REFERENCES dim_district(district_id),

    CONSTRAINT fk_ward
        FOREIGN KEY (ward_id) REFERENCES dim_ward(ward_id),

    CONSTRAINT fk_community
        FOREIGN KEY (community_area_id) REFERENCES dim_community_area(community_area_id)
);

DROP TABLE IF EXISTS dim_weather;

CREATE TABLE dim_weather (
    weather_date DATE PRIMARY KEY,
    temp_avg DECIMAL(5,2),
    temp_max DECIMAL(5,2),
    temp_min DECIMAL(5,2),
    precipitation DECIMAL(6,2),
    snowfall DECIMAL(6,2),
    snow_depth DECIMAL(6,2)
);

ALTER TABLE fact_crime
ADD CONSTRAINT fk_weather
    FOREIGN KEY (`date`)
    REFERENCES dim_weather(weather_date);


CREATE TABLE dim_license_code (
    license_code VARCHAR(10) PRIMARY KEY,
    license_description TEXT
);

CREATE TABLE dim_business_license (
    license_id        BIGINT PRIMARY KEY,
    account_number    BIGINT,
    legal_name        VARCHAR(255),
    business_name     VARCHAR(255),
    address           VARCHAR(255),
    city              VARCHAR(100),
    state             VARCHAR(10),
    zip               VARCHAR(20),
    community_area_id INT,
    neighborhood_name VARCHAR(100),
    license_code      VARCHAR(10),

    CONSTRAINT fk_business_community
        FOREIGN KEY (community_area_id)
        REFERENCES dim_community_area (community_area_id),

    CONSTRAINT fk_business_license_code
        FOREIGN KEY (license_code)
        REFERENCES dim_license_code (license_code)
);

CREATE TABLE dim_demographics (
    community_area_id INT NOT NULL PRIMARY KEY,
    community_area_name VARCHAR(100),

    income_under_25000 INT,
    income_25000_49999 INT,
    income_50000_74999 INT,
    income_75000_125000 INT,
    income_125000_plus INT,

    male_0_17 INT,
    male_18_24 INT,
    male_25_34 INT,
    male_35_49 INT,
    male_50_64 INT,
    male_65_plus INT,

    female_0_17 INT,
    female_18_24 INT,
    female_25_34 INT,
    female_35_49 INT,
    female_50_64 INT,
    female_65_plus INT,

    total_population INT,

    white INT,
    black_or_african_american INT,
    american_indian_or_alaska_native INT,
    asian INT,
    native_hawaiian_or_pacific_islander INT,
    other_race INT,
    multiracial INT,
    white_not_hispanic_or_latino INT,
    hispanic_or_latino INT,

    CONSTRAINT fk_demographics_community_area
        FOREIGN KEY (community_area_id)
        REFERENCES dim_community_area(community_area_id)
);