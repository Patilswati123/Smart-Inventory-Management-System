<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Redirect root URL directly to the Dashboard controller
    response.sendRedirect(request.getContextPath() + "/dashboard");
%>
