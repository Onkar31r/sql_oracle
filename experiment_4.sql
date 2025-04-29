SELECT table_name from user_tables;

-- 1st Question
SELECT last_name, job_id, salary AS Sal
FROM employees;

-- 2nd Question
SELECT *
FROM job_grades; 

-- 3rd Question
SELECT employee_id, last_name,
salary * 12 ANNUAL_SALARY
FROM employees;

-- 4th Question
-- a)
DESC EMPLOYEES;
SELECT 
    COLUMN_NAME AS "Column Name", 
    DATA_TYPE AS "Data Type", 
    CASE 
        WHEN DATA_TYPE = 'NUMBER' THEN DATA_PRECISION || ',' || DATA_SCALE 
        ELSE TO_CHAR(DATA_LENGTH) 
    END AS "Size/Precision", 
    CASE 
        WHEN NULLABLE = 'N' THEN 'NOT NULL' 
        ELSE 'NULLABLE' 
    END AS "Null Status"
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEES'
ORDER BY COLUMN_ID;

-- b)
SELECT employee_id, last_name, 
job_id, hire_date STARTDATE
FROM employees;

-- 5th Question
SELECT UNIQUE job_id FROM employees;

-- 6th Question
SELECT employee_id "EMP #", last_name Employee, 
job_id Job, hire_date "HIRE DATE"
FROM employees;
