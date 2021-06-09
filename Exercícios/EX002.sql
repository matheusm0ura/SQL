/*1. Write a query in SQL to display the first name, last name, department number, and department name for each employee.*/

SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_ID, d.DEPARTMENT_NAME FROM employees AS e 
JOIN departments AS d USING(DEPARTMENT_ID);

/*2. Write a query in SQL to display the first and last name, department, city, and state province for each employee.*/

SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, l.CITY, l.STATE_PROVINCE FROM employees AS e 
JOIN departments AS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN locations AS l ON l.LOCATION_ID = d.LOCATION_ID;

/*3. Write a query in SQL to display the first name, last name, salary, and job grade for all employees. */

SELECT e. FIRST_NAME || ' ' || e.LAST_NAME AS "Name", e.SALARY, j.GRADE_LEVEL FROM employees AS e, job_grades AS j
WHERE e.SALARY BETWEEN j.LOWEST_SAL AND j.HIGHEST_SAL
ORDER BY j.GRADE_LEVEL;

/*4. Write a query in SQL to display the first name, last name, department number and department name, for all employees for departments 80 or 40.*/

SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_ID, d.DEPARTMENT_NAME FROM employees AS e 
JOIN departments AS d USING(DEPARTMENT_ID)
WHERE d.DEPARTMENT_ID IN (80, 40) ORDER BY first_name;

/*5. Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name, department, city, and state province.*/

SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, l.CITY, l.STATE_PROVINCE  FROM employees AS e 
JOIN departments AS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN locations AS l ON l.LOCATION_ID = d.LOCATION_ID
WHERE e.FIRST_NAME LIKE '%z%'; 

/*6. Write a query in SQL to display all departments including those where does not have any employee.*/

SELECT e.first_name, e.last_name, d.department_name, d.department_id FROM departments AS d 
LEFT JOIN employees AS e ON e.department_id = d.department_id;

/*7. Write a query in SQL to display the first and last name and salary for those employees who earn less than the employee earn whose number is 182.*/

SELECT FIRST_NAME, LAST_NAME, SALARY FROM employees 
WHERE SALARY < (SELECT SALARY FROM employees WHERE EMPLOYEE_ID =  182);

/*8. Write a query in SQL to display the first name of all employees including the first name of their manager.*/

SELECT e.FIRST_NAME AS "Employee", m.FIRST_NAME AS "Manager" FROM employees AS e
JOIN employees AS m ON m.EMPLOYEE_ID = e.MANAGER_ID;

/*9. Write a query in SQL to display the department name, city, and state province for each department.*/

SELECT d.DEPARTMENT_NAME, l.CITY, l.STATE_PROVINCE FROM departments AS d
JOIN locations AS l ON l.LOCATION_ID  = d.LOCATION_ID;

/*10. Write a query in SQL to display the first name, last name, department number and name, for all employees who have or have not any department. */

SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_ID, d.DEPARTMENT_NAME FROM employees AS e 
JOIN departments AS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

/*11. Write a query in SQL to display the first name of all employees and the first name of their manager including those who does not working under any manager.*/

SELECT e.FIRST_NAME AS "Employee", m.FIRST_NAME AS "Manager" FROM employees AS e
LEFT JOIN employees AS m ON m.EMPLOYEE_ID = e.MANAGER_ID;

/*12. Write a query in SQL to display the first name, last name, and department number for those 
employees who works in the same department as the employee who holds the last name as Taylor.*/

SELECT e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT_ID FROM employees AS e
JOIN employees AS b ON b.LAST_NAME = 'Taylor' AND b.DEPARTMENT_ID = e.DEPARTMENT_ID

/*13. Write a query in SQL to display the job title, department name, 
full name (first and last name ) of employee, and starting date for all the jobs which started on or 
after 1st January, 1993 and ending with on or before 31 August, 1997*/

/*14. Write a query in SQL to display job title, full name (first and last name ) of employee, and the difference between maximum salary for the job and salary of the employee.*/

SELECT j.JOB_TITLE, e.FIRST_NAME || ' ' || e.LAST_NAME AS "Name", j.MAX_SALARY - e.SALARY AS "Difference" FROM employees AS e
JOIN jobs AS j ON e.JOB_ID = j.JOB_ID;

/*15. Write a query in SQL to display the name of the department, average salary and number of employees working in that department who got commission.*/

/*16. Write a query in SQL to display the full name (first and last name ) of employees, job title and the salary 
differences to their own job for those employees who is working in the department ID 80.*/

/*17. Write a query in SQL to display the name of the country, city, and the departments which are running there.*/

/*18. Write a query in SQL to display department name and the full name (first and last name) of the manager.*/

SELECT d.DEPARTMENT_NAME, e. FIRST_NAME || ' ' || e.LAST_NAME AS "Name" FROM departments AS d
JOIN employees AS e ON e.EMPLOYEE_ID = d.MANAGER_ID;

/*19. Write a query in SQL to display job title and average salary of employees. */

SELECT j.JOB_TITLE, AVG(e.SALARY) FROM employees AS e
JOIN jobs AS j ON e.JOB_ID = j.JOB_ID
GROUP BY j.JOB_TITLE;

/*20. Write a query in SQL to display the details of jobs which was done by any of the employees who is presently earning a salary on and above 12000. */

SELECT e.EMPLOYEE_ID, e. FIRST_NAME || ' ' || e.LAST_NAME AS "Name", e.salary, j.START_DATE, j.END_DATE, j.JOB_ID FROM employees AS e
JOIN job_history AS j ON e.EMPLOYEE_ID = j.EMPLOYEE_ID
WHERE salary >= 12000;

/*21. Write a query in SQL to display the country name, city, and number of those departments where at leaste 2 employees are working.*/

/*22. Write a query in SQL to display the department name, full name (first and last name) of manager, and their city. */

SELECT d.DEPARTMENT_NAME, e. FIRST_NAME || ' ' || e.LAST_NAME AS "Name", l.CITY FROM employees AS e 
JOIN  departments AS d ON e.EMPLOYEE_ID  = d.MANAGER_ID
JOIN locations AS l ON l.LOCATION_ID = d.LOCATION_ID;

/*23. Write a query in SQL to display the employee ID, job name, number of days worked in for all those jobs in department 80.*/

SELECT jh.EMPLOYEE_ID, j.JOB_TITLE, (jh.END_DATE - jh.START_DATE) AS "Number of days" FROM job_history AS jh
JOIN jobs AS j ON jh.JOB_ID = j.JOB_ID
WHERE jh.DEPARTMENT_ID = 80; 

/*24. Write a query in SQL to display the full name (first and last name), and salary of those employees who working in any department located in London.*/

SELECT e. FIRST_NAME || ' ' || e.LAST_NAME AS "Name", e.SALARY, d.DEPARTMENT_NAME, l.CITY FROM employees AS e 
JOIN departments AS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
JOIN locations AS l ON d.LOCATION_ID = l.LOCATION_ID
WHERE l.CITY = 'London';

/*25. Write a query in SQL to display full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.*/

/*26. Write a query in SQL to display the department name and number of employees in each of the department. */

/*27. Write a query in SQL to display the full name (firt and last name ) of employee with ID and name of the country presently where (s)he is working.*/

