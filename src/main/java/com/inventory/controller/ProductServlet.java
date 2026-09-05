package com.inventory.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.inventory.dao.ProductDAO;
import com.inventory.model.Product;

/**
 * ProductServlet - Controller for all Product Management operations
 * (List, Add, Edit, Update, Delete, Search)
 */
@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(req, resp);
                break;
            case "edit":
                showEditForm(req, resp);
                break;
            case "delete":
                deleteProduct(req, resp);
                break;
            case "search":
                searchProducts(req, resp);
                break;
            case "list":
            default:
                listProducts(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("insert".equals(action)) {
            insertProduct(req, resp);
        } else if ("update".equals(action)) {
            updateProduct(req, resp);
        } else {
            listProducts(req, resp);
        }
    }

    private void listProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> list = productDAO.getAllProducts();
        req.setAttribute("productList", list);
        req.getRequestDispatcher("/WEB-INF/views/product/product-list.jsp").forward(req, resp);
    }

    private void showNewForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("product", null);
        req.setAttribute("formTitle", "Add New Product");
        req.getRequestDispatcher("/WEB-INF/views/product/product-form.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Product existing = productDAO.getProductById(id);
            if (existing != null) {
                req.setAttribute("product", existing);
                req.setAttribute("formTitle", "Update Product (" + existing.getCode() + ")");
                req.getRequestDispatcher("/WEB-INF/views/product/product-form.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/products?action=list&error=Product+not+found");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/products?action=list&error=Invalid+product+ID");
        }
    }

    private void insertProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String code = req.getParameter("code");
        String name = req.getParameter("name");
        String category = req.getParameter("category");
        String priceStr = req.getParameter("price");
        String quantityStr = req.getParameter("quantity");
        String minStockStr = req.getParameter("minStockLevel");

        try {
            double price = Double.parseDouble(priceStr);
            int quantity = Integer.parseInt(quantityStr);
            int minStockLevel = Integer.parseInt(minStockStr);

            Product newProduct = new Product(code, name, category, price, quantity, minStockLevel);
            boolean success = productDAO.addProduct(newProduct);

            if (success) {
                resp.sendRedirect(req.getContextPath() + "/products?action=list&msg=Product+added+successfully!");
            } else {
                req.setAttribute("errorMessage", "Failed to add product. Product Code might already exist.");
                req.setAttribute("product", newProduct);
                req.setAttribute("formTitle", "Add New Product");
                req.getRequestDispatcher("/WEB-INF/views/product/product-form.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            req.setAttribute("errorMessage", "Invalid input format: " + e.getMessage());
            req.setAttribute("formTitle", "Add New Product");
            req.getRequestDispatcher("/WEB-INF/views/product/product-form.jsp").forward(req, resp);
        }
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String code = req.getParameter("code");
            String name = req.getParameter("name");
            String category = req.getParameter("category");
            double price = Double.parseDouble(req.getParameter("price"));
            int minStockLevel = Integer.parseInt(req.getParameter("minStockLevel"));

            Product product = new Product();
            product.setId(id);
            product.setCode(code);
            product.setName(name);
            product.setCategory(category);
            product.setPrice(price);
            product.setMinStockLevel(minStockLevel);

            boolean success = productDAO.updateProduct(product);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/products?action=list&msg=Product+updated+successfully!");
            } else {
                req.setAttribute("errorMessage", "Failed to update product.");
                req.setAttribute("product", product);
                req.setAttribute("formTitle", "Update Product");
                req.getRequestDispatcher("/WEB-INF/views/product/product-form.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/products?action=list&error=Invalid+form+data");
        }
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            boolean success = productDAO.deleteProduct(id);
            if (success) {
                resp.sendRedirect(req.getContextPath() + "/products?action=list&msg=Product+deleted+successfully!");
            } else {
                resp.sendRedirect(req.getContextPath() + "/products?action=list&error=Failed+to+delete+product.");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/products?action=list&error=Invalid+product+ID");
        }
    }

    private void searchProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("query");
        if (query == null || query.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/products?action=list");
            return;
        }

        List<Product> results = productDAO.searchProducts(query);
        req.setAttribute("productList", results);
        req.setAttribute("searchQuery", query);
        req.getRequestDispatcher("/WEB-INF/views/product/product-list.jsp").forward(req, resp);
    }
}
