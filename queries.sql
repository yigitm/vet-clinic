/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth > '2016-01-01' AND date_of_birth < '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name ='Agumon' OR name = 'Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon') ;
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

SELECT count(id) AS total_animals FROM animals;
SELECT count(id) AS total_no_escape_animals FROM animals;
SELECT AVG(weight_kg) AS average_weight FROM animals;
SELECT name, neutered, MAX(escape_attempts) FROM animals GROUP BY name, neutered, escape_attempts ORDER BY escape_attempts DESC LIMIT 1;
SELECT species, MAX(weight_kg) AS max_weight, MIN(weight_kg) AS min_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS average_escape FROM animals WHERE DATE_PART('YEAR', date_of_birth) > 1990 AND DATE_PART('YEAR', date_of_birth) < 2000 GROUP BY species;

SELECT name FROM animals AS a INNER JOIN owners AS o ON o.id = a.owner_id AND o.full_name = 'Melody Pond';
SELECT a.name, s.name AS animal_type FROM animals AS a INNER JOIN species AS s ON s.id = a.species_id AND s.id = 1;
SELECT o.full_name AS owners, a.name AS animals FROM animals AS a RIGHT JOIN owners AS o ON o.id = a.owner_id;
SELECT count(a.id) AS total_animals, s.name AS animal_type FROM animals AS a RIGHT OUTER JOIN species AS s ON s.id = a.species_id AND a.species_id IS NOT NULL GROUP BY s.name;
SELECT o.full_name AS owners, a.name AS animal_name, a.species_id AS animal_type FROM animals AS a INNER JOIN owners AS o ON o.id = a.owner_id AND o.full_name = 'Jennifer Orwell';
SELECT a.name AS animals, o.full_name AS owner FROM animals AS a INNER JOIN owners AS o ON o.id = a.owner_id AND a.escape_attempts = 0 AND o.full_name = 'Dean Winchester';
SELECT COUNT(a.owner_id) AS total_animal, o.full_name AS owner FROM animals AS a RIGHT OUTER JOIN owners AS o ON o.id = a.owner_id AND a.owner_id >= 1 GROUP BY a.owner_id, o.full_name ORDER BY COUNT(a.owner_id) DESC LIMIT 1;
