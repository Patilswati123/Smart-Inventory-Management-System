<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.inventory.model.Product" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<%
    @SuppressWarnings("unchecked")
    List<Product> products = (List<Product>) request.getAttribute("productList");
%>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-7">

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div>
                    <h3 class="fw-bold mb-0 text-warning text-dark">
                        <i class="bi bi-box-arrow-up me-2 text-warning"></i> Stock Out (Dispatch / Sale)
                    </h3>
                    <p class="text-muted small mb-0">Record dispatched inventory to customers or internal departments</p>
                </div>
                <a href="<%= request.getContextPath() %>/stock?action=history" class="btn btn-outline-secondary btn-sm">
                    <i class="bi bi-clock-history me-1"></i> View History
                </a>
            </div>

            <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

            <div class="card shadow-sm border-0 p-4">
                <form action="<%= request.getContextPath() %>/stock" method="post">
                    <input type="hidden" name="action" value="process-out">

                    <!-- Product Selection -->
                    <div class="mb-3">
                        <label for="productId" class="form-label fw-semibold">Select Product <span class="text-danger">*</span></label>
                        <select class="form-select" id="productId" name="productId" required>
                            <option value="">-- Choose a product to dispatch --</option>
                            <% if (products != null) {
                                   for (Product p : products) { %>
                                <option value="<%= p.getId() %>" data-stock="<%= p.getQuantity() %>" <%= p.getQuantity() <= 0 ? "disabled" : "" %>>
                                    <%= p.getCode() %> - <%= p.getName() %> 
                                    (Available: <%= p.getQuantity() %> <%= p.getQuantity() <= 0 ? "- OUT OF STOCK" : "" %>)
                                </option>
                            <%     }
                               } %>
                        </select>
                    </div>

                    <!-- Quantity to Dispatch -->
                    <div class="mb-3">
                        <label for="quantity" class="form-label fw-semibold">Quantity to Dispatch <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-danger fw-bold">-</span>
                            <input type="number" min="1" class="form-control" id="quantity" name="quantity" 
                                   placeholder="Enter number of units to remove" required>
                        </div>
                        <small class="text-muted">Must not exceed currently available stock.</small>
                    </div>

                    <!-- Remarks -->
                    <div class="mb-4">
                        <label for="remarks" class="form-label fw-semibold">Transaction Remarks / Dispatch Note</label>
                        <textarea class="form-control" id="remarks" name="remarks" rows="3" 
                                  placeholder="e.g. Sales order SO-1044 shipped to retail branch"></textarea>
                    </div>

                    <!-- Submit -->
                    <div class="d-flex justify-content-end gap-2">
                        <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-light border px-4">Cancel</a>
                        <button type="submit" class="btn btn-warning text-dark px-4 fw-semibold">
                            <i class="bi bi-box-arrow-up me-1"></i> Confirm Stock Out
                        </button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
