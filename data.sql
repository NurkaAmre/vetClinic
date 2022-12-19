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

-- DAY4
-- Insert data for vets:
INSERT INTO vets (name, age, date_of_graduation)
VALUES   ('Maisy Smith', 26, DATE '2019-01-17'),
         ('Stephanie Mendez', 64, DATE '1981-05-04'),
         ('Jack Harkness', 38, DATE '2008-06-08');

-- Vet William Tatcher is specialized in Pokemon.
INSERT INTO specializations (vet_id, species_id)
VALUES (4, 1);

-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO specializations (vet_id, species_id)
VALUES (2, 1);
INSERT INTO specializations (vet_id, species_id)
VALUES (2, 2);

-- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations (vet_id, species_id)
VALUES (3, 2);

-- Insert the data for visits:
INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES (1, 4, DATE '2020-05-24'),
         (1, 2, DATE '2020-07-22'),
         (2, 3, DATE '2021-02-02'),
         (3, 1, DATE '2020-01-05'),
         (3, 1, DATE '2020-03-08'),
         (3, 1, DATE '2020-05-14'),
         (4, 2, DATE '2021-05-04'),
         (5, 3, DATE '2021-02-24'),
         (6, 1, DATE '2019-12-21'),
         (6, 4, DATE '2020-08-10'),
         (6, 1, DATE '2021-04-07'),
         (7, 2, DATE '2019-09-29'),
         (8, 3, DATE '2020-10-03'),
         (8, 3, DATE '2020-11-04'),
         (9, 1, DATE '2019-01-24'),
         (9, 1, DATE '2019-05-15'),
         (9, 1, DATE '2020-02-27'),
         (9, 1, DATE '2020-08-03'),
         (10, 2, DATE '2020-05-24'),
         (10, 4, DATE '2021-01-11');


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';