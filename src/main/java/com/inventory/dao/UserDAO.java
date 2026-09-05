package com.inventory.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.inventory.model.User;
import com.inventory.util.DBConnection;

/**
 * UserDAO - Handles database operations for User authentication
 */
public class UserDAO {

    /**
     * Validates user credentials against the MySQL database.
     * 
     * @param username user entered username
     * @param password user entered password
     * @return User object if credentials are valid, null otherwise
     */
    public User validate(String username, String password) {
        String sql = "SELECT id, username, password, full_name, role FROM users WHERE username = ? AND password = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (SQLException e) {
            System.err.println("Error in UserDAO.validate: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }

        return null;
    }
}
