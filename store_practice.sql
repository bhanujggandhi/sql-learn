/*
* DB: Store
* Table: orders
* Question: Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
* ordered by orderid
*/
SELECT c.firstname, c.lastname, o.orderid, c.state 
FROM orders AS o INNER JOIN customers AS c 
ON o.customerid = c.customerid
WHERE c.state IN ('OH', 'OR', 'NY')
ORDER BY orderid;

/*
* DB: Store
* Table: products
* Question: Show me the inventory for each product
*/
SELECT p.prod_id, i.quan_in_stock, p.title
FROM products AS p INNER JOIN inventory AS i
ON p.prod_id = i.prod_id
ORDER BY p.prod_id;


/*
* DB: Store
* Table: orders
* Question: How many orders were made in January 2004?
*/

SELECT * FROM orders
-- where extract(year from orderdate) = 2004 and extract(month from orderdate) = 01;
WHERE date_trunc('month', orderdate) = '2004-01-01';

/*
* DB: Store
* Table: customers
* Question: How many people's zipcode have a 2 in it?.
* Expected output: 4211 
*/
SELECT count(zip) FROM customers
WHERE CAST(zip AS TEXT) LIKE '%2%';



/*
* DB: Store
* Table: customers
* Question: How many people's zipcode start with 2 with the 3rd character being a 1.
* Expected output: 109 
*/

SELECT zip FROM customers
WHERE CAST(zip AS TEXT) LIKE '2_1%';


/*
* DB: Store
* Table: customers
* Question: Which states have phone numbers starting with 302?
* Replace null values with "No State"                                                  
* Expected output: https://imgur.com/AVe6G4c
*/

SELECT COALESCE(state, 'No State') AS "State" FROM customers
WHERE phone::TEXT LIKE '302%';

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

