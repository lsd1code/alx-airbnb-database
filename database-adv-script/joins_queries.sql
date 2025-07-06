-- INNER JOIN
SELECT * FROM bookings b
INNER JOIN "USER" u
WHERE b.user_id == u.user_id;

-- LEFT JOIN
SELECT * FROM property p
LEFT JOIN reviews r
WHERE p.review_id == p.review_id;
