/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth > '2016-01-01' AND date_of_birth < '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name ='Agumon' OR name = 'Pikachu';
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon') ;
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

SELECT COUNT(id) AS total_animals FROM animals;
SELECT COUNT(id) AS total_no_escape_animals FROM animals;
SELECT AVG(weight_kg) AS average_weight FROM animals;
SELECT name, neutered, MAX(escape_attempts) FROM animals GROUP BY name, neutered, escape_attempts ORDER BY escape_attempts DESC LIMIT 1;
SELECT species, MAX(weight_kg) AS max_weight, MIN(weight_kg) AS min_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS average_escape FROM animals WHERE DATE_PART('YEAR', date_of_birth) > 1990 AND DATE_PART('YEAR', date_of_birth) < 2000 GROUP BY species;

SELECT name FROM animals AS a INNER JOIN owners AS o ON o.id = a.owner_id AND o.full_name = 'Melody Pond';
SELECT a.name, s.name AS animal_type FROM animals AS a INNER JOIN species AS s ON s.id = a.species_id AND s.id = 1;
SELECT o.full_name AS owners, a.name AS animals FROM animals AS a RIGHT JOIN owners AS o ON o.id = a.owner_id;
SELECT COUNT(a.id) AS total_animals, s.name AS animal_type FROM animals AS a RIGHT OUTER JOIN species AS s ON s.id = a.species_id AND a.species_id IS NOT NULL GROUP BY s.name;
SELECT o.full_name AS owners, a.name AS animal_name, a.species_id AS animal_type FROM animals AS a INNER JOIN owners AS o ON o.id = a.owner_id AND o.full_name = 'Jennifer Orwell';
SELECT a.name AS animals, o.full_name AS owner FROM animals AS a INNER JOIN owners AS o ON o.id = a.owner_id AND a.escape_attempts = 0 AND o.full_name = 'Dean Winchester';
SELECT COUNT(a.owner_id) AS total_animal, o.full_name AS owner FROM animals AS a RIGHT OUTER JOIN owners AS o ON o.id = a.owner_id AND a.owner_id >= 1 GROUP BY a.owner_id, o.full_name ORDER BY COUNT(a.owner_id) DESC LIMIT 1;

--Who was the last animal seen by William Tatcher?
SELECT animals.name
FROM animals
JOIN visits 
ON visits.animals_id = animals.id 
JOIN vets
ON vets.id = visits.vets_id 
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC LIMIT 1;

--How many different animals did Stephanie Mendez see?
SELECT COUNT( DISTINCT animals.id)
FROM animals
JOIN visits
ON visits.animals_id = animals.id 
JOIN vets 
ON vets.id = visits.vets_id 
AND vets.name = 'Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.
SELECT vets.name,
CASE
  WHEN species_id = 1 
    THEN 'Pokemon'
  WHEN species_id = 2
    THEN 'Digimon'
  WHEN species_id IS NULL
    THEN 'No Specialities'
END spec
FROM vets 
LEFT OUTER JOIN specializations AS spec ON (spec.vets_id = vets.id); 

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name
FROM animals 
JOIN visits ON (visits.animals_id = animals.id)
WHERE visits.date_of_visit > '2020-04-01' AND visits.date_of_visit < '2020-08-30'
AND visits.vets_id = 3;

--What animal has the most visits to vets?
SELECT animals.name,COUNT(animals.id) AS result 
FROM visits 
LEFT OUTER JOIN animals ON (animals.id = visits.animals_id) 
GROUP BY animals.name, visits.animals_id ORDER BY COUNT(animals.id) DESC LIMIT 1;

--Who was Maisy Smith's first visit?
SELECT MIN(date_of_visit), vets.name
FROM visits
JOIN vets ON (vets.id = visits.vets_id)
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name;

--Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, visits.date_of_visit, vets.name
FROM animals
JOIN visits 
ON (animals.id = visits.animals_id)
JOIN vets
ON (vets.id = visits.vets_id)
WHERE visits.date_of_visit IN(
  SELECT MAX(visits.date_of_visit)
  FROM visits
  JOIN animals ON (animals.id = visits.animals_id)
);

--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(vets.id), vets.name
FROM vets
JOIN visits 
ON visits.vets_id = vets.id 
WHERE vets.id NOT IN (
  SELECT vets_id FROM specializations
)
GROUP BY vets.id, vets.name;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT COUNT(species.name), species.name, vets.name
FROM vets
JOIN visits 
ON visits.vets_id = vets.id
JOIN animals 
ON animals.id = visits.animals_id
JOIN species 
ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name, species.name, vets.name
ORDER BY COUNT(species.name) DESC LIMIT 1;

