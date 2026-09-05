<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.inventory.model.Product" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<%
    @SuppressWarnings("unchecked")
    List<Product> lowStockList = (List<Product>) request.getAttribute("lowStockList");
%>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
        <div>
            <h2 class="fw-bold mb-1 text-danger">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>Low Stock Products Alert
            </h2>
            <p class="text-muted mb-0">Items where current inventory is at or below the defined minimum threshold</p>
        </div>
        <div>
            <a href="<%= request.getContextPath() %>/products?action=list" class="btn btn-outline-secondary btn-sm">
                <i class="bi bi-box-seam me-1"></i> Full Catalog
            </a>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

    <div class="card shadow-sm border-0 border-top border-danger border-4">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h6 class="fw-bold mb-0 text-danger">
                Critical Inventory Watchlist 
                <span class="badge bg-danger ms-1"><%= lowStockList != null ? lowStockList.size() : 0 %></span>
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
                            <th>Current Stock</th>
                            <th>Min Stock Level</th>
                            <th>Deficit Units</th>
                            <th class="text-center" style="width: 160px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (lowStockList != null && !lowStockList.isEmpty()) {
                               for (Product p : lowStockList) { 
                                   int deficit = p.getMinStockLevel() - p.getQuantity();
                        %>
                            <tr class="table-danger-subtle">
                                <td><code><%= p.getCode() %></code></td>
                                <td class="fw-bold text-dark"><%= p.getName() %></td>
                                <td><span class="badge bg-light text-dark border"><%= p.getCategory() %></span></td>
                                <td>
                                    <span class="badge bg-danger fs-6"><%= p.getQuantity() %> units</span>
                                </td>
                                <td class="text-muted"><%= p.getMinStockLevel() %> units</td>
                                <td>
                                    <span class="text-danger fw-bold">
                                        <%= deficit > 0 ? ("-" + deficit) : "At Threshold" %>
                                    </span>
                                </td>
                                <td class="text-center">
                                    <a href="<%= request.getContextPath() %>/stock?action=in&productId=<%= p.getId() %>" class="btn btn-success btn-sm">
                                        <i class="bi bi-plus-circle me-1"></i> Restock Now
                                    </a>
                                </td>
                            </tr>
                        <%     }
                           } else { %>
                            <tr>
                                <td colspan="7" class="text-center py-5 text-success">
                                    <i class="bi bi-check-circle-fill fs-1 d-block mb-2"></i>
                                    <h5>All stock levels are optimal!</h5>
                                    <p class="text-muted small mb-0">No products are currently at or below minimum threshold.</p>
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
