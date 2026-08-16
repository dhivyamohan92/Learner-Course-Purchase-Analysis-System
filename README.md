# Learner-Course-Purchase-Analysis-System
Learner Course Purchase Analysis – MySQL Project
📌 Project Overview

This project demonstrates SQL querying and data analysis using MySQL through a Learner Course Purchase database.

The project focuses on analyzing learner purchases, course performance, spending patterns, and category-level revenue using SQL concepts such as JOINs, aggregate functions, subqueries, CTEs, CASE expressions, NULL handling, and Views.

🎯 Objectives
Create a relational MySQL database.
Create learners, courses, and purchases tables.
Define primary keys and foreign keys.
Insert sample learner, course, and purchase data.
Analyze learner and course purchase information.
Calculate total spending and revenue.
Identify top-performing courses.
Compare learner spending with average spending.
Classify learners based on spending.
Handle NULL values in analytical reports.
Create a reusable category performance View.
🗄️ Database Schema
learners
Column	Description
learner_id	Primary Key
full_name	Learner name
country	Country of residence
courses
Column	Description
course_id	Primary Key
course_name	Course title
category	Course category
unit_price	Price per course
purchases
Column	Description
purchase_id	Primary Key
learner_id	Foreign Key → learners
course_id	Foreign Key → courses
quantity	Number of courses purchased
purchase_date	Date of purchase
Relationship
learners
    │
    │ 1
    │
    │ many
purchases
    │
    │ many
    │
    │ 1
courses

The purchases table acts as the transaction table connecting learners and courses.

🛠️ Technologies Used
MySQL
MySQL Workbench
SQL
📚 SQL Concepts Covered
Joins
INNER JOIN
LEFT JOIN
RIGHT JOIN
Aggregate Functions
SUM()
COUNT()
AVG()
ROUND()
Filtering & Sorting
WHERE
HAVING
ORDER BY
LIMIT
Advanced SQL
Subqueries
Correlated subqueries
Common Table Expressions (CTE)
CASE expressions
COALESCE()
IFNULL()
Views
🔍 Key Analysis Performed
1. Learner Total Spending

Calculates how much each learner has spent across all purchased courses.

SELECT
    l.full_name AS learner_name,
    l.country,
    ROUND(SUM(p.quantity * c.unit_price), 2) AS total_amount
FROM learners l
INNER JOIN purchases p
    ON l.learner_id = p.learner_id
INNER JOIN courses c
    ON p.course_id = c.course_id
GROUP BY l.full_name, l.country
ORDER BY total_amount DESC;
2. Top 3 Most Purchased Courses

Identifies the three courses with the highest number of purchases.

SELECT
    c.course_name,
    COUNT(p.purchase_id) AS total_purchase
FROM courses c
INNER JOIN purchases p
    ON c.course_id = p.course_id
GROUP BY c.course_name
ORDER BY total_purchase DESC
LIMIT 3;
3. CTE – Learners Spending Above 10,000

A CTE is used to calculate total spending per learner and then filter learners whose spending exceeds 10,000.

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
    GROUP BY l.learner_id, l.full_name, l.country
)
SELECT
    learner_id,
    full_name AS learner_name,
    country,
    ROUND(total_spending, 2) AS total_spending
FROM learner_spending
WHERE total_spending > 10000
ORDER BY total_spending DESC;
4. CASE – Learner Value Classification

Learners are classified based on their spending:

Spending	Classification
Above 15,000	High Value
8,000–15,000	Medium Value
Below 8,000	Low Value
CASE
    WHEN SUM(p.quantity * c.unit_price) > 15000
        THEN 'High Value'
    WHEN SUM(p.quantity * c.unit_price) >= 8000
        THEN 'Medium Value'
    ELSE 'Low Value'
END AS learner_category
5. NULL Handling

COALESCE() is used to replace NULL purchase quantities with zero.

SELECT
    c.course_id,
    c.course_name,
    c.category,
    COALESCE(SUM(p.quantity), 0) AS total_quantity_purchased
FROM courses c
LEFT JOIN purchases p
    ON c.course_id = p.course_id
GROUP BY c.course_id, c.course_name, c.category;

This ensures that courses with no purchases can still appear in the report.

📊 Category Performance View

A reusable View is created to analyze course category performance.

View: category_performance_view

The View provides:

Category
Total revenue
Number of purchases
Average revenue per purchase
CREATE VIEW category_performance_view AS
SELECT
    c.category,
    ROUND(SUM(p.quantity * c.unit_price), 2) AS total_revenue,
    COUNT(p.purchase_id) AS number_of_purchases,
    ROUND(
        SUM(p.quantity * c.unit_price) /
        COUNT(p.purchase_id),
        2
    ) AS average_revenue_per_purchase
FROM courses c
INNER JOIN purchases p
    ON c.course_id = p.course_id
GROUP BY c.category;

Query the View using:

SELECT *
FROM category_performance_view;
💡 Business Insights

The analysis can be used to:

Identify high-value learners.
Understand learner spending patterns.
Identify the most popular courses.
Identify courses with low or zero purchase activity.
Compare performance across different countries.
Identify high-performing course categories.
Analyze revenue generated by each category.
Support targeted marketing and learner-retention strategies.
📁 Project Structure

Recommended GitHub repository structure:

Learner-Course-Purchase-SQL-Analysis/
│
├── README.md
│
├── SQL/
│   └── learner_course_purchase_analysis.sql
│
├── Documentation/
│   └── Learner_Course_Purchase_Analysis_Process_Document.docx
│
├── Screenshots/
│   ├── database_creation.png
│   ├── join_analysis.png
│   ├── learner_spending.png
│   ├── cte_output.png
│   ├── case_classification.png
│   ├── null_handling.png
│   └── category_performance_view.png
│
└── Data/
    └── sample_data.sql
🎓 Learning Outcomes

Through this project, the following SQL skills were practiced:

Relational database design
Primary and foreign keys
Table relationships
SQL JOIN operations
Data aggregation
Business-oriented analytical queries
Subqueries
CTEs
Conditional logic using CASE
NULL handling
SQL Views
Translating business requirements into SQL queries
🚀 How to Run the Project
1. Clone the repository
git clone <your-repository-url>
2. Open MySQL Workbench
3. Run the SQL script

Execute:

SQL/learner_course_purchase_analysis.sql
4. Select the database
USE Learner_Course_DB;
5. Run the analytical queries

Execute the queries individually to view the results.

👤 Author

Dhivya Mohan

SQL | Data Analytics | MySQL | Power BI | Python

⭐ Project Highlights

This project demonstrates practical SQL skills required for Data Analyst / Business Intelligence roles, particularly:

SQL → Joins → Aggregation → Subqueries → CTE → CASE → NULL Handling → Views → Business Analysis


Absolutely. Update the Author section in the README to:

## 👤 Author
