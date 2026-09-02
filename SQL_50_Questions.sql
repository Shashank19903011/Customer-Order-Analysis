-- =========================================================
-- SQL SERVER CUSTOMER & ORDER ANALYSIS
-- 50 SQL Queries
-- =========================================================

-- 01. Find customer name and order amount

SELECT C.CustomerName,
       O.Amount
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID;

-- =========================================================

-- 02. Calculate delivery days

SELECT OrderID,
       DATEDIFF(DAY, OrderDate, DeliveryDate) AS NoOfDays
FROM Orders;

-- =========================================================

-- 03. Find total sales by customer

SELECT C.CustomerName,
       SUM(O.Amount) AS TotalSales
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

-- =========================================================

-- 04. Find orders placed in 2026

SELECT COUNT(OrderID) AS TotalOrders
FROM Orders
WHERE YEAR(OrderDate) = 2026;

-- =========================================================

-- 05. Find customers who signed up before 2025

SELECT CustomerName
FROM Customers
WHERE YEAR(SignupDate) < 2025;

-- =========================================================

-- 06. Find CustomerName, OrderID, and OrderDate for all customers who placed an order in 2025

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
WHERE YEAR(O.OrderDate) = 2025;

-- =========================================================

-- 07. Find CustomerName, OrderID, and number of days taken for delivery for every order

SELECT C.CustomerName,
       O.OrderID,
       DATEDIFF(DAY, O.OrderDate, O.DeliveryDate) AS DeliveryDays
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID;

-- =========================================================

-- 08. Find CustomerName, OrderID, and the date that is 5 days after the order date

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate,
       DATEADD(DAY, 5, O.OrderDate) AS FiveDaysAfterOrder
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID;

-- =========================================================

-- 09. Find CustomerName, OrderID, and OrderDate for all orders placed in March, regardless of year

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
WHERE MONTH(O.OrderDate) = 3;

-- =========================================================

-- 10. Find CustomerName, OrderID, and OrderDate for all orders placed on the 15th day of any month

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
WHERE DAY(O.OrderDate) = 15;

-- =========================================================

-- 11. Find CustomerName, OrderID, and the name of the weekday on which each order was placed

SELECT C.CustomerName,
       O.OrderID,
       DATENAME(WEEKDAY, O.OrderDate) AS WeekName
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID;

-- =========================================================

-- 12. Find CustomerName, OrderID, OrderDate, and the quarter in which each order was placed

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate,
       DATEPART(QUARTER, O.OrderDate) AS QuarterNo
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID;

-- =========================================================

-- 13. Find CustomerName, OrderID, OrderDate, and the last date of the month in which each order was placed

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate,
       EOMONTH(O.OrderDate) AS MonthEndDate
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID;

-- =========================================================

-- 14. Find CustomerName, OrderID, OrderDate, and the first day of the month in which the order was placed

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate,
       DATEADD(DAY, 1, EOMONTH(O.OrderDate, -1)) AS FirstDayOfOrder
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID;

-- =========================================================

-- 15. Find CustomerName, SignupDate, and how many days the customer has been registered as of today

SELECT CustomerName,
       SignupDate,
       DATEDIFF(DAY, SignupDate, GETDATE()) AS RegisteredDays
FROM Customers;

-- =========================================================

-- 16. Find CustomerName, OrderID, OrderDate, DeliveryDate, and DeliveryStatus. <=3 Fast, 4-5 Normal, >5 Delayed

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate,
       O.DeliveryDate,
       DATEDIFF(DAY, O.OrderDate, O.DeliveryDate) AS DeliveryDays,
       CASE
           WHEN DATEDIFF(DAY, O.OrderDate, O.DeliveryDate) <= 3 THEN 'FAST'
           WHEN DATEDIFF(DAY, O.OrderDate, O.DeliveryDate) BETWEEN 4 AND 5 THEN 'NORMAL'
           ELSE 'DELAYED'
       END AS DeliveryStatus
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID;

