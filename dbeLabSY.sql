SELECT table_name FROM user_tables;
DESC Employees;

SELECT * FROM Employees WHERE department_id = 90;
SELECT * FROM Employees WHERE last_name='Whalen';

SELECT last_name, salary FROM Employees WHERE salary != 3000;

SELECT last_name, salary, manager_id, employee_id  FROM Employees WHERE manager_id IN (100, 101, 201);

SELECT first_name FROM employees WHERE last_name LIKE '_o%';

SELECT last_name, salary, manager_id, employee_id  FROM Employees WHERE manager_id is NULL;

SELECT last_name, salary, manager_id, employee_id  FROM Employees WHERE salary >= 10000 AND job_id LIKE '%MAN%';

SELECT last_name, salary, manager_id, employee_id  FROM Employees WHERE salary >= 10000 OR job_id LIKE '%MAN%';

SELECT last_name, salary, manager_id, employee_id  FROM Employees WHERE job_id NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');

SELECT last_name, salary, manager_id, employee_id  FROM Employees WHERE job_id='SA_REP' OR job_id='AD_PRES' AND salary > 15000;