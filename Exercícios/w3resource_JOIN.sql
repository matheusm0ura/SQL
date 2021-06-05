/*1. Write a SQL statement to prepare a list with salesman name, customer name and their cities for the salesmen and customer who belongs to the same city. */

SELECT s.name, c.cust_name, s.city FROM salesman AS s 
JOIN customer AS c ON s.city = c.city; 

/*2. Write a SQL statement to make a list with order no, purchase amount, customer name and their cities for those orders which order amount between 500 and 2000.*/

SELECT o.ord_no, o.purch_amt, c.cust_name, c.city  FROM orders AS o
JOIN customer AS c ON o.customer_id = c.customer_id
WHERE o.purch_amt BETWEEN 500 AND 2000; 

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
