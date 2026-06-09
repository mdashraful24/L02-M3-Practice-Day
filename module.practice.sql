-- DATABASE CREATION
create database collage;


-- TABLE CREATION
create table departments (
  department_id serial primary key,
  department_name varchar(50)
);

create table employees (
  employee_id serial primary key,
  employee_name varchar(50),
  department_id int references departments (department_id),
  salary decimal(10, 2),
  hire_date date
);


-- DATASET TO INSERT
insert into departments (department_name)
values
('HR'),
('Marketing'),
('Finance'),
('IT'),
('Sales'),
('Engineering'),
('Customer Support'),
('Administration'),
('Research'),
('Quality Assurance');

insert into employees
(employee_name, department_id, salary, hire_date)
values
('Rahim Uddin', 1, 45000.00, '2022-01-15'),
('Karim Ahmed', 2, 52000.00, '2021-03-10'),
('Sara Khan', 3, 60000.00, '2020-07-20'),
('John Smith', 4, 75000.00, '2019-05-12'),
('Emma Brown', 5, 48000.00, '2023-02-01'),
('Ayaan Ali', 6, 85000.00, '2018-11-18'),
('Lina Rahman', 7, 42000.00, '2022-09-05'),
('Mark Taylor', 8, 50000.00, '2021-12-22'),
('Sophia Lee', 9, 67000.00, '2020-06-14'),
('Daniel Martinez', 10, 55000.00, '2023-01-30'),
('Nusrat Jahan', 1, 47000.00, '2021-04-08'),
('Hasan Mahmud', 2, 53000.00, '2022-08-19'),
('Olivia Wilson', 3, 62000.00, '2019-10-25'),
('James Anderson', 4, 78000.00, '2018-03-17'),
('Fatima Noor', 5, 51000.00, '2023-05-11'),
('Michael Johnson', 6, 90000.00, '2017-07-09'),
('David Miller', 7, 44000.00, '2022-06-27'),
('Emily Davis', 8, 56000.00, '2020-01-13'),
('Ryan Clark', 9, 70000.00, '2021-11-04'),
('Priya Sharma', 10, 58000.00, '2023-04-16');


-- CHECKS TABLE DATA
select * from departments;
select * from employees;


-- 🔴 PRACTICE QUESTIONS & ANSWERS

-- Q1: INNER JOIN to Retrieve Employee and Department Information
select * from employees as e
inner join departments as d on e.department_id = d.department_id;

-- another way
select * from employees
inner join departments using(department_id);


-- Q2: Show Department Name with Average Salary
select department_name, round(avg(salary)) from employees
join departments using (department_id)
group by department_name;


-- Q3: Count Employees in Each Department
select department_name, count(*) as total_employee from employees
join departments using (department_id)
group by department_name;


-- Q4: Find the Department name with the Highest Average Salary
select department_name, round(avg(salary)) as average_salary from employees
join departments using (department_id)
group by department_name order by average_salary desc limit 1;


-- Q5: Count Employees Hired Each Year
select extract(year from hire_date) as hired_years, count(*) as total_hired from employees
group by hired_years order by hired_years desc;

-- another ways
select extract(year from '2023-12-31'::date)
  
select extract(year from hire_date) as hired_years, count(*) as total_hired from employees
join departments using(department_id)
group by hired_years order by hired_years desc;
