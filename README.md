# 📦 E-commerce SQL Database

This project contains a simple relational database structure for managing an **e-commerce system** using **MySQL**. It includes schema creation, sample data, and a set of common queries to interact with the data.

---

## 🗂️ Database Overview

### Database Name:
**sql**
**ecommerce**

## Tables:

- customers – Stores customer details.

- products – Stores product information.

- orders – Tracks customer orders.

- order_items – Normalizes the many-to-many relationship between orders and products.

## Schema Structure

**customers**
Field | Type | Description
- customer_id | INT (PK) | Auto-incremented unique ID
- customer_name | VARCHAR(100) | Name of the customer
- customer_email | VARCHAR(100) | Unique email
- customer_address | VARCHAR(500) | Address of the customer

**products**
Field | Type | Description
- product_id | INT (PK) | Auto-incremented unique ID
- product_name | VARCHAR(200) | Name of the product
- product_price | DECIMAL(10,2) | Price of the product
- product_description | VARCHAR(1000) | Product details
- discount | DECIMAL(5,2) | Discount applied (default: 0.00)

**orders**
Field | Type | Description
- order_id | INT (PK) | Auto-incremented unique ID
- customer_id | INT (FK) | Linked to customers.customer_id
- order_date | DATE | Date the order was placed
- total_amount | DECIMAL(10,2) | Total cost of the order

**order_items**
Field | Type | Description
- order_item_id | INT (PK) | Auto-incremented unique ID
- order_id | INT (FK) | Linked to orders.order_id
- product_id | INT (FK) | Linked to products.product_id
- quantity | INT | Quantity of the product in the order

## 📊 SQL Operations
## ✅ Basic Queries
- 1.Retrieve customers who ordered in the last 30 days

- 2.Total amount spent by each customer

- 3.Update price of specific product (HD Monitor)

- 4.Add discount column to products

- 5.Top 3 most expensive products

- 6.Customers who bought 'Wireless Mouse'

- 7.Join orders and customers for order details

- 8.Retrieve high-value orders (> $150)

- 9.Normalize using order_items table

- 10.Calculate average order value

## 🧪 Sample Data Included
- 5 customers

- 5 products

- 5 orders

## ✍️ Author
- Created by: ARUN T
- Date: 23 April 2025

