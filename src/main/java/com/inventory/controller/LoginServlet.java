package com.inventory.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.inventory.dao.UserDAO;
import com.inventory.model.User;

/**
 * LoginServlet - Handles authentication and session establishment
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // If user is already logged in, redirect to dashboard
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("loggedUser") != null) {
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        // Show login view
        req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Username and password are required.");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            return;
        }

        User user = userDAO.validate(username.trim(), password.trim());

        if (user != null) {
            // Authentication successful: create new session
            HttpSession session = req.getSession(true);
            session.setAttribute("loggedUser", user);
            resp.sendRedirect(req.getContextPath() + "/dashboard");
        } else {
            // Authentication failed
            req.setAttribute("errorMessage", "Invalid username or password. Please try again.");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
        }
    }
}
