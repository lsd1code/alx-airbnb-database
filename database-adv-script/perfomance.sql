SELECT
    b.*,
    u.*,
    p.*,
    pay.*
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
WHERE u.status = 'active'
  AND p.city = 'New York';

-- Before refactoring
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

-- After refactoring
EXPLAIN ANALYZE
SELECT
    b.id AS booking_id,
    u.name AS user_name,
    p.title AS property_title,
    pay.amount AS payment_amount
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id;