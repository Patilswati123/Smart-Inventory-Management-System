<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.inventory.model.StockTransaction" %>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<jsp:include page="/WEB-INF/views/common/navbar.jsp" />

<%
    @SuppressWarnings("unchecked")
    List<StockTransaction> transactions = (List<StockTransaction>) request.getAttribute("transactions");
%>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
        <div>
            <h2 class="fw-bold mb-1"><i class="bi bi-clock-history me-2 text-primary"></i>Stock Transaction History</h2>
            <p class="text-muted mb-0">Complete audit log of all inventory movements (Stock In and Stock Out)</p>
        </div>
        <div class="d-flex gap-2">
            <a href="<%= request.getContextPath() %>/stock?action=in" class="btn btn-success btn-sm">
                <i class="bi bi-plus-lg me-1"></i> Stock In
            </a>
            <a href="<%= request.getContextPath() %>/stock?action=out" class="btn btn-warning btn-sm text-dark">
                <i class="bi bi-dash-lg me-1"></i> Stock Out
            </a>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

    <div class="card shadow-sm border-0">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h6 class="fw-bold mb-0">
                Transaction Records 
                <span class="badge bg-secondary ms-1"><%= transactions != null ? transactions.size() : 0 %></span>
            </h6>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th style="width: 70px;">#ID</th>
                            <th>Timestamp</th>
                            <th>Product Code</th>
                            <th>Product Name</th>
                            <th>Transaction Type</th>
                            <th>Quantity</th>
                            <th>Remarks / Notes</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (transactions != null && !transactions.isEmpty()) {
                               for (StockTransaction t : transactions) { %>
                            <tr>
                                <td class="text-muted small">#<%= t.getId() %></td>
                                <td class="text-nowrap small text-muted"><%= t.getTransactionDate() %></td>
                                <td><code><%= t.getProductCode() %></code></td>
                                <td class="fw-bold text-dark"><%= t.getProductName() %></td>
                                <td>
                                    <% if (t.isStockIn()) { %>
                                        <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1">
                                            <i class="bi bi-arrow-down-circle me-1"></i> STOCK IN
                                        </span>
                                    <% } else { %>
                                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-2 py-1">
                                            <i class="bi bi-arrow-up-circle me-1"></i> STOCK OUT
                                        </span>
                                    <% } %>
                                </td>
                                <td>
                                    <span class="fw-bold <%= t.isStockIn() ? "text-success" : "text-danger" %>">
                                        <%= t.isStockIn() ? "+" : "-" %><%= t.getQuantity() %>
                                    </span>
                                </td>
                                <td class="text-muted"><%= t.getRemarks() != null && !t.getRemarks().isEmpty() ? t.getRemarks() : "—" %></td>
                            </tr>
                        <% } } else { %>
                            <tr>
                                <td colspan="7" class="text-center py-5 text-muted">
                                    <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary"></i>
                                    No stock transaction records found.
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
