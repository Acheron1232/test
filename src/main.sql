-- task 1

create table student
(
    id            bigserial primary key,
    name          text not null,
    surname       text,
    patronymic    text,
    specialty_key int references specialty (id),
    subject       int references subject (id),
    rating        int
);

create table specialty
(
    id   serial primary key,
    name text not null
);

create table subject
(
    id   serial primary key,
    name text not null
);

-- task 2

create table product
(
    id    serial primary key,
    name  text not null primary key,
    price int
);

create table contract
(
    id          serial primary key,
    client_id   int references client (id),
    product_id  int references product (id),
    product_sum int,
    contract_date date
);

create table client
(
    id   serial primary key,
    name text not null
);
--1
update contract
set product_sum = 4
where id = 5;
--2
select *
from contract
where id = 7;
--3
select p.name
from product p
         inner join  contract c on p.id = c.product_id
where EXTRACT(month from c.contract_date) = 3;
--4
select c.client_id, COUNT(*) AS order_count
from contract c
group by c.client_id
order by order_count desc ;
--5
SELECT SUM(c.product_sum) AS total_tables_ordered
FROM contract c
         INNER JOIN product p ON c.product_id = p.id
WHERE p.name = 'стіл';
--6
SELECT c.client_id, COUNT(*) AS contract_count
FROM contract c
WHERE EXTRACT(YEAR FROM c.contract_date) = 2020
GROUP BY c.client_id;
--7
SELECT c.client_id, COUNT(*) AS contract_count
FROM contract c
GROUP BY c.client_id
HAVING COUNT(*) > 10;
--8
SELECT *
FROM contract
WHERE DATE(contract_date) = (SELECT DATE(contract_date) FROM contract WHERE id = 1);
--9
SELECT *
FROM contract
WHERE product_sum < (SELECT product_sum FROM contract WHERE id = 5)
LIMIT 1;