use parks_and_recreation;

select * from employee_demographics;
select * from employee_salary;

-- trigger

delimiter $$
create trigger tr1
after insert on employee_salary
for each row
begin
	insert into employee_demographics(employee_id, first_name, last_name) values(new.employee_id, new.first_name, new.last_name);
end $$
delimiter ;

insert into employee_salary(employee_id, first_name, last_name) values(13,'abc', 'def');

select * from employee_salary;
select * from employee_demographics;

delete from employee_demographics where employee_id = 13;

set sql_safe_updates = 0;
delete from employee_salary where employee_id = 13;
set sql_safe_updates = 1;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id) 
VALUES(13, 'Jean-Ralphio', 'Saperstein', 'Entertainment 720 CEO', 1000000, NULL);
select * from employee_salary;
select * from employee_demographics;

-- if salary is negative then salary should be 0
delimiter $$
create trigger check_salary 
before insert on employee_salary
for each row
begin
	if new.salary < 0 then
		set new.salary = 0;
    end if;
end $$
delimiter ;

insert into employee_salary values(14,'alex','smith',null,-98000,6);
select * from employee_salary;

-- update the salary only if salary is positive
delimiter $$
create trigger salary_positive
before update on employee_salary
for each row
begin 
	if new.salary < 0 then 
		set new.salary = old.salary;
	end if;
end $$
delimiter ;

select * from employee_salary;
update employee_salary set salary = -55000 where employee_id = 4;
select * from employee_salary;

show triggers;	 -- to show all triggers 
show triggers where `table` = 'employee_salary'; 	-- show all triggers from specific table(use backtick ` ,not this single inverted comma ')
drop trigger salary_positive;
show triggers;


-- events
-- Events are task or block of code that gets executed according to a schedule.
select * from employee_demographics;
show events;
-- we can drop or alter these events like this:
-- DROP EVENT IF EXISTS delete_retirees;
delimiter $$
create event delete_retirees
on schedule every 30 second
do 
begin
	delete from employee_demographics where age >= 60;
end $$
delimiter ;

select * from employee_demographics; -- employee_id = 2 got retired

-- show variables like 'event%';

