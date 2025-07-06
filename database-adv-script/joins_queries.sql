-- INNER JOIN
SELECT * FROM bookings b
INNER JOIN "USER" u
WHERE b.user_id == u.user_id;

-- LEFT JOIN
SELECT * FROM property p
LEFT JOIN reviews r
WHERE p.review_id == p.review_id
ORDER BY r.rating;

-- FULL OUTER JOIN
SELECT * FROM users s
FULL OUTER JOIN bookings b
WHERE s.booking_id == b.booking_id;