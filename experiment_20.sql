SELECT table_name FROM user_tables;

CREATE TABLE Employee_20 (
    EmpID NUMBER PRIMARY KEY,
    Name VARCHAR2(50),
    Dept VARCHAR2(30),
    Salary NUMBER,
    Bonus NUMBER
);

SELECT * FROM Employee_20;

CREATE TABLE Salary_Log_20 (
    LogID NUMBER PRIMARY KEY,
    EmpID NUMBER,
    OldSalary NUMBER,
    NewSalary NUMBER,
    ChangeDate DATE
);

CREATE OR REPLACE PROCEDURE GiveBonus_20(dept_name IN VARCHAR2, bonus_amt IN NUMBER) AS
BEGIN
    UPDATE Employee_20 
    SET Bonus = NVL(Bonus, 0) + bonus_amt 
    WHERE Dept = dept_name;
END;
/

SET SERVEROUTPUT ON;

DECLARE
    CURSOR low_salary IS
        SELECT Name, Salary FROM Employee_20
        WHERE Salary < (SELECT AVG(Salary) FROM Employee_20);
    emp_row low_salary%ROWTYPE;
BEGIN
    OPEN low_salary;
    LOOP
        FETCH low_salary INTO emp_row;
        EXIT WHEN low_salary%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Name: ' || emp_row.Name || ' | Salary: ' || emp_row.Salary);
    END LOOP;
    CLOSE low_salary;
END;
/

CREATE SEQUENCE Salary_Log_20_seq
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER salary_update_log_20
BEFORE UPDATE OF Salary ON Employee_20
FOR EACH ROW
BEGIN
    INSERT INTO Salary_Log_20 VALUES (
        Salary_Log_20_seq.NEXTVAL,
        :OLD.EmpID,
        :OLD.Salary,
        :NEW.Salary,
        SYSDATE
    );
END;
/

INSERT INTO Employee_20 VALUES (101, 'Alice', 'HR', 50000, 0);
INSERT INTO Employee_20 VALUES (102, 'Bob', 'HR', 40000, 0);
INSERT INTO Employee_20 VALUES (103, 'Charlie', 'Finance', 60000, 0);

EXEC GiveBonus_20('HR', 2000);

UPDATE Employee_20 SET Salary = 52000 WHERE EmpID = 101;

SELECT * FROM Salary_Log_20;

-- More data and testing trigger
INSERT INTO Employee_20 VALUES (104, 'David', 'Finance', 65000, 0);
INSERT INTO Employee_20 VALUES (105, 'Eva', 'HR', 43000, 0);
INSERT INTO Employee_20 VALUES (106, 'Farhan', 'IT', 70000, 0);
INSERT INTO Employee_20 VALUES (107, 'Geeta', 'IT', 38000, 0);
INSERT INTO Employee_20 VALUES (108, 'Hina', 'Marketing', 55000, 0);
COMMIT;

EXEC GiveBonus_20('IT', 3000);

-- Update salary (will trigger the log)
UPDATE Employee_20 SET Salary = 75000 WHERE EmpID = 106;  -- High increment
UPDATE Employee_20 SET Salary = 41000 WHERE EmpID = 107;  -- Moderate
UPDATE Employee_20 SET Salary = 58000 WHERE EmpID = 108;  -- Slight increment
UPDATE Employee_20 SET Salary = 123456789 WHERE EmpID = 108;
COMMIT;

SELECT * FROM Salary_Log_20;