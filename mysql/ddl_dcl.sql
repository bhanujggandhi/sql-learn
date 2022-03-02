--*****************************************************************************************
--Data Definition Language
--*****************************************************************************************
/*
Used to define data in the database or define a table
CREATE, ALTER, DROP
*/

-- CREATE
/*
Syntax: CREATE TABLE <TableName> (id INT PRIMARY, col1 VARCHAR(50) NOT NULL);

# Datatypes: https://www.journaldev.com/16774/sql-data-types

# Constraints: https://www.w3schools.com/sql/sql_constraints.asp

NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are different (May contain NULL)
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Uniquely identifies a row/record in another table
CHECK - Ensures that all values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column when no value is specified
INDEX - Used to create and retrieve data from the database very quickly

*/
CREATE TABLE language ( id INT PRIMARY KEY,
lang VARCHAR(50) NOT NULL DEFAULT 'Not Defined');
DESCRIBE language;

-- ALTER
/*
ALTER: ADD, MODIFY, DROP

ALTER TABLE language ADD country VARCHAR(50);

ALTER TABLE language MODIFY country VARCHAR(60);

ALTER TABLE langauge DROP country;
*/
ALTER TABLE language ADD country VARCHAR(50);
ALTER TABLE language MODIFY country VARCHAR(60);
ALTER TABLE language DROP country; -- DROP COLUMN country

-- DROP
/*
# Removes both the table and all of the data permanently.
DROP TABLE Tablename;

DROP TABLE TableName IF EXISTS;

#https://dev.mysql.com/doc/refman/8.0/en/drop-table.html

TRUNCATE TABLE TableName;
# as discussed earlier same as DELETE FROM TableName;

In SQL, the DROP command is used to remove the whole database or table indexes, data, and more. Whereas the TRUNCATE command is used to remove all the rows from the table.
*/

--*****************************************************************************************
--Data Control Language
--*****************************************************************************************
/*
Used to give permission (GRANT) or take away the permission (REVOKE) from the database.GRANT, REVOKE
*/

# https://en.wikipedia.org/wiki/Data_control_language
# https://dev.mysql.com/doc/refman/8.0/en/grant.html
# https://dev.mysql.com/doc/refman/8.0/en/revoke.html





