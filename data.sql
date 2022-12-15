/* Populate database with sample data. */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', 'Feb 03,2020', 0, true, 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', 'Nov 15, 2018', 2, true, 8);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', 'Jan 07, 2021', 1, false, 15.04);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', 'May 12, 2017', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', 'Feb 08, 2020', 0, false, -11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Plantmon', 'Nov 15, 2021', 2, true, -5.7);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Squirtle', 'Apr 02, 1993', 3, false, -12.13);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Angemon', 'Jun 12, 2005', 1, true, -45);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Boarman', 'Jun 07, 2005', 7, true, 20.4);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Blossom', 'Oct 13, 1998', 3, true, 17);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Ditto', 'May 14, 2022', 4, true, 22);

-- Insert the following data into the owners table:
INSERT INTO owners (full_name, age)
VALUES('Sam Smith', 34);
INSERT INTO owners (full_name, age)
VALUES('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age)
VALUES('Bob', 45);
INSERT INTO owners (full_name, age)
VALUES('Melody Pond', 77);
INSERT INTO owners (full_name, age)
VALUES('Dean Winchester', 14);
INSERT INTO owners (full_name, age)
VALUES('Jodie Whittaker', 38);

--Insert Pokemon & Digimon to species table
INSERT INTO species(name)
VALUES ('Pokemon');
INSERT INTO species(name)
VALUES ('Digimon');

-- Modify species_id column value:
-- If the name ends in "mon" it will be Digimon
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

-- All other animals are Pokemon
UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
UPDATE animals SET owner_id=1 where name='Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owner_id=1 where name='Agumon';
UPDATE animals SET owner_id=2 where name='Pikachu';
-- Bob owns Devimon and Plantmon.
UPDATE animals SET owner_id=3 where name='Devimon';
UPDATE animals SET owner_id=3 where name='Plantmon';
-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owner_id=4 where name='Charmander';
UPDATE animals SET owner_id=4 where name='Squirtle';
UPDATE animals SET owner_id=4 where name='Blossom';
Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id=5 where owner_id IS NULL;

-- Queries
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
