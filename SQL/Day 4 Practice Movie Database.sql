CREATE DATABASE NewPractice;

USE NewPractice;

CREATE TABLE movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    release_year INT,
    genre VARCHAR(50),
    director_id INT,
    box_office_collection DECIMAL(15, 2)
);


CREATE TABLE actors (
    actor_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    birth_date DATE
);


CREATE TABLE directors (
    director_id INT PRIMARY KEY,
    name VARCHAR(100),
    nationality VARCHAR(50)
);


CREATE TABLE movie_actors (
    movie_id INT,
    actor_id INT,
    role VARCHAR(100),
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);


INSERT INTO directors (director_id, name, nationality) VALUES
(1, 'Steven Spielberg', 'American'),
(2, 'Christopher Nolan', 'British-American'),
(3, 'Quentin Tarantino', 'American');


INSERT INTO movies (movie_id, title, release_year, genre, director_id, box_office_collection) VALUES
(1, 'Inception', 2010, 'Sci-Fi', 2, 829.89),
(2, 'Pulp Fiction', 1994, 'Crime', 3, 213.93),
(3, 'Jurassic Park', 1993, 'Adventure', 1, 1029.15),
(4, 'Django Unchained', 2012, 'Western', 3, 425.37),
(5, 'Interstellar', 2014, 'Sci-Fi', 2, 677.47);


INSERT INTO actors (actor_id, name, gender, birth_date) VALUES
(1, 'Leonardo DiCaprio', 'Male', '1974-11-11'),
(2, 'Samuel L. Jackson', 'Male', '1948-12-21'),
(3, 'Tom Hanks', 'Male', '1956-07-09'),
(4, 'Uma Thurman', 'Female', '1970-04-29'),
(5, 'Matthew McConaughey', 'Male', '1969-11-04');


INSERT INTO movie_actors (movie_id, actor_id, role) VALUES
(1, 1, 'Dom Cobb'),
(2, 2, 'Jules Winnfield'),
(2, 4, 'Mia Wallace'),
(3, 3, 'Dr. Alan Grant'),
(4, 1, 'Calvin Candie'),
(5, 5, 'Cooper');

-- Grouping
SELECT genre, SUM(box_office_collection) AS earnings
FROM Movies
GROUP BY genre;

--Grouping with Filters
SELECT D.name, AVG(M.box_office_collection) AS avgcoll
FROM Movies M
JOIN Directors D ON M.director_id = D.director_id
GROUP BY D.name
HAVING AVG(M.box_office_collection) > 600;

--Inner Join
SELECT M.title, D.name AS Dir_Name
FROM Movies M
JOIN Directors D ON M.director_id = D.director_id;

---Left Join
SELECT A.name, M.title
FROM Actors A
LEFT JOIN movie_actors MA ON A.actor_id = MA.actor_id
LEFT JOIN movies M ON MA.movie_id = M.movie_id

--Right Join
SELECT A.name, M.title
FROM Movies M
RIGHT JOIN movie_actors MA ON M.movie_id = MA.movie_id
RIGHT JOIN actors A ON MA.actor_id = A.actor_id;

---Cross Join
SELECT D.name AS Director, A.name AS Actor
FROM Directors D
CROSS JOIN Actors A;

--Extra

SELECT AVG(DATEDIFF(YEAR, birth_date, GETDATE())) AS avg_age
FROM Actors


SELECT M.title, M.box_office_collection
FROM Movies M
WHERE box_office_collection = (SELECT MAX(box_office_collection) FROM Movies);

SELECT genre AS Category
FROM Movies
UNION
SELECT nationality AS Category
FROM directors;

SELECT name 
FROM Actors
INTERSECT
SELECT name
FROM Directors;



SELECT name
FROM actors
WHERE actor_id IN (
    SELECT actor_id
    FROM movie_actors
    WHERE movie_id IN (
        SELECT movie_id
        FROM movies
        WHERE release_year <= 2000
    )
)
EXCEPT
SELECT name
FROM actors
WHERE actor_id IN (
    SELECT actor_id
    FROM movie_actors
    WHERE movie_id IN (
        SELECT movie_id
        FROM movies
        WHERE release_year > 2000
    )
);

