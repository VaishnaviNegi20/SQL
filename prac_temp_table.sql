use parks_and_recreation;
-- temporary table
-- method1
create temporary table temp_table1(
temp_id int primary key auto_increment,
first_name varchar(20),
last_name varchar(20),
fav_movie varchar(50)
);

select * from temp_table1;

insert into temp_table1 values(1,'vaishnavi','negi','3 idiots');

-- method2
select * from employee_salary;

create temporary table salary_above_50k
select * from employee_salary 
where salary >=50000;

select * from salary_above_50k; -- can use temp_table as long as the session is open and can use in different file in the same session also(which is not the case in cte)


