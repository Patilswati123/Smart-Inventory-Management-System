package com.inventory.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inventory.dao.ProductDAO;
import com.inventory.dao.StockDAO;
import com.inventory.model.Product;
import com.inventory.model.StockTransaction;

/**
 * DashboardServlet - Computes and displays inventory KPIs, alerts, and recent activities
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;
    private StockDAO stockDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        stockDAO = new StockDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int totalProducts = productDAO.getTotalProductCount();
        int totalStock = productDAO.getTotalStockUnits();
        int lowStockCount = productDAO.getLowStockCount();
        List<StockTransaction> recentTransactions = stockDAO.getRecentTransactions(6);
        List<Product> lowStockProducts = productDAO.getLowStockProducts();

        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("totalStock", totalStock);
        req.setAttribute("lowStockCount", lowStockCount);
        req.setAttribute("recentTransactions", recentTransactions);
        req.setAttribute("lowStockProducts", lowStockProducts);

        req.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard.jsp").forward(req, resp);
    }
}
