SELECT table_name from user_tables;

-- Tables
CREATE TABLE Accounts (
    AccountNo NUMBER PRIMARY KEY,
    HolderName VARCHAR2(50),
    Balance NUMBER
);

CREATE TABLE Transactions (
    TransID NUMBER PRIMARY KEY,
    AccountNo NUMBER,
    TransType VARCHAR2(10),
    Amount NUMBER,
    TransDate DATE
);

CREATE TABLE Transaction_Log (
    LogID NUMBER PRIMARY KEY,
    AccountNo NUMBER,
    Amount NUMBER,
    ActionType VARCHAR2(10),
    LogTime DATE
);

-- Sequences
CREATE SEQUENCE Trans_ID_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE Log_ID_SEQ START WITH 1 INCREMENT BY 1;

-- Sample Data
INSERT INTO Accounts VALUES (1001, 'Onkar Rane', 100000);
INSERT INTO Accounts VALUES (1002, 'Priya Patil', 50000);
INSERT INTO Accounts VALUES (1003, 'Amit Shah', 30000);
COMMIT;

-- Deposit Procedure
CREATE OR REPLACE PROCEDURE DepositAmount(acc_no IN NUMBER, amt IN NUMBER) AS
BEGIN
    UPDATE Accounts SET Balance = Balance + amt WHERE AccountNo = acc_no;

    INSERT INTO Transactions VALUES (
        Trans_ID_SEQ.NEXTVAL, acc_no, 'DEPOSIT', amt, SYSDATE
    );
END;
/

-- Withdraw procedure
CREATE OR REPLACE PROCEDURE WithdrawAmount(acc_no IN NUMBER, amt IN NUMBER) AS
    current_balance NUMBER;
BEGIN
    SELECT Balance INTO current_balance FROM Accounts WHERE AccountNo = acc_no;

    IF current_balance >= amt THEN
        UPDATE Accounts SET Balance = Balance - amt WHERE AccountNo = acc_no;

        INSERT INTO Transactions VALUES (
            Trans_ID_SEQ.NEXTVAL, acc_no, 'WITHDRAW', amt, SYSDATE
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient balance.');
    END IF;
END;
/

-- Hig Value Trigger
CREATE OR REPLACE TRIGGER HighValueTrigger
AFTER INSERT ON Transactions
FOR EACH ROW
WHEN (NEW.Amount > 50000)
BEGIN
    INSERT INTO Transaction_Log VALUES (
        Log_ID_SEQ.NEXTVAL, :NEW.AccountNo, :NEW.Amount, :NEW.TransType, SYSDATE
    );
END;
/

-- Mini Statement Cursor
SET SERVEROUTPUT ON;

DECLARE
    CURSOR mini_stmt IS
        SELECT TransType, Amount, TransDate FROM Transactions
        WHERE AccountNo = 1002;
    tx mini_stmt%ROWTYPE;
BEGIN
    OPEN mini_stmt;
    LOOP
        FETCH mini_stmt INTO tx;
        EXIT WHEN mini_stmt%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(tx.TransType || ' - ₹' || tx.Amount || ' on ' || tx.TransDate);
    END LOOP;
    CLOSE mini_stmt;
END;
/


-- Execute Procedures
EXEC DepositAmount(1001, 10000);
EXEC WithdrawAmount(1001, 60000);
EXEC WithdrawAmount(1002, 2000);

-- View log
SELECT * FROM Transaction_Log;


-- *** Finish ***

-- Inserting more data and testing

-- Additional sample accounts
INSERT INTO Accounts VALUES (1004, 'Sneha Kulkarni', 200000);
INSERT INTO Accounts VALUES (1005, 'Rohan Desai', 45000);
INSERT INTO Accounts VALUES (1006, 'Meera Naik', 15000);
COMMIT;


-- Sneha deposits ₹60,000 (should trigger log)
EXEC DepositAmount(1004, 60000);

-- Rohan withdraws ₹20,000 (won’t trigger)
EXEC WithdrawAmount(1005, 20000);

-- Meera tries to withdraw ₹20,000 (should fail due to insufficient balance)
EXEC WithdrawAmount(1006, 20000);

-- Sneha withdraws ₹80,000 (should trigger log)
EXEC WithdrawAmount(1004, 80000);

SELECT * FROM Accounts;
SELECT * FROM Transactions ORDER BY TransID;
SELECT * FROM Transaction_Log ORDER BY LogID;

SET SERVEROUTPUT ON;

DECLARE
    CURSOR sneha_stmt IS
        SELECT TransType, Amount, TransDate FROM Transactions
        WHERE AccountNo = 1004;
    tx sneha_stmt%ROWTYPE;
BEGIN
    OPEN sneha_stmt;
    LOOP
        FETCH sneha_stmt INTO tx;
        EXIT WHEN sneha_stmt%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(tx.TransType || ' - ₹' || tx.Amount || ' on ' || tx.TransDate);
    END LOOP;
    CLOSE sneha_stmt;
END;
/














