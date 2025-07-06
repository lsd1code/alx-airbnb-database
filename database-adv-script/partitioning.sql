-- Create a partitioned table by RANGE on start_date
CREATE TABLE bookings_partitioned (
id SERIAL PRIMARY KEY,
user_id INT,
property_id INT,
start_date DATE,
end_date DATE,
) PARTITION BY RANGE (start_date);

-- Create partitions for each year
CREATE TABLE bookings_2022 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');
CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');