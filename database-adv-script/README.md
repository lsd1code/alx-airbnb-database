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
