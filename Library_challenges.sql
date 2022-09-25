--Library Challenge--
--Here there's a total of 8 completed challenges using SQLite--
--Imagine this is a database of a small library--

 
--CHALLENGE 1--
--Find the number of available copies of Dracula--

SELECT COUNT(Title)
FROM Books
WHERE Title="Dracula";
--3 books--
SELECT COUNT(Books.Title)
FROM Loans
JOIN Books ON Books.BookID=Loans.BookID
WHERE Books.Title="Dracula" AND Loans.ReturnedDate IS NULL;
--1 hasn't been returned--
SELECT (SELECT COUNT(Books.Title)
FROM Books
WHERE Books.Title="Dracula")
-
(SELECT COUNT(Books.Title)
FROM Loans
JOIN Books ON Books.BookID=Loans.BookID
WHERE Books.Title="Dracula" AND Loans.ReturnedDate IS NULL)
AS AvailableBooks;
--There are 2 books available--



--CHALLENGE 2--
--Add two new books titles to the library collection--

INSERT INTO Books
(Title,Author,Published,Barcode)
VALUES
("Dracula","Bram Stoker","1897","4819277482"),
("Gulliver's Travels", "Jonathan Swift","1729","4899254401");
--Books were added to the system--
SELECT *
FROM Books
ORDER BY BookID DESC LIMIT 2;
--Double checked--



--CHALLENGE 3--
--Two books were lend to a patron. Add to the loans table--

SELECT*
FROM Patrons
WHERE FirstName="Jack" OR LastName="Vaan";
--PatronID 50--
INSERT INTO Loans
(BookID,PatronID,LoanDate,DueDate)
VALUES
((SELECT BookID FROM Books WHERE Barcode="2855934983"),(SELECT PatronID FROM Patrons WHERE FirstName="Jack" OR LastName="Vaan"),"2020-08-25","2020-09-08"),
((SELECT BookID FROM Books WHERE Barcode="4043822646"),(SELECT PatronID FROM Patrons WHERE FirstName="Jack" OR LastName="Vaan"),"2020-08-25","2020-09-08");
--Double Check--
SELECT Books.Title, Loans.PatronID
FROM Loans
JOIN Books ON Books.BookID=Loans.BookID
ORDER BY Loans.LoanID DESC LIMIT 2;



--CHALLENGE 4--
--Generate a report of books due back on 2020-07-13 with patron contacts-- 

SELECT Loans.DueDate,Patrons.FirstName, Patrons.LastName, Patrons.Email, Books.Title
FROM Loans
JOIN Books ON Books.BookID=Loans.BookID
JOIN Patrons ON Patrons.PatronID=Loans.PatronID
WHERE Loans.DueDate="2020-07-13" AND Loans.ReturnedDate IS NULL;



--CHALLENGE 5--
--Return 3 books on 2020-07-05 (Barcodes 6435968624,5677520613,8730298424)--

UPDATE Loans
SET ReturnedDate="2020-07-05"
WHERE BookID=(SELECT BookID FROM Books WHERE Barcode="6435968624")AND ReturnedDate IS NULL;

UPDATE Loans
SET ReturnedDate="2020-07-05"
WHERE BookID=(SELECT BookID FROM Books WHERE Barcode="5677520613")AND ReturnedDate IS NULL;

UPDATE Loans
SET ReturnedDate="2020-07-05"
WHERE BookID=(SELECT BookID FROM Books WHERE Barcode="8730298424")AND ReturnedDate IS NULL;



--CHALLENGE 6--
--Create a report showing the 10 patrons who have checked out the fewest books--

SELECT Patrons.FirstName, Patrons.LastName, Patrons.Email,COUNT(Loans.PatronID) 
FROM Loans
JOIN Patrons ON Patrons.PatronID=Loans.PatronID
GROUP BY Loans.PatronID
ORDER BY COUNT(Loans.PatronID) ASC LIMIT 10;


--CHALLENGE 7--
--Create a list of book from the 1890s that are currently available--

SELECT Books.BookID, Books.Title, Books.Author, Books.Published
FROM Books
JOIN Loans ON Books.BookID=Loans.BookID
WHERE Books.Published BETWEEN "1890" AND "1899"
AND Loans.ReturnedDate IS NOT NULL
GROUP BY Books.BookID
ORDER BY Books.Title, Published;



--CHALLENGE 8--
--Create two reports--
--FIrst: Show how many books were published each year--
--Second: Show the top five mos popular books--

--FIRST--
SELECT Published, COUNT(DISTINCT(Title)) 
FROM Books
GROUP BY Published
ORDER BY COUNT(DISTINCT(Title)) DESC;

--SECOND--
SELECT Books.Title, COUNT(Loans.LoanID)
FROM Loans
JOIN Books ON Books.BookID=Loans.BookID
GROUP BY Books.Title
ORDER BY COUNT(Loans.LoanID) DESC 
LIMIT 5;



