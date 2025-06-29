-- Enable UUID extension (PostgreSQL)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Insert sample users
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
(uuid_generate_v4(), 'Sarah', 'Johnson', 'sarah@example.com', 'hashed_password_1', '+1234567890', 'host', '2023-01-15 09:30:00'),
(uuid_generate_v4(), 'Michael', 'Chen', 'michael@example.com', 'hashed_password_2', '+1987654321', 'host', '2023-02-20 11:45:00'),
(uuid_generate_v4(), 'Emma', 'Rodriguez', 'emma@example.com', 'hashed_password_3', '+1122334455', 'guest', '2023-03-10 14:20:00'),
(uuid_generate_v4(), 'James', 'Wilson', 'james@example.com', 'hashed_password_4', '+1567890123', 'guest', '2023-04-05 16:55:00'),
(uuid_generate_v4(), 'Admin', 'User', 'admin@vacation.com', 'admin_hashed_pass', '+18005551234', 'admin', '2023-01-01 08:00:00');

-- Insert locations
INSERT INTO Location (location_id, city, country) VALUES
(uuid_generate_v4(), 'Paris', 'France'),
(uuid_generate_v4(), 'Tokyo', 'Japan'),
(uuid_generate_v4(), 'New York', 'USA'),
(uuid_generate_v4(), 'Barcelona', 'Spain'),
(uuid_generate_v4(), 'Kyoto', 'Japan');

-- Insert properties (using subqueries to get user and location IDs)
INSERT INTO Property (property_id, host_id, name, description, location_id, price_per_night, created_at) 
SELECT 
  uuid_generate_v4(),
  u.user_id,
  p.name,
  p.description,
  l.location_id,
  p.price_per_night,
  CURRENT_TIMESTAMP
FROM 
  (VALUES
    ('Luxury Paris Apartment', 'Stunning apartment with Eiffel Tower view', 250.00),
    ('Traditional Tokyo House', 'Authentic Japanese experience in central Tokyo', 180.00),
    ('NYC Penthouse', 'Modern penthouse with city skyline views', 350.00),
    ('Barcelona Beach Villa', 'Beachfront property with private pool', 420.00)
  ) AS p(name, description, price_per_night)
CROSS JOIN (SELECT user_id FROM "User" WHERE email = 'sarah@example.com') AS u
CROSS JOIN (SELECT location_id FROM Location WHERE city = 'Paris' LIMIT 1) AS l
LIMIT 1;

-- Add more properties
INSERT INTO Property (property_id, host_id, name, description, location_id, price_per_night, created_at) 
SELECT 
  uuid_generate_v4(),
  u.user_id,
  p.name,
  p.description,
  l.location_id,
  p.price_per_night,
  CURRENT_TIMESTAMP
FROM 
  (VALUES
    ('Traditional Tokyo House', 'Authentic Japanese experience in central Tokyo', 180.00),
    ('NYC Penthouse', 'Modern penthouse with city skyline views', 350.00),
    ('Barcelona Beach Villa', 'Beachfront property with private pool', 420.00),
    ('Kyoto Zen Retreat', 'Peaceful traditional house near temples', 150.00)
  ) AS p(name, description, price_per_night)
JOIN (SELECT user_id FROM "User" WHERE email = 'michael@example.com') AS u ON true
JOIN Location l ON l.city = 
  CASE 
    WHEN p.name = 'Traditional Tokyo House' THEN 'Tokyo'
    WHEN p.name = 'NYC Penthouse' THEN 'New York'
    WHEN p.name = 'Barcelona Beach Villa' THEN 'Barcelona'
    WHEN p.name = 'Kyoto Zen Retreat' THEN 'Kyoto'
  END;

-- Insert bookings
WITH 
  users AS (SELECT user_id, email FROM "User"),
  properties AS (SELECT property_id, name, price_per_night FROM Property)
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
SELECT
  uuid_generate_v4(),
  p.property_id,
  u.user_id,
  b.start_date,
  b.end_date,
  (b.nights * p.price_per_night) * (1 - b.discount) AS total_price,
  b.status,
  b.created_at
