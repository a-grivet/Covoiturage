--   Databse for Carpooling web application
--   Tables : trips, reservations

USE covoit;

-- temporarily disable foreign key constraints
SET FOREIGN_KEY_CHECKS = 0;

-- delete the child table, then the parent table
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS trips;

-- enable key constraints
SET FOREIGN_KEY_CHECKS = 1;


-- TABLE : trips
CREATE TABLE trips (
    id INT AUTO_INCREMENT PRIMARY KEY,

    driver_name     VARCHAR(100) NOT NULL,
    driver_email    VARCHAR(150) NOT NULL,
    driver_idafpa   VARCHAR(50)  NOT NULL,

    from_city       VARCHAR(100) NOT NULL,
    to_city         VARCHAR(100) NOT NULL,

    trip_date       DATE NOT NULL,
    trip_time       TIME NOT NULL,

    seats_total     INT NOT NULL,
    seats_taken     INT NOT NULL DEFAULT 0,

    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- TABLE : reservations
CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trip_id INT NOT NULL,

    passenger_name     VARCHAR(100) NOT NULL,
    passenger_email    VARCHAR(150) NOT NULL,
    passenger_idafpa   VARCHAR(50)  NOT NULL,

    seats INT NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_trip
        FOREIGN KEY (trip_id)
        REFERENCES trips(id)
        ON DELETE CASCADE
);

-- Index
CREATE INDEX idx_trip_date ON trips(trip_date);
CREATE INDEX idx_trip_route ON trips(from_city, to_city);
CREATE INDEX idx_reservation_trip ON reservations(trip_id);
