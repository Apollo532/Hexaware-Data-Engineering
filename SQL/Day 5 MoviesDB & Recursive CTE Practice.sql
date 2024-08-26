
CREATE DATABASE MoviesDB;

USE MoviesDB;



CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    release_year INT,
    genre VARCHAR(50),
    box_office_collection DECIMAL(15, 2),
    director_id INT,
    FOREIGN KEY (director_id) REFERENCES Directors(director_id)
);


CREATE TABLE Actors (
    actor_id INT PRIMARY KEY,
    actor_name VARCHAR(100),
    birthdate DATE,
    nationality VARCHAR(50)
);


CREATE TABLE Directors (
    director_id INT PRIMARY KEY,
    director_name VARCHAR(100),
    birthdate DATE,
    nationality VARCHAR(50)
);


CREATE TABLE Ratings (
    rating_id INT PRIMARY KEY,
    movie_id INT,
    rating_source VARCHAR(50),
    rating DECIMAL(3, 1),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);


INSERT INTO Directors (director_id, director_name, birthdate, nationality) VALUES
(1, 'Christopher Nolan', '1970-07-30', 'British-American'),
(2, 'Quentin Tarantino', '1963-03-27', 'American'),
(3, 'Steven Spielberg', '1946-12-18', 'American');


INSERT INTO Movies (movie_id, title, release_year, genre, box_office_collection, director_id) VALUES
(1, 'Inception', 2010, 'Sci-Fi', 829895144.00, 1),
(2, 'Pulp Fiction', 1994, 'Crime', 213928762.00, 2),
(3, 'Jurassic Park', 1993, 'Adventure', 1039179154.00, 3),
(4, 'Interstellar', 2014, 'Sci-Fi', 701729206.00, 1),
(5, 'Django Unchained', 2012, 'Western', 425368238.00, 2);

INSERT INTO Movies VALUES(6, 'Inglorious Bastards', 2010, 'Cri', 2765000890.00,2);


INSERT INTO Actors (actor_id, actor_name, birthdate, nationality) VALUES
(1, 'Leonardo DiCaprio', '1974-11-11', 'American'),
(2, 'Samuel L. Jackson', '1948-12-21', 'American'),
(3, 'Tom Hanks', '1956-07-09', 'American'),
(4, 'Matthew McConaughey', '1969-11-04', 'American'),
(5, 'Jamie Foxx', '1967-12-13', 'American');


INSERT INTO Ratings (rating_id, movie_id, rating_source, rating) VALUES
(1, 1, 'IMDB', 8.8),
(2, 1, 'Rotten Tomatoes', 87.0),
(3, 2, 'IMDB', 8.9),
(4, 2, 'Rotten Tomatoes', 92.0),
(5, 3, 'IMDB', 8.1),
(6, 3, 'Rotten Tomatoes', 91.0),
(7, 4, 'IMDB', 8.6),
(8, 4, 'Rotten Tomatoes', 72.0),
(9, 5, 'IMDB', 8.4),
(10, 5, 'Rotten Tomatoes', 87.0);


--Cleansing and Manipulation

UPDATE Movies
SET title = LTRIM(RTRIM(title));

UPDATE Ratings
SET rating = (SELECT AVG(rating) FROM Ratings WHERE rating IS NOT NULL)
WHERE rating IS NULL;

UPDATE Movies
SET genre = 'Crime'
WHERE genre IN (SELECT DISTINCT(genre) FROM Movies WHERE genre LIKE 'Cr%');

-- Regex

SELECT title
FROM Movies 
WHERE title LIKE 'In%';

SELECT director_name
FROM Directors
WHERE director_name LIKE 'Q% Tar%';

--Analytical Function

--Running Total of BoxOfficeCollection
SELECT title, genre, box_office_collection, 
       SUM(box_office_collection) OVER ( PARTITION BY genre ORDER BY release_year) AS RunningTotal
FROM Movies;

--Ranking functions
--RANK()

SELECT title, genre, box_office_collection,
	RANK() OVER(ORDER BY box_office_collection DESC) AS MovieRank
FROM Movies;

--DENSE_RANK()
SELECT title, genre, box_office_collection,
	DENSE_RANK() OVER(ORDER BY box_office_collection DESC) AS MovieRank
FROM Movies;

--ROW_NUMBER()

SELECT title, genre, box_office_collection,
	ROW_NUMBER() OVER(ORDER BY box_office_collection DESC) AS MovieRank
FROM Movies;


--NTILE()

SELECT title, genre, box_office_collection,
	NTILE(3) OVER(ORDER BY box_office_collection DESC) AS Quartiles
FROM Movies;


--CTE Queries

WITH AvgRatings AS (
SELECT movie_id, AVG(rating) AS AvgRating
FROM Ratings
GROUP BY movie_id
)
SELECT M.title, AR.AvgRating
FROM Movies M
JOIN AvgRatings AR ON M.movie_id = AR.movie_id;


-- CUBE and ROLLUP

SELECT director_id, genre, SUM(box_office_collection) AS Collections
FROM Movies
GROUP BY ROLLUP(genre, director_id);


SELECT director_id, genre, SUM(box_office_collection) AS Collections
FROM Movies
GROUP BY CUBE(genre, director_id);



--Correlation Query
SELECT title, box_office_collection
FROM Movies
WHERE box_office_collection > (SELECT AVG(box_office_collection) FROM Movies);

--PROCEDURE

CREATE PROCEDURE GetMoviesByGenre
    @Genre VARCHAR(50)
AS
BEGIN
    SELECT movie_id, title, release_year, box_office_collection
    FROM Movies
    WHERE genre = @Genre;
END;

EXEC GetMoviesByGenre @Genre = 'Crime';

--- For Hierarchical Query (Recursive CTE):

CREATE DATABASE OrgChartDB;
GO
USE OrgChartDB;
GO


CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT NULL
);


INSERT INTO Employees (employee_id, employee_name, manager_id) VALUES
(1, 'CEO', NULL),            -- CEO has no manager
(2, 'CTO', 1),               -- CTO reports to CEO
(3, 'CFO', 1),               -- CFO reports to CEO
(4, 'Engineering Manager', 2), -- Engineering Manager reports to CTO
(5, 'Finance Manager', 3),   -- Finance Manager reports to CFO
(6, 'Software Engineer', 4), -- Software Engineer reports to Engineering Manager
(7, 'Accountant', 5);        -- Accountant reports to Finance Manager


WITH EmpHierarchy AS (
SELECT employee_id, employee_name, manager_id, 1 AS level
FROM Employees
WHERE manager_id IS NULL
UNION ALL
SELECT E.employee_id, E.employee_name, E.manager_id, EH.level + 1 AS level
FROM Employees E
INNER JOIN EmpHierarchy EH ON E.manager_id = EH.employee_id
)

SELECT employee_id, employee_name, manager_id, level
FROM EmpHierarchy
ORDER BY level,manager_id, employee_id;