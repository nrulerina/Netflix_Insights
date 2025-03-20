
                                                 ------ 20 Business Problems ------
SELECT * FROM netflix_titles

--1. Total Number of Titles Available on Netflix
SELECT COUNT(*) AS total_titles FROM netflix_titles;

--2. Breakdown of Movies vs. TV Shows
SELECT type, COUNT(*) AS count 
FROM netflix_titles 
GROUP BY type;

--3. Top 5 Countries Producing the Most Content
SELECT TOP 5 country, COUNT(*) AS count
FROM netflix_titles
WHERE country IS NOT NULL
GROUP BY country
ORDER BY count DESC;

--4. Yearly Trend of Content Added to Netflix
SELECT release_year, COUNT(*) AS count 
FROM netflix_titles 
GROUP BY release_year 
ORDER BY release_year DESC;

--5. Most Popular Ratings (Target Audience Analysis)
SELECT TOP 5 rating , COUNT(*) AS counts
FROM netflix_titles
GROUP BY rating
ORDER BY counts DESC

--6. Most Common Content Categories (Genres) on Netflix
SELECT TOP 5 listed_in, COUNT(*) AS count 
FROM netflix_titles 
GROUP BY listed_in 
ORDER BY count DESC 

--7. Most Prolific Directors on Netflix
SELECT TOP 5 director, COUNT(*) AS count 
FROM netflix_titles
WHERE director IS NOT NULL
GROUP BY director 
ORDER BY count DESC

--8. Countries Producing the Most TV Shows
SELECT TOP 5 country, COUNT(*) AS count 
FROM netflix_titles 
WHERE type = 'TV Show' AND country IS NOT NULL 
GROUP BY country 
ORDER BY count DESC 

--9. Top 5 Most Common Movie Durations
SELECT TOP 5 duration , COUNT(*) AS counts
FROM netflix_titles
WHERE type='Movie'
GROUP BY duration
ORDER BY counts DESC

--9.1. Countries Producing the Most TV Shows and Movie
SELECT TOP 5 country, 'TV Show & Movie' AS type , COUNT(*) AS count
FROM netflix_titles
WHERE country IS NOT NULL
AND type IN ('TV Show', 'Movie')  -- Only include TV Shows and Movies
GROUP BY country
ORDER BY count DESC;

--10. Find the Latest Content Added to Netflix
SELECT TOP 5 title, date_added 
FROM netflix_titles 
WHERE date_added IS NOT NULL 
ORDER BY CONVERT(DATE, date_added, 101) DESC

--11. Find All Horror Movies for Targeted Marketing
SELECT title ,listed_in 
FROM netflix_titles
WHERE type = 'Movie' AND listed_in LIKE '%Horror%';

--12. Indentify TV Shows with more than 4 season
SELECT title, duration
FROM netflix_titles
WHERE type = 'TV Show'
AND 
    -- Ensure 'Seasons' is present to avoid errors
    duration LIKE '%Seasons'
AND 
    -- Convert numeric part to INT and check if > 3
    CAST(SUBSTRING(duration, 1, CHARINDEX(' ', duration) - 1) AS INT) > 3;

--13. Number of Titles Produced by Year
SELECT release_year, COUNT(*) AS count
FROM  netflix_titles
GROUP BY release_year
ORDER BY release_year DESC

--14. Identify Actors with the Most Appearances on Netflix
SELECT TOP 5 casts , COUNT(*) AS count
FROM netflix_titles
WHERE casts IS NOT NULL
GROUP BY casts
ORDER BY count DESC

--15. Finding the Percentage of Movies vs. TV Shows
SELECT type, COUNT(*) * 100/( SELECT COUNT(*) FROM netflix_titles)  AS Percentage
FROM netflix_titles
GROUP BY type 
ORDER BY percentage

-- alt
WITH Total AS(SELECT COUNT(*) AS total_count FROM netflix_titles)

SELECT type , COUNT(*) * 100 / total.total_count AS percentage
FROM netflix_titles, Total
GROUP BY type,total.total_count
ORDER BY percentage

--16. Monthly Trend of Content Added to Netflix
SELECT 
    FORMAT(CAST(date_added AS DATE), 'yyyy-MM') AS month_year, 
    COUNT(*) AS count 
FROM netflix_titles 
WHERE date_added IS NOT NULL 
GROUP BY FORMAT(CAST(date_added AS DATE), 'yyyy-MM')  
ORDER BY month_year DESC;

--17. Find the Most Common Genre Combinations
SELECT TOP 5 listed_in, COUNT(*) AS count 
FROM netflix_titles 
GROUP BY listed_in 
ORDER BY count DESC 

--18. Most Active Directors by Year
SELECT TOP 10 release_year, director, COUNT(*) AS count 
FROM netflix_titles 
WHERE director IS NOT NULL 
GROUP BY release_year, director
ORDER BY count DESC 

--19. Average Number of Titles Added Per Year Per Country
SELECT TOP 10 country, COUNT(*) / COUNT(DISTINCT release_year) AS avg_titles_per_year 
FROM netflix_titles 
WHERE country IS NOT NULL 
GROUP BY country 
ORDER BY avg_titles_per_year DESC 

--20. Top 5 Years with the Highest Number of New TV Shows
SELECT TOP 5 release_year, COUNT(*) AS tv_show_count 
FROM netflix_titles 
WHERE type = 'TV Show' 
GROUP BY release_year 
ORDER BY tv_show_count DESC 





