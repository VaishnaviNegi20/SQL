-- views - mostly used for complex queries
use newbatch;
show tables;
select * from order_details;
create view pending_orders as select orderid from order_details where status = 'pending';
select * from pending_orders;

select * from customers;
create view more_than_avg_oid as select state, oid from customers where oid > (select avg(oid) from customers);
select * from more_than_avg_oid;
drop view more_than_avg_oid;
