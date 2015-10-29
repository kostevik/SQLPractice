#SQLhomework.sql

------Revenue by Product Category---------------------------
SELECT Categories.CategoryName, Revenues.Revenue
FROM (SELECT Products.CategoryID, ROUND(SUM(OrderDetails.Quantity*Products.Price)) AS 'Revenue'
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.CategoryID) AS Revenues
JOIN Categories ON Revenues.CategoryID = Categories.CategoryID;


----Revenue by Product name in the highest product category----------------

SELECT Products.ProductName, SUM(OrderDetails.Quantity*Products.Price) AS Revenue
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.CategoryID = 1
GROUP BY Products.ProductName;

-------Revenue by employee in the same highest revenue product category------------

SELECT Employees.EmployeeID, SUM(OrderDetails.Quantity*Products.Price) AS Revenue
FROM Orders
Join Employees ON Orders.EmployeeID = Employees.EmployeeID
Join OrderDetails ON OrderDetails.OrderID = Orders.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.CategoryID = 1
GROUP BY Employees.EmployeeID;


----Revenue by Product name in the highest product category without using info from 1--------------------

SELECT Products.ProductName, SUM(OrderDetails.Quantity*Products.Price) AS Revenue
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.CategoryID = (SELECT FIRST(CatID) 
FROM (SELECT Products.CategoryID AS 'CatID', ROUND(SUM(OrderDetails.Quantity*Products.Price))
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.CategoryID)
GROUP BY Products.ProductName;

Productname 

(SELECT Products.CategoryID, ROUND(SUM(OrderDetails.Quantity*Products.Price))
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.CategoryID
ORDER BY Products.CategoryID ASC
LIMIT 1) AS TopCatIDs;

Second table has 
ProductID Employee etc. ----- then run join

(SELECT Products.ProductName AS PName, Products.CategoryID, SUM(Products.Price*OrderDetails.Quantity) AS Revenue
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.ProductName) AS ProductRevs;

------now run join------------ #2 ****************

SELECT PName, RevenueByProductName
From ((SELECT Products.CategoryID, ROUND(SUM(OrderDetails.Quantity*Products.Price)) AS 'RevenueBYCategory'
	FROM OrderDetails
	JOIN Products ON OrderDetails.ProductID = Products.ProductID
	GROUP BY Products.CategoryID
	ORDER BY RevenueBYCategory DESC
	LIMIT 1) AS TopCatIDs)
JOIN (SELECT Products.ProductName AS 'PName', Products.CategoryID, SUM(Products.Price*OrderDetails.Quantity) AS 'RevenueByProductName'
	FROM OrderDetails
	JOIN Products ON OrderDetails.ProductID = Products.ProductID
	GROUP BY Products.ProductName) AS ProductRevs
	ON TopCatIDs.CategoryID = ProductRevs.CategoryID;

------ #3------------------------------


SELECT Employee, SUM(RevenueByEmployee)
From ((SELECT Products.CategoryID, ROUND(SUM(OrderDetails.Quantity*Products.Price)) AS 'RevenueBYCategory'
	FROM OrderDetails
	JOIN Products ON OrderDetails.ProductID = Products.ProductID
	GROUP BY Products.CategoryID
	ORDER BY RevenueBYCategory DESC
	LIMIT 1) AS TopCatIDs)
JOIN (SELECT Products.ProductName, Employees.EmployeeID AS 'Employee', Products.CategoryID, (OrderDetails.Quantity*Products.Price) AS 'RevenueByEmployee'
	FROM Orders
	Join Employees ON Orders.EmployeeID = Employees.EmployeeID
	Join OrderDetails ON OrderDetails.OrderID = Orders.OrderID
	JOIN Products ON OrderDetails.ProductID = Products.ProductID) AS EmployeeRevs
	ON TopCatIDs.CategoryID = EmployeeRevs.CategoryID
	GROUP BY Employee;

SELECT FirstName, LastName, EmployeeID, SUM(RevenueByEmployee)
From ((SELECT Products.CategoryID, ROUND(SUM(OrderDetails.Quantity*Products.Price)) AS 'RevenueBYCategory'
	FROM OrderDetails
	JOIN Products ON OrderDetails.ProductID = Products.ProductID
	GROUP BY Products.CategoryID
	ORDER BY RevenueBYCategory DESC
	LIMIT 1) AS TopCatIDs)
JOIN (SELECT Products.ProductName, Employees.EmployeeID, Employees.FirstName, Employees.LastName, Products.CategoryID, (OrderDetails.Quantity*Products.Price) AS 'RevenueByEmployee'
	FROM Orders
	Join Employees ON Orders.EmployeeID = Employees.EmployeeID
	Join OrderDetails ON OrderDetails.OrderID = Orders.OrderID
	JOIN Products ON OrderDetails.ProductID = Products.ProductID) AS EmployeeRevs
	ON TopCatIDs.CategoryID = EmployeeRevs.CategoryID
	GROUP BY EmployeeID;




















