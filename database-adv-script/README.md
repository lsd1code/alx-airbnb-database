# Write Complex Queries with Joins

## Objective

Master SQL joins by writing complex queries using different types of joins.

## Instructions

Follow the tasks below to practice and demonstrate your understanding of SQL joins:

1. **INNER JOIN:**  
    Write a query using an `INNER JOIN` to retrieve all bookings and the respective users who made those bookings.  
    *Example:*  
    ```sql
    SELECT bookings.*, users.*
    FROM bookings
    INNER JOIN users ON bookings.user_id = users.id;
    ```

2. **LEFT JOIN:**  
    Write a query using a `LEFT JOIN` to retrieve all properties and their reviews, including properties that have no reviews.  
    *Example:*  
    ```sql
    SELECT properties.*, reviews.*
    FROM properties
    LEFT JOIN reviews ON properties.id = reviews.property_id;
    ```

3. **FULL OUTER JOIN:**  
    Write a query using a `FULL OUTER JOIN` to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.  
    *Example:*  
    ```sql
    SELECT users.*, bookings.*
    FROM users
    FULL OUTER JOIN bookings ON users.id = bookings.user_id;
    ```

## Notes

- Test each query to ensure it returns the expected results.
- Review the differences between `INNER JOIN`, `LEFT JOIN`, and `FULL OUTER JOIN` to understand when to use each.


## Practice Subqueries

### Objective

Write both correlated and non-correlated subqueries.

### Instructions

1. **Average Rating Subquery:**  
    Write a query to find all properties where the average rating is greater than 4.0 using a subquery.  
    *Example:*  
    ```sql
    SELECT *
    FROM properties
    WHERE id IN (
      SELECT property_id
      FROM reviews
      GROUP BY property_id
      HAVING AVG(rating) > 4.0
    );
    ```

2. **Correlated Subquery for Users:**  
    Write a correlated subquery to find users who have made more than 3 bookings.  
    *Example:*  
    ```sql
    SELECT *
    FROM users u
    WHERE (
      SELECT COUNT(*)
      FROM bookings b
      WHERE b.user_id = u.id
    ) > 3;
    ```


## Apply Aggregations and Window Functions

### Objective

Use SQL aggregation and window functions to analyze data.

### Instructions

1. **Total Bookings per User:**  
    Write a query to find the total number of bookings made by each user, using the `COUNT` function and `GROUP BY` clause.  
    *Example:*  
    ```sql
    SELECT user_id, COUNT(*) AS total_bookings
    FROM bookings
    GROUP BY user_id;
    ```

2. **Rank Properties by Bookings:**  
    Use a window function (`ROW_NUMBER`, `RANK`, or `DENSE_RANK`) to rank properties based on the total number of bookings they have received.  
    *Example:*  
    ```sql
    SELECT
      property_id,
      COUNT(*) AS total_bookings,
      RANK() OVER (ORDER BY COUNT(*) DESC) AS booking_rank
    FROM bookings
    GROUP BY property_id;
    ```


## Implement Indexes for Optimization

### Objective

Identify and create indexes to improve query performance.

### Instructions

1. **Identify High-Usage Columns:**  
    Review your `users`, `bookings`, and `properties` tables to determine which columns are frequently used in `WHERE`, `JOIN`, or `ORDER BY` clauses (e.g., `user_id`, `property_id`, `email`).

2. **Create Indexes:**  
    Write SQL `CREATE INDEX` statements for these columns and save them in a file named `database_index.sql`.  
    *Example:*  
    ```sql
    CREATE INDEX idx_users_email ON users(email);
    CREATE INDEX idx_bookings_user_id ON bookings(user_id);
    CREATE INDEX idx_bookings_property_id ON bookings(property_id);
    CREATE INDEX idx_properties_location ON properties(location);
    ```

3. **Measure Performance:**  
    Use the `EXPLAIN` or `ANALYZE` statement to compare the execution plans and performance of your queries before and after adding indexes.  
    - Run your queries with `EXPLAIN` (or `EXPLAIN ANALYZE` if supported) and note the query plan and execution time.  
    - Add the relevant indexes.  
    - Run the same queries again with `EXPLAIN`/`ANALYZE` and compare the results.  
    - Document your observations, highlighting any improvements in query speed or changes in the execution plan.

```sql
-- Before adding indexes
EXPLAIN ANALYZE
SELECT p.*, r.*
FROM properties p
LEFT JOIN reviews r ON p.id = r.property_id
WHERE p.location = 'Paris';

-- Add indexes
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_reviews_property_id ON reviews(property_id);

-- After adding indexes
EXPLAIN ANALYZE
SELECT p.*, r.*
FROM properties p
LEFT JOIN reviews r ON p.id = r.property_id
WHERE p.location = 'Paris';
```

## Optimize Complex Queries

### Objective

Refactor complex queries to improve performance.

### Instructions

1. **Write an Initial Query:**  
    Write a query that retrieves all bookings along with the user details, property details, and payment details. Save this query in a file named `performance.sql`.  
    *Example:*  
    ```sql
    SELECT
      b.*,
      u.*,
      p.*,
      pay.*
    FROM bookings b
    INNER JOIN users u ON b.user_id = u.id
    INNER JOIN properties p ON b.property_id = p.id
    LEFT JOIN payments pay ON b.id = pay.booking_id;
    ```

2. **Analyze Query Performance:**  
    Use the `EXPLAIN` or `EXPLAIN ANALYZE` statement to analyze the query's execution plan and identify any inefficiencies.  
    *Example:*  
    ```sql
    EXPLAIN ANALYZE
    SELECT
      b.*,
      u.*,
      p.*,
      pay.*
    FROM bookings b
    INNER JOIN users u ON b.user_id = u.id
    INNER JOIN properties p ON b.property_id = p.id
    LEFT JOIN payments pay ON b.id = pay.booking_id;
    ```

3. **Refactor the Query:**  
    Refactor the query to improve performance. Consider removing unnecessary columns, limiting the result set, or ensuring indexes exist on join columns.  
    *Example (refactored):*  
    ```sql
    SELECT
      b.id AS booking_id,
      u.name AS user_name,
      p.title AS property_title,
      pay.amount AS payment_amount
    FROM bookings b
    INNER JOIN users u ON b.user_id = u.id
    INNER JOIN properties p ON b.property_id = p.id
    LEFT JOIN payments pay ON b.id = pay.booking_id;
    ```

4. **Compare Performance:**  
    Use `EXPLAIN` or `EXPLAIN ANALYZE` again to compare the execution plan and performance before and after refactoring. Document your findings and any improvements in query speed or efficiency.


