package com.inventory.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.inventory.model.Product;
import com.inventory.util.DBConnection;

/**
 * ProductDAO - Handles all JDBC operations for Products
 */
public class ProductDAO {

    /**
     * Adds a new product to the inventory database.
     */
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (code, name, category, price, quantity, min_stock_level) VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, product.getCode().trim());
            ps.setString(2, product.getName().trim());
            ps.setString(3, product.getCategory().trim());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getQuantity());
            ps.setInt(6, product.getMinStockLevel());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in ProductDAO.addProduct: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    /**
     * Retrieves all products ordered by ID descending.
     */
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT id, code, name, category, price, quantity, min_stock_level FROM products ORDER BY id DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error in ProductDAO.getAllProducts: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    /**
     * Retrieves a single product by primary key ID.
     */
    public Product getProductById(int id) {
        String sql = "SELECT id, code, name, category, price, quantity, min_stock_level FROM products WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                return extractProductFromResultSet(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error in ProductDAO.getProductById: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return null;
    }

    /**
     * Updates existing product information.
     */
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET code = ?, name = ?, category = ?, price = ?, min_stock_level = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, product.getCode().trim());
            ps.setString(2, product.getName().trim());
            ps.setString(3, product.getCategory().trim());
            ps.setDouble(4, product.getPrice());
            ps.setInt(5, product.getMinStockLevel());
            ps.setInt(6, product.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in ProductDAO.updateProduct: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    /**
     * Deletes a product from the database.
     */
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error in ProductDAO.deleteProduct: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    /**
     * Searches products by code, name, or category keyword.
     */
    public List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT id, code, name, category, price, quantity, min_stock_level FROM products "
                + "WHERE code LIKE ? OR name LIKE ? OR category LIKE ? ORDER BY id DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword.trim() + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error in ProductDAO.searchProducts: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    /**
     * Retrieves all products where quantity is at or below minimum threshold.
     */
    public List<Product> getLowStockProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT id, code, name, category, price, quantity, min_stock_level FROM products "
                + "WHERE quantity <= min_stock_level ORDER BY quantity ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(extractProductFromResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error in ProductDAO.getLowStockProducts: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    /**
     * Counts total distinct products.
     */
    public int getTotalProductCount() {
        String sql = "SELECT COUNT(*) FROM products";
        return executeCountQuery(sql);
    }

    /**
     * Calculates total inventory units in stock.
     */
    public int getTotalStockUnits() {
        String sql = "SELECT COALESCE(SUM(quantity), 0) FROM products";
        return executeCountQuery(sql);
    }

    /**
     * Counts products currently below threshold.
     */
    public int getLowStockCount() {
        String sql = "SELECT COUNT(*) FROM products WHERE quantity <= min_stock_level";
        return executeCountQuery(sql);
    }

    private int executeCountQuery(String sql) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error in count query: " + e.getMessage());
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return 0;
    }

    private Product extractProductFromResultSet(ResultSet rs) throws SQLException {
        Product p = new Product();
        p.setId(rs.getInt("id"));
        p.setCode(rs.getString("code"));
        p.setName(rs.getString("name"));
        p.setCategory(rs.getString("category"));
        p.setPrice(rs.getDouble("price"));
        p.setQuantity(rs.getInt("quantity"));
        p.setMinStockLevel(rs.getInt("min_stock_level"));
        return p;
    }
}
