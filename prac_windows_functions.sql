use newbatch;
show tables;
CREATE TABLE if not exists cmarks (
    student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    branch VARCHAR(255),
    marks INTEGER
);

/*INSERT INTO cmarks (name,branch,marks)VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);*/

select * from cmarks;
select avg(marks) from cmarks;
select *, avg(marks) over() from cmarks;
select *, avg(marks) over(partition by branch) as 'avg_marks_by_branch'from cmarks; -- gives one avg per branch only 
select *, avg(marks) over (partition by branch  order by marks) as 'cumu_avg_marks_by_branch' from cmarks; -- gives cumulative avg by branch

-- find all the students who have marks higher than their avg marks of respective branch
select * from (select *, avg(marks) over (partition by branch) as branch_avg from cmarks) t where t.marks > t.branch_avg ;

-- rank
select *, rank() over(partition by branch order by marks desc) from cmarks;

-- find top two student marks of each branch
select *, dense_rank() over(partition by branch order by marks desc) from cmarks;

select name, branch, marks, dense_rank_number from (
select *, dense_rank() over(partition by branch order by marks desc) as dense_rank_number from cmarks) t 
where t.dense_rank_number <3;

-- create roll_no from branch and marks
select *, row_number() over(partition by branch) as number,
concat(branch, "-", row_number() over(partition by branch)) as roll_no
from cmarks; 

-- first_value, last_value and nth value 
-- get the highest marks in all the branches 
select *, first_value(marks) over (order by marks desc) as highest_marks from cmarks;

-- get the lowest marks in all the branches
select *, last_value(marks) over(order by marks desc) from cmarks;
select *, last_value(marks) over (order by marks desc 
								rows between unbounded preceding and unbounded following) from cmarks; -- default is rows between unbounded preceding and current row

-- get the student name who has highest marks branchwise
select *, first_value(name) over (partition by branch order by marks desc) from cmarks;

-- get the student name who has lowest marks branchwise
select *, last_value(name) over(partition by branch order by marks desc rows between unbounded preceding and unbounded following) from cmarks;

-- get the student name who has 3rd highest marks branchwise
select *, nth_value(name,3) over(partition by branch order by marks desc 
									rows between unbounded preceding and unbounded following) from cmarks;

-- get the student name who has 3rd lowest marks branchwise
select *, nth_value(name,3) over(partition by branch order by marks
									rows between unbounded preceding and unbounded following) from cmarks;
                                    
-- find the second last guy from each branch
select * from cmarks;
select *,nth_value(name,3) over(partition by branch order by marks desc rows between unbounded preceding and unbounded following) from cmarks;
                                    
-- 5th topper of each branch
select *, nth_value(name,5) over(partition by branch order by marks desc) 5th_topper from cmarks ; -- no 5th value hence null

-- find the branch topper only
select name,branch,marks from (select *, 
first_value(marks) over(partition by branch order by marks desc) topper_marks,
first_value(name) over(partition by branch order by marks desc) topper_name from cmarks) t
where t.name = t.topper_name and t.marks = t.topper_marks;

-- find the lowest value only(alternate way of writing windows function)
select name,branch,marks from (select *, 
last_value(marks) over w lowest_marks,
last_value(name) over w student_name from cmarks
window w as (partition by branch order by marks desc  rows between unbounded preceding and unbounded following)) t
where t.name = t.student_name and t.marks = t.lowest_marks;

-- lag,lead
select *, 
lag(marks) over(order by student_id) lag_by1,
lead(marks) over(order by student_id) lead_by1,
lag(marks,2) over(order by student_id) lag_by2,
lead(marks,2) over(order by student_id) lead_by2
from cmarks;

select *, 
lag(marks) over(partition by branch order by student_id) branchwise_lag1,
lead(marks) over(partition by branch order by student_id) branchwise_lead1
from cmarks;
-- find top two most paying customers of each month
create database if not exists zomato;
use zomato;
select * from orders_x;
select month(date),monthname(date) as month from orders_x;
select * from (select month(date), monthname(date) as month , user_id, sum(amount) as total_amount,
rank() over(partition by monthname(date) order by sum(amount) desc) as rank_total_amount from orders_x
group by user_id, month(date),monthname(date)
order by month(date)) t 
where t.rank_total_amount <3
order by month desc, rank_total_amount asc;

-- find the MoM revenue growth of zomato
select month(date), sum(amount),
lead(sum(amount)) over(order by month(date)) as amount_lead1,
(lead(sum(amount)) over(order by month(date)) - sum(amount))/sum(amount)*100 MoM -- %change = ((new-old)/old)*100
from orders_x
group by month(date)
order by month(date);




