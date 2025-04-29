SELECT table_name FROM user_tables;
DROP TABLE Students;

-- ** 1 **
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR2(100),
    dept_id INT
);

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR2(100)
);

-- Sample Data
INSERT INTO Employees VALUES (1, 'Alice', 101);
INSERT INTO Employees VALUES (2, 'Bob', 102);
INSERT INTO Departments VALUES (101, 'HR');
INSERT INTO Departments VALUES (102, 'IT');

-- INNER JOIN Query
SELECT e.emp_name, d.dept_name
FROM Employees e
INNER JOIN Departments d ON e.dept_id = d.dept_id;

-- ** 2 **
CREATE TABLE Students_join (
    student_id INT PRIMARY KEY,
    student_name VARCHAR2(100),
    course_id INT
);

CREATE TABLE ExamScores (
    exam_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR2(100),
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students_join(student_id)
);

-- Sample Data
INSERT INTO Students_join VALUES (1, 'John', 201);
INSERT INTO Students_join VALUES (2, 'Mary', 202);
INSERT INTO ExamScores VALUES (101, 1, 'Math', 85);

-- LEFT JOIN Query
SELECT s.student_name, e.subject, e.marks
FROM Students_join s
LEFT JOIN ExamScores e ON s.student_id = e.student_id;

-- ** 3 **
CREATE TABLE Orders_join (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_status VARCHAR2(50),
    FOREIGN KEY (order_id) REFERENCES Orders_join(order_id)
);

-- Sample Data
INSERT INTO Orders_join VALUES (1, 201, SYSDATE);
INSERT INTO Payments VALUES (101, 1, 'Success');
INSERT INTO Payments VALUES (102, 1, 'Failed'); 

-- RIGHT JOIN Query
SELECT p.payment_id, o.order_id, p.payment_status
FROM Orders_join o
RIGHT JOIN Payments p ON o.order_id = p.order_id;

-- ** 4 **
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR2(100),
    country VARCHAR2(100)
);

CREATE TABLE Books_join (
    book_id INT PRIMARY KEY,
    book_title VARCHAR2(255),
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Sample Data
INSERT INTO Authors VALUES (1, 'Jane Austen', 'UK');
INSERT INTO Books_join VALUES (1, 'Pride and Prejudice', 1);
INSERT INTO Books_join VALUES (2, 'Mystery Book', NULL);

-- FULL OUTER JOIN (requires UNION in Oracle)
SELECT a.author_name, b.book_title
FROM Authors a
LEFT JOIN Books_join b ON a.author_id = b.author_id
UNION
SELECT a.author_name, b.book_title
FROM Authors a
RIGHT JOIN Books_join b ON a.author_id = b.author_id;

-- ** 5 ** 
CREATE TABLE Products_join (
    product_id INT PRIMARY KEY,
    product_name VARCHAR2(100),
    price DECIMAL(10,2)
);

CREATE TABLE Discounts (
    discount_id INT PRIMARY KEY,
    discount_percent DECIMAL(5,2)
);

-- Sample Data
INSERT INTO Products_join VALUES (1, 'Phone', 30000.50);
INSERT INTO Discounts VALUES (1, 10);
INSERT INTO Discounts VALUES (2, 15);

-- CROSS JOIN
SELECT p.product_name, d.discount_percent
FROM Products_join p
CROSS JOIN Discounts d;

-- ** 6 **
CREATE TABLE EmployeesHierarchy (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR2(100),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES EmployeesHierarchy(emp_id)
);

-- Sample Data
INSERT INTO EmployeesHierarchy VALUES (1, 'CEO', NULL);
INSERT INTO EmployeesHierarchy VALUES (2, 'Manager A', 1);
INSERT INTO EmployeesHierarchy VALUES (3, 'Staff B', 2);

-- SELF JOIN
SELECT e1.emp_name AS Employee, e2.emp_name AS Manager
FROM EmployeesHierarchy e1
LEFT JOIN EmployeesHierarchy e2 ON e1.manager_id = e2.emp_id;

-- ** 7 **
CREATE TABLE Customers_join (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR2(100),
    email VARCHAR2(100)
);

CREATE TABLE Orders_join2 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers_join(customer_id)
);

-- Sample Data
INSERT INTO Customers_join VALUES (1, 'Anil', 'anil@mail.com');
INSERT INTO Orders_join2 VALUES (101, 1, SYSDATE);

-- NATURAL JOIN
SELECT customer_name, order_date
FROM Customers_join
NATURAL JOIN Orders_join2;
