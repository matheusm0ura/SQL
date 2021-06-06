/*1. Write a query in SQL to display the first name, last name, department number, and department name for each employee.*/

SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_ID, d.DEPARTMENT_NAME FROM employees AS e 
JOIN departments AS d USING(DEPARTMENT_ID);

/*2. Write a query in SQL to display the first and last name, department, city, and state province for each employee.*/

SELECT e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME, l.CITY, l.STATE_PROVINCE FROM employees AS e 
JOIN departments AS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN locations AS l ON l.LOCATION_ID = d.LOCATION_ID;

