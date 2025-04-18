-- Find all genres that have more than 3 movies with a rating of 'R'
SELECT * FROM movies;
SELECT * FROM movie_genres;
SELECT * FROM genres;

SELECT
    g.name AS genre_name,
    COUNT(m.movie_id) AS rated_movies
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
WHERE m.rating = 'R'
GROUP BY g.genre_id, g.name
HAVING COUNT(m.movie_id) > 3;

-- Find directors who have made movies with total revenue over 500 million and have directed at least 2 movies
SELECT * FROM directors;
SELECT * FROM movies;
SELECT * FROM movie_revenues;

SELECT
	d.first_name,
	d.last_name,
	m.title,
	mr.domestic_revenue,
	mr.international_revenue,
	mr.domestic_revenue + mr.international_revenue AS total_revenue
FROM directors d
INNER JOIN movies m
ON d.director_id=m.director_id
INNER JOIN movie_revenues mr
ON m.movie_id=mr.movie_id
WHERE mr.domestic_revenue + mr.international_revenue > 500000000;
	--za more than 2 movies ne sum sigurna bidejki sekoj direktor vo bazata ima samo po eden film 

-- Find actors who have appeared in more than 2 different genres and have won at least 1 award
SELECT * FROM actors;
SELECT * FROM cast_members;
SELECT * FROM movies;
SELECT * FROM movie_genres;
SELECT * FROM awards;
SELECT * FROM actor_awards;

SELECT
	a.first_name,
	a.last_name
FROM awards aw
INNER JOIN actor_awards acaw
ON aw.award_id=acaw.award_id
INNER JOIN actors a
ON acaw.actor_id=a.actor_id
INNER JOIN cast_members cm
ON a.actor_id=cm.actor_id
INNER JOIN movies m
ON cm.movie_id=m.movie_id
INNER JOIN movie_genres mg
ON m.movie_id=mg.movie_id
INNER JOIN genres g
ON mg.genre_id=g.genre_id
GROUP BY a.first_name, a.last_name
HAVING COUNT(DISTINCT g.genre_id) > 2
   AND COUNT(DISTINCT aw.award_id) >= 1;

-- Find movies that have received more than 3 reviews with an average rating above 7
SELECT * FROM movies;
SELECT * FROM reviews;

SELECT
    m.title,
    AVG(r.rating) AS avg_rating
FROM movies m
INNER JOIN reviews r ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title
HAVING COUNT(r.review_id) >= 2 --nemase so povekje od 3 reviews
   AND AVG(r.rating) > 7;


-- Find production companies that have invested more than 100 million in movies released after 2015
SELECT * FROM movies;
SELECT * FROM production_companies;
SELECT * FROM movie_production_companies;

SELECT 
    pc.name
FROM movies m
INNER JOIN movie_production_companies mpc
    ON m.movie_id = mpc.movie_id
INNER JOIN production_companies pc
    ON mpc.company_id = pc.company_id
WHERE m.budget > 100000
  AND m.release_date > '2015-01-01'
GROUP BY pc.name;

-- Find countries where more than 2 movies were filmed with a total budget exceeding 150 million
SELECT * FROM movies;
SELECT * FROM movie_locations;

SELECT 
	ml.country
FROM movies m
INNER JOIN movie_locations ml
ON m.movie_id=ml.movie_id
GROUP BY ml.country
HAVING COUNT(ml.movie_id) > 2
	AND SUM(m.budget) > 150000;

-- Find genres where the average movie duration is over 120 minutes and at least one movie has won an Oscar
SELECT * FROM genres;
SELECT * FROM movie_genres;
SELECT * FROM movies;
SELECT * FROM awards;
SELECT * FROM movie_awards;

SELECT
    g.name AS genre_name
FROM awards a
INNER JOIN movie_awards ma 
ON a.award_id = ma.award_id
INNER JOIN movies m 
ON ma.movie_id = m.movie_id
INNER JOIN movie_genres mg 
ON m.movie_id = mg.movie_id
INNER JOIN genres g 
ON mg.genre_id = g.genre_id
WHERE a.award_type = 'Oscar'
GROUP BY g.name
HAVING AVG(m.duration_minutes) > 120;

-- Find years where more than 3 movies were released with an average budget over 50 million
SELECT * FROM movies;

SELECT
    EXTRACT(YEAR FROM release_date) AS release_year
FROM movies
GROUP BY EXTRACT(YEAR FROM release_date)
HAVING COUNT(movie_id) >= 1 --nema povekje filmovi vo ista godina vo tabelata
	AND AVG(budget) > 50000000;
   
