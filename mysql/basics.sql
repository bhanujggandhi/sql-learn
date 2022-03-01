SELECT * FROM movies;
-- SELECT queries whatever specified
-- Next to SELECT comes the columns. * means all the cols. We can also define col names instead of *
SELECT NAME, YEAR FROM movies;

-- Result Set: A set of rows that form the result of a query along with column-names and meta-data.

/* 
Order of the column names can be defined after the SELECT. Not necessarily as defined in table.
Order of the rows will be preserved as in the defined table table until ORDER BY is used.
*/

/*
How to implement pagination is SQL?
LIMIT Keyword: Can be used at the end of the query followed by a limit number (It gives the subset of result).
OFFSET Keyword: This will define after how many rows we want the LIMIT numbered rows.
                eg: LIMIT 20 OFFSET 40 means skip first 40 rows then give me 20 rows.
*/
SELECT id, NAME FROM movies LIMIT 20;
SELECT id, NAME FROM movies LIMIT 20 OFFSET 20;

/*
How to get Ordered Data?
ORDER BY <Col Name> ASC/DESC: This will give data ordered data in ascending or descending fashion.
-> Default order is ASC order

# the output row order maynot be same as the one in the table due to query optimzier and internal data-structres/indices.
*/

SELECT NAME, rankscore, YEAR FROM movies
ORDER BY YEAR DESC
LIMIT 10;

/*
How to get unrepeated data from a column?
DISTINCT <Col Name>: Removes the duplicate from a column.
*/
SELECT DISTINCT genre FROM movies_genres;

/*
When Distinct is applied on two columns, 1st or 2nd column may have duplicate but 1st + 2nd Column will never have duplicated value.
*/
SELECT DISTINCT first_name, last_name FROM directors
ORDER BY first_name;

--*****************************************************************************************
-- WHERE Clause
--*****************************************************************************************
/*
Give me those movies having rank score greater than 9
So, WHERE <Condition>
*/
SELECT * FROM movies WHERE rankscore > 9;

/*
The SQL WHERE clause is used to filter the results and apply conditions in a SELECT, INSERT, UPDATE, or DELETE statement.
The SQL ORDER BY clause is used to sort the records in the result set for a SELECT statement.
The SQL SELECT LIMIT statement is used to retrieve records from one or more tables in a database and limit the number of records returned based on a limit value.
We could have reached to the final answer efficiently in a query if it is executed as per the standard order of execution. This order is:
1) FROM : Choose and join tables to get base data
2) WHERE : Filters the base data.
3) GROUP BY : Aggregates the base data
4) HAVING : Filters the aggregated data
5) SELECT : Returns the final data
6) ORDER BY: Sorts the final data
7) LIMIT: Limits the returned data to a row count.
*/

SELECT * FROM movies WHERE rankscore > 9
ORDER BY rankscore DESC
LIMIT 20;
 
# Comparison Operators: = , <> or != , < , <= , >, >= 
SELECT * FROM movies_genres WHERE genre = 'Comedy';

SELECT * FROM movies_genres WHERE genre <> 'Horror'; -- Equivalent to genre != 'Horror'

/*
Handling NULLs:
NULL => doesnot-exist/unknown/missing

IS Keyword is used for NULL
IS NULL or IS NOT NULL
*/
SELECT * FROM movies WHERE rankscore IS NOT NULL;

/*
LOGICAL OPERATORS
-> AND, OR, NOT, ALL, ANY, BETWEEN, EXISTS, IN, LIKE, SOME
AND, OR, NOT: Exactly like boolean. AND means BOTH should be true. OR means ANY ONE should be true. NOT means not that condition should be true.
*/

SELECT NAME,YEAR,rankscore FROM movies WHERE NOT YEAR<=2000 LIMIT 20;
SELECT NAME,YEAR,rankscore FROM movies WHERE rankscore>9 OR YEAR>2007 ORDER BY YEAR DESC;

-- BETWEEN Keyword 
SELECT NAME,YEAR,rankscore FROM movies WHERE YEAR BETWEEN 1999 AND 2000;
#inclusive: year>=1999 and year<=2000

--Low value should always be <= High value
SELECT NAME,YEAR,rankscore FROM movies WHERE YEAR BETWEEN 2000 AND 1999;
#lowvalue <= highvalue else you will get an empty result set

--IN Keyword
SELECT director_id, genre FROM directors_genres WHERE genre IN ('Comedy','Horror');
# same as genre='Comedy' OR genre='Horror' OR so on...

--LIKE Keyword
SELECT first_name, last_name FROM actors WHERE first_name LIKE '_es%';
/*
% is wild card means anything
_ means any single character
    1. 'Tis%' : Starting with Tis
    2. '%es': Ends with es
    3. 'Agn_s': Agn followed by one character followed by s
    
-> If we want to macth % or _, we should use the backslash as the escape character: \% and \_
*/ 

--*****************************************************************************************
--AGGREGATE FUNCTIONS
--*****************************************************************************************

--Aggregate functions: Computes a single value on a set of rows and returns the aggreagate
--COUNT, MIN, MAX, SUM, AVG

SELECT MIN(YEAR) FROM movies;
SELECT MAX(YEAR) FROM movies;
SELECT COUNT(YEAR) FROM movies WHERE YEAR>2000;