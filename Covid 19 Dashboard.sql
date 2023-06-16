

------------------------
--- Covid 19 Analysis---
------------------------
 

-- 1. Total Cases, Total Deaths & Death Percentage by Country and Date
-- Shows the likelihood of dying if you contract Covid-19

SELECT
	SUM(CAST(new_cases AS decimal)) AS total_cases, 
	SUM(CAST(new_deaths AS decimal))AS total_deaths, 
    (SUM(CAST(new_deaths AS decimal))/ NULLIF(SUM(CAST(new_cases AS decimal)),0))* 100 AS DeathPercentage
FROM
	[Portfolio Project].[dbo].[CovidDeaths]
WHERE
	continent IS NOT NULL
ORDER BY
	1,2
 
--2. 
--Shows total deaths per continent

SELECT
	location,
	SUM(CAST(new_deaths AS decimal)) AS TotalDeathCount
FROM
	[Portfolio Project].[dbo].[CovidDeaths]
WHERE
	continent IS NULL
	AND location NOT IN ('World', 'European Union', 'International', '%income')
	AND location NOT LIKE '%income%'
GROUP BY
	location
ORDER BY
	TotalDeathCount DESC

--3.
--Shows countries with Highest Infection Rate compared to Population

SELECT
	Location,
	Population,
	MAX(total_cases) AS HighestInfectionCount,
	Max(total_cases / CAST(population AS float))* 100 AS PercentPopulationInfected
FROM
	[Portfolio Project].[dbo].[CovidDeaths]
GROUP BY
	Location,
	Population
ORDER BY
	PercentPopulationInfected DESC

--4.
--Shows countries with Highest Infection Rate compared to Population grouped by date

SELECT
	Location,
	Population,
	Date,
	MAX(total_cases) AS HighestInfectionCount,
	Max(total_cases / CAST(population AS float))* 100 AS PercentPopulationInfected
FROM
	[Portfolio Project].[dbo].[CovidDeaths]
GROUP BY
	Location,
	Population,
	date
ORDER BY
	PercentPopulationInfected DESC


