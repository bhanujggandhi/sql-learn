-- Double quotes means "columns"
-- single quotes means character and strings

SELECT emp_no, concat(first_name,' ' ,last_name) AS "Full Name" FROM employees;

-- Functions
/*
Two types of functions
1. Aggregate: It aggregates the data and give one output. Like: Sum, Avg, etc.
it works on cols
2. Scalar: It runs on each individual row. Like: Concat, etc. It will run on each row and concat whatever specified.
*/ 


-- Select statement to find Mayumi Schueller 
SELECT * FROM employees
/*
filter on first name AND last name to limit the amount of data returned and focus the filtering on a single person
*/  
WHERE first_name = 'Mayumi' AND last_name = 'Schueller';  

/*
using " instead of '
    '' for texts
    "" for tables
*/ 

-- Filtering data

/*
1. AND: When all are true then only it will be true
2. OR: If atleast one is true then it will return true.
There is a order of operation.
-> AND will be chained with the last filter (INTERSECTION of data)
-> OR will start a new filter (UNION of data)
-> Brackets () have highest priority
Parentheses > Multiplication/Division > Subtraction/Addition > NOT > AND > OR

If operators have equal precedence, then the operators are evaluated directionally i/e/ from Left to Right or Right to left
*/ 

SELECT count(*) FROM customers
WHERE (state = 'OR' OR state = 'NY')
AND gender = 'F';

--NOT is used before the comparison
SELECT count(*) FROM customers
WHERE NOT age = 55;

/*
How filters work?
FROM -> WHERE -> SELECT
First compiler will see FROM table then it will work on WHERE condition then it will SELECT the tuples(row) out of it.
*/

/*
When a column does not have any value its called NULL value. NULL is used to represent empty or missing. (Special value)

We can handle NULL values using IS keyword
    -> IS NULL
    -> IS NOT NULL
    eg: SELECT name FROM employees WHERE name IS NOT NULL;
    
We can represent Columns having NULL values in a better way using COALESCE function
 *SELECT coalesce(age, 20) FROM customers;*
 Customers having NULL age will be replaced by 20 or whatever specified.
*/

/*
Between and IN are also used to query among a range of data
*/

/*
LIKE keyword is used for patter matching.
    -> % means any
        eg: 'M%' means it should start with M after that anything
    -> _ means character
        eg: 'Bh_nuj' means it should have Bh then 1 character then nuj
        
Similary to LIKE there is a keyword called ILIKE which is case insensitive. Upper/Lower case does not matter.

Postgres SQL matches the pattern only on String or Text. So before matching any patter first CAST it to text.
We can cast any column to text using 2 ways
    1. colname::text
    2. CAST(colname AS DATATYPE) eg: CAST(zipcode AS TEXT)
*/


/*
Current Date:
    SELECT NOW()::date; OR SELECT CURRENT_DATE;
Format Date:
    SELECT TO_CHAR(CURRENT_DATE, '(Format String)MM ddth, yyyy');
Date Operations:
    Subtracting two dates will give us No. of days between the two dates.
    select now() - '2022/01/01';
Age Function
    AGE function will take date as input and tell you the (No. of years, No. of months, No. of years till now)
    SELECT AGE('2000-10-04'::date);
    SELECT AGE('2000-10-04', '2022-10-04'); --This will tell us the no. of years, months, and days between the two dates

We can extract different things from a date using EXTRACT keyword
    SELECT EXTRACT(YEAR from '2000-10-04'::date) as YEAR; 
    
Date truncate function can be used to round years, months, or days
    select date_trunc('year', date '1992/11/13'); -- this will output the date 1992/01/01 which means we are truncating to year
    
INTERVAL keyword: It will help us to go forward or backward in the interval of dash years or months.
    eg: SELECT * FROM orders WHERE purchaseDate <= now() - interval '30 days';
        Give me all the orders which have purchase date less than 30 days earlier from today
        
*/

/*
DISTINCT keyword removes duplicates.
    -> There can be one column or multiple columns.
        Two cols will be evaluated based on both the columns.

*/