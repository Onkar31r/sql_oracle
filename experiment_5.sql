SELECT table_name FROM user_tables;

DESC employees;
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM locations;

-- Q- 1.1
SELECT last_name, salary "MONTHLY INCOME", salary*12 "ANNUAL INCOME" FROM employees;

-- Q- 1.2
SELECT MAX(SALARY) "MAX_SALARY", MIN(salary) "MIN_SALARY", MAX(SALARY) - MIN(salary) "SALARY_DIFFEREENCE"  FROM employees;

-- Q- 1.3
SELECT department_id, last_name, salary, salary + 500 "SALARY+BONUS" FROM employees WHERE department_id = 50;

-- Q- 2.1
SELECT last_name, salary FROM employees WHERE salary > 10000;

-- Q- 2.2
SELECT first_name, last_name, commission_pct FROM employees WHERE commission_pct != 0;

-- Q- 2.3
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date >= TO_DATE('2005-01-01' , 'YYYY-MM-DD');

-- Q-3.1
SELECT first_name, last_name,department_id, salary FROM employees WHERE salary > 10000 and department_id = 80;

-- Q- 3.2
SELECT first_name,last_name,job_id FROM employees WHERE job_id = 'AD_VP' or job_id='SA_MAN';
SELECT first_name, last_name, job_id FROM employees Where job_id IN ('AD_VP', 'SA_MAN');

-- Q- 3.3
SELECT first_name, last_name, department_id FROM employees WHERE department_id NOT IN (90);

-- Q- 4.1
SELECT first_name, last_name, first_name || ' ' || last_name "FULL NAME" FROM employees;

-- Q- 4.2
SELECT first_name FROM employees where first_name like 'J%';

-- Q- 4.3
SELECT last_name FROM employees WHERE last_name like '%son%';

-- Q- 5.1
SELECT first_name, last_name, department_id FROM employees WHERE department_id IN (10, 20, 30);

-- Q- 5.2 
SELECT first_name, last_name, salary FROM employees WHERE salary BETWEEN 5000 AND 15000;

-- Q- 5.3
SELECT first_name, last_name, commission_pct FROM employees WHERE commission_pct IS NULL;

-- Q- 6.1
SELECT first_name, last_name FROM employees WHERE last_name like 'A%n';
SELECT first_name, last_name FROM employees WHERE REGEXP_LIKE (last_name, '^A.*n$');

-- Q- 6.2
SELECT first_name, phone_number FROM employees WHERE REGEXP_LIKE(phone_number, '^515\.\d{3}\.\d{4}$');

-- Q- 6.3
SELECT email FROM employees WHERE REGEXP_LIKE(email, '^.*\.\[a-zA-Z]{3}');

-- Q. 7.1
SELECT CONCAT(first_name,CONCAT(' ',  last_name)) "Full Name" FROM employees;
SELECT first_name || ' ' || last_name AS "Full Name" FROM employees;

-- Q. 7.2
SELECT CONCAT(first_name, CONCAT('-', CONCAT(last_name, CONCAT('-',  job_id)))) AS "Req_O/P" FROM employees;
SELECT first_name || '-' || last_name || '-' || job_id AS "Req_O/P" FROM employees;

-- Q. 7.3
SELECT d.department_name || '( Location: ' || l.city || ' )' AS "Department Info" 
FROM departments d JOIN locations l on d.location_id = l.location_id;   