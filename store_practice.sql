/*
* DB: Store
* Table: orders
* Question: How many orders were made by customer 7888, 1082, 12808, 9623
*/

SELECT count(orderid) FROM orders
WHERE customerid IN (7888,1082,12808,9623);


/*
* DB: Store
* Table: customers
* Question: adjust the following query to display the null values as "No Address"
*/
-- SELECT coalesce(address2, 'No Address') 
-- FROM customers;

/*
* DB: Store
* Table: customers
* Question: Fix the following query to apply proper 3VL
*/

-- SELECT *
-- FROM customers
-- WHERE COALESCE(address2, 'No Address') IS NOT null;

/*
* DB: Store
* Table: customers
* Question: Fix the following query to apply proper 3VL
*/

SELECT COALESCE(lastName, 'Empty'), * FROM customers
WHERE (age IS NULL);

SELECT NULL = 1 OR 0 = 1 AS "HAHA";

/*
* DB: Store
* Table: Customers
* Question: 
* Select people either under 30 or over 50 with an income above 50000
* Include people that are 50
* that are from either Japan or Australia
*/

/*
* DB: Store
* Table: Orders
* Question: 
* What was our total sales in June of 2004 for orders over 100 dollars?
*/

SELECT * FROM customers
WHERE (age < 30 OR age >= 50) AND income > 50000 AND (country = 'Japan' OR country = 'Australia');

SELECT sum(totalamount) FROM orders
WHERE orderdate>='2004-06-01' AND orderdate <='2004-06-30' AND totalamount > 100;

SELECT SUM(totalamount) FROM orders
WHERE (orderdate >= '2004-06-01' AND orderdate <= '2004-06-30') 
AND totalamount > 100;

