-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 12, 2019 at 09:19 AM
-- Server version: 5.7.27-0ubuntu0.18.04.1
-- PHP Version: 7.2.19-0ubuntu0.18.04.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cr10_valeria_nazarova_carrental`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `address_ID` int(11) NOT NULL,
  `zip_code` varchar(10) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `house_no` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`address_ID`, `zip_code`, `country`, `city`, `street`, `house_no`) VALUES
(1, 'A1030', 'Austria', 'Vienna', 'Landstrasser Hauptstrasse', '3a'),
(2, '1100', 'Austria', 'Vienna', 'Laxenburgerstrasse', '15'),
(3, '1020', 'Austria', 'Vienna', 'Lassallestrasse', '3'),
(4, '1010', 'Austria', 'Vienna', 'Karl-Renner-Ring', '22'),
(5, '12345', 'Germany', 'Munchen', 'Musterstrasse', '10'),
(6, '34576', 'Germany', 'Frankfurt', 'Frankfurtergasse', '7/14'),
(7, '90210', 'USA', 'LosAngeles', 'BeverlyHillsDrive', '145'),
(8, '25678', 'Spain', 'Barcelona', 'Avenida Diagonal', '89'),
(9, '52078', 'Germany', 'Aachen', 'Stettingerstrasse', '25'),
(10, '45678', 'Germany', 'Wassenberg', 'Kirchstrasse', '46'),
(11, '41460', 'Germany', 'Neuss', 'Parkerstrasse', '6'),
(12, '141070', 'Russia', 'Moscow', 'Kosmonavtov', '59'),
(13, '8004', 'Schwitzerland', 'Zurich', 'Wolkenstrassee', '15');

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `VIN` varchar(17) NOT NULL,
  `brand` varchar(20) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `fuel` enum('diesel','super95','super98') DEFAULT NULL,
  `fk_location_ID` varchar(7) DEFAULT NULL,
  `license_plate_no` varchar(10) DEFAULT NULL,
  `status` enum('rented','stdby','service','damage') DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `fk_category_ID` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`VIN`, `brand`, `model`, `color`, `fuel`, `fk_location_ID`, `license_plate_no`, `status`, `notes`, `fk_category_ID`) VALUES
('12345g6yhju789kju', 'Toyota', 'Corolla', 'green', 'diesel', NULL, 'a45678', 'rented', NULL, 'cop01'),
('12sdfghy780kijhgd', 'Ford', 'Focus', 'blue', 'super95', 'VIE_01', '234dft', 'stdby', NULL, 'eco01'),
('12w4er5tgfcvfgtya', 'Toyota', 'Corolla', 'red', 'super95', 'VIE_01', 'er4567', 'damage', 'break in passenger side window broken, customer got a new car', 'cab01'),
('56gtyhjuik908jhgy', 'Mazda', 'rx7', 'red', 'super98', 'MUC_01', '176890', 'stdby', 'navigation system does not work - check', 'lux01'),
('ase4r5tyuh6jui890', 'Mazda', 'rx7', 'black', 'super98', 'MUC_01', 'dvgt67', 'service', NULL, 'min01'),
('qw3er5tgvb6yhju89', 'Mercedes', 'e200', 'orange', 'diesel', 'MUC_01', 'cvbtg6', 'stdby', NULL, 'std01');

-- --------------------------------------------------------

--
-- Table structure for table `cars_to_contracts`
--

CREATE TABLE `cars_to_contracts` (
  `fk_VIN` varchar(17) NOT NULL,
  `fk_contract_ID` int(11) DEFAULT NULL,
  `pick_up_date` datetime DEFAULT NULL,
  `drop_off_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cars_to_contracts`
--

INSERT INTO `cars_to_contracts` (`fk_VIN`, `fk_contract_ID`, `pick_up_date`, `drop_off_date`) VALUES
('12w4er5tgfcvfgtya', 6, '2019-05-10 10:00:00', '2019-05-12 10:00:00'),
('12345g6yhju789kju', 6, '2019-05-12 10:00:00', '2019-05-16 10:00:00'),
('qw3er5tgvb6yhju89', 8, '2019-09-20 12:00:00', '2019-09-25 12:00:00'),
('12w4er5tgfcvfgtya', 7, '2019-04-01 10:00:00', '2019-04-03 10:00:00'),
('12w4er5tgfcvfgtya', 5, '2019-07-10 12:00:00', '2019-07-15 12:00:00'),
('12w4er5tgfcvfgtya', 9, '2019-09-26 00:00:00', '2019-09-30 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `Category_ID` varchar(5) NOT NULL,
  `category_name` varchar(10) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `rental_rate` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`Category_ID`, `category_name`, `description`, `rental_rate`) VALUES
('cab01', 'cabrio', '2 doors, 1 big suitcase, no roof, max. 2pax, auto', '70.00'),
('cop01', 'compact', '4-5 doors, 1 big suitcase, 2 hand luggage, max. 4pax, a/c, manual', '45.00'),
('eco01', 'economy', '4 doors, 1 big suitcase, 2 hand luggage, max. 4pax,  manual', '35.00'),
('lux01', 'luxury', '5 doors, 4 big suitcase, max. 7pax, a/c, auto', '90.00'),
('min01', 'mini', '2-3 doors, 1 big suitcase, max. 2pax, manual', '25.00'),
('std01', 'standart', '4-5 doors, 2 big suitcase max. 5pax, a/c, manual', '50.00');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_ID` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `driver_license_no` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `fk_address_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_ID`, `first_name`, `last_name`, `driver_license_no`, `email`, `phone`, `date_of_birth`, `fk_address_ID`) VALUES
(1, 'Anna', 'Jones', 'A123456', 'annajones@ex.org', '00432221234567', '1973-02-15', 2),
(2, 'Martin', 'Strong', 'U234567', 'martinstr@ex.org', '0012345678907', '1985-01-23', 7),
(3, 'John', 'Mclein', 'RT23512345', 'jmc@ex.org', '002345654567', '1980-12-14', 4),
(4, 'Hans', 'Gruber', 'RU5678456', 'hans@ex.org', '00492341234568', '1965-09-18', 6),
(5, 'Julia', 'Roberts', 'BH67890543', 'juro@ex.org', '00345674356781', '1990-04-01', 8);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `employee_ID` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `fk_address_ID` int(11) DEFAULT NULL,
  `fk_location_ID` varchar(7) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `quit_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`employee_ID`, `first_name`, `last_name`, `fk_address_ID`, `fk_location_ID`, `hire_date`, `quit_date`) VALUES
(1, 'Angelina', 'Jolie', 9, 'VIE_01', '2015-10-15', NULL),
(2, 'Martin', 'Sheen', 10, 'VIE_01', '2016-02-01', '2019-08-31'),
(3, 'George', 'Clooney', 11, 'VIE_02', '2018-05-01', NULL),
(4, 'Bruce', 'Willice', 12, 'MUC_01', '2017-08-01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `invoice_ID` int(11) NOT NULL,
  `date_issued` datetime DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `paid_amount` decimal(10,2) DEFAULT NULL,
  `status` enum('open','closed','dispute') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`invoice_ID`, `date_issued`, `total_amount`, `paid_amount`, `status`) VALUES
(1, '2019-05-15 15:00:00', '124.00', '124.00', 'closed'),
(2, '2019-07-24 15:00:00', '250.00', '250.00', 'closed'),
(3, '2019-09-11 15:00:00', '35.00', '0.00', 'open'),
(4, '2019-04-20 15:00:00', '87.00', '60.00', 'dispute');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `location_ID` varchar(7) NOT NULL,
  `location_name` varchar(20) DEFAULT NULL,
  `fk_address_ID` int(11) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`location_ID`, `location_name`, `fk_address_ID`, `phone`) VALUES
('MUC_01', 'Munchen Hbf ', 5, '00491234567223'),
('VIE_01', 'Wien Mitte', 1, '00436646102214'),
('VIE_02', 'Praterstern', 3, '00436646105678');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `Product_ID` int(11) NOT NULL,
  `prod_name` varchar(20) DEFAULT NULL,
  `prod_description` varchar(255) DEFAULT NULL,
  `prod_price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`Product_ID`, `prod_name`, `prod_description`, `prod_price`) VALUES
