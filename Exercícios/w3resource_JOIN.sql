
/*28. Write a query in SQL to find the first name and last name of employees working for departments with a budget more than Rs. 50000. */

SELECT e.EMP_FNAME, e.EMP_LNAME FROM emp_department AS d 
JOIN emp_details AS e ON d.DPT_CODE = e.EMP_DEPT
WHERE d.DPT_ALLOTMENT > 50000;

/*29. Write a query in SQL to find the names of departments where more than two employees are working.*/

SELECT d.DPT_NAME FROM emp_department AS d 
JOIN emp_details AS e ON d.DPT_CODE = e.EMP_DEPT
GROUP BY d.DPT_NAME HAVING COUNT(e.EMP_IDNO) > 2;
