-- Create Retirement Titles table
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;

-- View table 
SELECT *
FROM retirement_titles;

-- Create Unique Titles table (remove duplicates)
SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO unique_titles
FROM employees as e
JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no, t.to_date DESC;

-- View table
SELECT *
FROM unique_titles;

-- Create Retiring Titles table
SELECT COUNT(title) as "count", title
INTO retiring_titles
FROM unique_titles 
GROUP BY title
ORDER BY "count" desc;

-- Create Mentorship Eligibility table
SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Retiring Employees
SELECT COUNT(emp_no) AS "Retiring Employees"
FROM unique_titles;

-- Employees Eligible for Mentorship
SELECT COUNT(emp_no) AS "Eligible for Mentorship"
FROM mentorship_eligibility;

-- Department with Max & Min Retirees
SELECT 
	MAX(count) AS "Max Retirees", 
	MIN(count) AS "Min Retirees"
FROM current_emp_count; 

-- Active Managers Who Will Retire Soon
SELECT first_name,
	last_name
FROM manager_info
WHERE to_date = '9999-01-01'