(1, 'CDW', 'reduce driver responsibility to 400 EUR', '30.00'),
(2, 'Super CDW', 'reduce driver responsibility to 0 EUR', '50.00'),
(3, 'extra driver', '2nd driver for the whole time of rental', '45.00'),
(4, 'road assistance', '24hrs evacuation service or technical assistance', '100.00'),
(5, 'navigation', 'TomTom navigator with local maps', '20.00'),
(6, 'gas refill', 'additional charge in case if car is returned with empty tank', '48.00'),
(7, 'drop-off change', 'if car returned in other location than pick-up', '135.00'),
(29, 'child seat', 'provide seat for a child', '15.00');

-- --------------------------------------------------------

--
-- Table structure for table `products_to_contracts`
--

CREATE TABLE `products_to_contracts` (
  `fk_contract_ID` int(11) DEFAULT NULL,
  `fk_product_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products_to_contracts`
--

INSERT INTO `products_to_contracts` (`fk_contract_ID`, `fk_product_ID`) VALUES
(8, 2),
(8, 3),
(8, 5),
(8, 6),
(8, 4),
(9, 7);

-- --------------------------------------------------------

--
-- Table structure for table `rental_contracts`
--

CREATE TABLE `rental_contracts` (
  `contract_ID` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `fk_invoice_ID` int(11) DEFAULT NULL,
  `fk_customer_ID` int(11) DEFAULT NULL,
  `fk_employee_ID` int(11) DEFAULT NULL,
  `fk_start_Location_ID` varchar(7) DEFAULT NULL,
  `fk_end_Location_ID` varchar(7) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rental_contracts`
--

INSERT INTO `rental_contracts` (`contract_ID`, `start_date`, `end_date`, `fk_invoice_ID`, `fk_customer_ID`, `fk_employee_ID`, `fk_start_Location_ID`, `fk_end_Location_ID`, `notes`) VALUES
(5, '2019-07-10 12:00:00', '2019-07-15 12:00:00', 2, 5, 1, 'VIE_01', 'VIE_01', NULL),
(6, '2019-05-10 10:00:00', '2019-05-16 10:00:00', 1, 1, 1, 'VIE_01', 'VIE_01', 'car damage / break in, customer got replacement higher category'),
(7, '2019-04-01 18:00:00', '2019-04-03 18:00:00', 4, 3, 1, 'VIE_01', 'VIE_01', NULL),
(8, '2019-09-20 12:00:00', '2019-09-25 12:00:00', 3, 4, 4, 'MUC_01', 'MUC_01', NULL),
(9, '2019-09-26 00:00:00', '2019-09-30 00:00:00', NULL, 5, 3, 'VIE_01', 'VIE_02', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_ID`);

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`VIN`),
  ADD KEY `fk_location_ID` (`fk_location_ID`),
  ADD KEY `fk_category_ID` (`fk_category_ID`);

