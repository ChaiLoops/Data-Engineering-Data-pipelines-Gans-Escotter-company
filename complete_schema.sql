DROP DATABASE IF EXISTS gans_sample_solution;

CREATE DATABASE gans_sample_solution;

USE gans_sample_solution;

CREATE TABLE cities (
    city_id INT AUTO_INCREMENT,
    city_name VARCHAR(255) NOT NULL,
    country VARCHAR(255),
	latitude FLOAT NOT NULL, -- storing in DD format
    longitude FLOAT NOT NULL, -- storing in DD format
    PRIMARY KEY (city_id)
);

CREATE TABLE populations (
    cities_data_id INT AUTO_INCREMENT,
    city_id INT,
    population INT NOT NULL, 
    
    -- Choose one of these two:
		-- the first is if you're getting population data through the API
        -- the second is if you were able to webscrape the census year
    data_collection_timestamp DATETIME, -- this is a proxy for the census date that we can get when using the API
    census_year INT, -- this is the actual census year which we can webscrape
    
    PRIMARY KEY (cities_data_id),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE forecasts (
	forecast_id INT AUTO_INCREMENT,
    city_id INT NOT NULL,
    forecast_time DATETIME NOT NULL,
    temp_in_celcius FLOAT,
    chance_of_precipitation FLOAT,
    last_3_hrs_rain_mm FLOAT,
    last_3_hrs_snow_mm FLOAT,
    data_collection_timestamp DATETIME, -- Forecasts can change
    PRIMARY KEY (forecast_id),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

CREATE TABLE cities_airports (
    city_id INT NOT NULL,
    iata VARCHAR(5) NOT NULL,
    PRIMARY KEY (city_id, iata),
    FOREIGN KEY (city_id) REFERENCES cities(city_id),
    FOREIGN KEY (iata) REFERENCES airports(iata)
);

CREATE TABLE airports (
	iata VARCHAR(5) NOT NULL,
    icao VARCHAR(4),
    airport_name VARCHAR(255),
    longitude FLOAT,
    latitude FLOAT,
    PRIMARY KEY (iata)
);

CREATE TABLE flights (
	flight_data_id INT AUTO_INCREMENT,
    iata VARCHAR(5) NOT NULL,
    flight_number VARCHAR(15),
    scheduled_arrival_time DATETIME NOT NULL,
    updated_arrival_time DATETIME,
    departure_location VARCHAR(255),
    PRIMARY KEY (flight_data_id),
    FOREIGN KEY (iata) REFERENCES airports(iata)
);

SELECT * FROM cities;
SELECT * FROM populations;
SELECT * FROM forecasts;
SELECT * FROM cities_airports;
SELECT * FROM airports;
SELECT * FROM flights;