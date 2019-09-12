1) Show all rental contracts incl. total amount, which contain any notes  and  also who was the employee to finalize this contract:

SELECT 
`rental_contracts`.`contract_ID`,`rental_contracts`.`start_date`, `rental_contracts`.`end_date`,`rental_contracts`.`notes`,
`invoices`.`total_amount`, `invoices`.`status`,
concat(`customers`.`first_name`, ' ', `customers`.`last_name`) as `Customer`, 
concat(`employees`.`first_name`, ' ', `employees`.`last_name`) as `Manager`
FROM `rental_contracts`
JOIN `customers` ON `fk_customer_ID` = `customer_ID`
JOIN `employees` ON `fk_employee_ID` = `employee_ID`
JOIN `invoices` ON `fk_invoice_ID` = `invoice_ID`
WHERE `rental_contracts`.`notes` IS NOT NULL AND `rental_contracts`.`notes` <> '' 

Result: 2 entries, which had a note

----------------------------------------------------
2) Show rentals turnover for the months May-Aug 2019:

SELECT SUM(`total_amount`) as `turnover for May-Aug 2019` 
FROM `invoices` 
JOIN `rental_contracts` ON `rental_contracts`.`fk_invoice_ID` = `invoices`.`invoice_ID` 
WHERE `rental_contracts`.`start_date` BETWEEN '2019-05-01' and '2019-08-31'

Result: 374.00

----------------------------------------------------
3) Show current booking situation for the upcoming bookings (cars, products booked for dates later than today) with their respective locatons and notes:

SELECT 
`rental_contracts`.`contract_ID`, 
concat(`cars`.`brand`, ' ', `cars`.`model`) as `Car`, 
`pick_up_date`, `drop_off_date`, 
`location_name`,
`prod_name` as `booked extras`,`rental_contracts`.`notes`
FROM `cars`
JOIN `cars_to_contracts` ON `fk_VIN` = `VIN`
JOIN `locations` ON `locations`.`location_ID` = `cars`.`fk_location_ID`
JOIN `rental_contracts`ON `fk_contract_ID` = `contract_ID`
JOIN `products_to_contracts` ON  `products_to_contracts`.`fk_contract_ID` = `contract_ID`
JOIN `products` ON `fk_product_ID` = `product_ID`
WHERE `cars_to_contracts`.`pick_up_date` > NOW();

Result: conract 8 and 9 with rows of all products booked

----------------------------------------------------
3a) Show  all contracts an info about the optional extras booked on them (if any)

SELECT 
`rental_contracts`.`contract_ID`, 
concat(`cars`.`brand`, ' ', `cars`.`model`) as `Car`, 
`pick_up_date`, `drop_off_date`, 
`location_name`,
`prod_name` as `booked extras`,`rental_contracts`.`notes`
FROM `cars`
JOIN `cars_to_contracts` ON `fk_VIN` = `VIN`
JOIN `locations` ON `locations`.`location_ID` = `cars`.`fk_location_ID`
JOIN `rental_contracts`ON `fk_contract_ID` = `contract_ID`
LEFT JOIN `products_to_contracts` ON  `products_to_contracts`.`fk_contract_ID` = `contract_ID`
LEFT JOIN `products` ON `fk_product_ID` = `product_ID`

------------------------------------------------------------------------
4) Show all our cars, where they are parked and their status

SELECT 
concat(`cars`.`brand`, ' ', `cars`.`model`) as `Car`, 
`cars`.`status`,
`locations`.`location_name`
FROM `cars`
LEFT JOIN locations ON `locations`.`location_ID` = `cars`.`fk_location_ID`

Result: all cars, status and location - one will have NULL as it is rented

------------------------------------------------------------------------

5) Show all cars which are available for rental 

SELECT 
concat(`cars`.`brand`, ' ', `cars`.`model`) as `Car`, `cars`.`status`,
`location_name`, 
concat (`city`,', ', `street`,', ', `house_no`) as `Address`
FROM `cars`
JOIN `locations` ON `fk_location_ID` = `location_ID`
JOIN `address` ON `fk_address_ID` = `address_ID`
WHERE `cars`.`status` = 'stdby'

Result:
Ford Focus / stdby / Wien Mitte / Vienna, Landstrasser Hauptstrasse, 3a
Mazda rx7 / stdby / Munchen Hbf / Munchen, Musterstrasse, 10
Mercedes e200 / stdby / Munchen Hbf / Munchen, Musterstrasse, 10

------------------------------------------------------------------------
 6) Show all cars that are rented at the moment and when they will be available again and at which location drop off is planned.

SELECT `cars`.`brand`, `cars`.`model`, `cars`.`status`,
`cars_to_contracts`.`pick_up_date`, `cars_to_contracts`.`drop_off_date`,
`locations`.`location_name`
FROM `cars`
JOIN `cars_to_contracts` ON `cars`.`VIN` = `cars_to_contracts`.`fk_VIN`
JOIN `rental_contracts` ON `cars_to_contracts`.`fk_contract_ID` = `rental_contracts`.`contract_ID`
JOIN `locations`ON `rental_contracts`.`fk_end_location_ID` = `locations`.`location_ID`
WHERE `cars`.`status` = 'rented' AND `cars_to_contracts`.`drop_off_date`> NOW();

Result: Toyota Corolla / rented / 2019-09-03 / 2019-09-16 / Wien Mitte
