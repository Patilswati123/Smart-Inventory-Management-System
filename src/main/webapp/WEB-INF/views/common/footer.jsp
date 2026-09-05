<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!-- Footer -->
    <footer class="bg-white border-top py-3 mt-auto text-center text-muted">
        <div class="container">
            <small>&copy; <%= java.time.Year.now().getValue() %> Smart Inventory Management System. Built with Java Servlets, JSP, JDBC, MySQL & Bootstrap 5.</small>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS (Includes Popper) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom JS -->
    <script src="<%= request.getContextPath() %>/assets/js/main.js"></script>
</body>
</html>
