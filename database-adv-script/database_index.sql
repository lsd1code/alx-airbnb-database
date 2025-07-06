-- Implement Indexes for Optimization
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_properties_location ON properties(location);

-- Before adding indexes
EXPLAIN ANALYZE
SELECT p.*, r.*
FROM properties p
LEFT JOIN reviews r ON p.id = r.property_id
WHERE p.location = 'Paris';

-- Add indexes
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_reviews_property_id ON reviews(property_id);

-- After adding indexes
EXPLAIN ANALYZE
SELECT p.*, r.*
FROM properties p
LEFT JOIN reviews r ON p.id = r.property_id
WHERE p.location = 'Paris';