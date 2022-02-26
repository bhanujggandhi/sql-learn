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
