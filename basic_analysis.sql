-- Netflix Basic Data Analysis SQL Script
-- ----------------------------------------------------
-- Q1: Total count of Movies vs TV Shows
SELECT type, COUNT(*) AS total_count
FROM netflix_titles
GROUP BY type;

-- Q2: Top 10 countries producing the most content
SELECT country, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- Q3: Most common genres
SELECT listed_in AS genre, COUNT(*) AS total
FROM netflix_titles
GROUP BY genre
ORDER BY total DESC
LIMIT 10;

-- Q4: Trend of content addition by year
SELECT release_year, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year
ORDER BY release_year;

-- Q5: Most frequent directors
SELECT director, COUNT(*) AS total_directed
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
ORDER BY total_directed DESC
LIMIT 10;
