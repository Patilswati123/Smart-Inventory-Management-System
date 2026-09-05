package com.inventory.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * AuthFilter - Intercepts HTTP requests and guards protected routes.
 * Ensures unauthenticated users cannot access dashboard, products, or stock actions.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = { "/*" })
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Allow public paths without authentication
        boolean isPublicPath = path.equals("/login") ||
                path.equals("/") ||
                path.equals("/index.jsp") ||
                path.startsWith("/assets/") ||
                path.endsWith(".css") ||
                path.endsWith(".js") ||
                path.endsWith(".png") ||
                path.endsWith(".ico");

        if (isPublicPath) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user session exists and contains user object
        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("loggedUser") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response);
        } else {
            // Redirect unauthenticated requests to login page
            res.sendRedirect(req.getContextPath() + "/login?msg=please_login");
        }
    }

    @Override
    public void destroy() {
    }
}
