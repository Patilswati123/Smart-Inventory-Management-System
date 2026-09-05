<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String successMsg = (String) request.getAttribute("successMessage");
    if (successMsg == null) {
        successMsg = request.getParameter("msg");
    }

    String errorMsg = (String) request.getAttribute("errorMessage");
    if (errorMsg == null) {
        errorMsg = request.getParameter("error");
    }

    String urlMsg = request.getParameter("msg");
    if ("logged_out".equals(urlMsg)) {
        successMsg = "You have been logged out successfully.";
    } else if ("please_login".equals(urlMsg)) {
        errorMsg = "Please log in first to access that page.";
    }
%>

<% if (successMsg != null && !successMsg.trim().isEmpty()) { %>
    <div class="alert alert-success alert-dismissible fade show d-flex align-items-center mb-4 shadow-sm" role="alert">
        <i class="bi bi-check-circle-fill me-2 fs-5"></i>
        <div><%= successMsg %></div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<% } %>

<% if (errorMsg != null && !errorMsg.trim().isEmpty()) { %>
    <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4 shadow-sm" role="alert">
        <i class="bi bi-exclamation-octagon-fill me-2 fs-5"></i>
        <div><%= errorMsg %></div>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
<% } %>
