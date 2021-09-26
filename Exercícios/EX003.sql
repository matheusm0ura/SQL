/*1. Write a SQL statement to display all the information of all salesmen. */

SELECT * FROM salesman

/*2. Write a SQL statement to display a string "This is SQL Exercise, Practice and Solution"*/

SELECT 'This is SQL Exercise, Practice and Solution';

/*31. From the following table, write a SQL query to find unique last name of all employees. Return emp_lname.*/

SELECT DISTINCT emp_lname FROM emp_details;

/*32. From the following table, write a SQL query to find the details of employees whose last name is 'Snares'. Return emp_idno, emp_fname, emp_lname, and emp_dept.*/

SELECT * FROM emp_details WHERE EMP_LNAME = 'Snares';

/*33. From the following table, write a SQL query to find the details of the employees who work in the department 57. Return emp_idno, emp_fname, emp_lname and emp_dept.*/

SELECT emp_idno, emp_fname, emp_lname, emp_dept FROM emp_details WHERE EMP_DEPT = 57;
