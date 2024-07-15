-- DROP DATABASE IF EXISTS `Parks_and_Recreation`;
CREATE DATABASE if not exists `Parks_and_Recreation`;
USE Parks_and_Recreation;

CREATE TABLE if not exists employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

CREATE TABLE if not exists employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);

/*
INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');
*/

/* INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);
*/

CREATE TABLE if not exists parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);

/*
INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');
*/

-- Using Common Table Expressions (CTE)
-- A CTE allows you to define a subquery block that can be referenced within the main query. 
-- It is particularly useful for recursive queries or queries that require referencing a higher level

-- Let's take a look at the basics of writing a CTE:


-- First, CTEs start using a "With" Keyword. Now we get to name this CTE anything we want
-- Then we say as and within the parenthesis we build our subquery/table we want
WITH CTE_Example AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary), AVG(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- directly after using it we can query the CTE
SELECT *
FROM CTE_Example;


-- Now if I come down here, it won't work because it's not using the same syntax
SELECT *
FROM CTE_Example;



-- Now we can use the columns within this CTE to do calculations on this data that
-- we couldn't have done without it.

WITH CTE_Example AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- notice here I have to use back ticks to specify the table names  - without them it doesn't work
SELECT gender, ROUND(AVG(`SUM(salary)`/`COUNT(salary)`),2)
FROM CTE_Example
GROUP BY gender;



-- we also have the ability to create multiple CTEs with just one With Expression

WITH CTE_Example AS 
(
SELECT employee_id, gender, birth_date
FROM employee_demographics dem
WHERE birth_date > '1985-01-01'
), -- just have to separate by using a comma
CTE_Example2 AS 
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary >= 50000
)
-- Now if we change this a bit, we can join these two CTEs together
SELECT *
FROM CTE_Example cte1
LEFT JOIN CTE_Example2 cte2
	ON cte1. employee_id = cte2. employee_id;


-- the last thing I wanted to show you is that we can actually make our life easier by renaming the columns in the CTE
-- let's take our very first CTE we made. We had to use tick marks because of the column names

-- we can rename them like this
WITH CTE_Example (gender, sum_salary, min_salary, max_salary, count_salary) AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
-- notice here I haven't use back ticks to specify the table names  - without them it works fine
SELECT gender, ROUND(AVG(sum_salary/count_salary),2) 
FROM CTE_Example
GROUP BY gender;

-- find out the highest salary employee details from each dept
with max_salary_by_dept as
(
select dept_id, max(salary) as max_salary
from employee_salary 
group by dept_id
)
select es.employee_id, es.first_name, es.last_name, es.dept_id, m.max_salary
from employee_salary es
join max_salary_by_dept m
on es.dept_id = m.dept_id
where es.salary = m.max_salary;




use bpdatabase;
WITH SalesBySalesperson AS (
    SELECT salesperson_id, SUM(sale_amount) AS total_sales
    FROM sales
    GROUP BY salesperson_id
)
SELECT * FROM SalesBySalesperson;

use interviewdb;
WITH SalesStats AS (
    SELECT employee_id,
           MIN(sale_amount) AS min_sale,
           MAX(sale_amount) AS max_sale
    FROM employee_sales1
    GROUP BY employee_id
)
SELECT es.employee_id, 
       es.sale_date, 
       es.sale_amount, 
       ss.min_sale, 
       ss.max_sale
FROM employee_sales1 es
JOIN SalesStats ss ON es.employee_id = ss.employee_id
ORDER BY es.employee_id, es.sale_date;


use test_db;
select * from employee_hierarchy;
WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: Select the starting point
    SELECT employee_id, employee_name, manager_id
    FROM employee_hierarchy
    WHERE employee_id = 1  -- Replace with the starting employee ID

    UNION ALL

    -- Recursive member: Select the next level in the hierarchy
    SELECT e.employee_id, e.employee_name, e.manager_id
    FROM employee_hierarchy e
    INNER JOIN EmployeeHierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM EmployeeHierarchy;
