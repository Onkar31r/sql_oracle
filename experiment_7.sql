SELECT table_name from user_tables;
DESC Order_Details;

-- 1. Primary Key Constraint
CREATE TABLE Customer (
    Customer_ID NUMBER PRIMARY KEY,
    First_Name VARCHAR2(50),
    Last_Name VARCHAR2(50),
    Phone_Number VARCHAR2(15)
);

-- 2. Foreign Key Constraint
CREATE TABLE Order_Details (
    Order_ID NUMBER PRIMARY KEY,
    Customer_ID NUMBER,
    Order_Date DATE,
    Total_Amount NUMBER(10,2),
    CONSTRAINT fk_order_customer FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

-- 3. Unique Constraint
CREATE TABLE User_Account (
    User_ID NUMBER PRIMARY KEY,
    User_Name VARCHAR2(50) UNIQUE,
    Email_Address VARCHAR2(100) UNIQUE,
    User_Password VARCHAR2(100)
);

-- 4. Composite Primary Key
CREATE TABLE Course_Registration (
    Student_ID NUMBER,
    Course_ID NUMBER,
    Registration_Date DATE,
    CONSTRAINT pk_course_registration PRIMARY KEY (Student_ID, Course_ID)
);

-- 5. Check Constraint
CREATE TABLE Product (
    Product_ID NUMBER PRIMARY KEY,
    Product_Name VARCHAR2(100),
    Price NUMBER(10,2) CHECK (Price > 0),
    Stock_Quantity NUMBER CHECK (Stock_Quantity >= 0)
);

-- 6. On Delete Cascade with Foreign Key
CREATE TABLE Department (
    Department_ID NUMBER PRIMARY KEY,
    Department_Name VARCHAR2(50)
);

CREATE TABLE Employee (
    Employee_ID NUMBER PRIMARY KEY,
    Employee_Name VARCHAR2(50),
    Department_ID NUMBER,
    CONSTRAINT fk_employee_department FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID) ON DELETE CASCADE
);

-- 7. Not Null Constraint
CREATE TABLE Book (
    Book_ID NUMBER PRIMARY KEY,
    Book_Title VARCHAR2(100) NOT NULL,
    Author_Name VARCHAR2(100) NOT NULL,
    Book_Price NUMBER(10,2) NOT NULL
);

-- 8. Default and Unique Constraints
CREATE TABLE Bank_Account (
    Account_ID NUMBER PRIMARY KEY,
    Account_Number VARCHAR2(20) UNIQUE,
    Account_Balance NUMBER(10,2) DEFAULT 0.00
);

-- 9. Self-Referencing Foreign Key
CREATE TABLE Employee_Manager (
    Employee_ID NUMBER PRIMARY KEY,
    Employee_Name VARCHAR2(50),
    Manager_ID NUMBER,
    CONSTRAINT fk_manager FOREIGN KEY (Manager_ID) REFERENCES Employee_Manager(Employee_ID)
);

-- 10. Enforcing Relationships in a School Management System
CREATE TABLE Student (
    Student_ID NUMBER PRIMARY KEY,
    First_Name VARCHAR2(50),
    Last_Name VARCHAR2(50)
);

CREATE TABLE Course (
    Course_ID NUMBER PRIMARY KEY,
    Course_Name VARCHAR2(100)
);

CREATE TABLE Enrollment (
    Enrollment_ID NUMBER PRIMARY KEY,
    Student_ID NUMBER,
    Course_ID NUMBER,
    CONSTRAINT fk_enrollment_student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
    CONSTRAINT fk_enrollment_course FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);

-- 11. Unique with Composite Keys
CREATE TABLE Event_Booking (
    Event_ID NUMBER,
    User_ID NUMBER,
    Seat_Number VARCHAR2(10),
    CONSTRAINT uq_event_seat UNIQUE (Event_ID, Seat_Number)
);

-- 12. Parent-Child Relationships
CREATE TABLE Category (
    Category_ID NUMBER PRIMARY KEY,
    Category_Name VARCHAR2(50),
    Parent_Category_ID NUMBER,
    CONSTRAINT fk_category_parent FOREIGN KEY (Parent_Category_ID) REFERENCES Category(Category_ID)
);

-- 13. Preventing Duplicate Data
CREATE TABLE Inventory_Item (
    Inventory_ID NUMBER PRIMARY KEY,
    Item_Name VARCHAR2(100) UNIQUE,
    Warehouse_Location VARCHAR2(100)
);

-- 14. Multi-Level Foreign Key Relationship
CREATE TABLE Country (
    Country_ID NUMBER PRIMARY KEY,
    Country_Name VARCHAR2(100)
);

CREATE TABLE State (
    State_ID NUMBER PRIMARY KEY,
    State_Name VARCHAR2(100),
    Country_ID NUMBER,
    CONSTRAINT fk_state_country FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
);

CREATE TABLE City (
    City_ID NUMBER PRIMARY KEY,
    City_Name VARCHAR2(100),
    State_ID NUMBER,
    CONSTRAINT fk_city_state FOREIGN KEY (State_ID) REFERENCES State(State_ID)
);

-- 15. Dropping and Re-Adding Constraints
ALTER TABLE Order_Details DROP CONSTRAINT fk_order_customer;
ALTER TABLE Order_Details ADD CONSTRAINT fk_order_customer FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) ON DELETE SET NULL;