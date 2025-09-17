# 🛒 E-commerce Store Database (MySQL)

## 📌 Overview
This project is a **relational database management system (RDBMS)** for an **E-commerce Store** built using **MySQL**.  
It covers **customers, products, categories, orders, payments, and reviews**, allowing you to manage and analyze store operations efficiently.  

The database includes:
- Customers & their details
- Product catalog with categories
- Orders and order items
- Payments tracking
- Customer reviews & ratings

---

## 📂 Project Structure
- `ecommerce_store.sql` → Contains the full database schema + sample data.  
- `README.md` → Documentation and usage guide.  

---

## 🏗️ Database Schema
### Main Entities
1. **Customers** → Stores user details.  
2. **Categories** → Groups products into categories.  
3. **Products** → Items available for sale.  
4. **Orders** → Tracks customer orders.  
5. **Order_Items** → Handles many-to-many relationship between products and orders.  
6. **Payments** → Records payments for orders.  
7. **Reviews** → Customer feedback for products.  

---

## 🔗 Relationships
- **One-to-Many** → Customers → Orders  
- **Many-to-Many** → Orders ↔ Products (via `Order_Items`)  
- **One-to-One** → Order → Payment  
- **One-to-Many** → Customers → Reviews  
- **One-to-Many** → Products → Reviews  

---

## ⚡ Installation & Setup
1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/ecommerce-store-db.git
   cd ecommerce-store-db

Import the SQL file into MySQL:

mysql -u root -p < ecommerce_store.sql


Verify the database:

SHOW DATABASES;
USE ecommerce_store;
SHOW TABLES;

📊 Sample Data

The SQL file comes with sample customers, products, orders, payments, and reviews.
Example:

John Doe orders a Samsung Galaxy S23 and Sony Headphones.

Mary Wanjiku buys 3 T-Shirts.

Ali Mohamed purchases The Lean Startup book.

🔍 Example Queries

Run these to test the system:

1. Get all orders with customer names
SELECT o.order_id, c.first_name, c.last_name, o.status, o.order_date
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;

2. Find top-selling products
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

3. Customer reviews with ratings
SELECT c.first_name, p.product_name, r.rating, r.comment
FROM Reviews r
JOIN Customers c ON r.customer_id = c.customer_id
JOIN Products p ON r.product_id = p.product_id;

🛠️ Tech Stack

Database: MySQL 8+

Language: SQL

Environment: Localhost / XAMPP / MySQL Workbench

✅ Features

Relational schema with constraints (PK, FK, UNIQUE, NOT NULL).

Supports multiple product categories.

Handles payments and orders properly.

Prevents duplicate reviews (one per product per customer).

Comes with sample dataset for quick testing.

📌 Future Improvements

Add discounts & coupons.

Add shipping details (tracking, courier, delivery time).

Implement user authentication in an application layer.
