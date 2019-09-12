Project structure:

1) STORY and explanation of connections between data entities;
Car Rental needs to keep track of their car fleet, customers, invoices, extra products booked by customers
Rental Contract is the main actor of this process and contains main infomation / links to information
One rental contract can be made only by one customer and perfect case scenario has only one car assigned to it, 
but Car Rental needs to cover as well force major cases when a customer requireds a new car during the rental period and the history of this manipulations needs to be tracked as well. That is why Contract to Car is many-to many connection. One contract can have only one invoice assigned to it.
The same is for the products: each product can be added to any contract and each contract can have many products, booked additionally, that is why I have a table to maintain many-to-many connection. If any products to ontract, invoice should be automatically recalculated.
Customer can have many contracts.
Cars can be parked at one location at a time or do not have location at all if rented.
Location can have many cars parked at it or zero.
Employee can work only at one office and office (location) can have several employees.
Car should have one category and category can be assigned to zero or many.

2) DB-development (exported as PDF files);
- cr10_valeria_nazarova_carrental_step1.pdf
- cr10_valeria_nazarova_carrental_step2.pdf
- cr10_valeria_nazarova_carrental_step3.pdf
database have been optimized up to certain extend during 3 steps, 
so I have decided to drop the 4th step as it would result in producing even more tables, 
and that was not the goal of the project, but I will share the ideas of optimization dirung code review
=^_^=

3) mySQL database (exported as SQL file);
- cr10_valeria_nazarova_carrental.sql
 
4) queries to DB (exported as SQL file);
- cr10_valeria_nazarova_carrental_queries.sql
