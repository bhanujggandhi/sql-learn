/*
* DB: Employees
* Table: titles
* Question: What unique titles do we have?
*/

SELECT DISTINCT title FROM titles;


/*
* DB: Employees
* Table: employees
* Question: How many unique birth dates are there?
*/

SELECT count(DISTINCT birth_date) FROM employees;


SELECT DISTINCT salary FROM salaries;

/*
* DB: Employees
* Table: employees
* Question: Get me all the employees above 60, use the appropriate date functions
*/

SELECT * FROM employees
WHERE EXTRACT(YEAR FROM AGE(birth_date))>60;

/*
* DB: Employees
* Table: employees
* Question: How many employees where hired in February?
*/

SELECT count(emp_no) FROM employees
WHERE EXTRACT(MONTH FROM hire_date) = 02;

/*
* DB: Employees
* Table: employees
* Question: How many employees were born in november?
*/

SELECT * FROM employees
WHERE EXTRACT(MONTH FROM birth_date) = 11;

/*
* DB: Employees
* Table: employees
* Question: Who is the oldest employee? (Use the analytical function MAX)
*/

SELECT MAX(AGE(birth_date)) FROM employees;



/*
* DB: Employees
* Table: employees
* Question: Find the age of all employees who's name starts with M.
* Sample output: https://imgur.com/vXs4093
* Use EXTRACT (YEAR FROM AGE(birth_date)) we will learn about this in later parts of the course
*/
SELECT first_name, EXTRACT (YEAR FROM AGE(birth_date)) AS "age" FROM employees
WHERE first_name ILIKE 'm%';


/*
* DB: Employees
* Table: employees
* Question: How many people's name start with A and end with R?
* Expected output: 1846
*/
SELECT first_name FROM employees
WHERE first_name ILIKE 'a%r';                                         


-- Practice LIKE keyword 
SELECT * FROM employees
WHERE first_name ILIKE 'M__ry' AND emp_no::TEXT ILIKE '1%';

SELECT * FROM employees
WHERE emp_no IN (100001, 100006, 11008);


-- Select statement to find Mayumi Schueller 
SELECT * FROM employees
/*
filter on first name AND last name to limit the amount of data returned and focus the filtering on a single person
*/  
WHERE first_name = 'Mayumi' AND last_name = 'Schueller';
