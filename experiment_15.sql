SELECT table_name FROM user_tables;

-- *** 1 ***
-- Create Users
CREATE USER doctor1 IDENTIFIED BY doctor1;
CREATE USER admin1 IDENTIFIED BY admin1;

-- Create Table
CREATE TABLE PatientRecords (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    disease VARCHAR(255),
    treatment VARCHAR(255),
    doctor_id INT
);

-- Grant Permissions to Doctor
GRANT SELECT, INSERT, UPDATE ON PatientRecords TO doctor1;

-- Create View for Admin
CREATE VIEW AdminView AS
SELECT patient_id, name, age FROM PatientRecords;

-- Grant Admin SELECT access
GRANT SELECT ON AdminView TO admin1;

-- Revoke Unnecessary Permissions
REVOKE INSERT, UPDATE, DELETE ON PatientRecords FROM admin1;

-- Check Access
SELECT OWNER, TABLE_NAME, GRANTEE, GRANTOR, PRIVILEGE
FROM DBA_TAB_PRIVS
WHERE GRANTEE IN ('DOCTOR1', 'ADMIN1');


-- *** 2 ***
-- Create Users
CREATE USER teller1 IDENTIFIED BY teller1;
CREATE USER manager1 IDENTIFIED BY manager1;

-- Grant Basic Roles to Users
GRANT CONNECT, RESOURCE TO teller1;
GRANT CONNECT, RESOURCE TO manager1;

-- Create Table: Accounts
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    balance DECIMAL(10,2)
);

-- Create Table: Transactions
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    amount DECIMAL(10,2),
    transaction_type VARCHAR(10),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_account FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- Grant Permissions to Teller
GRANT SELECT ON Accounts TO teller1;
GRANT SELECT ON Transactions TO teller1;

-- Grant Full Permissions to Manager
GRANT ALL ON Accounts TO manager1;
GRANT ALL ON Transactions TO manager1;

-- Revoke Modification Rights from Teller
REVOKE INSERT, UPDATE, DELETE ON Accounts FROM teller1;
REVOKE INSERT, UPDATE, DELETE ON Transactions FROM teller1;

-- Check Access
SELECT OWNER, TABLE_NAME, GRANTEE, GRANTOR, PRIVILEGE
FROM DBA_TAB_PRIVS
WHERE GRANTEE IN ('TELLER1', 'MANAGER1');
