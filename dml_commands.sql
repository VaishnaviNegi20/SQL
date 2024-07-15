#DML(Data Manipulation Language) commands --> insert,update,delete

show databases;
create database dml;
use dml;

create table mobile(
mobile_name varchar(20),
mobile_number int,
mfg_year int,
price int
);

desc mobile;

#insert data into the table
# in sql, a row is a tuple and column is a attribute
insert into mobile values('aa', 1234 , 2018,20000); #insert one row in order

select * from mobile;

insert into mobile(mobile_number, mobile_name, price,mfg_year) values(344556,'aa',23000,2021); #insert one row w/o order

#insert multiple records at a time
insert into mobile(mobile_number, mobile_name, price,mfg_year) values (3252566,'bb',34899,2022),(872870875,'ccc',56999,2024),(475208742,'dddd',23499,2023);

#update data(tuple) in a table
set SQL_SAFE_UPDATES = 0;
update mobile set mobile_name = 'eeee' where mobile_number = 1234;
update mobile set mobile_name = 'ffff', mfg_year = 2022 where mobile_number = 1234; 

#delete the records from the table
delete from mobile where mfg_year= 2022; 
delete from mobile where mobile_name= 'aa'
