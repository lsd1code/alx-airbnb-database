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