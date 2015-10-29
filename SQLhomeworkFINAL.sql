------Revenue by Product Category---------------------------
SELECT Categories.CategoryName, Revenues.Revenue
FROM (SELECT Products.CategoryID, ROUND(SUM(OrderDetails.Quantity*Products.Price)) AS 'Revenue'
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.CategoryID) AS Revenues
JOIN Categories ON Revenues.CategoryID = Categories.CategoryID;

--------------#2---------------------------------
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


--------------- #3 -------------------------------
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

	------SIMS Code--------------

	