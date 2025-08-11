<%-- 
    Document   : transaction
    Created on : Aug 3, 2025, 9:10:29 AM
    Author     : pruso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.models.*"%>
<%@page import="com.booking.patterns.FacadeDP"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pahana - Transaction Management</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }

            .main-container {
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar Styles */
            .sidebar {
                width: 280px;
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
                padding: 0;
                position: fixed;
                height: 100vh;
                overflow-y: auto;
                z-index: 1000;
            }

            .sidebar-header {
                padding: 2rem 1.5rem;
                border-bottom: 1px solid rgba(255,255,255,0.1);
                text-align: center;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: 700;
                color: white;
                text-decoration: none;
            }

            .logo:hover {
                color: #ffd700;
                text-decoration: none;
            }

            .nav-menu {
                padding: 1rem 0;
                flex-grow: 1;
            }

            .nav-item {
                margin: 0.5rem 1rem;
            }

            .nav-link {
                display: flex;
                align-items: center;
                padding: 0.75rem 1rem;
                color: rgba(255,255,255,0.8);
                text-decoration: none;
                border-radius: 8px;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .nav-link:hover {
                background: rgba(255,255,255,0.1);
                color: white;
                text-decoration: none;
            }

            .nav-link.active {
                background: rgba(255,255,255,0.2);
                color: white;
                border-left: 4px solid #ffd700;
            }

            .nav-link i {
                margin-right: 0.75rem;
                font-size: 1.1rem;
                width: 20px;
            }

            .sidebar-footer {
                padding: 1rem 1.5rem;
                border-top: 1px solid rgba(255,255,255,0.1);
                margin-top: auto;
            }

            .logout-btn {
                width: 100%;
                background: rgba(255,255,255,0.1);
                border: 1px solid rgba(255,255,255,0.2);
                color: white;
                padding: 0.75rem 1rem;
                border-radius: 8px;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }

            .logout-btn:hover {
                background: rgba(255,255,255,0.2);
                color: white;
                text-decoration: none;
            }

            /* Main Content Styles */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 2rem;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 2rem;
                padding: 1rem 0;
            }

            .header-left {
                display: flex;
                align-items: center;
            }

            .menu-toggle {
                background: none;
                border: none;
                font-size: 1.5rem;
                color: #333;
                margin-right: 1rem;
                cursor: pointer;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 600;
            }

            /* Content Cards */
            .content-card {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
            }

            .card-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: #333;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 6px;
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
                color: white;
            }

            /* Alert Styles */
            .alert {
                border-radius: 8px;
                border: none;
                padding: 1rem;
                margin-bottom: 1.5rem;
            }

            .alert-success {
                background-color: #d4edda;
                color: #155724;
            }

            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
            }

            .alert-info {
                background-color: #d1ecf1;
                color: #0c5460;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                }

                .sidebar.show {
                    transform: translateX(0);
                }

                .main-content {
                    margin-left: 0;
                }
            }
        </style>
    </head>
    <body>
        <%
            // Check if user is logged in
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            
            if (username == null || role == null) {
                response.sendRedirect("login.jsp?error=Please login first.");
                return;
            }
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "transaction");
            
            // Load transactions if not already loaded
            if (request.getAttribute("transactions") == null) {
                try {
                    FacadeDP facade = new FacadeDP();
                    List<Transaction> transactions;
                    
                    // Check if user is a customer - they should only see their own transactions
                    if ("CUSTOMER".equals(role)) {
                        int customerId = (Integer) session.getAttribute("userId");
                        transactions = facade.getTransactionsByCustomer(customerId);
                    } else {
                        // Admin, Manager, Cashier can see all transactions
                        transactions = facade.getAllTransactions();
                    }
                    
                    request.setAttribute("transactions", transactions);
                } catch (Exception e) {
                    // Handle error silently for now
                }
            }
        %>

        <div class="main-container">
            <!-- Sidebar -->
            <jsp:include page="includes/sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <div class="header">
                    <div class="header-left">
                        <button class="menu-toggle" onclick="toggleSidebar()">
                            <i class="bi bi-list"></i>
                        </button>
                        <h1 class="h3 mb-0">
                            <% if ("CUSTOMER".equals(role)) { %>
                            My Purchase History
                            <% } else { %>
                            Transaction Management
                            <% } %>
                        </h1>
                    </div>
                    <div class="user-info">
                        <span>Welcome, <%= username %> (<%= role %>)</span>
                        <div class="user-avatar">
                            <i class="bi bi-person"></i>
                        </div>
                    </div>
                </div>

                <!-- Messages -->
                <% if (request.getParameter("message") != null) { %>
                <div class="alert alert-success">
                    <i class="bi bi-check-circle me-2"></i><%= request.getParameter("message") %>
                </div>
                <% } %>
                
                <% if (request.getParameter("error") != null) { %>
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle me-2"></i><%= request.getParameter("error") %>
                </div>
                <% } %>

                <!-- Transaction List -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-receipt me-2"></i>
                            <% if ("CUSTOMER".equals(role)) { %>
                            My Transactions
                            <% } else { %>
                            Transaction List
                            <% } %>
                        </span>
                        <div>
                            <a href="TransactionServlet?action=list" class="btn btn-secondary me-2">
                                <i class="bi bi-arrow-clockwise me-2"></i>Refresh
                            </a>
                            <% if (!"CUSTOMER".equals(role)) { %>
                            <a href="pos.jsp" class="btn btn-primary">
                                <i class="bi bi-cart-plus me-2"></i>New Transaction
                            </a>
                            <% } %>
                        </div>
                    </h3>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Transaction ID</th>
                                    <% if (!"CUSTOMER".equals(role)) { %>
                                    <th>Customer</th>
                                    <% } %>
                                    <th>Total Amount</th>
                                    <th>Created By</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
                                    if (transactions != null && !transactions.isEmpty()) {
                                        for (Transaction transaction : transactions) {
                                %>
                                <tr>
                                    <td><%= transaction.getTransactionId() %></td>
                                    <% if (!"CUSTOMER".equals(role)) { %>
                                    <td>
                                        <%= transaction.getCustomer().getName() %>
                                        <br><small class="text-muted">(<%= transaction.getCustomer().getAccountNumber() %>)</small>
                                    </td>
                                    <% } %>
                                    <td><strong><%= transaction.getTotalAmount() %></strong></td>
                                    <td><%= transaction.getCreatedBy().getUsername() %></td>
                                    <td><%= transaction.getCreatedAt() %></td>
                                    <td>
                                        <a href="TransactionServlet?action=view&transaction_id=<%= transaction.getTransactionId() %>" 
                                           class="btn btn-sm btn-info">
                                            <i class="bi bi-eye me-1"></i>View
                                        </a>
                                    </td>
                                </tr>
                                <% 
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="<%= "CUSTOMER".equals(role) ? "5" : "6" %>" class="text-center text-muted">
                                        <i class="bi bi-inbox me-2"></i>No transactions found.
                                        <% if ("CUSTOMER".equals(role)) { %>
                                        <br><small>You haven't made any purchases yet.</small>
                                        <% } else { %>
                                        <br><small>Create your first transaction using the POS system.</small>
                                        <% } %>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Toggle sidebar on mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.toggle('show');
            }

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(event) {
                const sidebar = document.getElementById('sidebar');
                const menuToggle = document.querySelector('.menu-toggle');
                
                if (window.innerWidth <= 768) {
                    if (!sidebar.contains(event.target) && !menuToggle.contains(event.target)) {
                        sidebar.classList.remove('show');
                    }
                }
            });
        </script>
    </body>
</html> 