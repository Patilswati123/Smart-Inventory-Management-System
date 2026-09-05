/**
 * Package: com.inventory.dao
 * 
 * ROLE IN MVC: Data Access Layer (Persistence)
 * 
 * DAO stands for "Data Access Object".
 * This package isolates all database-related operations (JDBC code) from the rest of the application.
 * Neither Servlets nor JSPs should write SQL queries directly.
 * 
 * For example:
 * - ProductDAO.java   (addProduct, getAllProducts, getProductById, updateProduct, deleteProduct, searchProducts)
 * - UserDAO.java      (validateUser, registerUser)
 * - StockDAO.java     (recordStockIn, recordStockOut, getStockHistory, getLowStockProducts)
 * 
 * DAOs execute:
 * - Connection, PreparedStatement, ResultSet
 * - Standard CRUD (Create, Read, Update, Delete) SQL statements
 */
package com.inventory.dao;
