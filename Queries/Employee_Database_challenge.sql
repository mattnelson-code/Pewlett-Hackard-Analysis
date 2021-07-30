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
