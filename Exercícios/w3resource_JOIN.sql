/*22. Write a SQL query to display the item name, price, and company name of all the products.*/

SELECT i.PRO_NAME, i.PRO_PRICE, c.COM_NAME FROM item_mast AS i
JOIN company_mast AS c ON i.PRO_COM = c.COM_ID;

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
