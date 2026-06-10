-- Online Courses Enrollment

-- 🟠CREATION TABLES
create table students (
  student_id serial primary key,
  first_name varchar(50) not null,
  last_name varchar(50) not null,
  email varchar(50) unique not null,
  phone varchar(20),
  country varchar(50) not null,
  enrollment_date date
);

create table courses (
  course_id serial primary key,
  course_title varchar(150) not null,
  category varchar(50) not null,
  price decimal(10,2) not null,
  instructor varchar(100) not null,
  published_year int
);

-- Updated type
alter table courses
  alter column published_year type date
  using to_date(published_year::text, 'YYYY');

create table enrollments (
  enrollment_id serial primary key,
  student_id int references students(student_id),
  course_id int references courses(course_id),
  enrollment_date date,
  progress_percentage int not null,
  paid_amount decimal(10,2) not null
);

-- Drop NOT NULL constraint
alter table enrollments
  alter column progress_percentage
  drop not null;


-- 🟡INSERTION DATA
insert into students
(student_id, first_name, last_name, email, phone, country, enrollment_date)
values
(1, 'Rahim', 'Uddin', 'rahim@email.com', '01711111111', 'Bangladesh', '2023-01-10'),
(2, 'Karim', 'Ahmed', 'karim@email.com', NULL, 'Bangladesh', '2023-01-15'),
(3, 'Sara', 'Khan', 'sara@email.com', '01822222222', 'Pakistan', '2023-02-01'),
(4, 'John', 'Smith', 'john@email.com', NULL, 'USA', '2023-02-10'),
(5, 'Emma', 'Brown', 'emma@email.com', '01933333333', 'UK', '2023-02-20'),
(6, 'Ayaan', 'Ali', 'ayaan@email.com', NULL, 'India', '2023-03-05'),
(7, 'Lina', 'Rahman', 'lina@email.com', '01644444444', 'Bangladesh', '2023-03-12'),
(8, 'Mark', 'Taylor', 'mark@email.com', NULL, 'Australia', '2023-03-25'),
(9, 'Sophia', 'Lee', 'sophia@email.com', '01555555555', 'USA', '2023-04-01'),
(10, 'Daniel', 'Martinez', 'daniel@email.com', NULL, 'Spain', '2023-04-10');

insert into courses
(course_id, course_title, category, price, instructor, published_year)
values
(1, 'Complete SQL Bootcamp', 'Database', 49.99, 'John Carter', '2021-01-01'),
(2, 'Advanced JavaScript', 'Programming', 59.99, 'Sarah Miller', '2020-01-01'),
(3, 'Python for Data Science', 'Data Science', 69.99, 'David Kim', '2022-01-01'),
(4, 'Web Development with React', 'Programming', 54.99, 'Emily Stone', '2021-01-01'),
(5, 'Machine Learning Basics', 'AI', 79.99, 'Andrew Ng', '2019-01-01'),
(6, 'Cloud Computing Fundamentals', 'Cloud', 64.99, 'James Allen', '2020-01-01'),
(7, 'UI/UX Design Essentials', 'Design', 39.99, 'Laura Scott', '2022-01-01'),
(8, 'DevOps for Beginners', 'DevOps', 74.99, 'Michael Brown', '2023-01-01');

insert into enrollments
(
  enrollment_id, student_id, course_id, enrollment_date, progress_percentage, paid_amount
  )
values
(1, 1, 1, '2023-05-01', '80', 49.99),
(2, 2, 2, '2023-05-03', NULL, 59.99),
(3, 3, 3, '2023-05-05', '60', 69.99),
(4, 4, 1, '2023-05-07', '100', 49.99),
(5, 5, 4, '2023-05-10', '40', 54.99),
(6, 6, 5, '2023-05-12', NULL, 79.99),
(7, 7, 2, '2023-06-01', '90', 59.99),
(8, 8, 6, '2023-06-02', '30', 64.99),
(9, 9, 3, '2023-06-03', '70', 69.99),
(10, 10, 7, '2023-06-04', NULL, 39.99),
(11, 1, 8, '2023-06-05', '20', 74.99),
(12, 2, 1, '2023-06-06', '50', 49.99),
(13, 3, 6, '2023-06-07', NULL, 64.99),
(14, 4, 4, '2023-06-08', '85', 54.99),
(15, 5, 5, '2023-06-09', '60', 79.99);


