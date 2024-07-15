show databases;
use classicmodels;
show tables;
select * from customers;
select * from orders;
select * from employees;

-- multiple table joining
SELECT 
    o.orderNumber,
    o.status,
    o.customerNumber,
    c.customerName,
    c.salesRepEmployeeNumber,
    e.firstName AS 'sales person fname',
    e.lastName AS 'sales person lname',
    e.jobTitle
FROM
    orders o
        INNER JOIN
    customers c ON o.customerNumber = c.customerNumber
        INNER JOIN
    employees e ON c.salesRepEmployeeNumber = e.employeeNumber;
    
    
-- self join
SELECT 
    emp.employeeNumber,
    emp.firstName AS 'Employee Name',
    emp.jobTitle,
    mngr.firstName AS 'Manager Name',
    mngr.jobTitle AS 'Manager Title'
FROM
    employees AS emp
        INNER JOIN
    employees AS mngr 
    ON emp.reportsTo = mngr.employeeNumber; -- because we want to see which emp.reports to matches with mngr.employeenumber
-- in self join case, each employeeNumber is unique.


-- explicit join (use join keyword specifically)
select c.customerNumber, c.customerName, p.paymentDate, p.amount
from customers c
inner join payments p 
on c.customerNumber = p.customerNumber;

-- implicit join(don't use join keyword)
select c.customerNumber, c.customerName, p.paymentDate, p.amount
from customers c , payments p
where c.customerNumber = p.customerNumber; -- (if you don't write this where clause here it'll become cross join)

-- outer joins

-- what orders have been placed by each customers?
-- using inner join (problem is we don't get the customers who have not placed any orders)
select c.customerNumber, c.customerName, o.orderNumber
from customers c 
inner join orders o
on c.customerNumber = o.customerNumber;

-- customers who have not placed any orders(using subquery)
select c.customerNumber 
from customers c 
where c.customerNumber not in (
select distinct o.customerNumber from orders o 
);

-- left outer join
-- (solving the problem of inner join) 
-- for every customer, show the orders that a customer has placed(if any cutomer has not placed any order, the value will be null)
select c.customerNumber, c.customerName, o.orderNumber
from customers c 
left join orders o
on c.customerNumber = o.customerNumber; -- (mapping each c.customerNumber to the o.orderNumber)

-- right outer join 
select c.customerNumber, c.customerName, o.orderNumber
from customers c 
right join orders o
on c.customerNumber = o.customerNumber; -- (mapping each o.orderNumber to the c.customerNumber)

-- self outer join 
select emp.employeeNumber,
    emp.firstName AS 'Employee Name',
    emp.jobTitle,
    emp.reportsTo as 'emp.reportsTo',
    mngr.employeeNumber as 'mngr.employeeNumber',
    mngr.firstName AS 'Manager Name',
    mngr.jobTitle AS 'Manager Title'
from employees emp
left join employees mngr
on emp.reportsTo = mngr.employeeNumber; -- because we want to see which emp.reports to matches with mngr.employeenumber (each employeeNumber is unique)

-- using clause (used when the column_names are same)
select c.customerNumber, c.customerName, o.orderNumber, o.status
from customers c
left join orders o
using (customerNumber); -- since the column name is same, we don't have to put on condition here. By using 'using' clause, our query has been simplified.


select o.orderNumber, o.status, o.customerNumber, c.customerName, c.salesRepEmployeeNumber, e.firstName as empFirstName, e.lastName as empLastName, e.jobTitle as empJobTitle 
from orders o
join customers c
using (customerNumber)  -- using 'using' clause because both the column names for writing the condition is same 
join employees e
on c.salesRepEmployeeNumber = e.employeeNumber; -- not using 'using' clause bcz both the column names for writing the condition is not same 


-- natural join --> we don't specify the columns where the join should occur. sql take care of it by finding the common column name and join them together itself.
select orderNumber, customerNumber, customerName 
from orders
natural join customers; -- customerNumber is same in both the tables hence sql joined them using this column by itself.
-- drawback of natural join --> loose control of join condition and can produce unexpected results.
