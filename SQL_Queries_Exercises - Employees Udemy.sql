/*Employees Exercises */

/* SELECT - FROM Exercise */
SELECT dept_no FROM departments;
SELECT * FROM departments; 

/* WHERE - exercise */
SELECT * FROM employees
WHERE first_name = 'Elvis';

/* AND exercise */
SELECT * FROM employees
WHERE first_name = 'Kellie'
AND gender = 'F';

/* OR - exercise */
SELECT * FROM employees
WHERE first_name = 'Kellie'
OR first_name = 'Aruna';

/* Operator precedence - exercise */
SELECT * FROM employees
WHERE gender = 'F'
AND (first_name = 'Kellie'
OR first_name = 'Aruna');

/* IN - NOT IN - exercise 1 */
SELECT * FROM employees
WHERE first_name IN ('Denis', 'Elvis');

/* IN - NOT IN - exercise 2 */
SELECT * FROM employees
WHERE first_name NOT IN ('John', 'Mark', 'Jacob');

/* LIKE - NOT LIKE - exercise */
SELECT * FROM employees
WHERE first_name LIKE 'Mark%'; 

SELECT * FROM employees
WHERE hire_date LIKE '%2000%';

SELECT * FROM employees
WHERE emp_no LIKE '1000_';

/* Wildcard characters - exercise */
SELECT * FROM employees
WHERE first_name LIKE '%Jack%';

SELECT * FROM employees
WHERE first_name NOT LIKE ('%Jack%');

/* BETWEEN - AND - exercise */
SELECT * FROM salaries
WHERE salary BETWEEN 66000 AND 70000;

SELECT * FROM employees
WHERE emp_no NOT BETWEEN 10004 AND 10012; 

SELECT dept_name FROM departments
WHERE dept_no BETWEEN 'd003' AND 'd006'; 

/* IS NOT NULL - IS NULL - exercise */
SELECT * FROM departments
WHERE dept_no IS NOT NULL; 

/* Other comparison operators - exercise */
SELECT * FROM employees
WHERE hire_date LIKE '%200%'
AND gender = 'F'; 

SELECT * FROM salaries
WHERE salary > 150000;

/* SELECT DISTINCT - exercise */
SELECT DISTINCT hire_date FROM employees
LIMIT 1000;

/* Introduction to aggregate functions - exercise */
-- How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table?
SELECT COUNT(*)
FROM salaries
WHERE salary >= 100000; 

-- How many managers do we have in the “employees” database? Use the star symbol (*) in your code to solve this exercise.
SELECT COUNT(DISTINCT emp_no)
FROM dept_manager;

/* ORDER BY - exercise */
-- Select all data from the “employees” table, ordering it by “hire date” in descending order.
SELECT * 
FROM employees
ORDER BY hire_date DESC; 

/* Using Aliases (AS) - exercise */
-- Write a query that obtains two columns. 
-- The first column must contain annual salaries higher than 80,000 dollars. 
-- The second column, renamed to “emps_with_same_salary”, must show the number of employees contracted to that salary. 
-- Lastly, sort the output by the first column.

SELECT salary, COUNT(emp_no) AS emps_with_same_salary
FROM salaries
WHERE salary > 80000
GROUP BY salary
ORDER BY salary ASC; 

/* HAVING - exercise */
-- Select all employees whose average salary is higher than $120,000 per annum.

SELECT emp_no, AVG(salary) 
FROM salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;

/* WHERE vs HAVING - Part II - exercise */
-- Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000.

SELECT emp_no, from_date
FROM dept_emp
WHERE from_date > '2000-01-01'
HAVING COUNT(from_date) > 1
ORDER BY from_date ASC;

/* LIMIT - exercise */
-- Select the first 100 rows from the ‘dept_emp’ table. 

SELECT *
FROM dept_emp
LIMIT 100;

/* The INSERT statement - exercise 1 */

INSERT INTO employees
VALUES (999903, '1997-09-14', 'Jonathan', 'Creek', 'M', '1999-01-01');

-- Select ten records from the “titles” table to get a better idea about its content.

SELECT * 
FROM titles
LIMIT 10;

-- Then, in the same table, insert information about employee number 999903. 
-- State that he/she is a “Senior Engineer”, who has started working in this position on October 1st, 1997.

INSERT INTO titles (emp_no, title, from_date)
VALUES (999903, 'Senior Engineer', '1997-10-01');

-- At the end, sort the records from the “titles” table in descending order to check if you have successfully inserted the new record.

SELECT *
FROM titles
ORDER BY emp_no DESC;

/* The INSERT statement - exercise 2 */
-- Insert information about the individual with employee number 999903 into the “dept_emp” table. 
-- He/She is working for department number 5, and has started work on  October 1st, 1997; her/his contract is for an indefinite period of time.

INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
VALUES (999903, 'd005', '1997-10-01', '9999-01-01');

/* Inserting Data INTO a New Table - exercise */
-- Create a new department called “Business Analysis”. Register it under number ‘d010’.

INSERT INTO departments (dept_no, dept_name)
VALUES ('d010', 'Business Analysis');

/* The UPDATE Statement – Part II - exercise */
-- Change the “Business Analysis” department name to “Data Analysis”.

