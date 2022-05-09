-- successful queries

SELECT * FROM departments;

-- Retirement eligibility 1952 to 1955
SELECT first_name, last_name 
FROM employees 
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Retirement eligibility 1952
SELECT first_name, last_name 
FROM employees 
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Retirement eligibility 1953
SELECT first_name, last_name 
FROM employees 
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Retirement eligibility 1954
SELECT first_name, last_name 
FROM employees 
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Retirement eligibility 1955
SELECT first_name, last_name 
FROM employees 
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility 1952 to 1955 and hired in 1985 to 1988.
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Count the Queries
-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Create New Tables
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Export Data

-- Drop table
DROP TABLE retirement_info;

-- Recreate the retirement_info Table with the emp_no Column
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables.
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Use Aliases for Code Readability
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

--

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Use Left Join for retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Check the table
SELECT * FROM current_emp;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO dept_retirement_info
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- Check the table
SELECT * FROM dept_retirement_info;

SELECT * FROM salaries
ORDER BY to_date DESC;

-- Employee Information
SELECT e.emp_no, e.first_name, e.last_name,
e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- Check the table
SELECT * FROM emp_info;

-- List of managers per department
SELECT  dm.dept_no, d.dept_name, dm.emp_no, ce.last_name,
ce.first_name, dm.from_date, dm.to_date
INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments AS d
ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
ON (dm.emp_no = ce.emp_no);

-- Check the table
SELECT * FROM manager_info;

-- Department Retirees
SELECT ce.emp_no, ce.first_name, ce.last_name, d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- Check the table
SELECT * FROM dept_info;

-- Sales Retirement info
SELECT *
FROM dept_info AS di
WHERE (di.dept_name = 'Sales')

-- 
SELECT *
FROM dept_info AS di
WHERE (di.dept_name = 'Sales')
OR (di.dept_name = 'Development')

SELECT *
FROM dept_info AS di
WHERE di.dept_name IN ('Sales', 'Development')