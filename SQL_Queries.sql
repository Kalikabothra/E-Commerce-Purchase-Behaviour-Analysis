DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    category        VARCHAR(50),
    city            VARCHAR(50),
    country         VARCHAR(50),
    customer_id     VARCHAR(20),
    customer_name   VARCHAR(50),
    discount        NUMERIC(5,2),
    market          VARCHAR(20),
    order_date      DATE,
    order_id        VARCHAR(20),
    order_priority  VARCHAR(20),
    product_id      VARCHAR(30),
    product_name    VARCHAR(200),
    profit          NUMERIC(12,2),
    quantity        INT,
    region          VARCHAR(20),
    row_id          INT PRIMARY KEY,
    sales           NUMERIC(12,2),
    segment         VARCHAR(20),
    ship_date       DATE,
    ship_mode       VARCHAR(20),
    shipping_cost   NUMERIC(10,2),
    state           VARCHAR(50),
    sub_category    VARCHAR(20),
    year            INT,
    market2         VARCHAR(20),
    weeknum         INT
);

--imported successfully
SELECT *
FROM orders
LIMIT 10;

SELECT COUNT(*)
FROM orders;

SELECT
column_name,
data_type
FROM information_schema.columns
WHERE table_name='orders';


--BASIC INFORMATION
--Total orders
SELECT COUNT(DISTINCT order_id)
FROM orders;

--Total Customers
SELECT COUNT(DISTINCT customer_id)
FROM orders;

--Total Products
SELECT COUNT(DISTINCT product_name)
FROM orders;

--Total Revenue
SELECT SUM(sales)
FROM orders;

--Total Profit
SELECT SUM(profit)
FROM orders;

--Average Sales
SELECT AVG(sales)
FROM orders;


--SALES ANALYSIS
--Monthly Sales
SELECT 
EXTRACT (MONTH FROM order_date) AS month,
SUM(Sales)
FROM orders
GROUP BY month
ORDER BY month;

--Sales by category
SELECT category,
SUM(sales)
FROM orders
GROUP BY category
ORDER BY SUM(sales) DESC;

--Sales by sub-category
SELECT sub_category,
SUM(sales)
FROM orders
GROUP BY sub_category
ORDER BY SUM(sales) DESC;

--Top 10 customer orders with max reveneue
SELECT order_id,
SUM(sales)
FROM orders
GROUP BY order_id
ORDER BY SUM(sales) DESC
LIMIT 10;


--CUSTOMER ANALYSIS
--Top 10 Customers
SELECT customer_name, 
SUM(sales) AS total_sales
FROM orders
GROUP BY customer_name
ORDER BY SUM(sales) DESC 
LIMIT 10;

--Customers with max profit
SELECT customer_name,
SUM(profit) AS total_profit
FROM orders
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 10;


--PRODUCT ANALYSIS
--Top 10 Products
SELECT product_name,
SUM(quantity) FROM orders
GROUP BY product_name
ORDER BY SUM(quantity) DESC
LIMIT 10;

--Most Profitable Products
SELECT product_name,
SUM(profit) FROM orders
GROUP BY product_name
ORDER BY SUM(profit) DESC
LIMIT 10;

--Least Profitable Products
SELECT product_name,
SUM(profit) FROM orders
GROUP BY product_name
ORDER BY SUM(profit)
LIMIT 10;

--Top 10 Loss-Making Products
SELECT product_name,
SUM(profit) AS total_profit 
FROM orders
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 10;

--REGIONAL ANALYSIS
--Sales by Region
SELECT region,
SUM(sales)
FROM orders
GROUP BY region;

--Profit by Region
SELECT region,
SUM(profit)
FROM orders
GROUP BY region;

--Top 10 States by sales
SELECT state,
SUM(sales)
FROM orders
GROUP BY state
ORDER BY SUM(sales) DESC
LIMIT 10;

--Top 10 states by profit
SELECT state,
SUM(profit) AS total_profit
FROM orders
GROUP BY state
ORDER BY total_profit DESC
LIMIT 10;


--SHIPPING ANALYSIS
--Total Sales by Ship Mode
SELECT ship_mode,
SUM(sales)
FROM orders
GROUP BY ship_mode;

--Orders by Ship Mode
SELECT ship_mode,
COUNT(*)
FROM orders
GROUP BY ship_mode;


--DISCOUNT AND PROFIT
--Avg discount by category
SELECT category,
ROUND(AVG(discount),3) AS avg_discount
FROM orders
GROUP BY category
ORDER BY avg_discount DESC;

--Disc vs Profit
SELECT discount,
ROUND(AVG(profit),3) AS avg_profit
FROM orders
GROUP BY discount
ORDER BY discount;

--Categories with highest discount
SELECT category,
ROUND(AVG(discount),3)
FROM orders
GROUP BY category
ORDER BY AVG(discount) DESC;


--DELIVERY ANALYSIS
--Avg delivery time
SELECT
ROUND(AVG(ship_date - order_date),2) AS avg_delivery_days
FROM orders;

--PROFITABLITY ANALYSIS
--Overall Profitability
SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM orders;

--Most Profitable Products
SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) / NULLIF(SUM(sales), 0) * 100,
        2
    ) AS profit_margin_percentage
FROM orders
GROUP BY product_name
HAVING SUM(sales) > 0
ORDER BY total_profit DESC
LIMIT 10;


SELECT 
    ship_mode,
    SUM(profit) AS total_profit
FROM orders
GROUP BY ship_mode
ORDER BY total_profit DESC;