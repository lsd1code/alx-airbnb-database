## Partitioning Large Tables

### Objective

Implement table partitioning to optimize queries on large datasets.

### Instructions

1. **Partition the Booking Table:**  
    Assume the `bookings` table is large and query performance is slow. Implement partitioning on the `bookings` table based on the `start_date` column. Save the partitioning SQL in a file named `partitioning.sql`.  
    *Example:*  
    ```sql
    -- Create a partitioned table by RANGE on start_date
    CREATE TABLE bookings_partitioned (
      id SERIAL PRIMARY KEY,
      user_id INT,
      property_id INT,
      start_date DATE,
      end_date DATE,
      -- other columns
      ...
    ) PARTITION BY RANGE (start_date);

    -- Create partitions for each year
    CREATE TABLE bookings_2022 PARTITION OF bookings_partitioned
      FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');
    CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
      FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');
    -- Add more partitions as needed
    ```

2. **Test Query Performance:**  
    Test the performance of queries on the partitioned table, such as fetching bookings by a specific date range.  
    *Example:*  
    ```sql
    EXPLAIN ANALYZE
    SELECT *
    FROM bookings_partitioned
    WHERE start_date BETWEEN '2023-06-01' AND '2023-06-30';
    ```

3. **Report Improvements:**  
    Write a brief report summarizing any improvements observed in query speed or efficiency after partitioning. Include before-and-after execution times and any relevant observations.