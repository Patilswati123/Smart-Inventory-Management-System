<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container my-auto py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5 col-xl-4">
            
            <!-- Brand Heading -->
            <div class="text-center mb-4">
                <div class="bg-primary text-white d-inline-flex p-3 rounded-circle shadow-sm mb-2">
                    <i class="bi bi-boxes fs-2"></i>
                </div>
                <h3 class="fw-bold text-dark">Smart Inventory</h3>
                <p class="text-muted small">Enter your credentials to access the management portal</p>
            </div>

            <!-- Login Card -->
            <div class="card shadow border-0 p-4">
                <jsp:include page="/WEB-INF/views/common/alerts.jsp" />

                <form action="<%= request.getContextPath() %>/login" method="post">
                    <!-- Username -->
                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold">Username</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-person"></i></span>
                            <input type="text" class="form-control" id="username" name="username" 
                                   value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" 
                                   placeholder="Enter username" required autofocus>
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="mb-4">
                        <label for="password" class="form-label fw-semibold">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light"><i class="bi bi-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" 
                                   placeholder="Enter password" required>
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                        <i class="bi bi-box-arrow-in-right me-2"></i> Sign In
                    </button>
                </form>

                <!-- Demo Credentials Help Box -->
                <div class="mt-4 p-3 bg-light rounded border text-muted small">
                    <div class="fw-bold text-dark mb-1"><i class="bi bi-info-circle me-1"></i> Pre-configured Logins:</div>
                    <ul class="mb-0 ps-3">
                        <li><strong>Admin:</strong> <code>admin</code> / <code>admin123</code></li>
                        <li><strong>Staff:</strong> <code>staff</code> / <code>staff123</code></li>
                    </ul>
                </div>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
