SELECT table_name FROM user_tables;

-- 1.  Functional Dependency
CREATE TABLE LibraryBooks (
    Book_ID INT PRIMARY KEY,
    Book_Title VARCHAR(100),
    Author VARCHAR(100)
);

INSERT INTO LibraryBooks VALUES (1, 'DBMS Concepts', 'Navathe');
INSERT INTO LibraryBooks VALUES (2, 'Operating Systems', 'Galvin');

SELECT Book_ID, Book_Title FROM LibraryBooks;

-- 2. Partial Dependency
CREATE TABLE OrderDetails (
    Order_ID INT,
    Product_ID INT,
    Product_Name VARCHAR(50),
    Supplier_Name VARCHAR(50),
    PRIMARY KEY (Order_ID, Product_ID)
);

INSERT INTO OrderDetails VALUES (101, 1, 'Laptop', 'TechWorld');
INSERT INTO OrderDetails VALUES (102, 1, 'Laptop', 'TechWorld');
INSERT INTO OrderDetails VALUES (103, 2, 'Keyboard', 'KeyCo');

SELECT * FROM OrderDetails;

-- 3. Transitive Dependency
CREATE TABLE Courses (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(50),
    Instructor_ID INT,
    Instructor_Name VARCHAR(50)
);

INSERT INTO Courses VALUES (201, 'DBMS', 301, 'Dr. Sharma');
INSERT INTO Courses VALUES (202, 'OS', 302, 'Dr. Mehta');
INSERT INTO Courses VALUES (203, 'DBMS', 301, 'Dr. Sharma');

SELECT * FROM Courses;

-- 4. multi-Valued Dependency
CREATE TABLE MovieDetails (
    Movie_ID INT,
    Actor VARCHAR(50),
    Genre VARCHAR(50),
    PRIMARY KEY (Movie_ID, Actor, Genre) -- Composite Key
);

INSERT INTO MovieDetails VALUES (401, 'John Doe', 'Action');
INSERT INTO MovieDetails VALUES (401, 'John Doe', 'Sci-Fi');
INSERT INTO MovieDetails VALUES (401, 'Jane Smith', 'Action');

SELECT * FROM MovieDetails;













