# ---------------------------------------------------------------------- #
# Target DBMS:           MySQL                                           #
# Project name:          Northwind                                       #
# ---------------------------------------------------------------------- #
DROP DATABASE IF EXISTS CarDealershipDatabase;

CREATE DATABASE IF NOT EXISTS CarDealershipDatabase;

USE CarDealershipDatabase;

# ---------------------------------------------------------------------- #
# Tables                                                                 #
# ---------------------------------------------------------------------- #
# ---------------------------------------------------------------------- #
# Add table "DEALERSHIPS"                                                 #
# ---------------------------------------------------------------------- #

CREATE TABLE `DEALERSHIPS` (
    dealership_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(50),
    phone VARCHAR(12)
);

CREATE INDEX `CategoryName` ON `Categories` (`CategoryName`);

# ---------------------------------------------------------------------- #
# Add table "VEHICLES"                                       #
# ---------------------------------------------------------------------- #

CREATE TABLE `Vehicles` (
    VIN VARCHAR(17) PRIMARY KEY NOT NULL, -- Vehicle Identification Number, standard 17 chars
    make VARCHAR(50),
    model VARCHAR(50),
    year INT NOT NULL,
    color VARCHAR(30),
    odometer INT,
    price DECIMAL(10, 2),
    sold BOOLEAN DEFAULT FALSE
);

# ---------------------------------------------------------------------- #
# Add table "CustomerDemographics"                                       #
# ---------------------------------------------------------------------- #

CREATE TABLE `INVENTORY` (
    dealership_id INT,
    VIN VARCHAR(17),
    PRIMARY KEY (dealership_id, VIN),
    FOREIGN KEY (dealership_id) REFERENCES dealerships(dealership_id) ON DELETE CASCADE,
    FOREIGN KEY (VIN) REFERENCES vehicles(VIN) ON DELETE CASCADE
);
# ---------------------------------------------------------------------- #
# Add table "Customers"                                                  #
# ---------------------------------------------------------------------- #

CREATE TABLE `SALES_CONTRACTS` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    VIN VARCHAR(17),
    customer_name VARCHAR(100),
    customer_address VARCHAR(150),
    sale_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    sale_price DECIMAL(10, 2),
    FOREIGN KEY (VIN) REFERENCES vehicles(VIN) ON DELETE RESTRICT
);

# ---------------------------------------------------------------------- #
# Add table "Lease_contracts"                                                  #
# ---------------------------------------------------------------------- #

CREATE TABLE `Lease_contracts` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    VIN VARCHAR(17),
    customer_name VARCHAR(100),
    customer_address VARCHAR(150),
    lease_start_date DATE,
    lease_end_date DATE,
    monthly_payment DECIMAL(10, 2),
    FOREIGN KEY (VIN) REFERENCES vehicles(VIN) ON DELETE RESTRICT
);

# ---------------------------------------------------------------------- #
# Add info into "DEALERSHIPS"                                             #
# ---------------------------------------------------------------------- #

TRUNCATE TABLE DEALERSHIPS;
INSERT INTO DEALERSHIPS (NAME, ADDRESS, PHONE)
VALUES ('Luxury Motors', '123 Main St, Anytown', '555-123-4567'),
('City Cars', '456 Oak Ave, Big City', '555-987-6543'),
('Southside Auto', '789 Pine Ln, Smallville', '555-111-2222');

# ---------------------------------------------------------------------- #
# Add info into "VEHICLES"                                              #
# ---------------------------------------------------------------------- #

TRUNCATE TABLE VEHICLES;
INSERT INTO VEHICLES (VIN, make, model, year, color, odometer, price, sold)
VALUES ('ABCDE1234567890FG', 'Tesla', 'Model 3', 2023, 'Red', 500, 45000.00, FALSE),
('HIJKL9876543210MN', 'Ford', 'F-150', 2022, 'Black', 15000, 38000.00, FALSE),
('OPQRS1122334455667', 'Honda', 'Civic', 2021, 'Blue', 25000, 22000.00, FALSE),
('TUVWX0099887766554', 'Toyota', 'Camry', 2020, 'Silver', 40000, 18500.00, TRUE),
('YZABC6677889900112', 'BMW', 'X5', 2023, 'White', 1000, 62000.00, FALSE),
('DEFGH3344556677889', 'Mercedes-Benz', 'C-Class', 2022, 'Gray', 8000, 41000.00, FALSE),
('JKLMN9900112233445', 'Chevrolet', 'Silverado', 2021, 'Green', 30000, 32000.00, FALSE);

# ---------------------------------------------------------------------- #
# Add info into "INVENTORY"                                              #
# ---------------------------------------------------------------------- #

TRUNCATE TABLE INVENTORY;

INSERT INTO INVENTORY (dealership_id, VIN) 
VALUES (1, 'ABCDE1234567890FG'), -- Tesla Model 3 at Luxury Motors
(1, 'YZABC6677889900112'), -- BMW X5 at Luxury Motors
(2, 'HIJKL9876543210MN'), -- Ford F-150 at City Cars
(2, 'OPQRS1122334455667'), -- Honda Civic at City Cars
(3, 'DEFGH3344556677889'), -- Mercedes-Benz C-Class at Southside Auto
(3, 'JKLMN9900112233445'); -- Chevrolet Silverado at Southside Auto

# ---------------------------------------------------------------------- #
# Add info into "SALES_CONTRACTS"                                                 #
# ---------------------------------------------------------------------- #

TRUNCATE TABLE SALES_CONTRACTS;

INSERT INTO SALES_CONTRACTS (VIN, customer_name, customer_address, sale_date, sale_price)
VALUES ('TUVWX0099887766554', 'John Doe', '101 Elm St, Anytown', '2024-05-15 10:30:00', 18500.00);

# ---------------------------------------------------------------------- #
# Add info into "LEASE_CONTRACTS"                                                 #
# ---------------------------------------------------------------------- #

TRUNCATE TABLE LEASE_CONTRACTS;

INSERT INTO LEASE_CONTRACTS (VIN, customer_name, customer_address, lease_start_date, lease_end_date, monthly_payment)
VALUES ('OPQRS1122334455667', 'Jane Smith', '202 Oak St, Big City', '2024-06-01', '2027-05-31', 350.00);

