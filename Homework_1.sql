DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS teacher;
DROP TABLE IF EXISTS grade;
DROP TABLE IF EXISTS grade_details;
DROP TABLE IF EXISTS achievement_type;

CREATE TABLE student(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	date_of_birth DATE NOT NULL,
	enrolled_date DATE NOT NULL,
	gender VARCHAR(10),
	national_id_number INT NOT NULL UNIQUE,
	student_card_number INT NOT NULL UNIQUE
);

CREATE TABLE course(
	 id SERIAL PRIMARY KEY,
	 name VARCHAR(30) NOT NULL,
	 credit INT NOT NULL CHECK (credit <= 10),
	 academic_year INT NOT NULL CHECK (academic_year >= 1),
	 semester INT NOT NULL
);

CREATE TABLE teacher(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	date_of_birth DATE,
	academic_rank SMALLINT NOT NULL,
	hire_date DATE
);

CREATE TABLE grade(
	id SERIAL PRIMARY KEY,
	student_id INT UNIQUE NOT NULL,
	course_id INT UNIQUE NOT NULL,
	teacher_id INT UNIQUE NOT NULL,
	grade INT NOT NULL,
	comment TEXT,
	created_date TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE grade_details(
	id SERIAL PRIMARY KEY,
	grade_id INT UNIQUE NOT NULL,
	achivement_type_id INT UNIQUE NOT NULL,
	achievement_points NUMERIC(5,2) NOT NULL,
	achievement_max_points INT,
	achievement_date TIMESTAMP
);

CREATE TABLE achievement_type(
	id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
	description TEXT,
	paricipation_rate INT NOT NULL
);

SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM teacher;
SELECT * FROM grade;
SELECT * FROM grade_details;
SELECT * FROM achievement_type;
