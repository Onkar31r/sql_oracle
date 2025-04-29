SELECT table_name from user_tables;

-- 1
CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    Position VARCHAR2(50),
    Salary NUMBER(10,2),
    DateOfJoining DATE
);

-- 2.1 
ALTER TABLE Employees ADD Email VARCHAR2(100) UNIQUE;
-- 2.2
ALTER TABLE Employees MODIFY Salary NUMBER(10,2);

-- 3.1
CREATE TABLE TemporaryData (
    TempID NUMBER PRIMARY KEY,
    DataValue VARCHAR2(100)
);
DROP TABLE TemporaryData;
-- 3.2
CREATE TABLE OldProducts (
    ProductID NUMBER PRIMARY KEY,
    ProductName VARCHAR2(100),
    Price NUMBER(10,2)
);
ALTER TABLE OldProducts RENAME TO ArchivedProducts;

-- 4.1
CREATE TABLE Students (
    StudentID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50),
    Age NUMBER CHECK (Age > 18),
    Email VARCHAR2(100) UNIQUE
);
--4.2
CREATE TABLE Enrollments (
    EnrollmentID NUMBER PRIMARY KEY,
    StudentID NUMBER,
    CourseName VARCHAR2(50)
);
ALTER TABLE Enrollments ADD CONSTRAINT fk_student FOREIGN KEY (StudentID) REFERENCES Students(StudentID);

-- 5.1 
CREATE INDEX idx_position ON Employees(Position);
-- 5.2
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    FirstName VARCHAR2(50),
    LastName VARCHAR2(50)
);
CREATE INDEX idx_lastname ON Customers(LastName);
DROP INDEX idx_lastname;

-- 6.1
CREATE TABLE Logs (
    LogID NUMBER PRIMARY KEY,
    LogMessage VARCHAR2(255)
);
INSERT INTO Logs VALUES (1, 'System started');
INSERT INTO Logs VALUES (2, 'User login successful');
INSERT INTO Logs VALUES (3, 'Database backup completed');

TRUNCATE TABLE Logs;

-- 8.1
CREATE VIEW HighSalaryEmployees AS 
SELECT FirstName, LastName, Salary FROM Employees WHERE Salary > 50000;

-- 9.1
CREATE TABLE Books (
    BookID NUMBER PRIMARY KEY,
    Title VARCHAR2(100),
    Author VARCHAR2(100),
    Price NUMBER(10,2) CHECK (Price > 0),
    Stock NUMBER CHECK (Stock >= 0)
);

-- 10.1
CREATE TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    OrderDate DATE,
    CONSTRAINT fk_orders_customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
ALTER TABLE Orders DROP CONSTRAINT fk_orders_customers;
-- 10.2
CREATE TABLE Products (
    ProductID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Price NUMBER(10,2)
);
ALTER TABLE Products ADD CONSTRAINT chk_price CHECK (Price BETWEEN 10 AND 1000);

-- 11.1
CREATE GLOBAL TEMPORARY TABLE SessionData (
    SessionID NUMBER PRIMARY KEY,
    UserID NUMBER,
    StartTime TIMESTAMP,
    EndTime TIMESTAMP
) ON COMMIT DELETE ROWS;

-- 12.1
ALTER TABLE Employees RENAME COLUMN Position TO JobTitle;

-- 13.1
CREATE TABLE Sales_2020 (
    SaleID NUMBER PRIMARY KEY,
    Year NUMBER CHECK (Year < 2020),
    Amount NUMBER(10,2)
);

CREATE TABLE Sales_2025 (
    SaleID NUMBER PRIMARY KEY,
    Year NUMBER CHECK (Year BETWEEN 2020 AND 2024),
    Amount NUMBER(10,2)
);

CREATE TABLE Sales_2030 (
    SaleID NUMBER PRIMARY KEY,
    Year NUMBER CHECK (Year BETWEEN 2025 AND 2029),
    Amount NUMBER(10,2)
);

CREATE VIEW Sales AS
SELECT * FROM Sales_2020
UNION ALL
SELECT * FROM Sales_2025
UNION ALL
SELECT * FROM Sales_2030;

-- 14.1
CREATE TABLE Users (
    UserID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Email VARCHAR2(100) UNIQUE
);

CREATE TABLE Products (
    ProductID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Price NUMBER(10,2)
);

CREATE TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    UserID NUMBER,
    OrderDate DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- 15.1
CREATE TABLE Inventory (
    ItemID NUMBER PRIMARY KEY,
    ItemName VARCHAR2(100),
    Quantity NUMBER
);

CREATE TABLE TempInventory AS
SELECT DISTINCT * FROM Inventory;

DROP TABLE Inventory;

ALTER TABLE TempInventory RENAME TO Inventory;

