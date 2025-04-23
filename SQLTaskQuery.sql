-- Database Created --
CREATE DATABASE ecommerce;

-- Using ecommerce Database --
USE ecommerce;

-- customers Table Created --
CREATE TABLE customers (
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL UNIQUE,
    customer_address VARCHAR(500) NOT NULL
);

-- customers Table data inserted --
INSERT INTO customers (customer_name, customer_email, customer_address) 
VALUES 
	('Arun', 'dummyone@gmail.com', 'DummyAddressOne'),
	('Indira', 'dummytwo@gmail.com', 'DummyAddressTwo'),
	('Tamilarasu', 'dummythree@gmail.com', 'DummyAddressThree'),
	('Susil', 'dummyfour@gmail.com', 'DummyAddressFour'),
	('Arulnandhini', 'dummyfive@gmail.com', 'DummyAddressFive');
    
-- products Table Created --
CREATE TABLE products (
	product_id INT PRIMARY KEY AUTO_INCREMENT,
	product_name VARCHAR(200),
	product_price DECIMAL (10,2),
	product_description VARCHAR(1000)
);

-- products Table data inserted --
INSERT INTO products (product_name, product_price, product_description)
VALUES 
	('Wireless Mouse', 25.99, 'Ergonomic wireless mouse with USB receiver'),
	('Gaming Keyboard', 79.99, 'RGB mechanical keyboard with blue switches'),
	('HD Monitor', 149.99, '24-inch full HD monitor with HDMI and VGA ports'),
	('USB-C Charger', 19.50, 'Fast-charging USB-C power adapter'),
	('Noise Cancelling Headphones', 129.00, 'Over-ear headphones with active noise cancellation');

-- orders Table Created --
CREATE TABLE orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL (10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- orders Table data inserted --
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES
	(1, '2025-04-20', 71.49),
	(2, '2025-04-21', 45.50),
	(3, '2025-04-22', 115.98),
	(4, '2025-04-23', 89.99),
	(5, '2025-04-23', 65.94);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;

-- 1. Retrieve all customers who have placed an order in the last 30 days --
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;

-- 2. Get the total amount of all orders placed by each customer. --
SELECT c.customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 3. Update the price of Product C to 45.00. --
SET SQL_SAFE_UPDATES = 0;
UPDATE products
SET product_price = 45.00
WHERE product_name = 'HD Monitor';
SELECT product_name, product_price FROM products WHERE product_name = 'HD Monitor';
SET SQL_SAFE_UPDATES = 1;

-- 4. Add a new column discount to the products table. --
ALTER TABLE products
ADD COLUMN discount DECIMAL (5,2) DEFAULT 0.00;

SELECT * FROM products;

-- 5. Retrieve the top 3 products with the highest price. --
SELECT product_name, product_price
FROM products 
ORDER BY product_price DESC
LIMIT 3;

-- 6. Get the names of customers who have ordered Product A. --
SELECT DISTINCT c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE product_name ='Wireless Mouse'; 

-- 7. Join the orders and customers tables to retrieve the customer's name and order date for each order. --
SELECT c.customer_name, o.order_date 
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- 8. Retrieve the orders with a total amount greater than 150.00 --
SELECT *
FROM orders
WHERE total_amount > 150.00;

-- 9. Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table. --
CREATE TABLE order_items (
	order_item_id INT PRIMARY KEY AUTO_INCREMENT,
	order_id INT,
	product_id INT,
	quantity INT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_id, product_id, quantity) 
VALUES
	(1, 1, 1),
	(1, 4, 2),
	(2, 1, 1),
	(3, 2, 1),
	(3, 5, 1),
	(4, 3, 1),
	(5, 4, 2);

-- 10. Retrieve the average total of all orders. --
SELECT AVG(total_amount) AS average_order_total
FROM orders;