-- Find actors who have played lead roles in more than 2 movies with a total revenue exceeding 200 million
SELECT * FROM actors;
SELECT * FROM cast_members;
SELECT * FROM movies;
SELECT * FROM movie_revenues;

SELECT
	a.first_name,
	a.last_name
FROM actors a
INNER JOIN cast_members cm
ON a.actor_id=cm.actor_id
INNER JOIN movies m
ON cm.movie_id=m.movie_id
INNER JOIN movie_revenues mr
ON m.movie_id=mr.movie_id
GROUP BY a.actor_id
HAVING SUM(domestic_revenue + international_revenue) > 200000000
	AND COUNT(cm.actor_id) > 2;

-- Create a view that shows top-rated movies. Include: movie title, average rating, review count, director name
SELECT * FROM movies;
SELECT * FROM directors;
SELECT * FROM reviews;

CREATE VIEW top_rated_movies AS
SELECT 
    m.title AS movie_title,
    AVG(r.rating) AS avg_rating,
    COUNT(r.review_id) AS review_count,
    d.first_name AS director_name
FROM movies m
INNER JOIN reviews r 
ON m.movie_id = r.movie_id
INNER JOIN directors d 
ON m.director_id = d.director_id
GROUP BY m.movie_id, m.title, d.first_name
HAVING AVG(r.rating) > 7;

-- Create a view for movie financial performance. Include: movie title, budget, total revenue, profit, ROI
SELECT * FROM movies;
SELECT * FROM movie_revenues;

CREATE VIEW movie_financial_performance 
AS
SELECT
    m.title AS title,
    m.budget AS budget,
    (mr.domestic_revenue + mr.international_revenue) AS total_revenue,
    (mr.domestic_revenue + mr.international_revenue - m.budget) AS profit,
    ((mr.domestic_revenue + mr.international_revenue - m.budget) / m.budget) AS ROI --return on investment
FROM movies m
INNER JOIN movie_revenues mr 
ON m.movie_id = mr.movie_id;

-- Create a view for actor filmography. Include: actor name, movie count, genre list, total revenue
SELECT * FROM actors;
SELECT * FROM cast_members;
SELECT * FROM genres;
SELECT * FROM movie_genres;
SELECT * FROM movies;
SELECT * FROM movie_revenues;

CREATE VIEW actor_filmography 
AS
SELECT
    a.first_name || ' ' || a.last_name AS actor_name,
    COUNT(DISTINCT m.movie_id) AS movie_count,
    STRING_AGG(DISTINCT g.name, ', ') AS genre_list,
    SUM(mr.domestic_revenue + mr.international_revenue) AS total_revenue
FROM actors a
INNER JOIN cast_members cm 
ON a.actor_id = cm.actor_id
INNER JOIN movies m 
ON cm.movie_id = m.movie_id
INNER JOIN movie_revenues mr 
ON m.movie_id = mr.movie_id
INNER JOIN movie_genres mg 
ON m.movie_id = mg.movie_id
INNER JOIN genres g 
ON mg.genre_id = g.genre_id
GROUP BY a.actor_id;

-- Create a view for genre statistics. Include: genre name, movie count, average rating, total revenue
SELECT * FROM movies;
SELECT * FROM genres;
SELECT * FROM movie_genres;
SELECT * FROM movie_revenues;
SELECT * FROM reviews;

CREATE VIEW genre_statistics 
AS
SELECT
    g.name AS genre_name,
    COUNT(DISTINCT mg.movie_id) AS movie_count,
    AVG(r.rating) AS average_rating,
    SUM(mr.domestic_revenue + mr.international_revenue) AS total_revenue
FROM genres g
INNER JOIN movie_genres mg 
ON g.genre_id = mg.genre_id
INNER JOIN movies m 
ON mg.movie_id = m.movie_id
INNER JOIN movie_revenues mr 
ON m.movie_id = mr.movie_id
INNER JOIN reviews r 
ON m.movie_id = r.movie_id
GROUP BY g.name;
	
-- Create a view for production company performance. Include: company name, movie count, total investment, total revenue

SELECT * FROM production_companies;
SELECT * FROM movie_production_companies;
SELECT * FROM movies;
SELECT * FROM movie_revenues;

CREATE VIEW production_company_performance
AS
SELECT
	pc.name AS production_company_name,
	COUNT(mpc.company_id) AS movie_count,
	SUM(m.budget) AS total_investment,
	SUM(mr.domestic_revenue + mr.international_revenue) AS total_revenue
FROM production_companies pc
INNER JOIN movie_production_companies mpc
ON pc.company_id=mpc.company_id
INNER JOIN movies m
ON mpc.movie_id=m.movie_id
INNER JOIN movie_revenues mr
ON m.movie_id=mr.movie_id
GROUP BY pc.name;
