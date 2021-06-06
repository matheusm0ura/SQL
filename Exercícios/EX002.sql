/*1. Write a query in SQL to display the first name, last name, department number, and department name for each employee.*/

SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_ID, d.DEPARTMENT_NAME FROM employees AS e 
JOIN departments AS d USING(DEPARTMENT_ID);

/*2. Write a query in SQL to display the first and last name, department, city, and state province for each employee.*/

SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, l.CITY, l.STATE_PROVINCE FROM employees AS e 
JOIN departments AS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN locations AS l ON l.LOCATION_ID = d.LOCATION_ID;

/*3. Write a query in SQL to display the first name, last name, salary, and job grade for all employees. */

/*4. Write a query in SQL to display the first name, last name, department number and department name, for all employees for departments 80 or 40.*/

/*5. Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name, department, city, and state province.*/

/*6. Write a query in SQL to display all departments including those where does not have any employee.*/

/*7. Write a query in SQL to display the first and last name and salary for those employees who earn less than the employee earn whose number is 182.*/

/*8. Write a query in SQL to display the first name of all employees including the first name of their manager.*/

/*9. Write a query in SQL to display the department name, city, and state province for each department.*/

/*10. Write a query in SQL to display the first name, last name, department number and name, for all employees who have or have not any department. */

/*11. Write a query in SQL to display the first name of all employees and the first name of their manager including those who does not working under any manager.*/

/*12. Write a query in SQL to display the first name, last name, and department number for those 
employees who works in the same department as the employee who holds the last name as Taylor.*/

/*13. Write a query in SQL to display the job title, department name, 
full name (first and last name ) of employee, and starting date for all the jobs which started on or 
after 1st January, 1993 and ending with on or before 31 August, 1997*/

/*14. Write a query in SQL to display job title, full name (first and last name ) of employee, and the difference between maximum salary for the job and salary of the employee.*/

/*15. Write a query in SQL to display the name of the department, average salary and number of employees working in that department who got commission.*/

/*16. Write a query in SQL to display the full name (first and last name ) of employees, job title and the salary 
differences to their own job for those employees who is working in the department ID 80.*/

