SELECT table_name from user_tables;

SELECT SYSDATE FROM DUAL;

DESC employees;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

-- Q- 1 (Char Func)
    -- 1
    SELECT UPPER(first_name), LOWER(last_name) FROM employees;
    
    -- 2
    SELECT first_name, LENGTH(first_name) "No. of Chars" FROM employees;
    
    -- 3
    SELECT first_name, last_name, LENGTH(last_name) "LENGTH OF LAST NAME" FROM employees WHERE LENGTH(last_name) = &length;
    
    -- 4
    SELECT first_name, REPLACE(first_name, 'e', 'a') "Mod_Name" FROM employees;

-- Q- 1 (NUM FUNC)
    -- 1
    SELECT last_name,salary, ROUND(salary, -2) "Rounded Salary" FROM employees;
    
    -- 2
    SELECT salary, salary/1000"Normal Division", CEIL(salary/1000) "Ceiling Value", FLOOR(salary/1000) "Floored Value" FROM employees;
    
    -- 3
    SELECT salary, MOD(salary, 5) "Remainder" FROM employees;
    
-- Q-1 (Converion Func)
    -- 1
    SELECT TO_CHAR(hire_date, 'DD-Mon-YYYY')AS "MOD_DATE" FROM employees;
    
    -- 2
    SELECT TO_CHAR(salary) || ' USD' "Salary_with_sign" FROM employees;
    
-- Q- 2 (Date Functions)
    --1
    SELECT first_name, last_name, hire_date FROM employees WHERE EXTRACT(year from hire_date) = 2006;
    
    -- 2
    SELECT first_name, CEIL(MONTHS_BETWEEN(SYSDATE, hire_date)) "Completed Working MONTHS" FROM employees;
    
    -- 3
    SELECT first_name, last_name, hire_date, TO_CHAR(hire_date, 'DAY') FROM employees WHERE TRIM(TO_CHAR(hire_date, 'DAY') )= 'MONDAY'; -- Implicitly the return value is right padded, that's why we need to use TRIM() explicitly.
    
    -- 4
    SELECT first_name, last_name, hire_date, ADD_MONTHS(hire_date,6) "Mod_Hire_Date" FROM employees;
    
    -- 5
    SELECT first_name , last_name, TRUNC(sysdate - hire_date) "Days-Worked" FROM employees;
    
-- Ranging and Sorting
    -- Ranging
    --1
    SELECT last_name, first_name, salary FROM employees WHERE salary BETWEEN 5000 AND 15000;
    
    -- 2
    SELECT first_name, last_name, hire_date FROM employees 
    WHERE hire_date  BETWEEN TO_DATE('2000-01-01', 'YYYY-MM-DD') 
                                            AND TO_DATE('2005-12-31', 'YYYY-MM-DD');
    
    -- 3
    SELECT first_name, last_name, salary ,
    CASE
        WHEN salary < 5000 THEN 'Low Salary'
        WHEN salary BETWEEN 5000 AND 15000 THEN 'Moderate Salary'
        ELSE 'High Salary'
    END AS salary_status
    FROM employees;
    
-- Sorting
    -- 1
    SELECT first_name, last_name, salary FROM employees ORDER BY salary DESC;
    
    -- 2
    SELECT first_name, last_name, hire_date, department_id
    FROM employees
    ORDER BY hire_date ASC, department_id ASC;
    
    -- 3
    SELECT e.first_name, e.last_name, d.location_id, d.department_name
    FROM employees e JOIN
    departments d ON e.department_id = d.department_id
    ORDER BY d. location_id ASC, department_name ASC;
    
    
