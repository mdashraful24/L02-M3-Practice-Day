-- B6A3 - Vehicle Rental System


create database b6a3vihiclerentalsystem;


alter database b6a3vihiclerentalsystem
rename to vihiclerental;


create table users (
  user_id serial primary key,
  name varchar(100) not null,
  email varchar(100) unique not null,
  phone varchar(20),
  role varchar(20) not null default 'Customer' check (role in ('Admin', 'Customer'))
);

create table vehicles (
  vehicle_id serial primary key,
  name varchar(50) not null,
  type varchar(20) not null check (type in ('car', 'bike', 'truck')),
  model varchar(50) not null,
  registration_number varchar(50) not null,
  rental_price decimal(10,2) not null check (rental_price > 0),
  status varchar(20) not null default 'available' check (status in ('available', 'rented', 'maintenance'))
);

create table bookings (
  booking_id serial primary key,
  user_id int references users(user_id),
  vehicle_id int references vehicles(vehicle_id),
  start_date date,
  end_date date,
  status varchar(20) not null default 'pending' check (status in ('pending', 'confirmed', 'cancelled', 'completed')),
  total_cost decimal(10,2) not null check (total_cost > 0)
);


insert into users (
  name, email, phone, role
) values
('Alice', 'alice@example.com', '1234567890', 'Customer'),
('Bob', 'bob@example.com', '0987654321', 'Admin'),
('Charlie', 'charlie@example.com', '1122334455', 'Customer');

insert into vehicles (
  name, type, model, registration_number, rental_price, status
)
values
('Toyota Corolla', 'car', '2022', 'ABC-123', 50, 'available'),
('Honda Civic', 'car', '2021', 'DEF-456', 60, 'rented'),
('Yamaha R15', 'bike', '2023', 'GHI-789', 30, 'available'),
('Ford F-150', 'truck', '2020', 'JKL-012', 100, 'maintenance');

insert into bookings (
  user_id, vehicle_id, start_date, end_date, status, total_cost
)
values
(1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(1, 1, '2023-12-10', '2023-12-12', 'pending', 100);


select * from users;
select * from vehicles;
select * from bookings;


-- Query 1:
select b.booking_id, u.name as customer_name, v.name as vehicle_name, start_date, end_date, b.status from users as u
inner join bookings as b using (user_id)
inner join vehicles as v using (vehicle_id);

-- Query 2:
select * from vehicles as v
where not exists (
  select 1 from bookings as b -- 'anything'
  where b.vehicle_id = v.vehicle_id
);

-- Query 3:
select * from vehicles
where status = 'available' and type = 'car';

-- Query 4:
select v.name as vehicle_name, count(booking_id) as total_bookings from vehicles as v
join bookings using (vehicle_id)
group by vehicle_name
having count(booking_id) > 2;
