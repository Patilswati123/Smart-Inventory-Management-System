package com.inventory.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection - Centralized Database Connection Factory
 * 
 * Manages JDBC connections to MySQL database for all DAO classes.
 */
public class DBConnection {

    // Database Configuration
    private static final String URL = "jdbc:mysql://localhost:3306/smart_inventory_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    // Static block to load MySQL JDBC Driver class once
    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found! Ensure mysql-connector-j.jar is in WEB-INF/lib.");
            e.printStackTrace();
        }
    }

    /**
     * Obtains a new database connection.
     * 
     * @return active java.sql.Connection object
     * @throws SQLException if a database access error occurs
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    /**
     * Utility method to safely close JDBC resources (Connection, Statement, ResultSet).
     * 
     * @param closeables variable arguments of AutoCloseable resources
     */
    public static void close(AutoCloseable... closeables) {
        for (AutoCloseable c : closeables) {
            if (c != null) {
                try {
                    c.close();
                } catch (Exception e) {
                    // Ignored in cleanup
                }
            }
        }
    }
}
