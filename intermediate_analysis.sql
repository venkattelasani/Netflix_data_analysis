-- Netflix Intermediate Data Analysis SQL Script
-- ----------------------------------------------------
-- Q1: Top 5 countries with highest proportion of TV Shows
SELECT country, 
       SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) / COUNT(*) * 100 AS tvshow_percentage
FROM netflix_titles
GROUP BY country
ORDER BY tvshow_percentage DESC
LIMIT 5;

-- Q2: Count of titles added per month
SELECT MONTHNAME(date_added) AS month, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY month
ORDER BY total_titles DESC;

-- Q3: Average content release year by country
SELECT country, AVG(release_year) AS avg_release_year
FROM netflix_titles
GROUP BY country
ORDER BY avg_release_year DESC;

-- Q4: Directors with both Movies and TV Shows
SELECT director
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director
HAVING COUNT(DISTINCT type) > 1;

-- Q5: Most frequent actors in Netflix shows
SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(cast, ',', n.n), ',', -1)) AS actor_name, COUNT(*) AS appearances
FROM netflix_titles 
JOIN (SELECT 1 n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5) n
  ON LENGTH(cast) - LENGTH(REPLACE(cast, ',', '')) >= n.n - 1
GROUP BY actor_name
ORDER BY appearances DESC
LIMIT 10;

-- Q6: Most popular content rating
SELECT rating, COUNT(*) AS count_rating
FROM netflix_titles
GROUP BY rating
ORDER BY count_rating DESC;

-- Q7: Average duration of Movies vs TV Shows
SELECT type, AVG(CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)) AS avg_duration
FROM netflix_titles
WHERE duration LIKE '%min%'
GROUP BY type;

-- Q8: Country producing most content each year
SELECT release_year, country, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY release_year, country
ORDER BY release_year, total_titles DESC;

-- Q9: Year-on-year growth rate of content addition
SELECT release_year, COUNT(*) AS titles,
       ROUND((COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY release_year)) / LAG(COUNT(*)) OVER (ORDER BY release_year) * 100, 2) AS growth_rate
FROM netflix_titles
GROUP BY release_year;

-- Q10: Top genres by country
SELECT country, listed_in AS genre, COUNT(*) AS total_titles
FROM netflix_titles
GROUP BY country, genre
ORDER BY country, total_titles DESC;
