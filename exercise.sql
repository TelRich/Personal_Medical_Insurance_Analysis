-- Questions

-- 1. How many female are smokers?
%%sql 
SELECT  COUNT(*) count
FROM    insurance
WHERE   sex = 'female' AND smoker = 'yes'  

-- 2. How many male are smokers?
%%sql 
SELECT  COUNT(*) count
FROM    insurance
WHERE   sex = 'male' AND smoker = 'yes'  

--3. Show the distribution of smokers and non smokers in each region 
%%sql
SELECT      region, smoker, COUNT(*) count
FROM        insurance
GROUP BY    region, smoker

--4. Is there a region where its average charge is below the overall average charge?

--Average charge by region
%%sql
SELECT region, AVG(charges) avg_charge
FROM insurance
GROUP BY region

--Overall average charge
%%sql
SELECT AVG(charges) overall_avg_charges
FROM insurance


%%sql

-- USING CTE

WITH overall as (
    SELECT  AVG(charges) overall_avg_charges
    FROM    insurance
)

SELECT region, AVG(charges) avg_charges
FROM insurance, overall
GROUP BY region
HAVING AVG(charges) < overall_avg_charges

%%sql

-- USING SUBQUERY

SELECT      region, AVG(charges) avg_charge
FROM        insurance
GROUP BY    region
HAVING      AVG(charges) < (SELECT AVG(charges) FROM insurance) 

--5. What can you say about people with children and those without children in terms of smoking
%%sql
WITH children AS (
    SELECT  *
    FROM    insurance
    WHERE   children > 0
)

SELECT      region, sex, smoker, COUNT(*) count
FROM        children
GROUP BY    region, sex, smoker
ORDER BY    count DESC
LIMIT       10

%%sql
WITH no_children AS (
    SELECT  * 
    FROM    insurance
    WHERE   children <= 0
)

SELECT      region, sex, smoker, COUNT(*) count
FROM        no_children
GROUP BY    region, sex, smoker
ORDER BY    count DESC
LIMIT       10

--6. Which region has the highest number of smokers?
%%sql
SELECT region, MAX(count) max_smoker
FROM    (
    SELECT      region, COUNT(*) count
    FROM        insurance
    WHERE       smoker = 'yes'
    GROUP BY    region
)

--7. Which region has the lowest number of smokers?
%%sql
SELECT      region, COUNT(*) count
FROM        insurance
WHERE       smoker = 'yes'
GROUP BY    region

%%sql
SELECT region, MIN(count) min_smoker
FROM    (
    SELECT      region, COUNT(*) count
    FROM        insurance
    WHERE       smoker = 'yes'
    GROUP BY    region
)

--8. What is the average charge from female?
%%sql
SELECT  sex, AVG(charges) avg_charge
FROM    insurance
WHERE   sex = 'female'