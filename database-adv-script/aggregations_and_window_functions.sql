-- COUNT() and GROUP BY clause
SELECT user_id, COUNT(*) AS total_bookings
FROM bookings
GROUP BY user_id;

-- Window functions (ROW_NUMBER, COUNT)
SELECT
    property_id,
    COUNT(*) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS booking_rank,
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS row_num
FROM bookings
GROUP BY property_id;