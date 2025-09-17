-- Create Database
USE limpid_ltd;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Sample Customers
INSERT INTO Customers (first_name, last_name, email, phone, address)
VALUES
('John', 'Doe', 'john.doe@example.com', '0712345678', 'Nairobi, Kenya'),
('Mary', 'Wanjiku', 'mary.wanjiku@example.com', '0723456789', 'Kisumu, Kenya'),
('Ali', 'Mohamed', 'ali.mohamed@example.com', '0734567890', 'Mombasa, Kenya');


-- Categories Table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Insert Sample Categories
INSERT INTO Categories (category_name)
VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home & Kitchen');


-- Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    product_name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Insert Sample Products
INSERT INTO Products (category_id, product_name, description, price, stock_quantity)
VALUES
(1, 'Samsung Galaxy S23', 'Latest Samsung smartphone with AMOLED display', 95000.00, 10),
(1, 'Sony Headphones', 'Noise cancelling wireless headphones', 15000.00, 25),
(2, 'Men T-Shirt', 'Cotton slim fit T-shirt', 1200.00, 50),
(2, 'Women Dress', 'Floral summer dress', 3500.00, 30),
(3, 'The Lean Startup', 'Business & entrepreneurship book', 2200.00, 15),
(4, 'Blender', 'High-speed kitchen blender', 7500.00, 12);


-- Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert Sample Orders
INSERT INTO Orders (customer_id, status)
VALUES
(1, 'Pending'),
(2, 'Shipped'),
(3, 'Delivered');


-- Order_Items Table
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert Sample Order Items
INSERT INTO Order_Items (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 95000.00), -- John buys Samsung Galaxy S23
(1, 2, 2, 15000.00), -- John buys 2 Sony Headphones
(2, 3, 3, 1200.00),  -- Mary buys 3 T-Shirts
(3, 5, 1, 2200.00);  -- Ali buys The Lean Startup


-- Payments Table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('Credit Card','Debit Card','PayPal','Bank Transfer','Cash') NOT NULL,
    status ENUM('Pending','Completed','Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert Sample Payments
INSERT INTO Payments (order_id, amount, payment_method, status)
VALUES
(1, 125000.00, 'Credit Card', 'Pending'),
(2, 3600.00, 'PayPal', 'Completed'),
(3, 2200.00, 'Cash', 'Completed');


-- Reviews Table
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE (product_id, customer_id)
);

-- Insert Sample Reviews
INSERT INTO Reviews (product_id, customer_id, rating, comment)
VALUES
(1, 1, 5, 'Amazing phone! Totally worth it.'),
(3, 2, 4, 'Good quality T-shirt, will buy again.'),
(5, 3, 5, 'Very insightful book!');
