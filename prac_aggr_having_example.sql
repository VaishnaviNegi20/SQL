use classicmodels;

-- total payment from each customer after a certain date
select * from payments;
select p.customerNumber,customerName, sum(amount) as total_order_value
from payments p 
join customers c
on p.customerNumber = c.customerNumber -- or you can use, using (customerNumber)
where paymentDate > '2004-02-19'
group by p.customerNumber,customerName;

-- value of each unique order sorted by total order value 
select orderNumber, sum( quantityOrdered*priceEach) as total_order_value
from orderdetails 
group by orderNumber
order by total_order_value desc;

-- value of each unique order and its customer details sorted by total order value 
select orderNumber, customerNumber, customerName, sum(quantityOrdered*priceEach) as total_order_value
from orderdetails 
join orders using (orderNumber)
join customers using (customerNumber)
group by orderNumber, customerName
order by total_order_value desc;

-- value of each unique order and its customer detail, sales employee detail sorted by total order value 
select ordernumber, customerNumber, customerName, employeeNumber, concat(firstName," ", lastName) as employeeName, jobTitle, sum(quantityOrdered * priceEach) as total_order_value
from orderdetails
join orders using (orderNumber)
join customers using (customerNumber)
join employees on employees.employeeNumber = customers.salesRepEmployeeNumber
group by orderNumber
order by total_order_value desc;

-- count of orders placed by each customer and sales employee for that customer
select customerNumber, customerName, employeeNumber, concat(firstName," ", lastName) as employeeName, count(*) as order_count
from orders
join customers using (customerNumber)
join employees on customers.salesRepEmployeeNumber = employees.employeeNumber
group by customerNumber
order by order_count desc;

-- number of orders through each sales representative
select count(orderNumber) as total_orders, salesRepEmployeeNumber, concat(firstName,' ', lastName) as employeeName
from orders 
join customers using (customerNumber)
join employees on employees.employeeNumber = customers.salesRepEmployeeNumber
group by employeeNumber;


-- country wise count of orders
select country, count(*) as total_orders
from customers
join orders using (customerNumber)
group by country;

-- group by multiple columns
-- country wise count of orders on each date
select country, orderDate, count(*) as total_orders
from customers
join orders using (customerNumber)
group by country, orderDate
order by country;


-- find customers from france and usa whose total_order_value > 80000 across all their orders
select customerNumber, customerName,country, sum(quantityOrdered * priceEach) as total_order_value
from customers
join orders using (customerNumber)
join orderdetails using (orderNumber)
where country in ('France',"usa")
group by customerNumber, customerName
having total_order_value > 80000
order by total_order_value;

-- group by 'with rollup'
-- find the total payment along with the payment done by each customer
select * from payments;

select customerNumber, sum(amount) payment_by_customer
from payments
group by customerNumber
with rollup; -- here the column is showing null for total payment

select ifnull(customerNumber,'total_payment') as custNum, sum(amount) payment_by_customer
from payments
group by customerNumber
with rollup;