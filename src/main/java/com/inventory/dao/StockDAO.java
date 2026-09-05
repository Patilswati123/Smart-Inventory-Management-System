package com.inventory.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.inventory.model.StockTransaction;
import com.inventory.util.DBConnection;

/**
 * StockDAO - Handles database operations for Stock-In, Stock-Out, and History
 * Uses JDBC transactions (commit/rollback) to maintain ACID data integrity.
 */
public class StockDAO {

    /**
     * Records Stock In: increments product quantity and logs transaction.
     * 
     * @param productId ID of product to restock
     * @param quantity number of units received
     * @param remarks transaction comments
     * @return true if successful
     */
    public boolean stockIn(int productId, int quantity, String remarks) {
        String updateSql = "UPDATE products SET quantity = quantity + ? WHERE id = ?";
        String insertSql = "INSERT INTO stock_transactions (product_id, transaction_type, quantity, remarks) VALUES (?, 'IN', ?, ?)";

        Connection conn = null;
        PreparedStatement psUpdate = null;
        PreparedStatement psInsert = null;

        try {
            conn = DBConnection.getConnection();
            // Start transaction
            conn.setAutoCommit(false);

            // 1. Update product quantity
            psUpdate = conn.prepareStatement(updateSql);
            psUpdate.setInt(1, quantity);
            psUpdate.setInt(2, productId);
            int rowsUpdated = psUpdate.executeUpdate();

            if (rowsUpdated == 0) {
                conn.rollback();
                return false;
            }

            // 2. Insert transaction history log
            psInsert = conn.prepareStatement(insertSql);
            psInsert.setInt(1, productId);
            psInsert.setInt(2, quantity);
            psInsert.setString(3, remarks);
            psInsert.executeUpdate();

            // Commit transaction
            conn.commit();
            return true;
        } catch (SQLException e) {
            System.err.println("Error during stockIn transaction: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            DBConnection.close(psUpdate, psInsert, conn);
        }
    }

    /**
     * Records Stock Out: validates availability, decrements quantity, and logs transaction.
     * 
     * @param productId ID of product dispatched
     * @param quantity number of units removed
     * @param remarks transaction comments
     * @return 1 = Success, 0 = Insufficient Stock, -1 = Error
     */
    public int stockOut(int productId, int quantity, String remarks) {
        String checkSql = "SELECT quantity FROM products WHERE id = ? FOR UPDATE";
        String updateSql = "UPDATE products SET quantity = quantity - ? WHERE id = ?";
        String insertSql = "INSERT INTO stock_transactions (product_id, transaction_type, quantity, remarks) VALUES (?, 'OUT', ?, ?)";

        Connection conn = null;
        PreparedStatement psCheck = null;
        PreparedStatement psUpdate = null;
        PreparedStatement psInsert = null;
        ResultSet rsCheck = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // 1. Check current available stock with row lock
            psCheck = conn.prepareStatement(checkSql);
            psCheck.setInt(1, productId);
            rsCheck = psCheck.executeQuery();

            if (!rsCheck.next()) {
                conn.rollback();
                return -1; // Product not found
            }

            int currentStock = rsCheck.getInt("quantity");
            if (currentStock < quantity) {
                conn.rollback();
                return 0; // Insufficient stock
            }

            // 2. Decrement stock
            psUpdate = conn.prepareStatement(updateSql);
            psUpdate.setInt(1, quantity);
            psUpdate.setInt(2, productId);
            psUpdate.executeUpdate();

            // 3. Insert transaction log
            psInsert = conn.prepareStatement(insertSql);
            psInsert.setInt(1, productId);
            psInsert.setInt(2, quantity);
            psInsert.setString(3, remarks);
            psInsert.executeUpdate();

            conn.commit();
            return 1; // Success
        } catch (SQLException e) {
            System.err.println("Error during stockOut transaction: " + e.getMessage());
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return -1;
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            DBConnection.close(rsCheck, psCheck, psUpdate, psInsert, conn);
        }
    }

    /**
     * Retrieves all stock transactions ordered by newest first.
     */
    public List<StockTransaction> getAllTransactions() {
        return fetchTransactions("SELECT t.id, t.product_id, p.code AS product_code, p.name AS product_name, "
                + "t.transaction_type, t.quantity, t.remarks, t.transaction_date "
                + "FROM stock_transactions t JOIN products p ON t.product_id = p.id "
                + "ORDER BY t.transaction_date DESC, t.id DESC");
    }

    /**
     * Retrieves recent transactions limited by count (for Dashboard activity).
     */
    public List<StockTransaction> getRecentTransactions(int limit) {
        return fetchTransactions("SELECT t.id, t.product_id, p.code AS product_code, p.name AS product_name, "
                + "t.transaction_type, t.quantity, t.remarks, t.transaction_date "
                + "FROM stock_transactions t JOIN products p ON t.product_id = p.id "
                + "ORDER BY t.transaction_date DESC, t.id DESC LIMIT " + limit);
    }

    private List<StockTransaction> fetchTransactions(String sql) {
        List<StockTransaction> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                StockTransaction t = new StockTransaction();
                t.setId(rs.getInt("id"));
                t.setProductId(rs.getInt("product_id"));
                t.setProductCode(rs.getString("product_code"));
                t.setProductName(rs.getString("product_name"));
                t.setTransactionType(rs.getString("transaction_type"));
                t.setQuantity(rs.getInt("quantity"));
                t.setRemarks(rs.getString("remarks"));
                t.setTransactionDate(rs.getTimestamp("transaction_date"));
                list.add(t);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching transactions: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }
}
