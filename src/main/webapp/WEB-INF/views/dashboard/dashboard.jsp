<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.inventory.model.User" %>
<%@ page import="com.inventory.model.Product" %>
<%@ page import="com.inventory.model.StockTransaction" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<%
    User currentUser = (User) session.getAttribute("loggedUser");
    int totalProducts = (Integer) request.getAttribute("totalProducts");
    int totalStock = (Integer) request.getAttribute("totalStock");
    int lowStockCount = (Integer) request.getAttribute("lowStockCount");
    @SuppressWarnings("unchecked")
    List<StockTransaction> recentTransactions = (List<StockTransaction>) request.getAttribute("recentTransactions");
    @SuppressWarnings("unchecked")
    List<Product> lowStockProducts = (List<Product>) request.getAttribute("lowStockProducts");
%>

<div class="container py-4">
    <!-- Top Header -->
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <div>
            <h2 class="fw-bold mb-1">Dashboard</h2>
            <p class="text-muted mb-0">Overview of your inventory status and recent movements</p>
        </div>
        <div class="d-flex gap-2">
            <a href="<%= request.getContextPath() %>/products?action=new" class="btn btn-primary btn-sm">
                <i class="bi bi-plus-lg me-1"></i> Add Product
            </a>
            <a href="<%= request.getContextPath() %>/stock?action=in" class="btn btn-success btn-sm">
                <i class="bi bi-box-arrow-in-down me-1"></i> Stock In
            </a>
            <a href="<%= request.getContextPath() %>/stock?action=out" class="btn btn-warning btn-sm text-dark">
                <i class="bi bi-box-arrow-up me-1"></i> Stock Out
            </a>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

    <!-- 3 Stat KPI Cards -->
    <div class="row g-3 mb-4">
        <!-- Card 1: Total Products -->
        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100 p-3 border-start border-primary border-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted text-uppercase fw-semibold small">Total Products</span>
                        <h2 class="fw-bold text-dark mb-0 mt-1"><%= totalProducts %></h2>
                        <a href="<%= request.getContextPath() %>/products?action=list" class="text-primary small text-decoration-none">
                            View All Products <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>
                    <div class="bg-primary-subtle text-primary p-3 rounded-circle">
                        <i class="bi bi-box-seam fs-3"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 2: Total Units In Stock -->
        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100 p-3 border-start border-success border-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted text-uppercase fw-semibold small">Total Stock Units</span>
                        <h2 class="fw-bold text-dark mb-0 mt-1"><%= totalStock %></h2>
                        <span class="text-muted small">Units in warehouse</span>
                    </div>
                    <div class="bg-success-subtle text-success p-3 rounded-circle">
                        <i class="bi bi-stack fs-3"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 3: Low Stock Alerts -->
        <div class="col-md-4">
            <div class="card shadow-sm border-0 h-100 p-3 border-start <%= lowStockCount > 0 ? "border-danger" : "border-info" %> border-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <span class="text-muted text-uppercase fw-semibold small">Low Stock Alerts</span>
                        <h2 class="fw-bold <%= lowStockCount > 0 ? "text-danger" : "text-dark" %> mb-0 mt-1"><%= lowStockCount %></h2>
                        <a href="<%= request.getContextPath() %>/stock?action=low" class="<%= lowStockCount > 0 ? "text-danger" : "text-info" %> small text-decoration-none">
                            Review Critical Items <i class="bi bi-arrow-right"></i>
                        </a>
                    </div>
                    <div class="<%= lowStockCount > 0 ? "bg-danger-subtle text-danger" : "bg-info-subtle text-info" %> p-3 rounded-circle">
                        <i class="bi bi-exclamation-triangle fs-3"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <!-- Recent Stock Transactions -->
        <div class="col-lg-7">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold mb-0"><i class="bi bi-clock-history me-2 text-primary"></i>Recent Stock Activity</h5>
                    <a href="<%= request.getContextPath() %>/stock?action=history" class="btn btn-outline-secondary btn-sm">Full History</a>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Product</th>
                                    <th>Type</th>
                                    <th>Qty</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (recentTransactions != null && !recentTransactions.isEmpty()) { 
                                       for (StockTransaction t : recentTransactions) { %>
                                    <tr>
                                        <td>
                                            <div class="fw-semibold"><%= t.getProductName() %></div>
                                            <small class="text-muted"><%= t.getProductCode() %></small>
                                        </td>
                                        <td>
                                            <% if (t.isStockIn()) { %>
                                                <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">
                                                    <i class="bi bi-arrow-down me-1"></i> IN
                                                </span>
                                            <% } else { %>
                                                <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1">
                                                    <i class="bi bi-arrow-up me-1"></i> OUT
                                                </span>
                                            <% } %>
                                        </td>
                                        <td class="fw-bold"><%= t.getQuantity() %></td>
                                        <td class="text-muted small"><%= t.getTransactionDate() %></td>
                                    </tr>
                                <% } } else { %>
                                    <tr>
                                        <td colspan="4" class="text-center py-4 text-muted">No stock transactions recorded yet.</td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Low Stock Items Warning Box -->
        <div class="col-lg-5">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold mb-0 text-danger"><i class="bi bi-exclamation-octagon me-2"></i>Low Stock Watchlist</h5>
                    <span class="badge bg-danger"><%= lowStockCount %> items</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Product</th>
                                    <th>Stock</th>
                                    <th>Min</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% if (lowStockProducts != null && !lowStockProducts.isEmpty()) {
                                       for (Product p : lowStockProducts) { %>
                                    <tr>
                                        <td>
                                            <div class="fw-semibold"><%= p.getName() %></div>
                                            <small class="text-muted"><%= p.getCode() %></small>
                                        </td>
                                        <td>
                                            <span class="badge bg-danger"><%= p.getQuantity() %></span>
                                        </td>
                                        <td class="text-muted"><%= p.getMinStockLevel() %></td>
                                        <td>
                                            <a href="<%= request.getContextPath() %>/stock?action=in&productId=<%= p.getId() %>" class="btn btn-outline-success btn-sm py-0 px-2" title="Restock">
                                                <i class="bi bi-plus"></i> Restock
                                            </a>
                                        </td>
                                    </tr>
                                <% } } else { %>
                                    <tr>
                                        <td colspan="4" class="text-center py-4 text-success">
                                            <i class="bi bi-check-circle me-1"></i> All stock levels are healthy!
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
