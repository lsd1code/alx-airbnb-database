SELECT * FROM bookings b
INNER JOIN "USER" u
WHERE b.user_id == u.user_id;