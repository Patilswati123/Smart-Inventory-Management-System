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
 * StockServlet - Controller for Stock In, Stock Out, Stock History, and Low Stock Alerts
 */
@WebServlet("/stock")
public class StockServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StockDAO stockDAO;
    private ProductDAO productDAO;

    @Override
    public void init() {
        stockDAO = new StockDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "history";
        }

        switch (action) {
            case "in":
                showStockInForm(req, resp);
                break;
            case "out":
                showStockOutForm(req, resp);
                break;
            case "low":
                showLowStockView(req, resp);
                break;
            case "history":
            default:
                showStockHistory(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("process-in".equals(action)) {
            processStockIn(req, resp);
        } else if ("process-out".equals(action)) {
            processStockOut(req, resp);
        } else {
            showStockHistory(req, resp);
        }
    }

    private void showStockInForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        req.setAttribute("productList", products);
        req.getRequestDispatcher("/WEB-INF/views/stock/stock-in.jsp").forward(req, resp);
    }

    private void showStockOutForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        req.setAttribute("productList", products);
        req.getRequestDispatcher("/WEB-INF/views/stock/stock-out.jsp").forward(req, resp);
    }

    private void showStockHistory(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<StockTransaction> transactions = stockDAO.getAllTransactions();
        req.setAttribute("transactions", transactions);
        req.getRequestDispatcher("/WEB-INF/views/stock/stock-history.jsp").forward(req, resp);
    }

    private void showLowStockView(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Product> lowStockList = productDAO.getLowStockProducts();
        req.setAttribute("lowStockList", lowStockList);
        req.getRequestDispatcher("/WEB-INF/views/stock/low-stock.jsp").forward(req, resp);
    }

    private void processStockIn(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String remarks = req.getParameter("remarks");

            if (quantity <= 0) {
                req.setAttribute("errorMessage", "Quantity must be greater than 0.");
                showStockInForm(req, resp);
                return;
            }

            boolean success = stockDAO.stockIn(productId, quantity, remarks);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/stock?action=history&msg=Stock+added+successfully!");
            } else {
                req.setAttribute("errorMessage", "Failed to add stock.");
                showStockInForm(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Invalid form input: " + e.getMessage());
            showStockInForm(req, resp);
        }
    }

    private void processStockOut(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(req.getParameter("productId"));
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            String remarks = req.getParameter("remarks");

            if (quantity <= 0) {
                req.setAttribute("errorMessage", "Quantity must be greater than 0.");
                showStockOutForm(req, resp);
                return;
            }

            int result = stockDAO.stockOut(productId, quantity, remarks);
            if (result == 1) {
                resp.sendRedirect(req.getContextPath() + "/stock?action=history&msg=Stock+dispatched+successfully!");
            } else if (result == 0) {
                req.setAttribute("errorMessage", "Insufficient stock! Cannot dispatch more units than currently available.");
                showStockOutForm(req, resp);
            } else {
                req.setAttribute("errorMessage", "Failed to dispatch stock. Please try again.");
                showStockOutForm(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Invalid form input: " + e.getMessage());
            showStockOutForm(req, resp);
        }
    }
}
