create table customers(
  customer_id int,
  name varchar,
  order_id int
);

create table orders(
  order_id int,
  order_num int
);

create table menus(
  order_num int,
  name varchar,
  price int  
);

Insert Into customers values
  (1, 'John', 1),
  (2, 'Mary', 2),
  (3, 'David', 3);

Insert Into orders values
  (1, 1), (1, 2),
  (2, 2), (2, 3),
  (3, 3);

Insert Into menus values
  (1, 'Singha', 300),
  (2, 'Budweiser', 400),
  (3, 'Craft_Beer', 500);

.mode box
  --- JOIN, GROUP BY, ORDER BY, SELECTING Columns
select  
  o.order_id,
  c.name,
  sum(m.price) as total
from menus as m
JOIN orders as o
  ON m.order_num = o.order_num
JOIN customers as c 
  ON o.order_id = c.order_id
GROUP BY c.name
ORDER BY o.order_id ;


--- Aggregate Function
SELECT 
  m.name,
  max(price),
  min(price),
  avg(price),
  count(*),
  avg(price)*count(*) AS sum_price
FROM orders as o
JOIN menus as m
ON o.order_num  = m.order_num
group by m.name
ORDER BY sum_price DESC;

--- Basic Subqueries
SELECT *
FROM (select * from orders where order_id = 1) as o
Join menus as m
  ON o.order_num = m.order_num ;

--- WITH Subqueries
WITH o as (select * from orders where order_id = 1)
SELECT *
FROM  o
Join menus as m
  ON o.order_num = m.order_num 
WHERE name = 'Budweiser';

--- CASE CONDITION
SELECT
  name,
  CASE WHEN price > 450 THEN 'Expensive'
       WHEN price > 350 THEN 'Average'
       ELSE 'Cheap'
  END AS 'segment'
FROM menus
