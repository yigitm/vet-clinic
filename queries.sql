/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth > '2016-01-01' AND date_of_birth < '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name ='Agumon' OR name = 'Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon') ;
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
SAVEPOINT initialState;
UPDATE animals SET species='unspecified';
SELECT * FROM animals;
ROLLBACK TO initialState;
SELECT * FROM animals;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;
SAVEPOINT digimon;
UPDATE animals SET species='pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;

BEGIN;
SAVEPOINT backup;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-06-01';
SAVEPOINT dateDelete;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO dateDelete;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;

SELECT count(id) AS total_animals FROM animals;
SELECT count(id) AS total_no_escape_animals FROM animals;
SELECT AVG(weight_kg) AS average_weight FROM animals;
SELECT name, neutered, MAX(escape_attempts) FROM animals GROUP BY name, neutered, escape_attempts ORDER BY escape_attempts DESC LIMIT 1;
SELECT species, MAX(weight_kg) AS max_weight, MIN(weight_kg) AS min_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS average_escape FROM animals WHERE DATE_PART('YEAR', date_of_birth) > 1990 AND DATE_PART('YEAR', date_of_birth) < 2000 GROUP BY species;








