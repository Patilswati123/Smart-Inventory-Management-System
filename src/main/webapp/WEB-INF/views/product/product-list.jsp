<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.inventory.model.Product" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<%
    @SuppressWarnings("unchecked")
    List<Product> products = (List<Product>) request.getAttribute("productList");
    String searchQuery = (String) request.getAttribute("searchQuery");
%>

<div class="container py-4">
    <!-- Breadcrumb & Title -->
    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
        <div>
            <h2 class="fw-bold mb-1"><i class="bi bi-box-seam me-2 text-primary"></i>Product Management</h2>
            <p class="text-muted mb-0">Manage your product catalog, prices, and minimum stock rules</p>
        </div>
        <div>
            <a href="<%= request.getContextPath() %>/products?action=new" class="btn btn-primary">
                <i class="bi bi-plus-circle me-1"></i> Add New Product
            </a>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

    <!-- Search and Filter Bar -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body p-3">
            <form action="<%= request.getContextPath() %>/products" method="get" class="row g-2 align-items-center">
                <input type="hidden" name="action" value="search">
                <div class="col-md-9 col-lg-10">
                    <div class="input-group">
                        <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                        <input type="text" name="query" class="form-control border-start-0" 
                               placeholder="Search products by code, name, or category..." 
                               value="<%= searchQuery != null ? searchQuery : "" %>">
                    </div>
                </div>
                <div class="col-md-3 col-lg-2 d-flex gap-2">
                    <button type="submit" class="btn btn-outline-primary w-100">Search</button>
                    <% if (searchQuery != null && !searchQuery.trim().isEmpty()) { %>
                        <a href="<%= request.getContextPath() %>/products?action=list" class="btn btn-outline-secondary" title="Reset Search">
                            <i class="bi bi-x-lg"></i>
                        </a>
                    <% } %>
                </div>
            </form>
        </div>
    </div>

    <!-- Product Table Card -->
    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h6 class="fw-bold mb-0">
                Product Catalog 
                <span class="badge bg-secondary ms-1"><%= products != null ? products.size() : 0 %></span>
            </h6>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th>Code</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Unit Price</th>
                            <th>Current Stock</th>
                            <th>Min Level</th>
                            <th>Status</th>
                            <th class="text-center" style="width: 170px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (products != null && !products.isEmpty()) {
                               for (Product p : products) { %>
                            <tr>
                                <td class="fw-semibold"><code><%= p.getCode() %></code></td>
                                <td class="fw-bold text-dark"><%= p.getName() %></td>
                                <td>
                                    <span class="badge bg-light text-dark border"><%= p.getCategory() %></span>
                                </td>
                                <td>₹<%= String.format("%.2f", p.getPrice()) %></td>
                                <td>
                                    <% if (p.isLowStock()) { %>
                                        <span class="badge bg-danger fs-6"><%= p.getQuantity() %></span>
                                    <% } else { %>
                                        <span class="badge bg-success fs-6"><%= p.getQuantity() %></span>
                                    <% } %>
                                </td>
                                <td class="text-muted"><%= p.getMinStockLevel() %></td>
                                <td>
                                    <% if (p.isLowStock()) { %>
                                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle">
                                            <i class="bi bi-exclamation-triangle-fill me-1"></i> Low Stock
                                        </span>
                                    <% } else { %>
                                        <span class="badge bg-success-subtle text-success border border-success-subtle">
                                            <i class="bi bi-check-circle-fill me-1"></i> Healthy
                                        </span>
                                    <% } %>
                                </td>
                                <td class="text-center">
                                    <div class="btn-group btn-group-sm">
                                        <a href="<%= request.getContextPath() %>/stock?action=in&productId=<%= p.getId() %>" class="btn btn-outline-success" title="Stock In">
                                            <i class="bi bi-plus-lg"></i>
                                        </a>
                                        <a href="<%= request.getContextPath() %>/products?action=edit&id=<%= p.getId() %>" class="btn btn-outline-primary" title="Edit Product">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        <a href="<%= request.getContextPath() %>/products?action=delete&id=<%= p.getId() %>" class="btn btn-outline-danger" 
                                           onclick="return confirmDelete('Are you sure you want to delete product: <%= p.getName() %>?');" title="Delete Product">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        <% } } else { %>
                            <tr>
                                <td colspan="8" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary"></i>
                                    No products found matching your search.
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