-- =========================================================

-- 17. Find CustomerName, OrderID, OrderDate, OrderDate/DeliveryDate, DeliveryDays, and order month for orders taking more than 3 days

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate,
       O.DeliveryDate,
       DATEDIFF(DAY, O.OrderDate, O.DeliveryDate) AS DeliveryDays,
       DATENAME(MONTH, O.OrderDate) AS OrderMonth
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
WHERE DATEDIFF(DAY, O.OrderDate, O.DeliveryDate) > 3;

-- =========================================================

-- 18. Find the total sales amount for each year

SELECT YEAR(OrderDate) AS YearOfOrder,
       SUM(Amount) AS TotalSales
FROM Orders
GROUP BY YEAR(OrderDate);

-- =========================================================

-- 19. Find the total amount spent by each customer

SELECT C.CustomerName,
       SUM(O.Amount) AS TotalSpent
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

-- =========================================================

-- 20. Find how many orders each customer has placed

SELECT C.CustomerName,
       COUNT(O.OrderID) AS TotalOrders
FROM Customers C
LEFT JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

-- =========================================================

-- 21. Find customers who have NOT placed any orders

SELECT C.CustomerName,
       COUNT(O.OrderID) AS TotalOrders
FROM Customers C
LEFT JOIN Orders O
    ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL
GROUP BY C.CustomerName;

-- =========================================================

-- 22. Find customers whose total order amount is greater than 5,000

SELECT C.CustomerName,
       ROUND(SUM(O.Amount), 1) AS TotalAmount
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
HAVING SUM(O.Amount) > 5000;

-- =========================================================

-- 23. Find customers whose average order amount is greater than 2,000

SELECT C.CustomerName,
       ROUND(AVG(O.Amount), 1) AS AverageAmount
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
HAVING AVG(O.Amount) > 2000;

-- =========================================================

-- 24. Find the latest order date for each customer

SELECT C.CustomerName,
       MAX(O.OrderDate) AS LatestOrderDate
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

-- =========================================================

-- 25. Find the first order date for each customer

SELECT C.CustomerName,
       MIN(O.OrderDate) AS FirstOrderDate
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

-- =========================================================

-- 26. Find how many days passed between each customer's first order and latest order

SELECT C.CustomerName,
       MIN(O.OrderDate) AS FirstOrder,
       MAX(O.OrderDate) AS LatestOrder,
       DATEDIFF(DAY, MIN(O.OrderDate), MAX(O.OrderDate)) AS OrderSpanDays
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

-- =========================================================

-- 27. Find customers whose latest order was more than 100 days ago

SELECT C.CustomerName,
       MAX(O.OrderDate) AS LatestOrder,
       DATEDIFF(DAY, MAX(O.OrderDate), GETDATE()) AS DaysSinceLastOrder
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
HAVING DATEDIFF(DAY, MAX(O.OrderDate), GETDATE()) > 100;

-- =========================================================

-- 28. Find the number of orders placed in each month, regardless of year

SELECT MONTH(OrderDate) AS MonthOfOrder,
       COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY MONTH(OrderDate)
ORDER BY MONTH(OrderDate);

-- =========================================================

-- 29. Find the number of orders placed on each weekday

SELECT DATENAME(WEEKDAY, OrderDate) AS WeekName,
       COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY DATENAME(WEEKDAY, OrderDate);

-- =========================================================

-- 30. Find the total sales for each customer for each year

SELECT C.CustomerName,
       YEAR(O.OrderDate) AS YearOfOrder,
       SUM(O.Amount) AS TotalSales
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName, YEAR(O.OrderDate);

-- =========================================================

-- 31. Find the total sales for each customer for each month, regardless of year

SELECT C.CustomerName,
       MONTH(O.OrderDate) AS MonthOfOrder,
       SUM(O.Amount) AS TotalSales
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName, MONTH(O.OrderDate);

-- =========================================================

-- 32. Find the total sales for each month name, regardless of year

