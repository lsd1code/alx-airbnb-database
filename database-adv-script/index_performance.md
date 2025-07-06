# Write SQL `CREATE INDEX` statements for these columns and save them in a file named `database_index.sql`. 

```sql
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_properties_location ON properties(location);
```