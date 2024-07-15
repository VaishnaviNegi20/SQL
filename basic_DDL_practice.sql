create database newbatch; #creating a database
use newbatch;  #using the db
CREATE TABLE users (  							#creating a table
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

select * from users;  # *for selecting all the data available inside users table
insert into users(username, email) values('vaishnavi','abc@gmail.com'),('monika','xyz@gmail.com');
select * from users;
insert into users(username,email) values('vaishnavi','abc1@gmail.com'),('monika','xyz1@gmail.com');

create table posts (post_id int auto_increment primary key, user_id int not null, 
title varchar(100) not null,
content text not null,
created_at timestamp default current_timestamp,
foreign key (user_id) references users(user_id) 
);
select * from  posts;


