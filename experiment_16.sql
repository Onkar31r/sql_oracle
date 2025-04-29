SELECT table_name FROM user_tables;

-- *** 1 ***
-- Step 1: Create Tables
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR2(100),
    product_name VARCHAR2(100),
    quantity INT,
    total_amount NUMBER(10,2),
    order_status VARCHAR2(20) DEFAULT 'Pending'
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_status VARCHAR2(20) CHECK (payment_status IN ('Success', 'Failed')),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Step 2: Start Transaction
SET AUTOCOMMIT OFF;

-- Step 3: Insert Order
INSERT INTO Orders VALUES (1, 'Lucifer Morningstar', 'Smartphone', 1, 50000, 'Processing');

-- Step 4: Insert Payment (Assume failure)
INSERT INTO Payments VALUES (1, 1, 'Failed', DEFAULT);

-- Step 5: Conditional TCL
DECLARE
    v_status VARCHAR2(20);
BEGIN
    SELECT payment_status INTO v_status FROM Payments WHERE order_id = 1;

    IF v_status = 'Success' THEN
        UPDATE Orders SET order_status = 'Confirmed' WHERE order_id = 1;
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END;
/

SELECT * FROM Orders;
SELECT * FROM Payments;

-- *** 2 ***
-- Step 1: Create Accounts Table
CREATE TABLE Accounts_TCL (
    account_id INT PRIMARY KEY,
    customer_name VARCHAR2(100),
    balance NUMBER(10,2)
);

-- Insert Data
INSERT INTO Accounts_TCL VALUES (1, 'Alice', 5000);
INSERT INTO Accounts_TCL VALUES (2, 'Bob', 2000);

-- Step 2: Start Transaction
SET AUTOCOMMIT OFF;

-- Step 3-5: Transfer Logic
DECLARE
    v_balance NUMBER;
    v_transfer_amt NUMBER := 3000;
BEGIN
    SELECT balance INTO v_balance FROM Accounts_TCL WHERE customer_name = 'Alice';

    IF v_balance >= v_transfer_amt THEN
        UPDATE Accounts_TCL SET balance = balance - v_transfer_amt WHERE customer_name = 'Alice';
        UPDATE Accounts_TCL SET balance = balance + v_transfer_amt WHERE customer_name = 'Bob';
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END;
/

-- Check --
SELECT * FROM Accounts_TCL;
