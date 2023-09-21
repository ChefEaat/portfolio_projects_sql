-- shows cases vs total deaths as a percentage for Argentina and the United States
SELECT
	location,
	MAX(total_cases) AS total_cases,
	MAX(total_deaths) AS total_deaths,
	MAX((total_deaths/total_cases)* 100) AS death_percentage
FROM
	portfolio_youtube_project..covid_deaths
WHERE
	location = 'United States'
	OR location = 'Argentina'
	AND continent IS NOT NULL
GROUP BY
	location
ORDER BY
	death_percentage DESC

-- shows cases vs population as a percentage for the world

SELECT
	location,
	population,
	MAX(total_cases) AS highest_infection_count,
	MAX((total_cases/population))* 100 AS percent_infected
FROM
	portfolio_youtube_project..covid_deaths
WHERE
	continent IS NOT NULL
GROUP BY
	location,
	population
ORDER BY
	percent_infected DESC

-- shows deaths vs population as a percentage for the world, ordered in locations with the most deaths first

SELECT
	location,
	population,
	MAX(total_deaths) AS highest_death_count,
	MAX((total_deaths/population))* 100 AS percent_died
FROM
	portfolio_youtube_project..covid_deaths
WHERE
	continent IS NOT NULL
GROUP BY
	location,
	population
ORDER BY
	highest_death_count DESC

-- shows deaths vs population as a percentage for the continents of the world, ordered in continents with the most deaths first

SELECT
	location,
	MAX(total_deaths) AS highest_death_count,
	MAX((total_deaths/population))* 100 AS percent_died
FROM
	portfolio_youtube_project..covid_deaths
WHERE
	location IN ('Europe', 'Asia', 'North America', 'South America', 'Africa', 'Oceania')
GROUP BY
	location
ORDER BY
	highest_death_count DESC

-- new cases and deaths per day in the World

SELECT
	CAST(date AS date) AS date,
	SUM(total_cases) AS total_new_cases,
	SUM(total_deaths) AS total_new_deaths
FROM
	portfolio_youtube_project..covid_deaths
WHERE
	new_cases IS NOT NULL
GROUP BY
	date
ORDER BY
	date ASC

-- show the new vaccinations per day for the world, only showing days where new vaccines were adminstered adding up that total

SELECT
	CAST(d.date AS date) AS date,
	d.location,
	d.population,
	v.new_vaccinations,
	SUM(v.new_vaccinations) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS up_to_date_vaccinations
FROM
	portfolio_youtube_project..covid_deaths AS d
	JOIN portfolio_youtube_project..covid_vaccinations AS v
	ON d.location = v.location
	AND d.date = v.date
WHERE
	d.continent IS NOT NULL
	AND v.new_vaccinations IS NOT NULL
ORDER BY
	d.location,
	d.date ASC