/*1. Write a SQL statement to prepare a list with salesman name, customer name and their cities for the salesmen and customer who belongs to the same city. */

SELECT s.name, c.cust_name, s.city FROM salesman AS s 
JOIN customer AS c ON s.city = c.city; 

/*2. Write a SQL statement to make a list with order no, purchase amount, customer name and their cities for those orders which order amount between 500 and 2000.*/

SELECT o.ord_no, o.purch_amt, c.cust_name, c.city  FROM orders AS o
JOIN customer AS c ON o.customer_id = c.customer_id
WHERE o.purch_amt BETWEEN 500 AND 2000; 

/*3. Write a SQL statement to know which salesman are working for which customer.*/

SELECT s. name, c.cust_name FROM salesman AS s
JOIN customer AS c ON s.salesman_id = c.salesman_id; 

/*4. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who gets a commission from the company is more than 12%.*/

SELECT c.cust_name, s.name FROM customer as c
JOIN salesman as s ON c.salesman_id = s.salesman_id
where s.commission  > 0.12 

/*5. Write a SQL statement to find the list of customers who appointed a salesman for their jobs who does not live in the same city where their customer lives, 
and gets a commission is above 12% .*/

SELECT c.cust_name as "Customer Name", c.city "Customer city", s.name as "Seller Name", s.city as "Seller city" FROM customer as c
JOIN salesman as s ON s.salesman_id = c.salesman_id
where s.commission  > 0.12 and c.city != s.city;

/*6. Write a SQL statement to find the details of a order i.e. order number, order date, amount of order, which customer gives 
the order and which salesman works for that customer and how much commission he gets for an order.*/

SELECT o.ord_no, o.ord_date, o.purch_amt, c.cust_name, s.name, s.commission
FROM orders AS o 
JOIN customer AS c ON o.customer_id = c.customer_id
JOIN salesman as s ON s.salesman_id = c.salesman_id;

/*7. Write a SQL statement to make a join on the tables salesman, customer and orders in such a 
form that the same column of each table will appear once and only the relational rows will come.*/ 

SELECT * from orders 
NATURAL JOIN customer
NATURAL JOIN salesman;

/*8. Write a SQL statement to make a list in ascending order for the customer who works either through a salesman or by own.*/

SELECT c.cust_name, s.name FROM customer AS C
JOIN salesman AS s ON c.salesman_id  = s.salesman_id
ORDER BY c.customer_id;

/*9. Write a SQL statement to make a list in ascending order for the customer who holds a grade less than 300 and works either through a salesman or by own. */

SELECT c.cust_name, s.name FROM customer AS C
JOIN salesman AS s ON c.salesman_id  = s.salesman_id
WHERE c.grade < 300;

/*10. Write a SQL statement to make a report with customer name, city, order number, order date, and order amount in ascending order 
according to the order date to find that either any of the existing 
customers have placed no order or placed one or more orders.*/

SELECT c.cust_name, c. city, o.ord_no, o.ord_date, o.purch_amt 
FROM orders AS o 
JOIN customer as c ON c.customer_id = o.customer_id
order by o.ord_date;

/*12. Write a SQL statement to make a list in ascending order for the salesmen who works either for one or more customer or not yet join under any of the customers.*/

SELECT s.name, c.cust_name FROM salesman AS s 
JOIN customer AS c ON s.salesman_id  = c.salesman_id 
order by  s.salesman_id ; 

/*21. Write a SQL query to display all the data from the item_mast, including all the data for each item's producer company.*/

SELECT * FROM item_mast AS i
JOIN company_mast AS c ON i.PRO_COM = c.COM_ID;

/*22. Write a SQL query to display the item name, price, and company name of all the products.*/

SELECT i.PRO_NAME, i.PRO_PRICE, c.COM_NAME FROM item_mast AS i
JOIN company_mast AS c ON i.PRO_COM = c.COM_ID;

/*24. Write a SQL query to display the names of the company whose products have an average price larger than or equal to Rs. 350.*/

SELECT c.COM_NAME, AVG(i.PRO_PRICE) FROM item_mast AS i
JOIN company_mast AS c ON i.PRO_COM = c.COM_ID
GROUP BY c.COM_NAME HAVING AVG(i.PRO_PRICE) >= 350;

/*27. Write a query in SQL to display the first name and last name of each employee, along with the name and sanction amount for their department*/

SELECT e.EMP_FNAME, e.EMP_LNAME, d.DPT_NAME, d.DPT_ALLOTMENT  
FROM emp_department AS d 
JOIN emp_details AS e ON d.DPT_CODE = e.EMP_DEPT;

/*28. Write a query in SQL to find the first name and last name of employees working for departments with a budget more than Rs. 50000. */

SELECT e.EMP_FNAME, e.EMP_LNAME FROM emp_department AS d 
JOIN emp_details AS e ON d.DPT_CODE = e.EMP_DEPT
WHERE d.DPT_ALLOTMENT > 50000;

/*29. Write a query in SQL to find the names of departments where more than two employees are working.*/

SELECT d.DPT_NAME FROM emp_department AS d 
JOIN emp_details AS e ON d.DPT_CODE = e.EMP_DEPT
GROUP BY d.DPT_NAME HAVING COUNT(e.EMP_IDNO) > 2;
