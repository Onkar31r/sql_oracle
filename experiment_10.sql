SELECT table_name from user_tables;

-- 1
SELECT * FORM students;
SELECT * FROM students;

-- 2
SELECT student_id, name FROM student;
SELECT student_id, name FROM students;

-- 3
SELECT name, order FROM orders;
SELECT name, `order` FROM orders;

-- 4
SELECT * FROM students WHERE age = 'twenty';
SELECT * FROM students WHERE age = 20;

-- 5
SELECT salary / bonus FROM employees;
SELECT salary / NULLIF(bonus, 0) FROM employees;

-- 6
INSERT INTO students (id, name) VALUES (1, 'John');
INSERT INTO students (id, name) VALUES (1, 'Mike');

-- 7
INSERT INTO students (id, name) VALUES (2, NULL);
INSERT INTO students (id, name) VALUES (2, 'Default Name');

-- 8
INSERT INTO orders (order_id, customer_id) VALUES (1, 100);

INSERT INTO customers (id, name) VALUES (100, 'John Doe');
INSERT INTO orders (order_id, customer_id) VALUES (1, 100);

-- 9
SELECT name, COUNT(*) FROM students;
SELECT name, COUNT(*) FROM students GROUP BY name;

-- 10
SELECT * FROM students HAVING age > 18;
SELECT * FROM students WHERE age > 18;

-- 11
SELECT name FROM students WHERE COUNT(*) > 5;
SELECT name, COUNT(*) FROM students GROUP BY name HAVING COUNT(*) > 5;

-- 12
SELECT student_id, name, COUNT(*) FROM students GROUP BY student_id;
SELECT student_id, name, COUNT(*) FROM students GROUP BY student_id, name;

-- 13
SELECT DISTINCT student_id, COUNT(*) FROM students;
SELECT student_id, COUNT(*) FROM students GROUP BY student_id;

-- 14
SELECT students.name, orders.order_id FROM students JOIN orders;
SELECT students.name, orders.order_id 
FROM students 
JOIN orders ON students.id = orders.student_id;

-- 15
SELECT name, age FROM students 
JOIN teachers ON students.age = teachers.age;

SELECT name, age FROM students
UNION
SELECT name, age FROM teachers;

-- 16
UPDATE students SET age = 20;
UPDATE students SET age = 20 WHERE student_id = 5;
 
-- 17
UPDATE students SET age = 20;
UPDATE students SET age = 20 WHERE student_id = 5;

-- 18
INSERT INTO students VALUES (1, 'John');
INSERT INTO students (id, name) VALUES (1, 'John');

-- 19
SELECT * FROM students WHERE name LIKE John;
SELECT * FROM students WHERE name LIKE '%John%';

-- 20
SELECT * FROM students LIMIT 5;
SELECT * FROM students ORDER BY age DESC LIMIT 5;

-- 21
SELECT name FROM students WHERE id = (SELECT id FROM teachers);
SELECT name FROM students WHERE id IN (SELECT id FROM teachers);

-- 22
SELECT name FROM students WHERE EXISTS (id);
SELECT name FROM students WHERE EXISTS (SELECT id FROM teachers WHERE teachers.id = students.id);

-- 23
INSERT INTO students (id, name, dob) VALUES (1, 'John', '32-01-2023');
INSERT INTO students (id, name, dob) VALUES (1, 'John', '2023-01-31');