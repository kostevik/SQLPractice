SELECT Customers.CustomerID, Customers.CustomerName, Orders.EmployeeID #when pulling in more than one table must specifiy column
FROM Customers # FROM Customers, Orders --> could do this but gets complicated #grab from what you asked for in SELECT first
JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
# This joins the two tables


SELECT Customers.CustomerID, Customers.CustomerName, Orders.EmployeeID 
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Orders.EmployeeID ASC;
#you can join all of the tables together... sometimes you have to go through other tables to get what you want - like leapfrog


--------This is a query that does this------------------
SELECT Customers.CustomerID, Customers.CustomerName, SUM(Orders.Cost) #doesn't work because Cost isn't an actual column 
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Orders.EmployeeID ASC;


------------This is an example of a leapfrog------------
SELECT Customers.CustomerID, Customers.CustomerName, Orders.EmployeeID, Products.Price
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON OrderDetails.OrderID = Orders.OrderID
JOIN Products ON Products.ProductID = OrderDetails.ProductID;


---------Query within a Query--------------
SELECT Bosstable.EmployeeID, SUM(Bosstable.Price)
FROM (SELECT Customers.CustomerID, Customers.CustomerName, Orders.EmployeeID, Products.Price
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON OrderDetails.OrderID = Orders.OrderID
JOIN Products ON Products.ProductID = OrderDetails.ProductID
ORDER BY Orders.EMployeeID ASC) AS Bosstable
GROUP BY Bosstable.EmployeeID;

#Could run this and then export into excel and then do sums




------------homework atempt-------------------------------------
SELECT Products.CategoryID, EXP(SUM(ln(OrderDetails.Quantity),ln(Products.UnitPrice)))
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID;

SELECT Products.CategoryID, SUM(OrderDetails.Quantity)
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID;

SELECT Products.CategoryID, SUM(OrderDetails.Quantity)
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.CategoryID;

SELECT Products.CategoryID, EXP(SUM(ln(OrderDetails.Quantity),ln(Products.Price)))
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.CategoryID;

SELECT Products.CategoryID, EXP(SUM(LN(OrderDetails.Quantity),LN(Products.Price)))
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Products.CategoryID;

SELECT OrderDetails.ProductID, SUM(OrderDetails.Quantity)
FROM OrderDetails
GROUP BY ProductID;
















