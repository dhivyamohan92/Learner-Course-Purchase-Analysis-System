create database E_Learning;
Use E_Learning;

/* Creating learner table*/

Create table learners
(
learner_id int unique primary key ,
full_name Varchar(25),
country Varchar(25)
);

/* Creating courses Table*/
create table courses
(
course_id int unique primary key,
course_name Varchar(25),
category Varchar(25),
unit_price decimal(10,2)
);

/* creating purchases table */

create table purchases
(
purchase_id int Primary Key,
learner_id int,
course_id int,
quantity int,
purchase_date datetime default current_timestamp,
Foreign key(learner_id) references learners(learner_id),
Foreign key(course_id) references courses(course_id)
);

INSERT INTO learners (learner_id, full_name, country)
VALUES
(1001, 'Arun Kumar', 'India'),
(1007, 'Priya Sharma', 'India'),
(1015, 'Rahul Menon', 'India'),
(1023, 'Sneha Iyer', 'India'),
(1031, 'Vikram Singh', 'India'),
(1042, 'John Smith', 'USA'),
(1056, 'Emily Johnson', 'USA'),
(1064, 'Michael Brown', 'Canada'),
(1078, 'Emma Wilson', 'UK'),
(1089, 'Daniel Lee', 'Singapore'),
(1097, 'Sophia Chen', 'Australia'),
(1108, 'Lucas Martin', 'France');

INSERT INTO courses (course_id, course_name, category, unit_price)
VALUES
(2005, 'SQL Fundamentals', 'Database', 120.00),
(2012, 'Advanced SQL & Queries', 'Database', 185.00),
(2028, 'Python Programming', 'Programming', 150.00),
(2036, 'Python for DA', 'Data Science', 195.00),
(2041, 'Power BI Analytics', 'Data Analytics', 180.00),
(2057, 'Advanced Power BI', 'Data Analytics', 240.00),
(2063, 'Machine Learning', 'AI/ML', 250.00),
(2079, 'Deep Learning', 'AI/ML', 320.00),
(2084, 'Excel Advanced', 'Productivity', 100.00),
(2096, 'Advanced Excel', 'Productivity', 175.00),
(2103, 'AWS Cloud', 'Cloud', 220.00),
(2118, 'AWS Solutions', 'Cloud', 350.00),
(2125, 'Statistics for DS', 'Data Science', 160.00),
(2137, 'Tableau', 'Data Visualization', 190.00),
(2149, 'Generative AI', 'Artificial Intelligence', 275.00);

INSERT INTO purchases
    (purchase_id, learner_id, course_id, quantity, purchase_date)
VALUES
(50021, 1001, 2005, 1, '2026-01-12'),
(50038, 1001, 2041, 1, '2026-01-25'),
(50047, 1001, 2057, 1, '2026-03-08'),

(50063, 1007, 2028, 1, '2026-01-18'),
(50079, 1007, 2063, 1, '2026-02-14'),
(50094, 1007, 2149, 2, '2026-05-21'),

(50106, 1015, 2036, 1, '2026-01-29'),
(50124, 1015, 2103, 1, '2026-02-20'),
(50141, 1015, 2118, 1, '2026-04-17'),

(50158, 1023, 2005, 1, '2026-02-05'),
(50173, 1023, 2084, 2, '2026-02-28'),
(50189, 1023, 2125, 1, '2026-06-03'),

(50204, 1031, 2012, 1, '2026-01-15'),
(50226, 1031, 2057, 1, '2026-03-11'),
(50243, 1031, 2079, 1, '2026-05-09'),

(50261, 1042, 2063, 1, '2026-01-22'),
(50278, 1042, 2118, 1, '2026-03-19'),
(50295, 1042, 2149, 1, '2026-07-02'),

(50312, 1056, 2041, 1, '2026-02-11'),
(50329, 1056, 2137, 1, '2026-04-06'),
(50347, 1056, 2096, 1, '2026-06-18'),

(50364, 1064, 2028, 1, '2026-01-31'),
(50382, 1064, 2036, 1, '2026-03-15'),
(50401, 1064, 2103, 1, '2026-05-27'),

(50418, 1078, 2084, 3, '2026-02-08'),
(50436, 1078, 2057, 1, '2026-04-22'),

(50453, 1089, 2012, 1, '2026-02-17'),
(50471, 1089, 2079, 1, '2026-05-14'),

(50488, 1097, 2125, 1, '2026-03-03'),
(50507, 1097, 2137, 1, '2026-06-25');

Select * from courses,purchases,learners;

Select l.full_name,c.course_name,c.category,p.quantity,round(p.quantity * c.unit_price,2) as Total_Amount ,p.purchase_date
from courses c inner join purchases p on c.course_id = p.course_id 
inner join learners l on l.learner_id= p.learner_id
Order by Total_Amount desc;

