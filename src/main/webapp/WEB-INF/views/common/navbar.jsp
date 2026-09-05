<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.inventory.model.User" %>
<%
    User currentUser = (User) session.getAttribute("loggedUser");
    String currentPath = request.getRequestURI();
%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm py-2">
    <div class="container-fluid px-lg-4">
        <!-- Brand -->
        <a class="navbar-brand d-flex align-items-center fw-bold" href="<%= request.getContextPath() %>/dashboard">
            <span class="bg-primary text-white p-2 rounded me-2 d-inline-flex align-items-center justify-content-center" style="width: 32px; height: 32px;">
                <i class="bi bi-boxes"></i>
            </span>
            <span>Smart Inventory</span>
        </a>

        <!-- Responsive Hamburger Toggle -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#appNavbar" aria-controls="appNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse" id="appNavbar">
            <% if (currentUser != null) { %>
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link <%= currentPath.contains("/dashboard") ? "active fw-semibold text-white" : "" %>" href="<%= request.getContextPath() %>/dashboard">
                            <i class="bi bi-speedometer2 me-1"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= currentPath.contains("/product") ? "active fw-semibold text-white" : "" %>" href="<%= request.getContextPath() %>/products?action=list">
                            <i class="bi bi-box-seam me-1"></i> Products
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle <%= currentPath.contains("/stock") ? "active fw-semibold text-white" : "" %>" href="#" id="stockDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-arrow-left-right me-1"></i> Stock Management
                        </a>
                        <ul class="dropdown-menu shadow" aria-labelledby="stockDropdown">
                            <li>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/stock?action=in">
                                    <i class="bi bi-plus-circle text-success me-2"></i> Stock In (Restock)
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/stock?action=out">
                                    <i class="bi bi-dash-circle text-danger me-2"></i> Stock Out (Dispatch)
                                </a>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/stock?action=history">
                                    <i class="bi bi-clock-history text-primary me-2"></i> Stock History Log
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/stock?action=low">
                                    <i class="bi bi-exclamation-triangle text-warning me-2"></i> Low Stock Alerts
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>

                <!-- User & Logout -->
                <div class="d-flex align-items-center">
                    <div class="text-light me-3 text-end d-none d-md-block">
                        <div class="fw-semibold small"><i class="bi bi-person-circle me-1"></i> <%= currentUser.getFullName() %></div>
                        <div class="text-white-50" style="font-size: 0.75rem;"><span class="badge bg-secondary"><%= currentUser.getRole() %></span></div>
                    </div>
                    <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-danger btn-sm">
                        <i class="bi bi-box-arrow-right me-1"></i> Logout
                    </a>
                </div>
            <% } else { %>
                <div class="ms-auto">
                    <a href="<%= request.getContextPath() %>/login" class="btn btn-primary btn-sm">
                        <i class="bi bi-box-arrow-in-right me-1"></i> Login
                    </a>
                </div>
            <% } %>
        </div>
    </div>
</nav>
