CREATE TABLE uber_ride (
    ride_id SERIAL PRIMARY KEY,
    ride_timestamp TIMESTAMP,
    ride_status VARCHAR(20)  -- "ride_completed", "cancelled_by_driver" or "cancelled_by_user"
);

-- Insert sample records
INSERT INTO uber_ride (ride_timestamp, ride_status)
VALUES
    ('2024-05-09 08:30:00', 'cancelled_by_driver'),
    ('2024-05-09 09:00:00', 'cancelled_by_user'),
    ('2024-05-09 10:00:00', 'ride_completed'),
    ('2024-05-09 11:00:00', 'cancelled_by_user'),
    ('2024-05-09 12:00:00', 'cancelled_by_driver'),
    ('2024-05-09 13:00:00', 'cancelled_by_user'),
    ('2024-05-09 14:00:00', 'cancelled_by_user'),
    ('2024-05-09 15:00:00', 'cancelled_by_user'),
    ('2024-05-09 16:00:00', 'ride_completed'),
    ('2024-05-09 17:00:00', 'cancelled_by_user'),
    ('2024-05-09 18:00:00', 'ride_completed'),
    ('2024-05-09 19:00:00', 'cancelled_by_user'),
    ('2024-05-09 20:00:00', 'cancelled_by_user'),
    ('2024-05-09 21:00:00', 'cancelled_by_user'),
    ('2024-05-09 22:00:00', 'cancelled_by_driver'),
    ('2024-05-09 13:00:00', 'cancelled_by_user'),
    ('2024-05-09 14:00:00', 'cancelled_by_user'),
    ('2024-05-09 15:00:00', 'cancelled_by_user'),
    ('2024-05-09 16:00:00', 'ride_completed'),
    ('2024-05-09 17:00:00', 'cancelled_by_user'),
    ('2024-05-09 18:00:00', 'cancelled_by_driver'),
    ('2024-05-09 19:00:00', 'cancelled_by_user'),
    ('2024-05-09 20:00:00', 'cancelled_by_user'),
    ('2024-05-09 21:00:00', 'cancelled_by_user'),
    ('2024-05-09 22:00:00', 'cancelled_by_driver');

SELECT * FROM uber_ride

--Find out % of ride cancelled by uber_driver
SELECT ROUND(100*COUNT(ride_id)::numeric/(SELECT COUNT(ride_id) FROM uber_ride WHERE ride_status<> 'ride_completed'),2)::numeric as cancelled_by_driver
FROM uber_ride
WHERE ride_status = 'cancelled_by_driver' 







	