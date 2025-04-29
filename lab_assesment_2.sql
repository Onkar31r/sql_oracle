SELECT table_name FROM user_tables;

CREATE TABLE salesman_la (
salesman_id NUMBER PRIMARY KEY,
name VARCHAR2(50),
city VARCHAR2(50),
commission NUMBER(10,2)
);

SELECT * FROM salesman_la;

CREATE TABLE customer_la(
customer_id NUMBER PRIMARY KEY,
cust_name VARCHAR2(50),
city VARCHAR2(50),
grade NUMBER,
salesman_id NUMBER,
CONSTRAINT fk_cust_salesman FOREIGN KEY (salesman_id) REFERENCES salesman_la(salesman_id)
);
SELECT *  FROM customer_la;

CREATE TABLE orders_la(
ord_no NUMBER PRIMARY KEY,
purch_amt NUMBER(10,2),
ord_date DATE,
customer_id NUMBER,
salesman_id NUMBER,
CONSTRAINT fk_cust_ord FOREIGN KEY (customer_id) REFERENCES customer_la(customer_id),
CONSTRAINT fk_sales_ord FOREIGN KEY (salesman_id) REFERENCES salesman_la(salesman_id)
);
SELECT * FROM orders_la;

INSERT INTO salesman_la VALUES(5001, 'James Hoog' , 'New York', 0.15);
INSERT INTO salesman_la VALUES(5002, 'Nail Knite' , 'Paris', 0.13);
INSERT INTO salesman_la VALUES(5005, 'Pit Alex' , 'London', 0.11);
INSERT INTO salesman_la VALUES(5006, 'MC Lyon' , 'Paris', 0.14);
INSERT INTO salesman_la VALUES(5007, 'Paul Adam' , 'Rome', 0.13);
INSERT INTO salesman_la VALUES(5003, 'Lauson Hen' , 'San Rose', 0.12);

INSERT INTO customer_la VALUES(3002, 'Nick Rimado', 'New York', 100, 5001);
INSERT INTO customer_la VALUES(3007, 'Brad Davis', 'New York', 200, 5001);
INSERT INTO customer_la VALUES(3005, 'Graham Zusi', 'California', 200, 5002);
INSERT INTO customer_la VALUES(3008, 'Julian Green', 'London',300, 5002);
INSERT INTO customer_la VALUES(3004, 'Fabian Johnson', 'Paris',300, 5006);
INSERT INTO customer_la VALUES(3009, 'Geoff Cameron', 'Berlin',100, 5003);
INSERT INTO customer_la VALUES(3003, 'Jozy Altidor', 'Moscow',200, 5007);
INSERT INTO customer_la(customer_id, cust_name, city, salesman_id) VALUES(3001, 'Brad Guzan', 'London', 5002);


INSERT INTO orders_la VALUES(70001, 150.5, '2012-10-05', 3005, 5002);
INSERT INTO orders_la VALUES(70009, 270.65,'2012-09-10', 3001, 5005);
INSERT INTO orders_la VALUES(70002, 65.26, '2012-10-05', 3002, 5001);
INSERT INTO orders_la VALUES(70004, 110.5, '2012-08-17', 3009, 5003);
INSERT INTO orders_la VALUES(70007, 948.5, '2012-09-10', 3005, 5002);
INSERT INTO orders_la VALUES(70005, 2400.6, '2012-07-27', 3007, 5001);
INSERT INTO orders_la VALUES(70008, 5760, '2012-09-10', 3002, 5001);
INSERT INTO orders_la VALUES(70010, 1983.43, '2012-10-10', 3004, 5006);
INSERT INTO orders_la VALUES(70003, 2480.4, '2012-10-10', 3009, 5003);
INSERT INTO orders_la VALUES(70012, 250.45, '2012-06-27', 3008, 5002);
INSERT INTO orders_la VALUES(70011, 75.29, '2012-08-17', 3003, 5007);
INSERT INTO orders_la VALUES(70013, 3045.6, '2012-04-25', 3002, 5001);


-- Q.1
SELECT * FROM salesman_la WHERE city='London';
SELECT * FROM customer_la WHERE city='London';

-- Q.2
SELECT DISTINCT(name), city FROM salesman_la;

-- Q.3
SELECT s.salesman_id, c.customer_id FROM salesman_la s JOIN customer_la c ON s.salesman_id=c.salesman_id;

-- s.salesman_id, s.name, o.ord_no, o.ord_date, MIN(o.purch_amt), MAX(o.purch_amt)
SELECT DISTINCT(ord_date) FROM  orders_la GROUP BY ord_date;
-- Q.4
SELECT s.salesman_id, s.name, o.ord_no, UNIQUE(ord_date), MIN(o.purch_amt), MAX(o.purch_amt) FROM salesman_la s JOIN orders_la o ON s.salesman_id = o.salesman_id GROUP BY o.ord_date;

-- Q.5
