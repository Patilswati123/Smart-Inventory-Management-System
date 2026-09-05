-- ==========================================================
-- Database Schema: Smart Inventory Management System
-- Database: MySQL 8.0
-- ==========================================================

CREATE DATABASE IF NOT EXISTS smart_inventory_db;
USE smart_inventory_db;

-- 1. Users Table (Authentication and Authorization)
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'STAFF',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Products Table (Inventory Items)
CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    quantity INT NOT NULL DEFAULT 0,
    min_stock_level INT NOT NULL DEFAULT 10,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. Stock Transactions Table (Stock In / Stock Out History Log)
CREATE TABLE IF NOT EXISTS stock_transactions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    transaction_type ENUM('IN', 'OUT') NOT NULL,
    quantity INT NOT NULL,
    remarks VARCHAR(255),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- ==========================================================
-- Initial Seed Data
-- ==========================================================

-- Insert Default Users (admin / admin123, staff / staff123)
INSERT INTO users (username, password, full_name, role) VALUES
('admin', 'admin123', 'System Administrator', 'ADMIN'),
('staff', 'staff123', 'Warehouse Staff', 'STAFF')
ON DUPLICATE KEY UPDATE full_name = VALUES(full_name);

-- Insert Sample Products
INSERT INTO products (code, name, category, price, quantity, min_stock_level) VALUES
('PRD-101', 'Wireless Ergonomic Mouse', 'Electronics', 799.00, 45, 10),
('PRD-102', 'Mechanical Gaming Keyboard', 'Electronics', 2499.00, 18, 5),
('PRD-103', '27-inch 4K IPS Monitor', 'Displays', 21999.00, 4, 8),      -- Low Stock Alert (< 8)
('PRD-104', 'USB-C Fast Charging Cable (2m)', 'Accessories', 399.00, 85, 20),
('PRD-105', 'Noise-Cancelling Headphones', 'Audio', 4999.00, 3, 5),       -- Low Stock Alert (< 5)
('PRD-106', 'Ergonomic Office Chair', 'Furniture', 8499.00, 12, 5)
ON DUPLICATE KEY UPDATE price = VALUES(price);

-- Insert Sample Stock Transactions History
INSERT INTO stock_transactions (product_id, transaction_type, quantity, remarks) VALUES
(1, 'IN', 50, 'Initial bulk procurement from vendor'),
(1, 'OUT', 5, 'Dispatched to Engineering department'),
(2, 'IN', 20, 'Shipment received from manufacturer'),
(2, 'OUT', 2, 'Sold to customer ORD-901'),
(3, 'IN', 5, 'Procured 5 units from distributor'),
(3, 'OUT', 1, 'Transferred to design studio'),
(4, 'IN', 100, 'Bulk purchase order received'),
(4, 'OUT', 15, 'Office stock distribution'),
(5, 'IN', 5, 'Trial batch received'),
(5, 'OUT', 2, 'Sent for testing and review');
