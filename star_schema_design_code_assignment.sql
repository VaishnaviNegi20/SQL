#creating star-schema design

create database ssd_code;
use ssd_code;

#creating dimension tables

create table dim_customers(
customer_id int primary key,
customer_name varchar(50),
email varchar(100) unique);

create table dim_locations(
location_id int primary key,
location_name varchar(50) 
);

create table dim_products(
product_id int primary key,
product_name varchar(100),
price decimal(8,3)
);

create table dim_category(
category_id int primary key,
category_name varchar(20) 
);

#creating the fact table for orders

create table fact_orders(
order_id int auto_increment primary key,
order_date datetime,
customer_id int,
location_id int,
product_id int,
category_id int,
quantity int,
sales decimal(10,2),
discount decimal(4,2),
foreign key (customer_id) references dim_customers(customer_id),
foreign key (location_id) references dim_locations(location_id),
foreign key (product_id) references dim_products(product_id),
foreign key (category_id) references dim_category(category_id)
);

#inserting data into dimension tables
insert into dim_customers(customer_id, customer_name, email) values(1,'abc_def','abc@gmail.com');
insert into dim_locations(location_id, location_name) values(1,'New Delhi');
insert into dim_products(product_id, product_name,price) values(1,'mobile',25999.99);
insert into dim_category(category_id, category_name) values(1,'technology');

insert into dim_customers(customer_id, customer_name, email) values(2,'pqr_xyz','pqr@gmail.com');
insert into dim_locations(location_id, location_name) values(2,'Dehradun');
insert into dim_products(product_id, product_name,price) values(2,'cake',3000);
insert into dim_category(category_id, category_name) values(2,'food');

select * from dim_customers;
select * from dim_locations;
select * from dim_products;
select * from dim_category;


#inserting data into fact table
insert into fact_orders(order_date, customer_id,location_id, product_id, category_id, quantity, sales, discount) values(now(),1,1,1,1,2,51999.98,0);
insert into fact_orders(order_date, customer_id,location_id, product_id, category_id, quantity, sales, discount) values(now(),2,2,2,2,5,14625,2.5);

select * from fact_orders;

