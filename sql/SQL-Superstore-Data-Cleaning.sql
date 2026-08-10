-- Checking for duplicates
SELECT
    Order_ID,
    Product_ID,
    COUNT(*) AS DuplicateCount
FROM superstore
GROUP BY
    Order_ID,
    Product_ID
HAVING COUNT(*) > 1;

SELECT *
FROM superstore
WHERE Order_ID = 'IN-2014-45174'
ORDER BY Product_ID
  

-- Inspecting the two market columns
SELECT Market, Market2
FROM superstore
WHERE Market = 'Canada'

SELECT DISTINCT Order_Date
FROM superstore
  

-- Checking potential city name variations, specifically city names with accents
SELECT DISTINCT City
FROM superstore
WHERE City LIKE 'V%a'

SELECT
    City COLLATE Latin1_General_CI_AI AS NormalizedCity,
    COUNT(DISTINCT City) AS Variations
FROM superstore
GROUP BY City COLLATE Latin1_General_CI_AI
HAVING COUNT(DISTINCT City) > 1;

SELECT Country,
       City,
    COUNT(*)
FROM superstore
WHERE City COLLATE Latin1_General_CI_AI = 'Los Angeles'
OR City COLLATE Latin1_General_CI_AI = 'Macon'
OR City COLLATE Latin1_General_CI_AI = 'Vitoria'
GROUP BY Country, City
  

-- Deleting columns
ALTER TABLE superstore
DROP COLUMN Noneed

ALTER TABLE superstore
DROP COLUMN Market

SELECT DISTINCT Market
FROM superstore
  

-- Checking date format
SELECT TOP 20
Order_Date,
Ship_Date
FROM superstore
  

--Changing data types
ALTER TABLE superstore
ALTER COLUMN Order_Date DATE

ALTER TABLE superstore
ALTER COLUMN Ship_Date DATE

ALTER TABLE superstore
ALTER COLUMN Profit DECIMAL (18,2)

ALTER TABLE superstore
ALTER COLUMN Quantity INT

ALTER TABLE superstore
ALTER COLUMN Shipping_Cost DECIMAL(18,2)


--Detecting invalid numeric values stored as text 
SELECT *
FROM superstore
WHERE TRY_CAST(Profit AS DECIMAL(18,4)) IS NULL
AND Profit IS NOT NULL

SELECT Profit
FROM superstore
WHERE Profit LIKE '%e%'
  

-- Correcting scientific notation value before changing data type to DECIMAL
UPDATE superstore
SET Profit = '-0.0009'
WHERE Profit = '-9e-04'

ALTER TABLE superstore
ALTER COLUMN Profit DECIMAL (18,2)
