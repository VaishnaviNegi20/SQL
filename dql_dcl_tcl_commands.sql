#DQL(Data Qurery language) commands -> select
create database sqlcommands;
use sqlcommands;
create table mobile (
mobile_name varchar(20),
mobile_number int,
mfg_year int,
price int
);
desc mobile;
insert into mobile(mobile_number, mobile_name, price,mfg_year) values (3252566,'bb',34899,2022),(872870875,'ccc',56999,2024),(475208742,'dddd',23499,2023);
select * from mobile;

select * from mobile limit 1; #to select only one record

select * from mobile limit 1 offset 2; # to select 1 record at a time with jump of 2 means 1st record then 3rd 

#DCL(Data control language) -> grant, revoke
GRANT SELECT ON mobile TO 'root'@'localhost'; #if grant to db, write dbname instead of table_name
GRANT SELECT, INSERT, DELETE, UPDATE ON mobile TO 'root'@'localhost';
GRANT ALL ON mobile TO 'root'@'localhost';
GRANT SELECT  ON mobile TO '*'@'localhost'; #Granting a Privilege to all in a Table(see GfG)

REVOKE SELECT ON  mobile FROM 'root'@'localhost'; #if revoke from db, write dbname instead of table_name
select * from mobile;
REVOKE SELECT ON  sqlcommands FROM 'root'@'localhost';
# read fully on GfG

#TCL(Transactional control language) -> commit, rollback
set autocommit = 0; #the state of the data is temporary until the commit statement is executed
delete from mobile where mfg_year = 2023; 
select * from mobile;
commit;

delete from mobile where mobile_name = 'bb';
rollback; 
commit;
# so until and unless the commit is done, the state of the data is tempoary and if we rollback, we can go back to the previous state and undo the operation we done(basically kind of restore the data as we do in mobile and laptop)
 
#once the commit statement is passed, the state of the data is permanent and the rollback will not do anything means you can't change to the previous state
update mobile set mobile_name = 'apple' where mobile_name = 'ccc';
select * from mobile;
rollback;
select * from mobile;

update mobile set mobile_name = 'apple' where mobile_name = 'ccc';
select * from mobile;
commit;
select * from mobile;
rollback;
select * from mobile;

show variables like 'autocommit';
set autocommit = 1;
show variables like 'autocommit';
set autocommit = 0;  


-- own 
select user from mysql.user; -- gives all user present in the system
select user(); -- gives current user
create user 'abc'@'localhost'; -- without password so it's vulnerable
create user 'xyz'@'localhost' identified by '123456'; -- with password so it's secure
show grants for 'root'@'localhost';
drop user 'abc'@'localhost';

use newbatch;
select * from users;
insert into users(username , email) values('nehaaaa','nehaaaa@gmail.com'),('n2','n2saa@gmail.com');
delete from users where user_id = 9;
rollback;
select * from users;
delete from users where user_id = 9;
commit;
select * from users;
rollback;

-- savepoint
start transaction;
update users set create_at = '2024-06-25 11:58:38' where user_id =6;
savepoint a;
 update users set create_at = '2024-06-25 11:58:38' where user_id =5;
 savepoint b;
 delete from users where user_id = 8;
 rollback to savepoint a;
 select * from users;
 delete from users where user_id = 8;
 savepoint d;
 update users set create_at = '2020-06-25 11:58:38' where user_id =6;
 rollback to savepoint a;
 

-- how aggregate function handle NULL values
Create table t1 ( A int, B int);
Insert into t1 values(1,null);
Insert into t1 values(2,null);
Insert into t1 values(3, null);
Insert into t1 values(4,null);
Insert into t1 values(null,null);
Select count(*) from t1;
Select count(A) from t1;
Select count(B) from t1;