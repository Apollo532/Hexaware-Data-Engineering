USE Pet_Adoption;

CREATE TABLE Adoption(
animal_id INT PRIMARY KEY NOT NULL,
name VARCHAR(40),
contact VARCHAR(40)
);

CREATE TABLE animals (
    id INT NOT NULL,
    name VARCHAR(40),
    breed VARCHAR(30),
    color VARCHAR(30),
    gender VARCHAR(10),
    status INT,
    species VARCHAR(20),
    shelter INT
);

CREATE TABLE shelter (
    id INT,
    name VARCHAR(50),
    location VARCHAR(50)
);

INSERT INTO animals(id, name, breed, color, gender, status, species, shelter) 
VALUES(501, 'Bellyflop', 'Beagle', 'Brown', 'Male', 0, 'Dog', 1);
INSERT INTO animals(id, name, breed, color, gender, status, species, shelter) 
VALUES(502, 'Snowy', 'Husky', 'White', 'Female', 0, 'Dog', 1);
INSERT INTO animals(id, name, breed, color, gender, status, species, shelter) 
VALUES(503, 'Princes', 'Pomeranian', 'Black', 'Female', 0, 'Dog', 1);
INSERT INTO animals(id, name, breed, color, gender, status, species, shelter) 
VALUES(504, 'Cricket', 'Chihuahua', 'Brown', 'Female', 0, 'Dog', 1);
INSERT INTO animals(id, name, breed, color, gender, status, species, shelter) 
VALUES(505, 'Spot', 'Dalmatian', 'Black and White', 'Male', 0, 'Dog', 1);
INSERT INTO animals(id, name, breed, color, gender, status, species, shelter) 
VALUES(401, 'Meowcat1', 'Asian', 'Brown', 'Male', 0, 'Cat', 2);
INSERT INTO animals(id, name, breed, color, gender, status, species, shelter) 
VALUES(402, 'Meowcat2', 'Africa', 'White', 'Female', 1, 'Cat', 3);
INSERT INTO animals(id, name, breed, color, gender, status, species, shelter) 
VALUES(403, 'Meowcat3', 'Africa', 'Black', 'Female', 1, 'Cat', 3);
INSERT INTO animals(id, name, breed, color, gender, status, species, shelter) 
VALUES(404, 'Meowcat4', 'Bengal', 'Black and White', 'Male', 0, 'Cat', 2);
INSERT INTO animals(id, name, breed, color, gender, status, species, shelter) 
VALUES(301, 'Snoopy', 'Asian', 'Brown', 'Male', 0, 'Dog', 2);
INSERT INTO animals(id, name, breed, color, gender, status, species, shelter) 
VALUES(302, 'Tommy', 'Asian', 'Brown', 'Male', 1, 'Cat', 3);

INSERT INTO adoptions(animal_id, name, contact) 
VALUES(101, 'Pinnochio', 'pinnocchio@gmail.com');
INSERT INTO adoptions(animal_id, name, contact) 
VALUES(102, 'Stella', 'Stella@gmail.com');
INSERT INTO adoptions(animal_id, name, contact) 
VALUES(103, 'Bob', 'bob@gmail.com');
INSERT INTO adoptions(animal_id, name, contact) 
VALUES(104, 'Alex', 'alex@gmail.com');
INSERT INTO adoptions(animal_id, name, contact) 
VALUES(105, 'Sunny', 'sunny@gmail.com');

INSERT INTO shelter(id, name, location) 
VALUES(1, 'Animals for Homes', 'Smart City');
INSERT INTO shelter(id, name, location) 
VALUES(2, 'Adopt Animals', 'Green Town');
INSERT INTO shelter(id, name, location) 
VALUES(3, 'Give Life', 'Blue Hills');


SELECT * FROM sys.tables;
SELECT * FROM animals;
SELECT * FROM adoptions;
SELECT id, breed FROM animals;
SELECT name FROM animals WHERE gender='Female';
SELECT id FROM animals WHERE status=0;
SELECT * FROM animals ORDER BY status DESC;
SELECT * FROM animals ORDER BY color DESC;
SELECT * FROM shelter ORDER BY id DESC;
SELECT * FROM animals ORDER BY id;
SELECT * FROM shelter;

UPDATE animals SET color='Brown and Red' WHERE name='Spot';
UPDATE animals SET gender='Red' WHERE id=501;
UPDATE animals SET status=1 WHERE gender='Female';
UPDATE animals SET species='Dog';
UPDATE animals SET shelter=1;

DELETE FROM animals WHERE id=501;


ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species VARCHAR(20);