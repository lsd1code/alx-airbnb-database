# Normalization

- Normalization is the process of reducing redundancy and improving data integrity in RDMS
- It is an essential procedure to avoid inconsistencies in RDMS

## Fist Normal Form (`1NF`)

- Ensures each entry/row has a unique identifier, and each column contains an atomic value
- The tables already satisfy 1NF
  - Contains atomic values
  - Primary keys are defined

## Second Normal Form (`2NF`)

- Builds on the foundation 1NF
- Ensures that each non-key column in a table is dependent on the primary key
- There should be no partial dependencies in the table
- The tables already satisfy 2NF
  - No partial dependencies
  - All PKs are single column

## Third Normal Form (`1NF`)

- Builds on the foundation 1NF
- Ensures that there are no transitive dependencies in the table

### STEP 1: Identify Transitive dependencies in the `Property` table for 3NF violations

- Location might combine `city and country`, this violates the 3NF if `city -> country`, making country transitively dependent on city instead of `property_id`

### STEP 2: Resolve Violations

- Split `Property` table

  - Create a new `Location` table to isolate location-related attributes
  - Replace location in Property with location_id (foreign key)

- New tables

**`Location`**

- location_id: Primary Key, UUID, Indexed
- city: VARCHAR, NOT NULL
- country: VARCHAR, NOT NULL

**`Property`**

- property_id: Primary Key, UUID, Indexed
- host_id: Foreign Key, references User(user_id)
- name: VARCHAR, NOT NULL
- description: TEXT, NOT NULL
- location: VARCHAR, NOT NULL
- pricepernight: DECIMAL, NOT NULL
- created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
- updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP

### STEP 3: Verify 3NF compliance

- Location Table:
  - city and country depend directly on location_id (PK)
  - No transitive dependencies (country is not derivable from city alone; "Paris, TX, USA" vs. "Paris, France")
