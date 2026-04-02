-- =============================================
-- SMART PARKING SYSTEM — MySQL Setup
-- =============================================

-- Database banao
CREATE DATABASE IF NOT EXISTS parking_system;
USE parking_system;

-- =============================================
-- TABLE 1: SLOTS
-- =============================================
CREATE TABLE IF NOT EXISTS slots (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    slot_number VARCHAR(20) NOT NULL UNIQUE,
    type        ENUM('bike','car','truck') NOT NULL,
    is_booked   BOOLEAN DEFAULT FALSE
);

-- =============================================
-- TABLE 2: BOOKINGS
-- =============================================
CREATE TABLE IF NOT EXISTS bookings (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id           VARCHAR(60)  NOT NULL UNIQUE,
    slot_number         VARCHAR(20)  NOT NULL,
    user_name           VARCHAR(100) NOT NULL,
    vehicle_number      VARCHAR(30)  NOT NULL,
    vehicle_type        ENUM('bike','car','truck') NOT NULL,
    booking_date        DATE         NOT NULL,
    booking_time        TIME         NOT NULL,
    amount              INT          NOT NULL,
    razorpay_order_id   VARCHAR(100),
    razorpay_payment_id VARCHAR(100),
    payment_status      ENUM('PENDING','PAID','FAILED') DEFAULT 'PENDING',
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (slot_number) REFERENCES slots(slot_number)
);

-- =============================================
-- SLOTS DATA INSERT
-- Bike: 40, Car: 30, Truck: 10
-- =============================================

-- BIKE SLOTS (BIKE-1 to BIKE-40)
INSERT IGNORE INTO slots (slot_number, type) VALUES
('BIKE-1','bike'),('BIKE-2','bike'),('BIKE-3','bike'),('BIKE-4','bike'),('BIKE-5','bike'),
('BIKE-6','bike'),('BIKE-7','bike'),('BIKE-8','bike'),('BIKE-9','bike'),('BIKE-10','bike'),
('BIKE-11','bike'),('BIKE-12','bike'),('BIKE-13','bike'),('BIKE-14','bike'),('BIKE-15','bike'),
('BIKE-16','bike'),('BIKE-17','bike'),('BIKE-18','bike'),('BIKE-19','bike'),('BIKE-20','bike'),
('BIKE-21','bike'),('BIKE-22','bike'),('BIKE-23','bike'),('BIKE-24','bike'),('BIKE-25','bike'),
('BIKE-26','bike'),('BIKE-27','bike'),('BIKE-28','bike'),('BIKE-29','bike'),('BIKE-30','bike'),
('BIKE-31','bike'),('BIKE-32','bike'),('BIKE-33','bike'),('BIKE-34','bike'),('BIKE-35','bike'),
('BIKE-36','bike'),('BIKE-37','bike'),('BIKE-38','bike'),('BIKE-39','bike'),('BIKE-40','bike');

-- CAR SLOTS (CAR-1 to CAR-30)
INSERT IGNORE INTO slots (slot_number, type) VALUES
('CAR-1','car'),('CAR-2','car'),('CAR-3','car'),('CAR-4','car'),('CAR-5','car'),
('CAR-6','car'),('CAR-7','car'),('CAR-8','car'),('CAR-9','car'),('CAR-10','car'),
('CAR-11','car'),('CAR-12','car'),('CAR-13','car'),('CAR-14','car'),('CAR-15','car'),
('CAR-16','car'),('CAR-17','car'),('CAR-18','car'),('CAR-19','car'),('CAR-20','car'),
('CAR-21','car'),('CAR-22','car'),('CAR-23','car'),('CAR-24','car'),('CAR-25','car'),
('CAR-26','car'),('CAR-27','car'),('CAR-28','car'),('CAR-29','car'),('CAR-30','car');

-- TRUCK SLOTS (TRUCK-1 to TRUCK-10)
INSERT IGNORE INTO slots (slot_number, type) VALUES
('TRUCK-1','truck'),('TRUCK-2','truck'),('TRUCK-3','truck'),('TRUCK-4','truck'),('TRUCK-5','truck'),
('TRUCK-6','truck'),('TRUCK-7','truck'),('TRUCK-8','truck'),('TRUCK-9','truck'),('TRUCK-10','truck');

-- =============================================
-- USEFUL QUERIES (Reference ke liye)
-- =============================================

-- Saare available slots dekhna:
-- SELECT * FROM slots WHERE is_booked = FALSE;

-- Saari paid bookings dekhna:
-- SELECT * FROM bookings WHERE payment_status = 'PAID' ORDER BY created_at DESC;

-- Ek slot free karna (exit ke baad):
-- UPDATE slots SET is_booked = FALSE WHERE slot_number = 'CAR-1';

-- Kisi ticket ki detail dekhna:
-- SELECT * FROM bookings WHERE ticket_id = 'TKT-XXXXXXXXXX';

-- Aaj ki bookings:
-- SELECT * FROM bookings WHERE booking_date = CURDATE() AND payment_status = 'PAID';

-- Total earnings aaj:
-- SELECT SUM(amount) AS aaj_ki_kamai FROM bookings WHERE booking_date = CURDATE() AND payment_status = 'PAID';
