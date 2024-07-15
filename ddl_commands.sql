# DDL(Data Definition Language) commands --> create,alter,drop,truncate

show databases;
drop database superstore2;
create database ddl;
use ddl;
show tables;

create table mobile(
mobile_name varchar(20),
mobile_number int,
mfg_year int,
price int
);

#command to describe the table schema
desc mobile;

-- unique and check constraints
create table mobile1(
mobile_name varchar(20),
mobile_number int unique check (length(mobile_number) >=10) -- bcz of country_code
);
desc mobile1;
insert into mobile1(mobile_number) values(12345); -- it'll show you the error but here the error is not defined clearly 
insert into mobile1(mobile_number) values(1234567890);

-- we'll use named constraints to show the readable error
create table mobile2(
mobile_number varchar(15) unique,
constraint mobile_number_less_than_10_digits check (length(mobile_number) >= 10)
);
desc mobile2;
insert into mobile2 values(123456); -- here it'll throw the readable error
insert into mobile2 values(1234567890);
insert into mobile2 values(1234567890); -- duplicate entry not allowed bcz of the unique constraint


# adding the new attribute to the table
alter table mobile add color varchar(10);
alter table mobile add price int;
 
#changing the column name of the table 
alter table mobile rename column color to mobile_color;

#modifying the column datatype
alter table mobile modify column mobile_color varchar(20);
alter table mobile modify column color char(10);

#dropping the column from a table
alter table mobile drop column mobile_color;
alter table mobile drop column color, drop column price ; # dropping multiple columns together

#change the table name
alter table mobile rename to mobile_description;
desc mobile_description;

#drop command
drop table mobile_description;
drop database ddl;

insert into mobile(mobile_name, mobile_number,mfg_year,price) values('aa', 1234556, 2013,25000);
insert into mobile(mobile_name, mobile_number,mfg_year,price) values('bb', 1234656, 2023,30000);

#truncate command --> used to delete all the rows from the table and free the space containing the table
select * from mobile; 
truncate table mobile;
select * from mobile;

#difference between truncate and drop
/* truncate deletes all the records from the table but stucture of the schema remains 
preserved, whereas drop remove the entire table, records as well as schema structure.*/


 
 