SELECT EXTRACT(MONTH FROM INTERVAL '5 years 20 months');

SELECT date_trunc('year', date '1992/11/13');

SELECT EXTRACT(DAY FROM '2000/10/04'::date) AS DAY;

SELECT AGE('2000-10-04'::date, date '1996-02-17');

SELECT date '1800/01/01'; -- same as '1800/01/01'::date;
SELECT now() - '2022/01/01';

SELECT TO_CHAR(CURRENT_DATE, 'MM ddth, yyyy');
SELECT NOW()::date;
SELECT CURRENT_DATE;

SELECT * FROM timezones;

-- insert into timezones values(
--     timestamp without time zone '2022-01-01 10:00:00-05',
--     timestamp with time zone '2022-01-01 10:00:00-05'
-- );

/*
create table timezones(
    ts timestamp without time zone,
    tz timestamp with time zone
);
*/

-- Alter user postgres set timezone='UTC';

-- SET time zone 'UTC';
SHOW timezone;