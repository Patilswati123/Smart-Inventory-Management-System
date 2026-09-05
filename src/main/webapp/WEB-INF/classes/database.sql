-- ==========================================================
-- Database Schema for Smart Inventory Management System
-- Database: MySQL
-- ==========================================================

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS smart_inventory_db;
USE smart_inventory_db;

-- 2. Users Table (for Authentication)
-- CREATE TABLE users (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     username VARCHAR(50) NOT NULL UNIQUE,
--     password VARCHAR(255) NOT NULL,
--     full_name VARCHAR(100) NOT NULL,
--     role VARCHAR(20) DEFAULT 'STAFF',
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

-- 3. Products Table (for Product Management)
-- CREATE TABLE products (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     code VARCHAR(50) NOT NULL UNIQUE,
--     name VARCHAR(100) NOT NULL,
--     category VARCHAR(50),
--     price DECIMAL(10,2) NOT NULL,
--     quantity INT NOT NULL DEFAULT 0,
--     min_stock_level INT NOT NULL DEFAULT 10,
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );

-- 4. Stock Transactions Table (for Stock In / Stock Out / History)
-- CREATE TABLE stock_transactions (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     product_id INT NOT NULL,
--     transaction_type ENUM('IN', 'OUT') NOT NULL,
--     quantity INT NOT NULL,
--     remarks VARCHAR(255),
--     transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
-- );
