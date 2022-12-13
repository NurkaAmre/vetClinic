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

-- Queries
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