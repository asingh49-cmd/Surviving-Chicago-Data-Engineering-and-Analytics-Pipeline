SET GLOBAL local_infile = 1;
USE crime_analysis;

LOAD DATA LOCAL INFILE '/Users/junnychoi/Desktop/iucr.csv'
INTO TABLE dim_iucr
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(iucr_code, primary_description, secondary_description);



LOAD DATA LOCAL INFILE '/Users/junnychoi/Desktop/police_stations.csv'
INTO TABLE dim_district
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    district_id,
    district_name,
    address,
    city,
    state,
    zip,
    website,
    phone,
    x_coordinate,
    y_coordinate,
    latitude,
    longitude
);


INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (1, 'ROGERS PARK', '51,259,902.4506', '34,052.3975757');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (2, 'WEST RIDGE', '98,429,094.8621', '43,020.6894583');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (3, 'UPTOWN', '65,095,642.7289', '46,972.7945549');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (4, 'LINCOLN SQUARE', '71,352,328.2399', '36,624.6030848');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (5, 'NORTH CENTER', '57,054,167.8500', '31,391.6697542');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (6, 'LAKE VIEW', '87,214,799.2728', '51,973.0968677');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (7, 'LINCOLN PARK', '88,316,400.4728', '49,478.4277714');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (8, 'NEAR NORTH SIDE', '76,675,895.9728', '57,293.1649516');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (9, 'EDISON PARK', '31,636,313.7864', '25,937.2268410');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (10, 'NORWOOD PARK', '121,959,105.4700', '80,368.3743778');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (11, 'JEFFERSON PARK', '64,868,161.6818', '44,011.9571704');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (12, 'FOREST GLEN', '89,130,893.6364', '74,493.8216040');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (13, 'NORTH PARK', '70,288,706.4343', '41,581.9486539');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (14, 'ALBANY PARK', '53,542,230.8191', '39,339.0164387');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (15, 'PORTAGE PARK', '110,196,097.1390', '46,520.6421377');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (16, 'IRVING PARK', '89,611,382.3106', '49,083.2240938');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (17, 'DUNNING', '103,595,001.1750', '54,555.9925337');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (18, 'MONTCLARE', '27,576,393.6325', '22,404.8521448');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (19, 'BELMONT CRAGIN', '109,099,414.6890', '43,000.9437079');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (20, 'HERMOSA', '32,602,059.4055', '27,179.0174378');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (21, 'AVONDALE', '55,209,595.4739', '34,261.9033409');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (22, 'LOGAN SQUARE', '84,012,057.6122', '45,994.6836171');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (23, 'HUMBOLDT PARK', '100,480,876.5020', '48,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (24, 'WEST TOWN', '78,414,483.1177', '46,918.1460794');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (25, 'AUSTIN', '199,254,207.4327', '75,226.4749169');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (26, 'WEST GARFIELD PARK', '32,857,292.0282', '30,887.8625783');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (27, 'EAST GARFIELD PARK', '53,883,220.8462', '31,514.6259595');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (28, 'NEAR WEST SIDE', '81,833,988.5291', '50,745.7322596');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (29, 'NORTH LAWNDALE', '89,487,422.0422', '44,959.4596967');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (30, 'SOUTH LAWNDALE', '83,323,843.1571', '44,689.0541133');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (31, 'LOWER WEST SIDE', '81,750,523.4022', '31,840.3129827');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (32, 'LOOP', '16,610,777.6711', '23,942.4675207');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (33, 'NEAR SOUTH SIDE', '49,769,639.4541', '45,035.1651083');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (34, 'ARMOUR SQUARE', '21,186,904.0026', '20,563.7085665');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (35, 'DOUGLAS', '46,064,021.8619', '27,659.0930162');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (36, 'OAKLAND', '10,475,598.9557', '13,741.3091693');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (37, 'FULLER PARK', '19,916,704.2892', '23,089.0879507');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (38, 'GRAND BOULEVARD', '50,268,083.1184', '36,844.5630018');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (39, 'KENWOOD', '29,701,774.1691', '23,336.1762091');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (40, 'WASHINGTON PARK', '34,914,150.2978', '25,250.9088179');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (41, 'HYDE PARK', '45,105,380.1732', '29,746.7600167');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (42, 'WOODLAWN', '49,278,116.3953', '27,137.3497024');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (43, 'SOUTH SHORE', '81,000,000.0000', '44,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (44, 'CHATHAM', '36,551,000.0000', '25,942.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (45, 'AVALON PARK', '34,852,737.7367', '27,630.8225543');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (46, 'SOUTH CHICAGO', '46,600,000.0000', '26,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (47, 'BURNSIDE', '16,000,000.0000', '18,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (48, 'CALUMET HEIGHTS', '35,415,000.0000', '23,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (49, 'ROSELAND', '134,313,706.73', '56,632.7954292');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (50, 'PULLMAN', '35,555,000.0000', '24,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (51, 'SOUTH DEERING', '70,000,000.0000', '40,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (52, 'EAST SIDE', '52,000,000.0000', '32,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (53, 'WEST PULLMAN', '90,000,000.0000', '45,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (54, 'RIVERDALE', '44,000,000.0000', '29,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (55, 'HEGEWISCH', '42,000,000.0000', '27,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (56, 'GARFIELD RIDGE', '54,000,000.0000', '32,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (57, 'ARCHER HEIGHTS', '30,000,000.0000', '22,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (58, 'BRIGHTON PARK', '40,000,000.0000', '27,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (59, 'MCKINLEY PARK', '27,000,000.0000', '21,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (60, 'BRIDGEPORT', '32,000,000.0000', '23,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (61, 'NEW CITY', '86,000,000.0000', '42,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (62, 'WEST ELSDON', '23,000,000.0000', '19,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (63, 'GAGE PARK', '31,000,000.0000', '23,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (64, 'CLEARING', '66,000,000.0000', '35,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (65, 'WEST LAWN', '40,000,000.0000', '27,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (66, 'CHICAGO LAWN', '67,000,000.0000', '38,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (67, 'WEST ENGLEWOOD', '73,000,000.0000', '40,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (68, 'ENGLEWOOD', '51,000,000.0000', '33,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (69, 'GREATER GRAND CROSSING', '59,000,000.0000', '35,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (70, 'ASHBURN', '62,000,000.0000', '36,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (71, 'AUBURN GRESHAM', '70,000,000.0000', '40,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (72, 'BEVERLY', '31,000,000.0000', '23,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (73, 'WASHINGTON HEIGHTS', '40,000,000.0000', '27,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (74, 'MOUNT GREENWOOD', '27,000,000.0000', '21,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (75, 'MORGAN PARK', '32,000,000.0000', '23,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (76, 'OHARE', '60,000,000.0000', '34,000.0000000');
INSERT INTO dim_community_area (community_area_id, community_name, shape_area, shape_length) VALUES (77, 'EDGEWATER', '23,000,000.0000', '19,000.0000000');

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE dim_ward;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA LOCAL INFILE '/Users/junnychoi/Desktop/ward.csv'
INTO TABLE dim_ward
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ward_id,
 alderman_first_name,
 alderman_last_name,
 address,
 address_2,
 city,
 state,
 zip,
 phone,
 email,
 website);

LOAD DATA LOCAL INFILE '/Users/junnychoi/Desktop/crimes.csv'
INTO TABLE fact_crime
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    crime_id,
    case_number,
    @csv_date,
    block,
    iucr_code,
    location_description,
    @csv_arrest,
    @csv_domestic,
    district_id,
    ward_id,
    community_area_id,
    @csv_updated_on
)
SET 
    date = STR_TO_DATE(@csv_date, '%m/%d/%y %H:%i'),
    updated_on = STR_TO_DATE(@csv_updated_on, '%m/%d/%y %H:%i'),
    arrest = (LOWER(@csv_arrest) = 'true'),
    domestic = (LOWER(@csv_domestic) = 'true');
    
LOAD DATA LOCAL INFILE '/Users/junnychoi/Desktop/PROJECT - DATA ENGINEERING/weather.csv'
INTO TABLE dim_weather
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    @csv_date,
    @csv_temp_avg,
    @csv_temp_max,dim_weather
    @csv_temp_min,
    @csv_precip,
    @csv_snowfall,
    @csv_snow_depth
)
SET 
    weather_date  = STR_TO_DATE(@csv_date, '%m/%d/%y'),
    temp_avg      = NULLIF(@csv_temp_avg, ''),
    temp_max      = NULLIF(@csv_temp_max, ''),
    temp_min      = NULLIF(@csv_temp_min, ''),
    precipitation = NULLIF(@csv_precip, ''),
    snowfall      = NULLIF(@csv_snowfall, ''),
    snow_depth    = NULLIF(@csv_snow_depth, '');
    
    
LOAD DATA LOCAL INFILE '/Users/junnychoi/Desktop/license_codes.csv'
INTO TABLE dim_license_code
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(license_code, license_description);

LOAD DATA LOCAL INFILE '/Users/junnychoi/Desktop/business_licenses.csv'
INTO TABLE dim_business_license
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    license_id,
    account_number,
    legal_name,
    business_name,
    address,
    city,
    state,
    @csv_zip,
    @csv_community_area_id,
    neighborhood_name,
    license_code
)
SET
    zip = REPLACE(@csv_zip, '.0', ''),
    community_area_id = NULLIF(@csv_community_area_id, '');


LOAD DATA LOCAL INFILE '/Users/junnychoi/Desktop/demographics.csv'
INTO TABLE dim_demographics
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

