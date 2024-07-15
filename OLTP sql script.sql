create database superstore;
use superstore;
#customer table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

# products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL,
    stock_quantity INT NOT NULL
);

#orders table
create table orders(
order_id int auto_increment primary key,
customer_id int not null,
order_date datetime not null,
total_amount decimal(10,2) not null,
foreign key(custome_id) references customers(customer_id));

#order_items table
create table order_items(
order_item_id int auto_increment primary key,
order_id int not null,
product_id int not null,
quantity int not null,
price decimal(10,2) not null,
foreign key(order_id) references orders(order_id),
foreign key(product_id) references products(product_id));

#insert customer
insert into customers(first_name, last_name,email) values('vaishnavi', 'negi', 'vaish@gmail.com');

select * from customers;

# insert product
insert into products(product_name,price,stock_quantity) values('mobile','20000.00','4');
select * from products;

#insert orders 
insert into orders(customer_id, order_date, total_amount) values('1',now(),40000.00); #The NOW() function returns the current date and time.
select * from orders;

#insert order_item
insert into order_items(order_id,product_id,quantity,price) values('1','1','2',20000.00);
select * from order_items;






