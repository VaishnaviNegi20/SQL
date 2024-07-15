-- joins
use newbatch; 
-- Create the customers table
CREATE TABLE customers (
    cid INT PRIMARY KEY,
    fname VARCHAR(50),
    state VARCHAR(2),
    oid INT
);

-- Create the order_details table
CREATE TABLE order_details (
    orderid INT PRIMARY KEY,
    date DATE,
    status VARCHAR(20)
);

-- Insert data into the customers table
INSERT INTO customers (cid, fname, state, oid) VALUES
(1, 'Alice', 'NY', 1001),
(2, 'Bob', 'CA', 1002),
(3, 'Charlie', 'TX', 1003),
(4, 'David', 'FL', 1004),
(5, 'Eve', 'NV', 1005),
(6, 'Frank', 'WA', 1006),
(7, 'Grace', 'OR', 2001),
(8, 'Hank', 'MI', 2002),
(9, 'Ivy', 'IL', 1007),
(10, 'Jack', 'PA', 1008),
(11, 'Karen', 'OH', 2003),
(12, 'Leo', 'GA', 2004);

-- Insert data into the order_details table
INSERT INTO order_details (orderid, date, status) VALUES
(1001, '2023-01-31', 'shipped'),
(1002, '2023-02-28', 'delivered'),
(1003, '2023-03-31', 'pending'),
(1004, '2023-04-30', 'shipped'),
(1005, '2023-05-31', 'delivered'),
(1006, '2023-06-30', 'pending'),
(1009, '2023-07-31', 'shipped'),
(1010, '2023-08-31', 'delivered'),
(1007, '2023-09-30', 'pending'),
(1011, '2023-10-31', 'shipped'),
(1012, '2023-11-30', 'delivered');
insert into order_details values
(3022, '2023-11-30', 'delivered'),
(3011, '2023-12-31', 'shipped'),
(6011, '2022-10-31', 'pending');

select * from customers;
select * from order_details;
    
-- inner join - gives common values only
select * from customers inner join order_details 
on customers.oid = order_details.orderid;

select customers.cid , customers.fname, order_details.status from customers 
inner join order_details 
on customers.oid = order_details.orderid;

-- left join 
select * from customers left join order_details 
on customers.oid = order_details.orderid;

select customers.cid , customers.fname, order_details.status from customers 
left join order_details 
on customers.oid = order_details.orderid;

-- right join 
select * from customers right join order_details 
on customers.oid = order_details.orderid;

select customers.cid, customers.fname, order_details.status from customers 
right join order_details 
on customers.oid = order_details.orderid;

select c.cid, c.fname, o.status from customers as c 
right join order_details as o 
on c.oid = o.orderid;

select c.cid, c.fname, o.status from customers as c 
right join order_details as o 
on c.oid = o.orderid
order by c.cid desc;

-- full outer join
 select * from customers as c 
 left join order_details as o
 on c.oid = o.orderid
 union 
 select * from customers as c
 right join order_details as o
 on c.oid = o.orderid;
 