-- 🟢CHECKS TABLE INFORMATION
select * from students;
select * from courses;
select * from enrollments;


-- 🔵START SOLVING ALL PROBLEMS

-- Q1: Display all students and their phone numbers. If the phone number is NULL, show 'Not Provided' using COALESCE.
-- Solution:
select concat(first_name,' ',last_name) as full_name, coalesce(phone, 'Not Provided') from students;

-- Q2: Show all courses ordered by price (highest to lowest) and limit the result to 5 courses.
-- Solution:
select * from courses order by price desc limit 5;

-- Q3: Display courses for page 2, assuming 3 courses per page, using LIMIT and OFFSET.
-- Solution:
select * from courses limit 3 offset 3 * 1;

-- Q4: Update the price of all courses in the Programming category by increasing it 10%.
-- Solution:
update courses set price = price * 1.10 where category = 'Programming';

-- Q5: Delete all enrollment records where progress_percentage is NULL.
-- Solution:
delete from enrollments where progress_percentage is null;

-- Q6: Find the total paid amount per course category using GROUP BY.
-- Solution:
select category, sum(paid_amount) as total_paid_amount from courses as c
join enrollments as e on c.course_id = e.course_id
group by category order by total_paid_amount asc;

-- Q7: Show course categories where the average course price is greater than 60 using HAVING.
-- Solution:
select category, round(avg(price), 2) as avg_course_price from courses
group by category
having avg(price) > 60;

-- Q8: Count how many students are enrolled in each course.
-- Solution:
select course_title, count(*) from courses as c
join enrollments as e on c.course_id = e.course_id
group by course_title;

-- Q9: Explain what happens if you try to insert an enrollment with a student_id that does not exist in the students table.
-- Solution:.
insert into enrollments (
  enrollment_id, student_id, course_id, enrollment_date, progress_percentage, paid_amount
  )
values
(16, 11, 1, '2023-05-01', '80', 49.99);

Explanation: You tried to insert an enrollment with student_id = 11, but there is no student with ID 11 in the students table.
Because of the foreign key rule, the database only allows values that already exist in the students table.
Since student 11 does not exist, the insert fails with a foreign key constraint error.

-- Q10: Display student full name, course title, and paid amount using an INNER JOIN.
-- Solution:
select concat(first_name, ' ', last_name) as "Full Name", course_title, paid_amount from students as s
inner join enrollments as e on s.student_id = e.student_id
inner join courses as c on e.course_id = c.course_id;

-- Q11: Display all students and their enrolled courses. Include students who have not enrolled in any course using a LEFT JOIN.
-- Solution:
select * from students
left join enrollments using (student_id)
left join courses using (course_id);

-- Q12: Display all courses and their enrolled students. Include courses that have no enrollments using a RIGHT JOIN.
-- Solution:
select * from students
right join enrollments using (student_id)
right join courses using (course_id);

-- Q13: Display all students and all courses, even if there is no matching enrollment, using a FULL JOIN.
-- Solution:
select * from students
full join enrollments using (student_id)
full join courses using (course_id);

-- Q14: Show the number of enrollments per year based on enrollment_date.
-- Solution:
select extract(year from enrollment_date) as per_year, count(*) as per_year_total_enrolled from enrollments
group by per_year;

-- Q15: Find the average progress percentage per course, ignoring NULL values.
-- Solution:
select course_title, round(avg(progress_percentage), 2) from courses
join enrollments using (course_id)
where progress_percentage is not null
group by course_title;
