/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(id INT GENERATED ALWAYS AS IDENTITY, 
                    name VARCHAR(240), 
                    date_of_birth date, 
                    escape_attempts INT, 
                    neutered BOOLEAN, 
                    weight_kg DECIMAL);

-- Add new column to animals table
ALTER TABLE animals
    ADD COLUMN species VARCHAR(250);

-- DAY3
-- Create owners table
CREATE TABLE owners(
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(150),
    age INT,
    PRIMARY KEY (id)
 );

-- create species table
 CREATE TABLE species(
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(150),
    PRIMARY KEY (id)
 );

--  Modify animals table
-- id is set as autoincremented PRIMARY KEY
ALTER TABLE animals
    ADD PRIMARY KEY (id);

-- Remove column species
ALTER TABLE animals
    DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id int;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id int;
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners(id);

-- DAY4
-- Create a table named vets
CREATE TABLE vets(
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(150),
	age INT,
	date_of_graduation date,
    PRIMARY KEY (id)
 );

-- Create a "join table" called specializations
CREATE TABLE specializations (
    vet_id int,
    species_id int,
    PRIMARY KEY(vet_id, species_id),
    CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id),
    CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id)
);

-- Create a "join table" called visits
CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY,
    vet_id int,
    animal_id int,
    date_of_visit date,
    PRIMARY KEY(id),
    CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id),
    CONSTRAINT fk_animals FOREIGN KEY (animal_id) REFERENCES animals(id)
);

