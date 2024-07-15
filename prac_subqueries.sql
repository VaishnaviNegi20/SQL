use classicmodels;

-- subqueries in WHERE clause
-- query1 - find the products that have same productline as of '1917 Grand Touring Sedan'
select * from products;
select productline from products where productName = '1917 Grand Touring Sedan';
select productName from products where productLine = (select productline from products where productName = '1917 Grand Touring Sedan');

-- query2 - find the cars which are costlier than '1936 Mercedes-Benz 500K Special Roadster'
select productName, msrp
from products where productLine regexp 'car' and msrp > (select msrp from products where productName = '1936 Mercedes-Benz 500K Special Roadster') 
order by msrp desc;

-- query3 - find cars which are costlier than avg cost of all cars
select productName, msrp 
from products where productLine regexp 'car' and msrp > (select avg(msrp) from products where productLine regexp 'car')
order by msrp desc;

-- or the other way is: 
select productName, msrp 
from products 
where productLine regexp 'car' and msrp > (select avg(msrp) from products where productLine in ('classic cars','vintage cars'))
order by msrp desc;

-- query4 - customers who never placed an order (subquery vs join)
-- whether to use subquery or join, it depends on readability and performance. 
-- using subquery(here subquery is preferred)
select customerNumber 
from customers
where customerNumber not in (
select distinct customerNumber from orders
);
-- using join
select customerNumber 
from customers
left join orders using (customerNumber)
where orderNumber is null;


-- query5 (example where join is preferred over subquery)
-- customers who have ordered the product with productCode 'S18_1749'
-- using subquery
select distinct customerNumber from customers where customerNumber in ( 
	select customerNumber from orders where ordernumber in (
		select ordernumber from orderdetails where productCode = 'S18_1749'));

-- using join (here join is preferred)
select distinct customerNumber from customers 
join orders using (customerNumber)
join orderdetails using (ordernumber)
where productCode = 'S18_1749';

-- ALL keyword
-- find products costlier than all trucks
-- using max()
select * from products where msrp > (
	-- max price of truck only
    select max(msrp) from products where productLine regexp 'truck');
    
-- using ALL 
select * from products where msrp > all(
select msrp from products where productLine regexp 'truck');


-- ANY keyword
-- select customers who have made atleast 2 payments
-- using IN 
select * from customers where customerNumber in (
	select customerNumber
	from payments
	group by customerNumber
	having count(*) >=2 );
    
-- using Any
select customers from payments where customerNumber = any(
	select customerNumber 
	from payments 
	group by customerNumber
	having count(*) >=2);
    
-- correlated subquery - inner query dependent on outer query
-- slower in performance, yet powerful and useful in real life scenarios
-- find product whose price is higher than avg price of their corresponding productline

select * 
from products p
where msrp > (
	select avg(msrp) from products where productLine = p.productLine);

select avg(msrp) from products where productLine = 'Ships'; -- just for checking


-- EXISTS operator -> return true only and gives the output, but doesn't give output if false.
-- select customers who have made any payment(example of correlated subquery with exists)
select customerNumber, customerName
from customers c
where exists (select distinct customerNumber from payments p where p.customerNumber = c.customerNumber);


-- subquery in SELECT clause
-- write a query that create following 'view' of payment table (add 2 columns which give avg payment and difference between amount and avg payment)
select * from payments;
select *,
(select avg(amount) from payments) as avgPayment,
amount - (select avgPayment) as 'difference' 
from payments;

-- subquery in FROM clause
--  write a query that create following 'view' of payment table where difference > 0 (amount is higher than avg)
select * 
from (
select *, 
(select avg(amount) from payments) as avgPayment,
amount - (select avgPayment) as 'difference' 
from payments ) as InvoiceSummary -- this alias is mandatory, otherwise you'll get an error that error code 1248 : every dderived table must have its own alias
where difference > 0 ;
