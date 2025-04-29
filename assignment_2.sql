SELECT table_name FROM user_tables;
SELECT * FROM Departments;
--*** Creating Tables ***

-- Departments Table
CREATE TABLE Departments (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(100) UNIQUE NOT NULL
);

-- Students Table
CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    dept_id NUMBER,
    CONSTRAINT fk_student_dept FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE SET NULL
);

-- Professors Table
CREATE TABLE Professors (
    professor_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    dept_id NUMBER,
    CONSTRAINT fk_professor_dept FOREIGN KEY (dept_id) REFERENCES Departments(dept_id) ON DELETE SET NULL
);

-- Courses Table
CREATE TABLE Courses (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(100) NOT NULL,
    credits NUMBER CHECK (credits BETWEEN 1 AND 6),
    professor_id NUMBER,
    CONSTRAINT fk_course_prof FOREIGN KEY (professor_id) REFERENCES Professors(professor_id) ON DELETE SET NULL
);

-- Enrollments Table (Many-to-Many between Students and Courses)
CREATE TABLE Enrollments (
    enroll_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    course_id NUMBER,
    enroll_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_enroll_student FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_enroll_course FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE,
    CONSTRAINT unique_enrollment UNIQUE (student_id, course_id)
);

-- Assignments Table
CREATE TABLE Assignments (
    assignment_id NUMBER PRIMARY KEY,
    course_id NUMBER,
    title VARCHAR2(200) NOT NULL,
    due_date DATE NOT NULL,
    CONSTRAINT fk_assignment_course FOREIGN KEY (course_id) REFERENCES Courses(course_id) ON DELETE CASCADE
);

-- Submissions Table
CREATE TABLE Submissions (
    submission_id NUMBER PRIMARY KEY,
    assignment_id NUMBER,
    student_id NUMBER,
    submitted_on DATE DEFAULT SYSDATE,
    CONSTRAINT fk_submission_assignment FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id) ON DELETE CASCADE,
    CONSTRAINT fk_submission_student FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE
);

-- *** AUTO INCREMENT ***
CREATE SEQUENCE student_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE professor_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE course_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE enroll_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE assignment_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE submission_seq START WITH 1 INCREMENT BY 1;

-- *** Sample data ***

-- Departments Table
INSERT INTO Departments (dept_id, dept_name) VALUES (1, 'Computer Science & Engineering');
INSERT INTO Departments (dept_id, dept_name) VALUES (2, 'Mechanical Engineering');
INSERT INTO Departments (dept_id, dept_name) VALUES (3, 'Electronics & Communication');
INSERT INTO Departments (dept_id, dept_name) VALUES (4, 'Civil Engineering');

-- Students Table
INSERT INTO Students (student_id, first_name, last_name, email, dept_id)
VALUES (student_seq.NEXTVAL, 'Amit', 'Sharma', 'amit.sharma@iitb.ac.in', 1);

INSERT INTO Students (student_id, first_name, last_name, email, dept_id)
VALUES (student_seq.NEXTVAL, 'Priya', 'Singh', 'priya.singh@nitk.ac.in', 2);

INSERT INTO Students (student_id, first_name, last_name, email, dept_id)
VALUES (student_seq.NEXTVAL, 'Rahul', 'Patel', 'rahul.patel@iitd.ac.in', 1);

INSERT INTO Students (student_id, first_name, last_name, email, dept_id)
VALUES (student_seq.NEXTVAL, 'Sneha', 'Iyer', 'sneha.iyer@iiith.ac.in', 3);

-- Professors Table
INSERT INTO Professors (professor_id, full_name, email, dept_id)
VALUES (professor_seq.NEXTVAL, 'Dr. Rajesh Verma', 'rajesh.verma@iitb.ac.in', 1);

INSERT INTO Professors (professor_id, full_name, email, dept_id)
VALUES (professor_seq.NEXTVAL, 'Dr. Ananya Nair', 'ananya.nair@iitm.ac.in', 2);

-- Courses Table
INSERT INTO Courses (course_id, course_name, credits, professor_id)
VALUES (course_seq.NEXTVAL, 'Data Structures & Algorithms', 4, 1);

INSERT INTO Courses (course_id, course_name, credits, professor_id)
VALUES (course_seq.NEXTVAL, 'Thermodynamics', 3, 2);

INSERT INTO Courses (course_id, course_name, credits, professor_id)
VALUES (course_seq.NEXTVAL, 'Microprocessors & Embedded Systems', 4, 1);

-- Enrollments Table
INSERT INTO Enrollments (enroll_id, student_id, course_id, enroll_date)
VALUES (enroll_seq.NEXTVAL, 1, 1, TO_DATE('2024-01-10', 'YYYY-MM-DD'));

INSERT INTO Enrollments (enroll_id, student_id, course_id, enroll_date)
VALUES (enroll_seq.NEXTVAL, 2, 2, TO_DATE('2024-01-12', 'YYYY-MM-DD'));

INSERT INTO Enrollments (enroll_id, student_id, course_id, enroll_date)
VALUES (enroll_seq.NEXTVAL, 3, 1, TO_DATE('2024-01-15', 'YYYY-MM-DD'));

-- Assignments Table
INSERT INTO Assignments (assignment_id, course_id, title, due_date)
VALUES (assignment_seq.NEXTVAL, 1, 'Sorting Algorithms Analysis', TO_DATE('2024-02-01', 'YYYY-MM-DD'));

INSERT INTO Assignments (assignment_id, course_id, title, due_date)
VALUES (assignment_seq.NEXTVAL, 2, 'Heat Transfer Experiment Report', TO_DATE('2024-02-10', 'YYYY-MM-DD'));

-- Submissions Table
INSERT INTO Submissions (submission_id, assignment_id, student_id, submitted_on)
VALUES (submission_seq.NEXTVAL, 1, 1, TO_DATE('2024-01-30', 'YYYY-MM-DD'));

INSERT INTO Submissions (submission_id, assignment_id, student_id, submitted_on)
VALUES (submission_seq.NEXTVAL, 2, 2, TO_DATE('2024-02-08', 'YYYY-MM-DD'));

-- *** JOINS *** 
-- 1. Inner Join
SELECT s.student_id, s.first_name, s.last_name, s.email, d.dept_name
FROM Students s
INNER JOIN Departments d ON s.dept_id = d.dept_id;

-- 2. LEFT JOIN
SELECT s.student_id, s.first_name, s.last_name, e.course_id, e.enroll_date
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id;

-- 3. RIGHT JOIN
SELECT e.enroll_id, e.student_id, c.course_name, c.credits
FROM Enrollments e
RIGHT JOIN Courses c ON e.course_id = c.course_id;

-- 4. FULL OUTER JOIN
SELECT s.student_id, s.first_name, s.last_name, e.course_id, e.enroll_date
FROM Students s
FULL OUTER JOIN Enrollments e ON s.student_id = e.student_id;

-- 5. CROSS JOIN
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
CROSS JOIN Courses c;

-- 6. SELF JOIN
SELECT s1.first_name AS Student1, s2.first_name AS Student2, s1.dept_id
FROM Students s1
JOIN Students s2 ON s1.dept_id = s2.dept_id
WHERE s1.student_id <> s2.student_id;

-- 7. NATURAL JOIN
SELECT p.full_name, p.email, d.dept_name
FROM Professors p
NATURAL JOIN Departments d;
