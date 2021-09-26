/*1. Write a SQL statement to display all the information of all salesmen. */

SELECT * FROM salesman

/*2. Write a SQL statement to display a string "This is SQL Exercise, Practice and Solution"*/

SELECT 'This is SQL Exercise, Practice and Solution';

20. From the following table, write a SQL query to find the Nobel Prize winners in 1970 excluding the subjects Physiology and Economics. 
Return year, subject, winner, country, and category. 

21. From the following table, write a SQL query to combine the winners in 'Physiology' before 1971 and winners in 'Peace' on or after 1974. 
Return year, subject, winner, country, and category. 

22. From the following table, write a SQL query to find the details of the Nobel Prize winner 'Johannes Georg Bednorz'. Return year, subject, winner, country, and category.

23. From the following table, write a SQL query to find the Nobel Prize winners for the subject not started with the letter 'P'. 
Return year, subject, winner, country, and category. Order the result by year, descending.

24. From the following table, write a SQL query to find the details of 1970 Nobel Prize winners. Order the result by subject, ascending except ‘Chemistry’ 
and ‘Economics’ which will come at the end of result set. Return year, subject, winner, country, and category.

25. From the following table, write a SQL query to select a range of products whose price is in the range Rs.200 to Rs.600. 
Begin and end values are included. Return pro_id, pro_name, pro_price, and pro_com.

26. From the following table, write a SQL query to calculate the average price for manufacturer code equal to 16. Return avg.

27. From the following table, write a SQL query to display the pro_name as 'Item Name' and pro_priceas 'Price in Rs.'



/*28. From the following table, write a SQL query to find the items whose prices are higher than or equal to $250. Order the result 
by product price in descending, then product name in ascending. Return pro_name and pro_price.*/

SELECT pro_name, pro_price FROM item_mast WHERE pro_price >= 250.00 ORDER BY pro_price DESC, pro_name;

/*29. From the following table, write a SQL query to calculate average price of the items of each company. Return average price and company code.*/

SELECT pro_com, AVG(pro_price) AS AVERAGE FROM item_mast GROUP BY  pro_com ORDER BY pro_com;

/*30. From the following table, write a SQL query to find the cheapest item(s). Return pro_name and, pro_price.*/

SELECT pro_name, pro_price FROM item_mast WHERE pro_price = (SELECT MIN(pro_price) FROM item_mast);

/*31. From the following table, write a SQL query to find unique last name of all employees. Return emp_lname.*/

SELECT DISTINCT emp_lname FROM emp_details;

/*32. From the following table, write a SQL query to find the details of employees whose last name is 'Snares'. Return emp_idno, emp_fname, emp_lname, and emp_dept.*/

SELECT * FROM emp_details WHERE EMP_LNAME = 'Snares';

/*33. From the following table, write a SQL query to find the details of the employees who work in the department 57. Return emp_idno, emp_fname, emp_lname and emp_dept.*/

SELECT emp_idno, emp_fname, emp_lname, emp_dept FROM emp_details WHERE EMP_DEPT = 57;