Select l.full_name,c.course_name,c.category,p.quantity,round(p.quantity * c.unit_price,2) as Total_Amount ,p.purchase_date
from courses c left join purchases p on c.course_id = p.course_id 
left join learners l on l.learner_id= p.learner_id
Order by Total_Amount desc;

Select l.full_name,c.course_name,c.category,p.quantity,round(p.quantity * c.unit_price,2) as Total_Amount ,p.purchase_date
from courses c Right join purchases p on c.course_id = p.course_id 
right join learners l on l.learner_id= p.learner_id
Order by Total_Amount desc;

Select l.full_name,round(sum(p.quantity * c.unit_price),2) as Total_Amount,l.country
from courses c inner join purchases p on c.course_id = p.course_id 
inner join learners l on l.learner_id= p.learner_id
Group by l.full_name,l.country
Order by Total_Amount desc;

Select c.course_name,count(p.purchase_id) as Total_Purchase from courses c inner join purchases p
on c.course_id = p.course_id
group by course_name
order by Total_Purchase desc
Limit 3;

USE e_learning;

Select c.category,round(sum(p.quantity * c.unit_price),2) as Total_Revenue,count(distinct(p.learner_id)) As Count_Uniquelearners
from courses c inner join purchases p on c.course_id = p.course_id 
inner join learners l on l.learner_id= p.learner_id
Group by c.category;


Select l.full_name,Count(p.purchase_id) as No_of_Purchases from learners l 
inner join purchases p on l.learner_id= p.learner_id
group by l.full_name
having No_of_Purchases > 1;

Select c.course_name from courses c 
left join purchases p on c.course_id = p.course_id
where p.purchase_id is null; 

SELECT
    l.full_name AS learner_name,
    ROUND(SUM(p.quantity * c.unit_price), 2) AS total_amount
FROM learners l
INNER JOIN purchases p
    ON l.learner_id = p.learner_id
INNER JOIN courses c
    ON p.course_id = c.course_id
GROUP BY l.learner_id, l.full_name
HAVING SUM(p.quantity * c.unit_price) >
(
    SELECT AVG(learner_total)
    FROM
    (
        SELECT
            p1.learner_id,
            SUM(p1.quantity * c1.unit_price) AS learner_total
        FROM purchases p1
        INNER JOIN courses c1
            ON p1.course_id = c1.course_id
        GROUP BY p1.learner_id
    ) AS learner_totals
)
ORDER BY total_amount DESC;

Select* from courses;

WITH learner_spending AS
(
    SELECT
        l.learner_id,
        l.full_name,
        l.country,
        SUM(p.quantity * c.unit_price) AS total_spending
    FROM learners l
    INNER JOIN purchases p
        ON l.learner_id = p.learner_id
    INNER JOIN courses c
        ON p.course_id = c.course_id
    GROUP BY
        l.learner_id,
        l.full_name,
        l.country
)
SELECT
    learner_id,
    full_name AS learner_name,
    country,
    ROUND(total_spending, 2) AS total_spending
FROM learner_spending ls
WHERE total_spending >
(
    SELECT AVG(ls2.total_spending)
    FROM learner_spending ls2
    WHERE ls2.country = ls.country
)
ORDER BY country, total_spending DESC;

with Learners_spending as
(
Select l.full_name,round(sum(p.quantity*c.unit_price),2) as Total_spent
from learners l inner join purchases p on 
l.learner_id = p.learner_id 
inner join courses c on 
c.course_id =  p.course_id
group by l.full_name
having Total_spent >10000)
select *from Learners_Spending;

SELECT
    l.full_name AS learner_name,
    ROUND(SUM(p.quantity * c.unit_price), 2) AS total_spending,
    CASE
        WHEN SUM(p.quantity * c.unit_price) > 15000 THEN 'High Value'
        WHEN SUM(p.quantity * c.unit_price) >= 8000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS learner_category
FROM learners l
INNER JOIN purchases p
    ON l.learner_id = p.learner_id
INNER JOIN courses c
    ON p.course_id = c.course_id
GROUP BY l.full_name
ORDER BY total_spending DESC;

Select c.course_name,COALESCE(count(p.purchase_id),0) as Count_Purchased from 
courses c inner join purchases p on
c.course_id = p.course_id
group by c.course_name,c.course_id;

create view category_performance_view as
(
Select c.category,round(sum(p.quantity*c.unit_price),2) as Total_Revenue,count(p.purchase_id) as Items_Purchased,
round(avg(p.quantity*c.unit_price),2) as Avg_Revenue from learners l inner join purchases p on 
l.learner_id = p.learner_id 
inner join courses c on 
c.course_id =  p.course_id
group by c.category,c.course_id
);

Select * from category_performance_view;









