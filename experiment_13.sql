SELECT table_name FROM user_tables;

-- 1
SELECT employee_id, salary FROM employees WHERE salary < '5000';

-- 2
SELECT first_name, hire_date FROM employees WHERE hire_date > '01-JAN-2005';

-- 3
SELECT first_name, salary FROM employees WHERE salary > '4000';

-- 5
SELECT first_name, salary FROM employees WHERE salary > '6000.50';

-- 7
SELECT employee_id FROM employees WHERE employee_id = '100';

-- 8
SELECT first_name, hire_date FROM employees WHERE hire_date < '15-JUL-2006';

-- 9
SELECT first_name || ' earns ' || salary FROM employees;

-- 10
SELECT e.first_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 11
SELECT first_name || ' earns ' || TO_CHAR(salary) FROM employees;

-- 12
SELECT first_name, TO_CHAR(hire_date, 'DD-MON-YYYY') FROM employees;

-- 13
SELECT first_name, salary FROM employees WHERE salary < TO_NUMBER('15000');

-- 14
SELECT first_name, TO_TIMESTAMP(hire_date, 'DD-MON-YYYY HH24:MI:SS') FROM employees;

-- 15
SELECT first_name, TO_CHAR(salary, 'L99,999.99') AS formatted_salary FROM employees;

-- 16
SELECT first_name, hire_date FROM employees WHERE hire_date > TO_DATE('15-JAN-2007', 'DD-MON-YYYY');

-- 17
SELECT first_name, TO_CHAR(TO_DATE(salary, 'J'), 'JSP') FROM employees;

-- 18
SELECT first_name, EXTRACT(YEAR FROM hire_date) FROM employees;

-- 19
SELECT first_name, TO_CHAR(salary, '999.99%') FROM employees;

-- 20
SELECT first_name, TO_TIMESTAMP_TZ(hire_date, 'DD-MON-YYYY HH24:MI:SS TZH:TZM') FROM employees;
