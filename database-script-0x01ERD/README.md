# Design Database Schema(DDL)

This repository contains the SQL schema for a vacation rental platform database designed to support user management, property listings, bookings, payments, reviews, and messaging. The database is optimized for performance and ensures data integrity through normalization to the Third Normal Form (3NF)

## Key Features

- **3NF Compliant Design**: Eliminates data redundancy through proper normalization
- **UUID Primary Keys**: Secure and globally unique identifiers
- **Referential Integrity**: Enforced through foreign key constraints
- **Data Validation**: Comprehensive check constraints for business rules
- **Optimized Indexing**: Faster query performance for common operations
- **Historical Data Integrity**: Preserves important historical records

## Normalization Process

The database was normalized to 3NF through these key steps:

1. **Initial Analysis**: Identified all entities and their attributes
2. **1NF Compliance**: Ensured atomic values and primary keys
3. **2NF Compliance**: Removed partial dependencies
4. **3NF Compliance**:
   - Identified transitive dependency in `Property.location`
   - Created separate `Location` table with `city` and `country`
   - Added `location_id` foreign key to `Property` table

## Schema Details

### Tables

#### 1. User

- Stores platform user information
- **Columns**:
  - [`user_id` (PK), `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`, `created_at`]

#### 2. Location

- Stores geographical information (Added during normalization)
- **Columns**:
  - [`location_id` (PK), `city`, `country`]

#### 3. Property

- Stores rental property listings
- **Columns**:
  - [`property_id` (PK), `host_id` (FK), `name`, `description`, `location_id` (FK), `pricepernight`, `created_at`, `updated_at`]

#### 4. Booking

- Manages property reservations
- **Columns**:
  - [`booking_id` (PK), `property_id` (FK), `user_id` (FK), `start_date`, `end_date`, `total_price`, `status`, `created_at`]

#### 5. Payment

- **Columns**:
  - [`payment_id` (PK), `booking_id` (FK), `amount`, `payment_date`, `payment_method`]

#### 6. Review

- **Columns**:
  - [`review_id` (PK), `property_id` (FK), `user_id` (FK), `rating`, `comment`, `created_at`]

#### 7. Message

- **Columns**:
  - [`message_id` (PK), `sender_id` (FK), `recipient_id` (FK), `message_body`, `sent_at`]

### Constraints

- **Primary Keys**: UUID for all tables
- **Foreign Keys**: Relationships between tables
- **Check Constraints**:
  - Valid user roles (`guest`, `host`, `admin`)
  - Valid booking statuses (`pending`, `confirmed`, `canceled`)
  - Valid payment methods (`credit_card`, `paypal`, `stripe`)
  - Rating between 1-5
  - Booking end date after start date
  - Users can't message themselves
- **Unique Constraints**: Email addresses

### Indexes

- Primary keys (automatically indexed)
- Foreign key columns
- Frequently searched columns:
  - User emails
  - Property locations
  - Booking dates
  - Property prices

### MySQL Setup

1. Create database:
   ```sql
   CREATE DATABASE vacation_rental;
   USE vacation_rental;
   ```
2. Execute schema script (remove UUID functions):
   ```bash
   mysql -u root -p vacation_rental < schema.sql
   ```

## Optimization Notes

1. **Historical Pricing**: `total_price` in Booking preserves original price
2. **Cascade Deletes**: User deletion removes associated data
3. **Location Restrictions**: Locations can't be deleted while referenced
4. **Index Optimization**: Balanced between write performance and read speed