UPDATE departments 
SET dept_name = 'Data Analysis'
WHERE dept_name = 'Business Analysis';

/* The DELETE Statement – Part II - exercise */
-- Remove the department number 10 record from the “departments” table.

DELETE FROM departments
WHERE dept_no = 'd010';

SELECT * FROM departments; 

/* COUNT() - exercise */
-- How many departments are there in the “employees” database? Use the ‘dept_emp’ table to answer the question.

SELECT COUNT(DISTINCT dept_no)
FROM departments;

/*SUM() - exercise */
-- What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997?

SELECT SUM(salary)
FROM salaries
WHERE from_date > '1997-01-01'; 

/* MIN() and MAX() - exercise */

-- 1. Which is the lowest employee number in the database?
SELECT MIN(emp_no)
FROM employees;

-- 2. Which is the highest employee number in the database?
SELECT MAX(emp_no)
FROM employees;

/* AVG() - exercise */
-- What is the average annual salary paid to employees who started after the 1st of January 1997?

SELECT AVG(salary)
FROM salaries
WHERE from_date > '1997-01-01';

/* ROUND() - exercise */
-- Round the average amount of money spent on salaries for all contracts that started after the 1st of January 1997 to a precision of cents.

SELECT ROUND(AVG(salary),2)
FROM salaries
WHERE from_date > '1997-01-01';

/* Intro to JOINs - exercise 1 */
-- Create departments_dup table

DROP TABLE IF EXISTS department_dups;
CREATE TABLE department_dups (
	dept_no CHAR(4),
    department_name VARCHAR(40));

-- Insert the information contained in ‘departments’ into ‘departments_dup’.
INSERT INTO department_dups (dept_no, department_name)
SELECT * FROM departments; 

-- Then, insert a record whose department name is “Public Relations”.
INSERT INTO department_dups (department_name)
VALUE ('Public Relations'); 

-- Delete the record(s) related to department number two.
DELETE FROM department_dups
WHERE dept_no = 'd002'; 

-- Insert two new records in the “departments_dup” table. Let their values in the “dept_no” column be “d010” and “d011”.
INSERT INTO department_dups (dept_no)
VALUES ('d010'), ('d011'); 

/* Intro to JOINs - exercise 2 */
-- Create and fill in the ‘dept_manager_dup’ table, using the following code:

DROP TABLE IF EXISTS dept_manager_dup;
CREATE TABLE dept_manager_dup (
	emp_no INT(11) NOT NULL,
    dept_no CHAR(4) NULL,
    from_date DATE NOT NULL,
    to_date DATE NULL);
    
INSERT INTO dept_manager_dup
SELECT * FROM dept_manager; 

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES 
(999904, '2017-01-01'),
(999905, '2017-01-01'),
(999906, '2017-01-01'),
(999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE dept_no = 'd001';

/* INNER JOIN - Part II - exercise */
-- Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. 
SELECT dept_manager.emp_no, dept_manager.dept_no, employees.first_name, employees.last_name, employees.hire_date
FROM employees
INNER JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no;

/* LEFT JOIN - Part II - exercise */
-- Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. 
-- See if the output contains a manager with that name.  
SELECT * 
FROM employees
LEFT JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
WHERE employees.last_name = "Markovitch"
ORDER BY employees.hire_date;

/* JOIN and WHERE Used Together - exercise */
-- Select the first and last name, the hire date, and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”.
SELECT employees.first_name, employees.last_name, titles.title, employees.hire_date
FROM employees
JOIN titles
ON employees.emp_no = titles.emp_no
WHERE employees.first_name = "Margareta"
AND employees.last_name = "Markovitch"; 

/* CROSS JOIN - exercise 1 */
-- Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9.
 SELECT 
	departments.*,
	dept_manager.*
FROM departments
CROSS JOIN dept_manager
WHERE departments.dept_no = "d009"
ORDER BY departments.dept_no ASC;

/* CROSS JOIN - exercise 2 */
-- Return a list with the first 10 employees with all the departments they can be assigned to.
SELECT 
	employees.*,
    dept_emp.*
FROM employees
CROSS JOIN dept_emp
WHERE employees.emp_no < 10011
ORDER BY employees.emp_no, dept_emp.dept_no;

/* Join more than two tables in SQL - exercise */
-- Select all managers’ first and last name, hire date, job title, start date, and department name.
SELECT employees.first_name, employees.last_name, employees.hire_date, dept_manager.from_date, titles.title, departments.dept_name
FROM employees
JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
JOIN departments
ON dept_manager.dept_no = departments.dept_no
JOIN titles
ON employees.emp_no = titles.emp_no
ORDER BY employees.emp_no; 

/* Tips and tricks for joins - exercise */
-- How many male and how many female managers do we have in the ‘employees’ database?
SELECT COUNT(DISTINCT employees.emp_no)
FROM employees
JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
GROUP BY employees.gender; 

/* UNION vs UNION ALL - exercise */
-- Go forward to the solution and execute the query. 
-- What do you think is the meaning of the minus sign before subset A in the last row (ORDER BY -a.emp_no DESC)? 
SELECT
    *
FROM
    (SELECT
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) as a
ORDER BY -a.emp_no DESC;

