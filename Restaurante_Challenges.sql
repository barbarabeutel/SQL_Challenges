--Challenges Restaurant--
--Here there's a total of 12 completed challenges--
--The last challenges are the more complex ones--
--Imagine there's a restaurant reservation system and this is its database--

--CHALLENGE 1--
--The marketing team needs a list with the name, last name and email of our clients.--

SELECT FirstName, LastName, Email
FROM Customers
GROUP BY LastName;

--CHALLENGE 2--
--Create a table for customers--

CREATE TABLE FiveYearParty 
("CustomerID" INT,
"PartySize" INT);

--CHALLENGE 3--
--Create Menu Options as:--
--1 - All itens sorted by price from low to high--
--2 - Only beverages and Appetizers--
--3 - All itens but Beverages"--

--MENU1--

SELECT *
FROM Dishes
ORDER BY Price;

--MENU2--

SELECT *
FROM Dishes
WHERE Type="Beverage" OR Type="Appetizer"
ORDER BY Type;

--MENU3--

SELECT *
FROM Dishes
WHERE Type!= "Beverage"
ORDER BY Type;

--CHALLENGE 4--
--Add new customer information into the database--

INSERT INTO Customers
(FirstName, LastName, Email, Address, City, State, Phone, Birthday)
VALUES
("Henry", "Gunner", "hgrunner@noistwo.com", "108 Algoma Park",
"Chicago","IL","524-456-8564","1990-02-06");

--CHALLENGE 5--
--Customer wants to update their details--

SELECT* 
FROM Customers
WHERE LastName="Jenkins";

SELECT*
FROM Customers
WHERE CustomerID=26;

UPDATE Customers
SET Address="74 Pine St.",City="New York",State="NY"
WHERE CustomerID="26";


--CHALLENGE 6--
--Customer wants their record to be deleted--

SELECT CustomerID, FirstName, LastName, Email
FROM Customers
WHERE LastName="Jenkins";

DELETE
FROM Customers
WHERE CustomerID="4";


--CHALLENGE 7--
--Add one member to the party list and their friends--

INSERT INTO FiveYearParty
(CustomerID, PartySize)
VALUES
((SELECT CustomerID
FROM Customers
WHERE Email="atapley2j@kinetecoinc.com"),
"4");


--CHALLENGE 8--
--Find a reservation in name of Stevenson using all
possible spellings ways--

SELECT Customers.FirstName, Customers.LastName, Reservations.Date, Reservations.PartySize
FROM Reservations
JOIN Customers ON Customers.CustomerID=Reservations.CustomerID
WHERE Customers.LastName LIKE "Ste%"
ORDER BY Reservations.Date DESC;

--CHALLENGE 9--
--Add a reservation to the reservation table--

SELECT*
FROM Customers
WHERE Email="smac@rouxacademy.com";

INSERT INTO Customers
(FirstName, LastName, Email, Phone)
VALUES
("Sam", "McAdams", "smac@rouxacademy.com","555-555-1212");

INSERT INTO Reservations
(CustomerID,Date,PartySize)
VALUES
("103", "2020-07-14 18:00:00", "5");

--CHALLENGE 10--
--Find the customer, create a delivery order, add itens to the order and find the total cost--

SELECT*
FROM Customers
WHERE FirstName="Loretta";

--CustomerID 70--

INSERT INTO Orders
(CustomerID,OrderDate)
VALUES
("70","2020-06-28 19:00:00")

SELECT* 
FROM Orders
WHERE CustomerID="70"
ORDER BY OrderDate DESC; 

--OrdersID 1001--

INSERT INTO OrdersDishes
(OrderID,DishID)
VALUES
("1001",(SELECT DishID FROM Dishes WHERE Name="House Salad")),
("1001",(SELECT DishID FROM Dishes WHERE Name="Mini Cheeseburgers")),
("1001",(SELECT DishID FROM Dishes WHERE Name="Tropical Blue Smoothie"));

--DOUBLE CHECK THE ORDER INPUT--


SELECT *
FROM Dishes
JOIN OrdersDishes ON Dishes.DishID=OrdersDishes.DishID
WHERE OrdersDishes.OrderID="1001";

--LOOKING GOOD--

SELECT SUM(Dishes.PRICE)
FROM Dishes
JOIN OrdersDishes ON Dishes.DishID=OrdersDishes.DishID
WHERE OrdersDishes.OrderID="1001";

--THAT WILL BE $21--

--CHALLENGE 11--
--Set Cleo Coldwater's favourite dish to Quinoa Salmon Salad--

SELECT *
FROM Customers
WHERE LastName="Goldwater";

--Customer ID 42--

SELECT *
FROM Dishes
WHERE Name="Quinoa Salmon Salad";

--DishID 9--

UPDATE Customers
SET FavoriteDish=((SELECT DishID
FROM Dishes
WHERE Name="Quinoa Salmon Salad"))
WHERE Customers.CustomerID="42";

--CHALLENGE 12--
--List the 5 customers who has made the large amount of orders in the house--

SELECT Customers.FirstName, Customers.LastName, Customers.Email, COUNT(Orders.CustomerID)
FROM Customers
JOIN Orders ON Customers.CustomerID=Orders.CustomerID
GROUP BY Orders.CustomerID
ORDER BY COUNT(Orders.CustomerID)DESC LIMIT 5;
