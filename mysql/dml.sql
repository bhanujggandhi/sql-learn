--*****************************************************************************************
--Data Manipulation Language
--*****************************************************************************************
/*
Used to manipulate data in the database
SELECT, INSERT, UPDATE, DELETE
*/
-- SELECT

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

/*
GROUP BY: It groups the data and we can query anything related to the group in this case number of movies in the group of years.
*/

SELECT YEAR, COUNT(YEAR) FROM movies GROUP BY YEAR ORDER BY YEAR;

--Alias is Grouped data
SELECT YEAR, COUNT(YEAR) year_count FROM movies GROUP BY YEAR ORDER BY year_count;
-- year_count is an alias.
-- often used with COUNT, MIN, MAX or SUM.
-- if grouping columns contain NULL values, all null values are grouped together.

/*
How to filter groups?
HAVING keyword: Having is used to filter data out of groups
    eg: Below we want to filter those groups which have year_count alias greater than 1000
*/

SELECT YEAR, COUNT(YEAR) year_count FROM movies
GROUP BY YEAR
HAVING year_count > 1000
ORDER BY year_count;

/*
Order of execution:
1. GROUP BY to create groups
2. apply the AGGREGATE FUNCTION
3. Apply HAVING condition.
*/

SELECT NAME, YEAR  FROM movies HAVING YEAR>2000;
# HAVING without GROUP BY is same as WHERE

SELECT YEAR, COUNT(YEAR) year_count FROM movies WHERE rankscore>9 GROUP BY YEAR HAVING year_count>20;

/*
Order of execution:
    1. WHERE to filtter all the rows with rankscore > 9
    2. Then GROUP BY year to group the data.
    3. COUNT function is applied on the year and alias given as year_count
    4. year_count > 20 is filtered out of the groups

# HAVING vs WHERE
## WHERE is applied on individual rows while HAVING is applied on groups.
## HAVING is applied after grouping while WHERE is used before grouping.
*/

--To refer order of operators
--Refer: https://dev.mysql.com/doc/refman/8.0/en/select.html

--*****************************************************************************************
--JOINs in SQL
--*****************************************************************************************
--Used to combine data from multiple tables, unleash the power of RDBMS and using relations to get the related data.

/*
JOIN keyword, ON keyword
We can JOIN two tables based ON some condition.
The below query says:
    1. FROM movies alias m JOIN movies_genres alias g
    2. Based on condition id = movie_id
    3. Give me the movie name and genre
*/

SELECT m.name, g.genre FROM movies m 
    JOIN movies_genres g  -- INNER JOIN movies_genres g (This will also work)
ON m.id = g.movie_id;

#Table aliases: m and g

/*
Natural Join: A join where we have the same column names across the table. In that case we do not need to specify the join condition, SQL will automatically detect PK and FK and join on their basis.
eg: #T1: C1, C2
    #T2: C1, C3, C4
    
    SELECT * FROM T1 JOIN T2;
    SELECT * FROM T1 JOIN T2 USING (C1);
    Both are same. 2nd is more explicit way of saying using C1 JOIN T1 and T2
    
    # returns C1,C2,C3,C4
    # no need to use the keyword "ON"
    
Outer Join: It can be LEFT, RIGHT, or FULL. LEFT OUTER JOIN will give the Intersection + Left part with NULLs for the right values. Similarly, RIGHT OUTER JOIN will give the Intersection + Right part with NULLs for the left values. FULL OUTER JOIN will give INTERSECTION + Left part with NULLs for the right values + Right part with NULLs for the left values
*/

SELECT m.name, g.genre FROM movies m
    LEFT JOIN movies_genres g
ON m.id=g.movie_id LIMIT 20;

#LEFT JOIN or LEFT OUTER JOIN
#RIGHT JOIN or RIGHT OUTER JOIN
#FULL JOIN or FULL OUTER JOIN
#JOIN or INNER JOIN

# NULL for missing counterpart rows.

-- 3-way joins and k-way joins
SELECT a.first_name, a.last_name FROM actors a
    JOIN roles r ON a.id=r.actor_id
    JOIN movies m ON m.id=r.movie_id AND m.name='Officer 444';

-- Practical note about joins: Joins can be expensive computationally when we have large tables.


--*****************************************************************************************
--SubQueries or Nested Queries
--*****************************************************************************************
# List all actors in the movie Schindler's List

SELECT first_name, last_name
FROM   actors
WHERE  id IN (SELECT actor_id
              FROM   roles
              WHERE  movie_id IN (SELECT id
                                  FROM   movies
                                  WHERE  NAME = 'Schindler\'s List')); 
                                  
/*
This query says:
    1. Get me the ID of the movies having name Schindler's List (It can be an array or a single value)
    2. Get me actor_id of the actors who have roles in movie_id IN the above query
    3. Get me names of the actors who have actor_id present in the array resturned by the above query
*/

/*
First INNER QUERY is executed then it's result is used by the query just above it.

# IN, NOT IN, EXISTS, NOT EXISTS, ANY, ALL, Comparison operators
# EXISTS returns true if the subquery returns one or more records or NULL
# ANY operator returns TRUE if any of the subquery values meet the condition (Minimum should satisfy).
# ALL operator returns TRUE if all of the subquery values meet the condition (Maximum should satisfy).
*/

SELECT * FROM movies WHERE rankscore >= ALL (SELECT MAX(rankscore) FROM movies);
--Get me the movies which have rankscore greater than the max rankscore of the movies.

# https://en.wikipedia.org/wiki/Correlated_subquery


-- INSERT

INSERT INTO movies(id, NAME, YEAR, rankscore) VALUES( 412321, 'Thor', 2011, 7);
SELECT * FROM movies WHERE id=412321;

-- To Insert multiple tuples to the table
INSERT INTO movies(id, NAME, YEAR, rankscore) VALUES (412322, 'Iron Man', 2008, 7.9), (412323, 'Iron Man 2', 2010, 7);

-- INSERT FROM one table to annother using nnested sub query:
-- https://en.wikipedia.org/wiki/Insert_(SQL)#Copying_rows_from_other_tables

-- UPDATE
-- Update <TableName> set col1=val1, col2=val2 where condition
UPDATE movies SET rankscore = 9 WHERE id=412321;
# Update multiple rows also.
# Can be used along with Sub-queries.

-- DELETE
DELETE FROM movies WHERE id=412321;
# Remove all rows: TRUNCATE TABLE TableName; 
# Same as selete without a WHERE Clause.
