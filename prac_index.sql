-- index is useful for the performance of a database
-- it increases the speed of data retrieval but also consume memory so if speed is your priority then use it
use classicmodels;

-- index creation
create index i_cnum on customers(customerNumber);	-- it will not create a new column

select * from customers;
create index i_cus on customers(customerNumber, customerName);  -- can use more than one column also

-- show index
show index from customers;

-- remove index
alter table customers drop index i_cnum;
alter table customers drop index i_cus;

show index from customers;