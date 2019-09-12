1) Show all rental contracts (incl. dates, customer names and total amount), which contain any notes  and  also who was the employee to finalize this contract:

SELECT 
`rental_contracts`.`contract_ID`,`rental_contracts`.`start_date`, `rental_contracts`.`end_date`,`rental_contracts`.`notes`,
`invoices`.`total_amount`, `invoices`.`status`,
concat(`customers`.`first_name`, ' ', `customers`.`last_name`) as `Customer`, 
concat(`employees`.`first_name`, ' ', `employees`.`last_name`) as `Manager`
FROM `rental_contracts`
JOIN `customers` ON `fk_customer_ID` = `customer_ID`
JOIN `employees` ON `fk_employee_ID` = `employee_ID`
JOIN `invoices` ON `fk_invoice_ID` = `invoice_ID`
WHERE `rental_contracts`.`notes` IS NOT NULL

Result: only one entry, which had a note

----------------------------------------------------
2) Show only  contracts, that have additional products booked, who booked them and what are the products.
SELECT `rental_contracts`.`contract_ID`, `products`.`prod_name`, 
concat(`customers`.`first_name`, ' ', `customers`.`last_name`) as `Customer`
FROM `rental_contracts`
JOIN `customers` ON `fk_customer_ID` = `customer_ID`
JOIN `products_to_contracts` ON `fk_contract_ID` = `contract_ID`
JOIN `products` ON `fk_product_ID` = `product_ID`

Result: only contract 8 with many products
------------------------------------------------------------------------
2a) Show all contracts and if there are any additional products booked and what are these products.
SELECT `rental_contracts`.`contract_ID`, `products`.`prod_name`
FROM `rental_contracts`
LEFT JOIN `products_to_contracts`ON `fk_contract_ID` = `contract_ID`
LEFT JOIN `products` ON `fk_product_ID` = `product_ID`

Result: all  contracts where 5, 6, 7 have NULL and only 8 has many products
------------------------------------------------------------------------
3) Show all products and contracts to see the current booking situation for the upcoming bookings and also the names of the customers:

SELECT 
`rental_contracts`.`contract_ID`, 
concat (`customers`.`first_name`, ' ', `customers`.`last_name`) as `Customer`,
`products`.`prod_name`
FROM `rental_contracts`
LEFT JOIN `products_to_contracts`ON `fk_contract_ID` = `contract_ID`
LEFT JOIN `products` ON `fk_product_ID` = `product_ID`
JOIN `customers` ON `fk_customer_ID` = `customer_ID`
WHERE `rental_contracts`.`start_date` LIKE '2019-09%'
UNION
SELECT 
`rental_contracts`.`contract_ID`, 
concat (`customers`.`first_name`, ' ', `customers`.`last_name`) as `Customer`,
`products`.`prod_name`
FROM `rental_contracts`
LEFT JOIN `products_to_contracts`ON `fk_contract_ID` = `contract_ID`
LEFT JOIN `products` ON `fk_product_ID` = `product_ID`
JOIN `customers` ON `fk_customer_ID` = `customer_ID`
WHERE `rental_contracts`.`start_date` LIKE '2019-09%'
------------------------------------------------------------------------

4) Show all cars that are currently parked at all locations

SELECT 
concat(`cars`.`brand`, ' ', `cars`.`model`) as `Car`, 
`location_name`, 
concat (`city`,', ', `street`,', ', `house_no`) as `Address`
FROM `cars`
JOIN `locations` ON `fk_location_ID` = `location_ID`
JOIN `address` ON `fk_address_ID` = `address_ID`

4b) Show all cars which are available for rental 
(to check – include `cars`.`status` in previous query)

SELECT 
concat(`cars`.`brand`, ' ', `cars`.`model`) as `Car`, `cars`.`status`,
`location_name`, 
concat (`city`,', ', `street`,', ', `house_no`) as `Address`
FROM `cars`
JOIN `locations` ON `fk_location_ID` = `location_ID`
JOIN `address` ON `fk_address_ID` = `address_ID`
WHERE `cars`.`status` = 'stdby'

-----------------------------------------------------------------------------
5) Show contracts and cars assigned to bookings, that are in the future and also if there any optional extras booked

SELECT 
`rental_contracts`.`contract_ID`, 
concat(`cars`.`brand`, ' ', `cars`.`model`) as `Car`, 
`pick_up_date`, `pick_up_date`, 
`prod_name` as `booked extras`,`rental_contracts`.`notes`
FROM `cars`
JOIN `cars_to_contracts` ON `fk_VIN` = `VIN`
JOIN `rental_contracts`ON `fk_contract_ID` = `contract_ID`
JOIN `products_to_contracts` ON  `products_to_contracts`.`fk_contract_ID` = `contract_ID`
JOIN `products` ON `fk_product_ID` = `product_ID`
WHERE `cars_to_contracts`.`pick_up_date` > NOW();