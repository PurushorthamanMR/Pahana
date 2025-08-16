<%-- 
    Document   : sidebar
    Created on : Aug 3, 2025, 9:13:00 AM
    Author     : pruso
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String role = (String) session.getAttribute("role");
    String currentPage = (String) request.getAttribute("currentPage");
    if (currentPage == null) {
        currentPage = "";
    }
%>

<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <div class="logo">
            <img src="<%= request.getContextPath() %>/IMG/pahana.png" alt="Pahana" style="height: 36px; width: auto; margin-right: 4px; vertical-align: middle;"/>Pahana
        </div>
    </div>

    <nav class="nav-menu">
        <!-- Dashboard -->
        <% if ("ADMIN".equals(role)) { %>
        <div class="nav-item">
            <span class="nav-link disabled" style="opacity: 0.6; cursor: not-allowed;">
                <i class="bi bi-speedometer2"></i>
                Dashboard
            </span>
        </div>
        <% } else if ("MANAGER".equals(role)) { %>
        <div class="nav-item">
            <a href="DashboardServlet" class="nav-link <%= "dashboard".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-speedometer2"></i>
                Dashboard
            </a>
        </div>
        <% } %>
        
        <!-- POS -->
        <% if ("ADMIN".equals(role)) { %>
        <div class="nav-item">
            <span class="nav-link disabled" style="opacity: 0.6; cursor: not-allowed;">
                <i class="bi bi-cart-check"></i>
                POS
            </span>
        </div>
        <% } else if ("MANAGER".equals(role) || "CASHIER".equals(role)) { %>
        <div class="nav-item">
            <a href="pos.jsp" class="nav-link <%= "pos".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-cart-check"></i>
                POS
            </a>
        </div>
        <% } %>
        
        <!-- Transactions -->
        <% if ("ADMIN".equals(role)) { %>
        <div class="nav-item">
            <span class="nav-link disabled" style="opacity: 0.6; cursor: not-allowed;">
                <i class="bi bi-receipt"></i>
                Transactions
            </span>
        </div>
        <% } else if ("MANAGER".equals(role) || "CASHIER".equals(role) || "CUSTOMER".equals(role)) { %>
        <div class="nav-item">
            <a href="transaction.jsp" class="nav-link <%= "transaction".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-receipt"></i>
                Transactions
            </a>
        </div>
        <% } %>
        
        <!-- Customer -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role)) { %>
        <div class="nav-item">
            <a href="CustomerServlet?action=list" class="nav-link <%= "customer".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-people"></i>
                Customers
            </a>
        </div>
        <% } %>
        
        <!-- Book Categories -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role)) { %>
        <div class="nav-item">
            <a href="BookCategoryServlet?action=list" class="nav-link <%= "bookcategory".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-tags"></i>
                Book Categories
            </a>
        </div>
        <% } %>
        
        <!-- Books -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role)) { %>
        <div class="nav-item">
            <a href="BookServlet?action=list" class="nav-link <%= "book".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-book"></i>
                Books
            </a>
        </div>
        <% } %>
        
        <!-- Stocks -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role)) { %>
        <div class="nav-item">
            <a href="StockServlet?action=list" class="nav-link <%= "stock".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-boxes"></i>
                Stocks
            </a>
        </div>
        <% } %>
        
        <!-- Users -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role)) { %>
        <div class="nav-item">
            <a href="UserServlet?action=list" class="nav-link <%= "user".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-person-gear"></i>
                Users
            </a>
        </div>
        <% } %>
        
        <!-- User Roles -->
        <% if ("ADMIN".equals(role)) { %>
        <div class="nav-item">
            <a href="UserRoleServlet?action=list" class="nav-link <%= "userrole".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-shield-check"></i>
                User Roles
            </a>
        </div>
        <% } %>
        
        <!-- Profile -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role) || "CUSTOMER".equals(role)) { %>
        <div class="nav-item">
            <a href="profile.jsp" class="nav-link <%= "profile".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-person-circle"></i>
                Profile
            </a>
        </div>
        <% } %>
        
        <!-- Help Content -->
        <% if ("ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role) || "CUSTOMER".equals(role)) { %>
        <div class="nav-item">
            <a href="help.jsp" class="nav-link <%= "help".equals(currentPage) ? "active" : "" %>">
                <i class="bi bi-question-circle"></i>
                Help Content
            </a>
        </div>
        <% } %>
    </nav>

    <div class="sidebar-footer">
        <a href="LogoutServlet" class="logout-btn">
            <i class="bi bi-box-arrow-right me-2"></i>
            Logout
        </a>
    </div>
</div> 
