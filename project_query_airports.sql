-- shows airports by id ascending

SELECT
	*
FROM
	airport_project..airports
ORDER BY
	id ASC

-- shows the countries with the most amount of airports, that remain operational

SELECT
	iso_country,
	COUNT(type) AS num_of_airports
FROM
	airport_project..airports
WHERE
	type != 'closed'
GROUP BY
	iso_country
ORDER BY
	num_of_airports DESC

-- shows the countries with the most amount of large airports

SELECT
	iso_country,
	COUNT(type) AS num_of_large_airports
FROM
	airport_project..airports
WHERE
	type = 'large_airport'
GROUP BY
	iso_country
ORDER BY
	num_of_large_airports DESC

-- shows the continents with the most amount of airports, closed and operational

SELECT
	continent,
	COUNT(type) AS num_of_airports
FROM
	airport_project..airports
GROUP BY
	continent
ORDER BY
	num_of_airports DESC

-- shows the countries with the highest average elevation for small, medium and large airports

SELECT
    iso_country,
    CASE
        WHEN type IN ('small_airport', 'medium_airport', 'large_airport') THEN 'all_airports'
        ELSE type
    END AS type,
    AVG(elevation_ft) AS average_elevation
FROM
    airport_project..airports
WHERE
    type IN ('small_airport', 'medium_airport', 'large_airport')
GROUP BY
    iso_country,
    CASE
        WHEN type IN ('small_airport', 'medium_airport', 'large_airport') THEN 'all_airports'
        ELSE type
    END
ORDER BY
    average_elevation DESC

-- shows the continents with the highest average elevation for small, medium and large airports

SELECT
	continent,
	CASE
        WHEN type IN ('small_airport', 'medium_airport', 'large_airport') THEN 'all_airports'
        ELSE type
    END AS type,
    AVG(elevation_ft) AS average_elevation
FROM
    airport_project..airports
WHERE
    type IN ('small_airport', 'medium_airport', 'large_airport')
GROUP BY
    continent,
    CASE
        WHEN type IN ('small_airport', 'medium_airport', 'large_airport') THEN 'all_airports'
        ELSE type
    END
ORDER BY
    average_elevation DESC