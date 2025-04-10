CREATE DATABASE ecommerce_data;
USE ecommerce_data;
DROP TABLE IF EXISTS details;
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(100),
    state VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(20),
    amount DECIMAL(10, 2),
    profit DECIMAL(10, 2),
    quantity INT,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    payment_mode VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
SET SQL_SAFE_UPDATES = 0;
UPDATE orders
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

SELECT * FROM orders;

-- 1. View sample orders
SELECT * FROM orders LIMIT 10;

-- 2. Orders from Delhi
SELECT * FROM orders WHERE city = 'Delhi';


DESCRIBE details;
SELECT COUNT(*) FROM details;
ALTER TABLE details
CHANGE `Order ID` order_id VARCHAR(20);



-- 3. Join orders and details to get full order info
SELECT order_id, city, amount, category
FROM orders 
JOIN details ON order_id = order_id
LIMIT 10;



-- 4. Total sales per category
SELECT category, SUM(amount) AS total_sales
FROM details
GROUP BY category;
DESCRIBE orders;

-- 5. Customer with highest single purchase
SELECT amount
FROM orders 
JOIN details ON order_id = order_id
WHERE amount = (
    SELECT MAX(amount) FROM details
);

-- 6. Create a view for city-wise profit
CREATE OR REPLACE VIEW city_profit_view AS
SELECT city, SUM(profit) AS total_profit
FROM orders
JOIN details ON order_id = order_id
GROUP BY city;

-- 7. Indexing (only works if not already indexed)
CREATE INDEX order_id ON details(order_id);
CREATE INDEX category ON details(category);

-- 8. Handling NULLs
SELECT * FROM details
WHERE payment_mode IS NULL;