SELECT DATENAME(MONTH, OrderDate) AS MonthName,
       SUM(Amount) AS TotalSales
FROM Orders
GROUP BY DATENAME(MONTH, OrderDate);

-- =========================================================

-- 33. Find the total sales for each quarter and show only quarters where total sales are greater than 20,000

SELECT DATEPART(QUARTER, OrderDate) AS QuarterOrder,
       SUM(Amount) AS TotalSales
FROM Orders
GROUP BY DATEPART(QUARTER, OrderDate)
HAVING SUM(Amount) > 20000;

-- =========================================================

-- 34. Find the average number of days taken to deliver orders for each customer

SELECT C.CustomerName,
       AVG(DATEDIFF(DAY, O.OrderDate, O.DeliveryDate)) AS AvgDeliveryDays
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

-- =========================================================

-- 35. Calculate total sales for each customer and classify them: >10000 High, 5000-10000 Medium, otherwise Low

SELECT C.CustomerName,
       SUM(O.Amount) AS TotalSales,
       CASE
           WHEN SUM(O.Amount) > 10000 THEN 'HIGH'
           WHEN SUM(O.Amount) BETWEEN 5000 AND 10000 THEN 'MEDIUM'
           ELSE 'LOW'
       END AS CustomerCategory
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName;

-- =========================================================

-- 36. Classify each order based on delivery time: 1-2 Excellent, 3-4 Good, 5-6 Slow, >6 Very Slow

SELECT C.CustomerName,
       O.OrderID,
       DATEDIFF(DAY, O.OrderDate, O.DeliveryDate) AS DeliveryDays,
       CASE
           WHEN DATEDIFF(DAY, O.OrderDate, O.DeliveryDate) BETWEEN 1 AND 2 THEN 'EXCELLENT'
           WHEN DATEDIFF(DAY, O.OrderDate, O.DeliveryDate) BETWEEN 3 AND 4 THEN 'GOOD'
           WHEN DATEDIFF(DAY, O.OrderDate, O.DeliveryDate) BETWEEN 5 AND 6 THEN 'SLOW'
           ELSE 'VERY SLOW'
       END AS DeliveryStatus
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID;

-- =========================================================

-- 37. For each order, calculate ExpectedDelivery = 3 days after OrderDate and classify ON TIME/LATE

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate,
       O.DeliveryDate,
       DATEADD(DAY, 3, O.OrderDate) AS ExpectedDeliveryDate,
       CASE
           WHEN O.DeliveryDate <= DATEADD(DAY, 3, O.OrderDate) THEN 'ON TIME'
           ELSE 'LATE'
       END AS Status
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID;

-- =========================================================

-- 38. Find orders where the delivery date is after the end of the order month

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate,
       O.DeliveryDate
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
WHERE O.DeliveryDate > EOMONTH(O.OrderDate);

-- =========================================================

-- 39. Find customers whose total delivery time across all their orders is greater than 15 days

SELECT C.CustomerName,
       SUM(DATEDIFF(DAY, O.OrderDate, O.DeliveryDate)) AS TotalDeliveryDays
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
HAVING SUM(DATEDIFF(DAY, O.OrderDate, O.DeliveryDate)) > 15;

-- =========================================================

-- 40. Find the total sales for each customer in each quarter

SELECT C.CustomerName,
       DATEPART(QUARTER, O.OrderDate) AS QuarterNo,
       SUM(O.Amount) AS TotalSales
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName, DATEPART(QUARTER, O.OrderDate);

-- =========================================================

-- 41. Find the total sales for each customer for each year and month

SELECT C.CustomerName,
       YEAR(O.OrderDate) AS YearOrder,
       MONTH(O.OrderDate) AS MonthOrder,
       SUM(O.Amount) AS TotalSales
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName, YEAR(O.OrderDate), MONTH(O.OrderDate);

-- =========================================================

-- 42. Find how many orders were placed in each month name, showing month name instead of month number

