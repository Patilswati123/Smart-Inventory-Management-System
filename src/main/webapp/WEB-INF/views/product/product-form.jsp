<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.inventory.model.Product" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<%
    Product product = (Product) request.getAttribute("product");
    String formTitle = (String) request.getAttribute("formTitle");
    boolean isEdit = (product != null && product.getId() > 0);
%>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3 class="fw-bold mb-0">
                    <i class="bi <%= isEdit ? "bi-pencil-square" : "bi-plus-circle" %> me-2 text-primary"></i>
                    <%= formTitle != null ? formTitle : (isEdit ? "Update Product" : "Add Product") %>
                </h3>
                <a href="<%= request.getContextPath() %>/products?action=list" class="btn btn-outline-secondary btn-sm">
                    <i class="bi bi-arrow-left me-1"></i> Back to Catalog
                </a>
            </div>

            <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

            <div class="card shadow-sm border-0 p-4">
                <form action="<%= request.getContextPath() %>/products" method="post">
                    <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>">
                    <% if (isEdit) { %>
                        <input type="hidden" name="id" value="<%= product.getId() %>">
                    <% } %>

                    <div class="row g-3">
                        <!-- Product Code -->
                        <div class="col-md-6">
                            <label for="code" class="form-label fw-semibold">Product Code / SKU <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="code" name="code" 
                                   placeholder="e.g. PRD-201" 
                                   value="<%= isEdit ? product.getCode() : (product != null && product.getCode() != null ? product.getCode() : "") %>" 
                                   required>
                            <small class="text-muted">Unique alphanumeric identifier</small>
                        </div>

                        <!-- Category -->
                        <div class="col-md-6">
                            <label for="category" class="form-label fw-semibold">Category <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="category" name="category" list="categoryOptions"
                                   placeholder="Select or enter category" 
                                   value="<%= isEdit ? product.getCategory() : (product != null && product.getCategory() != null ? product.getCategory() : "") %>" 
                                   required>
                            <datalist id="categoryOptions">
                                <option value="Electronics">
                                <option value="Displays">
                                <option value="Accessories">
                                <option value="Audio">
                                <option value="Furniture">
                                <option value="Stationery">
                            </datalist>
                        </div>

                        <!-- Product Name -->
                        <div class="col-12">
                            <label for="name" class="form-label fw-semibold">Product Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" 
                                   placeholder="e.g. Wireless Ergonomic Mouse" 
                                   value="<%= isEdit ? product.getName() : (product != null && product.getName() != null ? product.getName() : "") %>" 
                                   required>
                        </div>

                        <!-- Price -->
                        <div class="col-md-4">
                            <label for="price" class="form-label fw-semibold">Unit Price (₹) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">₹</span>
                                <input type="number" step="0.01" min="0" class="form-control" id="price" name="price" 
                                       placeholder="0.00" 
                                       value="<%= isEdit ? product.getPrice() : (product != null ? product.getPrice() : "") %>" 
                                       required>
                            </div>
                        </div>

                        <!-- Quantity (Only editable on Create; on Edit it's managed via Stock Transactions) -->
                        <div class="col-md-4">
                            <label for="quantity" class="form-label fw-semibold">
                                <%= isEdit ? "Current Stock Units" : "Initial Stock Quantity" %> <span class="text-danger">*</span>
                            </label>
                            <% if (isEdit) { %>
                                <input type="text" class="form-control bg-light" id="quantity" 
                                       value="<%= product.getQuantity() %>" readonly>
                                <small class="text-muted">Use <a href="<%= request.getContextPath() %>/stock?action=in&productId=<%= product.getId() %>">Stock In / Out</a> to adjust</small>
                            <% } else { %>
                                <input type="number" min="0" class="form-control" id="quantity" name="quantity" 
                                       placeholder="0" value="<%= product != null ? product.getQuantity() : "0" %>" required>
                                <small class="text-muted">Opening balance</small>
                            <% } %>
                        </div>

                        <!-- Min Stock Level -->
                        <div class="col-md-4">
                            <label for="minStockLevel" class="form-label fw-semibold">Min Stock Alert Level <span class="text-danger">*</span></label>
                            <input type="number" min="1" class="form-control" id="minStockLevel" name="minStockLevel" 
                                   placeholder="e.g. 10" 
                                   value="<%= isEdit ? product.getMinStockLevel() : (product != null ? product.getMinStockLevel() : "10") %>" 
                                   required>
                            <small class="text-muted">Triggers low-stock warning</small>
                        </div>
                    </div>

                    <hr class="my-4">

                    <!-- Buttons -->
                    <div class="d-flex justify-content-end gap-2">
                        <a href="<%= request.getContextPath() %>/products?action=list" class="btn btn-light border px-4">Cancel</a>
                        <button type="submit" class="btn btn-primary px-4 fw-semibold">
                            <i class="bi <%= isEdit ? "bi-check2" : "bi-plus-lg" %> me-1"></i>
                            <%= isEdit ? "Save Changes" : "Create Product" %>
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
