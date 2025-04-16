-- Show movies and their directors
SELECT * FROM movies;
SELECT * FROM directors;

SELECT 
    m.title,
    d.first_name,
    d.last_name
FROM movies m
INNER JOIN directors d
ON m.director_id = d.director_id;

-- Show actors and their movies

SELECT * FROM cast_members;
SELECT * FROM movies;
SELECT * FROM actors;

SELECT 
	m.title,
	a.first_name,
	a.last_name
FROM actors a
INNER JOIN cast_members cm
ON a.actor_id=cm.actor_id
INNER JOIN movies m
ON m.movie_id=cm.movie_id;

-- Show movies and their genres
SELECT * FROM movies;
SELECT * FROM movie_genres;
SELECT * FROM genres;

SELECT
	m.title,
	g.name
FROM genres g
INNER JOIN movie_genres mg
ON g.genre_id=mg.genre_id
INNER JOIN movies m
ON mg.movie_id=m.movie_id;

-- Show users and their reviews
SELECT * FROM users;
SELECT * FROM reviews;

SELECT
	u.username,
	r.rating,
	r.review_text
FROM users u
INNER JOIN reviews r
ON u.user_id=r.user_id;

-- Show movies and their locations
SELECT * FROM movies;
SELECT * FROM movie_locations;

SELECT 
	m.title,
	ml.city,
	ml.country,
	ml.specific_location
FROM movies m
INNER JOIN movie_locations ml
ON m.movie_id=ml.movie_id;

-- Show movies and their production companies
SELECT * FROM movies;
SELECT * FROM production_companies;
SELECT * FROM movie_production_companies;

SELECT 
	m.title,
	pc.name
FROM movies m
INNER JOIN movie_production_companies mpc
ON m.movie_id=mpc.movie_id
INNER JOIN production_companies pc
ON mpc.company_id=pc.company_id;

-- Show actors and their awards
SELECT * FROM actors;
SELECT * FROM actor_awards;
SELECT * FROM awards;

SELECT
	ac.first_name,
	ac.last_name,
	aw.name,
	aw.award_type,
	aw.year,
	aw.category
FROM actors ac
INNER JOIN actor_awards acaw
ON ac.actor_id=acaw.actor_id
INNER JOIN awards aw
ON acaw.award_id=aw.award_id;

-- Show movies and their awards
SELECT * FROM movies;
SELECT * FROM awards;
SELECT * FROM movie_awards;

SELECT
	m.title,
	aw.name,
	aw.award_type,
	aw.year,
	aw.category
FROM movies m
INNER JOIN movie_awards ma
ON m.movie_id=ma.movie_id
INNER JOIN awards aw
ON ma.award_id=aw.award_id;

-- Show users and their watchlist movies
SELECT * FROM users;
SELECT * FROM user_watchlist;
SELECT * FROM movies;

SELECT
	u.username,
	m.title
FROM users u
INNER JOIN user_watchlist uw
ON u.user_id=uw.user_id
INNER JOIN movies m
ON uw.movie_id=m.movie_id;

-- Show movies and their revenues
SELECT * FROM movies;
SELECT * FROM movie_revenues;

SELECT
	m.title,
	mr.domestic_revenue,
	mr.international_revenue
FROM movies m
INNER JOIN movie_revenues mr
ON m.movie_id=mr.movie_id;
