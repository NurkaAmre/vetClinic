/*Queries that provide answers to the questions from all projects.*/
-- DAY1
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=true and escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name!='Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- DAY2

-- set value to species and ROLLBACK
BEGIN;
UPDATE animals
SET species='unspecified';
ROLLBACK;

-- updated the animals table by setting the species column to digimon & pokemon, commited transaction
BEGIN;
UPDATE animals
SET species='digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species='pokemon'
WHERE species=NULL;
COMMIT;

-- delete all records from animals table
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- Delete all animals born after Jan 1st, 2022
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '01-01-2022';

-- Savepoint for the transaction
BEGIN;
SAVEPOINT data_birth_01_01_22;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK data_birth_01_01_22;

-- Update all animals' weights that are negative to be their weight multiplid by -1.
 UPDATE animals
  SET weight_kg = weight_kg * -1
  WHERE weight_kg < 0;

-- Commit transaction
COMMIT;

-- Queries DAY3
How many animals are there?
SELECT COUNT(*) FROM animals;

How many animals have never tried to escape? 2
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

What is the average weight of animals? 
SELECT AVG(weight_kg) as "Average weight" FROM animals;

Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) As "Best Escapee" FROM animals GROUP BY neutered;

What is the minimum and maximum weight of each type of animal?
select species, MIN(weight_kg) as "Min-weight", MAX(weight_kg) as "Max-weight" from animals GROUP BY species;

What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS "AVR escapee" FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species; 

-- What animals belong to Melody Pond?
select name from animals
JOIN owners
ON animals.owner_id=owners.id
WHERE full_name='Melody Pond';

List of all animals that are pokemon
select animals.name from animals
JOIN species
ON animals.species_id= species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
select * from owners;
select owners.full_name as Owners, animals.name as Animals from animals
right JOIN owners
ON animals.owner_id= owners.id;

How many animals are there per species?
select COUNT(animals.name) as "Animal count", species.name as "Species" from animals
JOIN species
ON animals.species_id= species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
select species.name as "Species" from species
JOIN animals
ON species.id = animals.species_id
JOIN owners
ON owners.id = animals.owner_id
where owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
select animals.name as "Animal who dont have guts" from owners
JOIN animals
ON owners.id = animals.owner_id
where owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, count(animals.id) AS animal_count
FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY animal_count DESC
LIMIT 1;

-- DAY4 Queries
-- Who was the last animal seen by William Tatcher?
SELECT * FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.id) FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN owners ON visits.vet_id = owners.id
WHERE owners.full_name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT *
FROM vets
JOIN specializations ON vets.id = specializations.vet_id;

List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN owners ON visits.vet_id = owners.id
WHERE owners.full_name = 'Stephanie Mendez'
AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.id) AS visit_count FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY visit_count DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT * FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
JOIN owners ON visits.vet_id = owners.id
WHERE owners.full_name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, vets.name, visits.date_of_visit FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(visits.animal_id)
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN specializations ON specializations.species_id = vets.id
WHERE specializations.species_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(visits.animal_id) AS visit_count FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
JOIN owners ON visits.vet_id = owners.id
JOIN specializations ON specializations.species_id = vets.id
JOIN species ON specializations.species_id = species.id
WHERE owners.full_name = 'Maisy Smith'
GROUP BY species.name
ORDER BY visit_count DESC
LIMIT 1;