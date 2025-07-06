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