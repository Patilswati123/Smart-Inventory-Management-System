/**
 * Package: com.inventory.controller
 * 
 * ROLE IN MVC: Controller Layer
 * 
 * This package contains HttpServlet classes that act as the Controllers in the MVC pattern.
 * Servlets intercept user requests, parse input parameters, call appropriate DAO methods,
 * set response data into request/session scope, and forward the flow to JSP views.
 * 
 * For example:
 * - LoginServlet.java       (Handles login verification and session creation)
 * - LogoutServlet.java      (Invalidates user session and redirects to login)
 * - DashboardServlet.java   (Fetches counts and summary metrics for dashboard)
 * - ProductServlet.java     (Routes actions: add, view, update, delete, search)
 * - StockServlet.java       (Handles stock in, stock out, stock history, low stock alerts)
 * 
 * Controllers:
 * - Extend HttpServlet
 * - Override doGet() and doPost()
 * - Never execute direct SQL queries (delegates to DAO)
 * - Never output HTML directly (forwards to JSP via RequestDispatcher)
 */
package com.inventory.controller;
