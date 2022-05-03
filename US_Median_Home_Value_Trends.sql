/*
Explore US median home value changes from 2000-2022

Skills used: Creating Views, Joins, Aggregate Functions, Numeric Functions
*/

-- Show annual median home values by state, dating back to 2000. Excludes states without data from 2000-2010 (NM, MT, ND, WY)

SELECT
	state_name, 2000_avg_value, 2001_avg_value, 2002_avg_value, 2003_avg_value, 2004_avg_value, 2005_avg_value,
    2006_avg_value, 2007_avg_value, 2008_avg_value, 2009_avg_value, 2010_avg_value, 2011_avg_value,
    2012_avg_value, 2013_avg_value, 2014_avg_value, 2015_avg_value, 2016_avg_value, 2017_avg_value, 
    2018_avg_value, 2019_avg_value, 2020_avg_value, 2021_avg_value, 2022_avg_value
FROM home_values
WHERE 2000_avg_value > 0
ORDER BY 2000_avg_value DESC
    
-- Calculate the median household income to home price ratio in 2022

CREATE OR REPLACE VIEW income_home_price_ratio AS
 SELECT
	hv.state_name,
	household_income,
	2022_avg_value AS home_value,
    ROUND((household_income / 2022_avg_value) * 100, 2) AS income_home_price_ratio
FROM home_values hv
JOIN median_household_income_2022 mhi
	ON hv.state_name = mhi.state
ORDER BY income_home_price_ratio DESC

-- Create a view of the percent change in home value from 2000-2007 by state

CREATE OR REPLACE VIEW home_value_change_2000_2007 AS
SELECT
	state_size_rank,
	state_name,
	2000_avg_value,
    2007_avg_value,
	ROUND((2007_avg_value - 2000_avg_value) / 2000_avg_value * 100, 1) AS percent_change
FROM home_values
WHERE 2000_avg_value <> 0
ORDER BY percent_change DESC

-- Create a view of the percent change in home value from 2007-2010 by state

CREATE OR REPLACE VIEW home_value_change_2007_2010 AS
SELECT
	state_size_rank,
	state_name,
	2007_avg_value,
    2010_avg_value,
	ROUND((2010_avg_value - 2007_avg_value) / 2007_avg_value * 100, 1) AS percent_change
FROM home_values
WHERE 2007_avg_value <> 0
ORDER BY percent_change ASC

-- Create a view of the percent change in home value from 2010-2017 by state

CREATE OR REPLACE VIEW home_value_change_2010_2017 AS
SELECT
	state_size_rank,
	state_name,
	2010_avg_value,
    2017_avg_value,
	ROUND((2017_avg_value - 2010_avg_value) / 2010_avg_value * 100, 1) AS percent_change
FROM home_values
ORDER BY percent_change DESC

-- Create a view of the percent change in home value from 2017-2022 by state

CREATE OR REPLACE VIEW home_value_change_2017_2022 AS
SELECT
	state_size_rank,
	state_name,
	2017_avg_value,
    2022_avg_value,
	ROUND((2022_avg_value - 2017_avg_value) / 2017_avg_value * 100, 1) AS percent_change
FROM home_values
ORDER BY percent_change DESC



