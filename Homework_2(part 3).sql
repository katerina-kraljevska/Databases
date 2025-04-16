-- Show all R-rated movies and their directors
SELECT * FROM movies;
SELECT * FROM directors;

SELECT 
    m.title,
	m.rating,
    d.first_name,
    d.last_name
FROM movies m
FULL JOIN directors d
ON m.director_id = d.director_id
WHERE m.rating = 'R';

-- Show all movies from 2019 and their genres
SELECT * FROM movies;
SELECT * FROM movie_genres;
SELECT * FROM genres;

SELECT
	m.title,
	g.name,
	m.relase_date
FROM genres g
INNER JOIN movie_genres mg
ON g.genre_id=mg.genre_id
INNER JOIN movies m
ON m.movie_id=mg.movie_id
WHERE m.release_date
BETWEEN '2019-01-01' AND '2019-12-31';

-- Show all American actors and their movies
SELECT * FROM cast_members;
SELECT * FROM movies;
SELECT * FROM actors;

SELECT 
    m.title,
    a.first_name,
    a.last_name,
    a.nationality
FROM actors a
INNER JOIN cast_members cm 
ON a.actor_id = cm.actor_id
INNER JOIN movies m 
ON m.movie_id = cm.movie_id
WHERE a.nationality = 'American';

-- Show all movies with budget over 100M and their production companies
SELECT * FROM movies;
SELECT * FROM production_companies;
SELECT * FROM movie_production_companies;

SELECT 
	m.title,
	m.budget,
	pc.name
FROM movies m
INNER JOIN movie_production_companies mpc
ON m.movie_id=mpc.movie_id
INNER JOIN production_companies pc
ON mpc.company_id=pc.company_id
WHERE m.budget> 100000000;

-- Show all movies filmed in 'London' and their directors
SELECT * FROM movies;
SELECT * FROM movie_locations;
SELECT * FROM directors;

SELECT 
	m.title,
	ml.city,
	d.first_name,
	d.last_name
FROM movies m
INNER JOIN movie_locations ml
ON m.movie_id=ml.movie_id
INNER JOIN directors d
ON m.director_id=d.director_id
-- WHERE ml.city='London';
WHERE ml.city='Tokyo';
--nema za london

-- Show all horror movies and their actors
SELECT * FROM cast_members;
SELECT * FROM movies;
SELECT * FROM actors;
SELECT * FROM movie_genres;
SELECT * FROM genres;


SELECT 
	m.title,
	g.name,
	a.first_name,
	a.last_name
FROM actors a
INNER JOIN cast_members cm
ON a.actor_id=cm.actor_id
INNER JOIN movies m
ON cm.movie_id=m.movie_id
INNER JOIN movie_genres mg
ON m.movie_id=mg.movie_id
INNER JOIN genres g
ON mg.genre_id=g.genre_id
WHERE g.name='Horror';

-- Show all movies with reviews rated 5 and their reviewers
SELECT * FROM users;
SELECT * FROM reviews;
SELECT * FROM movies;

SELECT
	u.username,
	r.rating,
	r.review_text,
	m.title
FROM users u
INNER JOIN reviews r
ON u.user_id=r.user_id
INNER JOIN movies m
ON r.movie_id=m.movie_id
-- WHERE r.rating = 5; --nema so ratring 5
WHERE r.rating = 8;

-- Show all British directors and their movies
SELECT * FROM movies;
SELECT * FROM directors;

SELECT 
    m.title,
    d.first_name,
    d.last_name
FROM directors d
INNER JOIN movies m
ON d.director_id = m.director_id
WHERE d.nationality='British';

-- Show all movies longer than 180 minutes and their genres
SELECT * FROM movies;
SELECT * FROM movie_genres;
SELECT * FROM genres;

SELECT
	m.title,
	g.name,
	m.duration_minutes
FROM genres g
INNER JOIN movie_genres mg
ON g.genre_id=mg.genre_id
INNER JOIN movies m
ON m.movie_id=mg.movie_id
-- WHERE m.duration_minutes>180; --nema vo bazata so nad 180
WHERE m.duration_minutes>150;

-- Show all Oscar-winning movies and their directors
SELECT * FROM movies;
SELECT * FROM awards;
SELECT * FROM movie_awards;
SELECT * FROM directors;

SELECT
	m.title,
	d.first_name,
	d.last_name,
	aw.name,
	aw.award_type,
	aw.category
FROM directors d
INNER JOIN movies m
ON d.director_id=m.director_id
INNER JOIN movie_awards ma
ON m.movie_id=ma.movie_id
INNER JOIN awards aw
ON ma.award_id=aw.award_id
WHERE aw.award_type='Oscar';

