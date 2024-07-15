show databases;
use world;
show tables;
select * from country;
select name from country where name like '____'; -- exactly 4 characters
select name, length(name) as length_country from country where name like '%____'; -- minimum 4 characters, maximum can be anything
select name, length(name) as length_country from country where name like '%____' order by length(name); -- minimum 4 characters, maximum can be anything

use sakila;
show tables;
select * from actor_info;
select concat(lower(first_name), " ", last_name) as Name from actor_info;
select concat(first_name, " ", last_name) as Name, length(concat(first_name, last_name)) as length from actor_info;

#capitalize the string using substr()
select last_name, concat(substr(last_name,1,1),lower(substr(last_name,2))) from actor_info; 
select first_name, last_name, concat(concat(substr(first_name,1,1),lower(substr(last_name,2)))," ",concat(substr(last_name,1,1),lower(substr(last_name,2)))) as Full_Name from actor_info; 