FROM
  (VALUES
    ('Luxury Paris Apartment', 'emma@example.com', '2023-06-10', '2023-06-17', 7, 0.1, 'confirmed', '2023-05-01 14:30:00'),
    ('Traditional Tokyo House', 'james@example.com', '2023-07-15', '2023-07-22', 7, 0.0, 'confirmed', '2023-04-20 10:15:00'),
    ('NYC Penthouse', 'emma@example.com', '2023-08-05', '2023-08-12', 7, 0.15, 'confirmed', '2023-06-10 16:45:00'),
    ('Barcelona Beach Villa', 'james@example.com', '2023-09-01', '2023-09-08', 7, 0.05, 'pending', '2023-07-12 09:30:00'),
    ('Kyoto Zen Retreat', 'emma@example.com', '2023-10-10', '2023-10-20', 10, 0.2, 'confirmed', '2023-08-15 11:20:00')
  ) AS b(property_name, user_email, start_date, end_date, nights, discount, status, created_at)
JOIN properties p ON p.name = b.property_name
JOIN users u ON u.email = b.user_email;

-- Insert payments
WITH bookings AS (
  SELECT b.booking_id, b.total_price, b.created_at 
  FROM Booking b
  JOIN Property p ON b.property_id = p.property_id
  WHERE p.name IN ('Luxury Paris Apartment', 'Traditional Tokyo House', 'NYC Penthouse', 'Kyoto Zen Retreat')
)
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
SELECT
  uuid_generate_v4(),
  booking_id,
  total_price,
  created_at + INTERVAL '1 hour',
  CASE 
    WHEN RANDOM() < 0.4 THEN 'credit_card'
    WHEN RANDOM() < 0.7 THEN 'paypal'
    ELSE 'stripe'
  END
FROM bookings;

-- Insert reviews
WITH 
  users AS (SELECT user_id, email FROM "User"),
  properties AS (SELECT property_id, name FROM Property),
  bookings AS (SELECT property_id, user_id FROM Booking WHERE status = 'confirmed')
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
SELECT
  uuid_generate_v4(),
  p.property_id,
  u.user_id,
  r.rating,
  r.comment,
  b.created_at + INTERVAL '2 days'
FROM
  (VALUES
    ('Luxury Paris Apartment', 'emma@example.com', 5, 'Absolutely stunning views and perfect location!'),
    ('Traditional Tokyo House', 'james@example.com', 4, 'Authentic experience, would recommend'),
    ('NYC Penthouse', 'emma@example.com', 5, 'Best city views I have ever seen'),
    ('Kyoto Zen Retreat', 'emma@example.com', 4, 'Peaceful and beautiful, a true retreat')
  ) AS r(property_name, user_email, rating, comment)
JOIN properties p ON p.name = r.property_name
JOIN users u ON u.email = r.user_email
JOIN bookings b ON b.property_id = p.property_id AND b.user_id = u.user_id;

-- Insert messages
WITH users AS (SELECT user_id, email FROM "User")
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
SELECT
  uuid_generate_v4(),
  s.user_id,
  r.user_id,
  m.message_body,
  m.sent_at
FROM
  (VALUES
    ('emma@example.com', 'sarah@example.com', 'Is the apartment available in June?', '2023-04-28 15:30:00'),
    ('sarah@example.com', 'emma@example.com', 'Yes, it is available!', '2023-04-28 16:45:00'),
    ('james@example.com', 'michael@example.com', 'Do you provide airport pickup?', '2023-06-10 09:15:00'),
    ('michael@example.com', 'james@example.com', 'We can arrange it for an extra fee', '2023-06-10 11:20:00'),
    ('emma@example.com', 'michael@example.com', 'Can we check in early?', '2023-07-22 08:30:00')
  ) AS m(sender_email, recipient_email, message_body, sent_at)
JOIN users s ON s.email = m.sender_email
JOIN users r ON r.email = m.recipient_email;