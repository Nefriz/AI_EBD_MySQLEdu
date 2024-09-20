CREATE DATABASE assignment01;
USE assignment01;

CREATE TABLE region (
    region_code VARCHAR(5) PRIMARY KEY,
    region_fullname VARCHAR(25)
);

CREATE TABLE cities (
    city VARCHAR(25) PRIMARY KEY,
    region_code VARCHAR(5),
    population INT,
    FOREIGN KEY (region_code) REFERENCES region(region_code)
);
CREATE TABLE countries (
    country_code VARCHAR(5) PRIMARY KEY,
    region_code VARCHAR(5),
    country_name VARCHAR(25),
    FOREIGN KEY (region_code) REFERENCES region(region_code)
);
CREATE TABLE continents (
    continent_name VARCHAR(25) PRIMARY KEY,
    country_code VARCHAR(5),
    FOREIGN KEY (country_code) REFERENCES countries(country_code)
);
CREATE TABLE buildings (
    building_id INT PRIMARY KEY,
    city VARCHAR(25),
    address VARCHAR(50),
    FOREIGN KEY (city) REFERENCES cities(city)
);


-- Insert data into region
INSERT INTO region (region_code, region_fullname) VALUES
('001', 'North America'),
('002', 'Europe'),
('003', 'Asia'),
('004', 'South America'),
('005', 'Africa'),
('006', 'Oceania');

-- Insert data into countries
INSERT INTO countries (country_code, region_code, country_name) VALUES
('US', '001', 'United States'),
('FR', '002', 'France'),
('CN', '003', 'China'),
('BR', '004', 'Brazil'),
('ZA', '005', 'South Africa'),
('AU', '006', 'Australia');

-- Insert data into continents
INSERT INTO continents (continent_name, country_code) VALUES
('America', 'US'),
('Europe', 'FR'),
('Asia', 'CN'),
('South America', 'BR'),
('Africa', 'ZA'),
('Oceania', 'AU');

-- Insert data into cities
INSERT INTO cities (city, region_code, population) VALUES
('New York', '001', 8419600),
('Paris', '002', 2148000),
('Beijing', '003', 21542000),
('Rio de Janeiro', '004', 6748000),
('São Paulo', '004', 12300000),
('Cape Town', '005', 433688),
('Johannesburg', '005', 957441),
('Sydney', '006', 5312163),
('Melbourne', '006', 5078193);

-- Insert data into buildings
INSERT INTO buildings (building_id, city, address) VALUES
(1, 'New York', '350 5th Ave, New York, NY 10118'),
(2, 'Paris', 'Tour Eiffel, Champ de Mars, Paris'),
(3, 'Beijing', 'Forbidden City, Beijing, China'),
(4, 'Rio de Janeiro', 'Christ the Redeemer, Rio de Janeiro, Brazil'),
(5, 'São Paulo', 'Paulista Avenue, São Paulo, Brazil'),
(6, 'Cape Town', 'Table Mountain, Cape Town, South Africa'),
(7, 'Johannesburg', 'Nelson Mandela Square, Johannesburg, South Africa'),
(8, 'Sydney', 'Sydney Opera House, Sydney, Australia'),
(9, 'Melbourne', 'Federation Square, Melbourne, Australia');

WITH general_table AS (
    SELECT 
        cont.continent_name AS continent,
        cou.country_name AS country,
        ct.city AS city,
        ct.population AS population,
	    bd.address AS building 
    FROM continents AS cont
    JOIN countries AS cou
        ON cont.country_code = cou.country_code
    JOIN cities AS ct
        ON cou.region_code = ct.region_code
    JOIN buildings AS bd
        ON bd.city = ct.city
    JOIN region AS rg
        ON rg.region_code = cou.region_code
)
SELECT 
    continent, 
    COUNT(DISTINCT country) AS country_count, 
    SUM(population) AS total_population
FROM general_table
WHERE population > 1000000
GROUP BY continent
ORDER BY total_population DESC;
