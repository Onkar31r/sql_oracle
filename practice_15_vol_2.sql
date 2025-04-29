SELECT table_name FROM user_tables;

-- UNION operator
SELECT employee_id, job_id
FROM employees
UNION
SELECT employee_id, job_id
FROM job_history;

SELECT employee_id, job_id, department_id
FROM employees
UNION
SELECT employee_id, job_id, department_id
FROM job_history;

-- UNION ALL operator
SELECT employee_id, job_id,department_id
FROM employees
UNION
SELECT employee_id, job_id,department_id
FROM job_history
ORDER BY employee_id;

-- INTERSECT
SELECT employee_id, job_id, department_id
FROM employees
INTERSECT
SELECT employee_id, job_id, department_id
FROM job_history;

SELECT * FROM job_history;



desc employees

select employee_id, last_name, job_id, hire_date, department_id from employees;

desc job_history

select * from job_history

select employee_id, job_id from employees
union 
select employee_id, job_id from job_history

select employee_id, job_id, department_id from employees
union all
select employee_id, job_id, department_id from job_history
order by employee_id;

select employee_id, job_id from employees
intersect
select employee_id, job_id from job_history

select employee_id, job_id from employees
minus
select employee_id, job_id from job_history

 SELECT employee_id, department_id
 FROM   employees
 WHERE  (employee_id, department_id) 
IN (SELECT employee_id, department_id
 FROM   employees 
UNION
 SELECT employee_id, department_id
 FROM   job_history);

SELECT department_id, TO_NUMBER(null) 
location, hire_date
FROM   employees
UNION
SELECT department_id, location_id,  TO_DATE(null)
FROM   departments;

select employee_id,job_id,salary from employees 
union 
select employee_id,job_id,0 from job_history;