SELECT DATENAME(MONTH, OrderDate) AS MonthName,
       MONTH(OrderDate) AS MonthNo,
       COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY DATENAME(MONTH, OrderDate), MONTH(OrderDate)
ORDER BY MONTH(OrderDate);

-- =========================================================

-- 43. Find total sales for each customer in each month, showing only customer/month combinations above 3,000

SELECT C.CustomerName,
       MONTH(O.OrderDate) AS MonthNo,
       DATENAME(MONTH, O.OrderDate) AS MonthName,
       SUM(O.Amount) AS TotalSales
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName,
         DATENAME(MONTH, O.OrderDate),
         MONTH(O.OrderDate)
HAVING SUM(O.Amount) > 3000
ORDER BY MONTH(O.OrderDate);

-- =========================================================

-- 44. Find customers whose average delivery time is greater than 3 days

SELECT C.CustomerName,
       AVG(DATEDIFF(DAY, O.OrderDate, O.DeliveryDate)) AS AverageDeliveryDays
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
HAVING AVG(DATEDIFF(DAY, O.OrderDate, O.DeliveryDate)) > 3;

-- =========================================================

-- 45. Find customers who have placed more than 3 orders

SELECT C.CustomerName,
       COUNT(O.OrderID) AS TotalOrders
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
HAVING COUNT(O.OrderID) > 3;

-- =========================================================

-- 46. Find customers where the difference between their first and latest order is more than 300 days

SELECT C.CustomerID,
       MIN(O.OrderDate) AS FirstOrder,
       MAX(O.OrderDate) AS LatestOrder,
       DATEDIFF(DAY, MIN(O.OrderDate), MAX(O.OrderDate)) AS SpanOfDays
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID
HAVING DATEDIFF(DAY, MIN(O.OrderDate), MAX(O.OrderDate)) > 300;

-- =========================================================

-- 47. Find customers who placed orders between 2025-01-01 and 2025-06-30

SELECT C.CustomerName,
       O.OrderID,
       O.OrderDate,
       O.Amount
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
WHERE O.OrderDate BETWEEN '2025-01-01' AND '2025-06-30'
ORDER BY O.OrderDate ASC;

-- =========================================================

-- 48. Find customers whose total sales in 2025 were greater than ₹5,000

SELECT C.CustomerName,
       SUM(O.Amount) AS TotalSales
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
WHERE YEAR(O.OrderDate) = 2025
GROUP BY C.CustomerName
HAVING SUM(O.Amount) > 5000;

-- =========================================================

-- 49. Find the total sales for each customer in the month of their latest order

WITH LatestOrder AS
(
    SELECT CustomerID,
           EOMONTH(MAX(OrderDate)) AS LatestOrderMonth
    FROM Orders
    GROUP BY CustomerID
)
SELECT C.CustomerName,
       L.LatestOrderMonth,
       SUM(O.Amount) AS TotalSales
FROM Customers C
INNER JOIN LatestOrder L
    ON C.CustomerID = L.CustomerID
INNER JOIN Orders O
    ON O.CustomerID = L.CustomerID
   AND EOMONTH(O.OrderDate) = L.LatestOrderMonth
GROUP BY C.CustomerName, L.LatestOrderMonth;

-- =========================================================

-- 50. For each customer, find CustomerName, LatestOrderDate, and Total Sales in the year of their latest order

WITH LatestOrder AS
(
    SELECT CustomerID,
           MAX(OrderDate) AS LatestOrderDate
    FROM Orders
    GROUP BY CustomerID
)
SELECT C.CustomerName,
       L.LatestOrderDate,
       SUM(O.Amount) AS LatestYearSales
FROM Customers C
INNER JOIN LatestOrder L
    ON C.CustomerID = L.CustomerID
INNER JOIN Orders O
    ON O.CustomerID = L.CustomerID
   AND YEAR(O.OrderDate) = YEAR(L.LatestOrderDate)
GROUP BY C.CustomerName, L.LatestOrderDate;

-- =========================================================
