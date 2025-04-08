SELECT * FROM movies;
SELECT * FROM actors;
SELECT * FROM directors;
SELECT * FROM production_companies;
SELECT * FROM reviews;

--find movies released in 2019
SELECT * FROM movies
WHERE release_date
BETWEEN '2019-01-01' AND '2019-12-31';

--all actors from british nationality
SELECT * FROM actors
WHERE nationality='British';

--find all movies with 'PG-13' rating
SELECT * FROM movies
WHERE rating='PG-13';

--find all direstors from amarican nationality
SELECT * FROM directors
WHERE nationality='American';

--find all movies with duration more than 150 minutes
SELECT * FROM movies
WHERE duration_minutes>150;

--find all actors with last name "Pitt"
SELECT * FROM actors
WHERE last_name='Pitt';

--find all movies with budget grater than 100 million
SELECT * FROM movies
WHERE budget>100000000;

--find all reviews with rating 5
SELECT * FROM reviews
WHERE rating=5; --nema vakvo review vo bazata

--find all movies in english
SELECT * FROM movies
WHERE language='English';

--find all production comapnies from 'California'
SELECT * FROM production_companies
WHERE headquarters LIKE '%California';
