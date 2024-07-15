create database superstore_olap;
use superstore_olap;

#dimension table for customers
create table dim_customers(
customer_id int primary key,
first_name varchar(50),
last_name varchar(50),
email varchar(100));

#dimension table for products
create table dim_products(
product_id int primary key,
product_name varchar(100),
price decimal(10,2));

-- fact table for sales
create table fact_sales(
sale_id int auto_increment primary key,
customer_id int,
product_id int,
sale_date date,
quantity int,
total_amount decimal(10,2),
foreign key (customer_id) references dim_customers(customer_id),
foreign key (product_id) references dim_products(product_id));

#Insert data into dimension tables
insert into dim_customers(customer_id, first_name,last_name,email) values(1,'vaishnavi','negi','vaish@gmail.com');
select * from dim_customers;

insert into dim_products(product_id, product_name, price) values(1,'mobile','20000.00');

# insert data into fact table
insert into fact_sales(customer_id, product_id, sale_date, quantity, total_amount) values (1,1,'2024-06-12', 2 , 40000.00);
select * from fact_sales;

SELECT
    p.product_name,
    SUM(f.quantity) AS total_quantity,
    SUM(f.total_amount) AS total_sales
FROM
    fact_sales f
JOIN
    dim_products p ON f.product_id = p.product_id
GROUP BY
    p.product_name; 