--
-- Indexes for table `cars_to_contracts`
--
ALTER TABLE `cars_to_contracts`
  ADD KEY `fk_VIN` (`fk_VIN`),
  ADD KEY `fk_contract_ID` (`fk_contract_ID`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`Category_ID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_ID`),
  ADD KEY `fk_address_ID` (`fk_address_ID`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_ID`),
  ADD KEY `fk_address_ID` (`fk_address_ID`),
  ADD KEY `fk_location_ID` (`fk_location_ID`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_ID`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`location_ID`),
  ADD KEY `fk_address_ID` (`fk_address_ID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`Product_ID`);

--
-- Indexes for table `products_to_contracts`
--
ALTER TABLE `products_to_contracts`
  ADD KEY `fk_contract_ID` (`fk_contract_ID`),
  ADD KEY `fk_product_ID` (`fk_product_ID`);

--
-- Indexes for table `rental_contracts`
--
ALTER TABLE `rental_contracts`
  ADD PRIMARY KEY (`contract_ID`),
  ADD KEY `fk_invoice_ID` (`fk_invoice_ID`),
  ADD KEY `fk_customer_ID` (`fk_customer_ID`),
  ADD KEY `fk_employee_ID` (`fk_employee_ID`),
  ADD KEY `fk_start_Location_ID` (`fk_start_Location_ID`),
  ADD KEY `fk_end_Location_ID` (`fk_end_Location_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `address_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `Product_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `rental_contracts`
--
ALTER TABLE `rental_contracts`
  MODIFY `contract_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_ibfk_1` FOREIGN KEY (`fk_location_ID`) REFERENCES `locations` (`location_ID`),
  ADD CONSTRAINT `cars_ibfk_2` FOREIGN KEY (`fk_category_ID`) REFERENCES `categories` (`Category_ID`);

--
-- Constraints for table `cars_to_contracts`
--
ALTER TABLE `cars_to_contracts`
  ADD CONSTRAINT `cars_to_contracts_ibfk_1` FOREIGN KEY (`fk_VIN`) REFERENCES `cars` (`VIN`),
  ADD CONSTRAINT `cars_to_contracts_ibfk_2` FOREIGN KEY (`fk_contract_ID`) REFERENCES `rental_contracts` (`contract_ID`);

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`fk_address_ID`) REFERENCES `address` (`address_ID`);

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`fk_address_ID`) REFERENCES `address` (`address_ID`),
  ADD CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`fk_location_ID`) REFERENCES `locations` (`location_ID`);

--
-- Constraints for table `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_ibfk_1` FOREIGN KEY (`fk_address_ID`) REFERENCES `address` (`address_ID`);

--
-- Constraints for table `products_to_contracts`
--
ALTER TABLE `products_to_contracts`
  ADD CONSTRAINT `products_to_contracts_ibfk_1` FOREIGN KEY (`fk_contract_ID`) REFERENCES `rental_contracts` (`contract_ID`),
  ADD CONSTRAINT `products_to_contracts_ibfk_2` FOREIGN KEY (`fk_product_ID`) REFERENCES `products` (`Product_ID`);

--
-- Constraints for table `rental_contracts`
--
ALTER TABLE `rental_contracts`
  ADD CONSTRAINT `rental_contracts_ibfk_1` FOREIGN KEY (`fk_invoice_ID`) REFERENCES `invoices` (`invoice_ID`),
  ADD CONSTRAINT `rental_contracts_ibfk_2` FOREIGN KEY (`fk_customer_ID`) REFERENCES `customers` (`customer_ID`),
  ADD CONSTRAINT `rental_contracts_ibfk_3` FOREIGN KEY (`fk_employee_ID`) REFERENCES `employees` (`employee_ID`),
  ADD CONSTRAINT `rental_contracts_ibfk_4` FOREIGN KEY (`fk_start_Location_ID`) REFERENCES `locations` (`location_ID`),
  ADD CONSTRAINT `rental_contracts_ibfk_5` FOREIGN KEY (`fk_end_Location_ID`) REFERENCES `locations` (`location_ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
