/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(id INT GENERATED ALWAYS AS IDENTITY, 
                    name VARCHAR(240), 
                    date_of_birth date, 
                    escape_attempts INT, 
                    neutered BOOLEAN, 
                    weight_kg DECIMAL);
