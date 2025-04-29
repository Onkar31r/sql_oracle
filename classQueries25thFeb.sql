SELECT table_name from user_tables;

SELECT COUNT(*) FROM employees WHERE department_id=50;

SELECT AVG(commission_pct) FROM employees WHERE department_id=80;

SELECT COUNT(DISTINCT department_id ) "Active Departments"  FROM employees;

SELECT department_id dept_id, job_id, SUM(salary) FROM employees GROUP BY department_id, job_id;

SELECT department_id, COUNT(last_name) FROM employees WHERE department_id=10;

SELECT job_id, SUM(salary) PAYROLL FROM employees WHERE job_id NOT LIKE '%REP%' GROUP BY job_id HAVING SUM(salary) > 13000 ORDER BY SUM(salary);

SELECT MAX(AVG(salary)) FROM employees GROUP BY department_id;
