-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
SELECT et.emp_no,
et.first_name,
et.last_name,
-- Retrieve the title, from_date, and to_date columns from the Titles table.
tt.title,
tt.from_date,
tt.to_date
-- Create a new table using the INTO clause.
INTO retirement_titles
FROM employees AS et
--  Join both tables on the primary key.
INNER JOIN titles AS tt
ON (et.emp_no = tt.emp_no)
-- Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. 
-- Then, order by the employee number.
WHERE (et.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY tt.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Retrieve the number of employees by their most recent job title who are about to retire.
SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY title DESC;

-- Query to create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program
SELECT DISTINCT ON (emp_no) et.emp_no,
et.first_name,
et.last_name,
et.birth_date,
de.from_date,
de.to_date,
tt.title
INTO mentorship_eligibility
FROM employees AS et
INNER JOIN dept_emp AS de
ON (et.emp_no = de.emp_no)
INNER JOIN titles as tt
ON (et.emp_no = tt.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (et.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY et.emp_no;