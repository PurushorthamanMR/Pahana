<%-- 
    Document   : customer_view
    Created on : Aug 3, 2025, 9:08:30 AM
    Author     : pruso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.models.*"%>
<%@page import="com.booking.dao.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookShop - View Customer</title>
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
                display: flex;
                flex-direction: column;
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
            }

            .nav-link:hover {
                background-color: rgba(255,255,255,0.1);
                color: white;
                text-decoration: none;
            }

            .nav-link.active {
                background-color: rgba(255,255,255,0.2);
                color: white;
            }

            .nav-link i {
                margin-right: 0.75rem;
                width: 20px;
                text-align: center;
            }

            /* Sidebar Footer Styles */
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
                text-decoration: none;
            }

            .btn-secondary {
                background: #6c757d;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 6px;
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-secondary:hover {
                background: #5a6268;
                color: white;
                text-decoration: none;
            }

            .btn-danger {
                background: #dc3545;
                border: none;
                padding: 0.5rem 1rem;
                border-radius: 6px;
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .btn-danger:hover {
                background: #c82333;
                color: white;
                text-decoration: none;
            }

            /* Form Styles */
            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 0.5rem;
                display: block;
            }

            .form-control {
                border: 1px solid #ddd;
                border-radius: 6px;
                padding: 0.75rem;
                font-size: 1rem;
                transition: border-color 0.3s ease;
                background-color: #f8f9fa;
                color: #495057;
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
                outline: none;
            }

            .form-control[readonly] {
                background-color: #e9ecef;
                color: #6c757d;
                cursor: not-allowed;
            }

            .row {
                display: flex;
                flex-wrap: wrap;
                margin-right: -0.75rem;
                margin-left: -0.75rem;
            }

            .col-md-6 {
                flex: 0 0 50%;
                max-width: 50%;
                padding-right: 0.75rem;
                padding-left: 0.75rem;
            }

            .col-12 {
                flex: 0 0 100%;
                max-width: 100%;
                padding-right: 0.75rem;
                padding-left: 0.75rem;
            }

            /* Alert Styles */
            .alert {
                padding: 1rem;
                margin-bottom: 1rem;
                border: 1px solid transparent;
                border-radius: 6px;
            }

            .alert-danger {
                color: #721c24;
                background-color: #f8d7da;
                border-color: #f5c6cb;
            }

            .alert-success {
                color: #155724;
                background-color: #d4edda;
                border-color: #c3e6cb;
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

                .col-md-6 {
                    flex: 0 0 100%;
                    max-width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <!-- Sidebar -->
            <div class="sidebar" id="sidebar">
                <div class="sidebar-header">
                    <a href="dashboard.jsp" class="logo">
                        <i class="bi bi-book"></i> BookShop
                    </a>
                </div>
                
                <nav class="nav-menu">
                    <div class="nav-item">
                        <a href="dashboard.jsp" class="nav-link">
                            <i class="bi bi-speedometer2"></i> Dashboard
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="book.jsp" class="nav-link">
                            <i class="bi bi-book"></i> Books
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="book_category.jsp" class="nav-link">
                            <i class="bi bi-collection"></i> Categories
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="customer.jsp" class="nav-link active">
                            <i class="bi bi-people"></i> Customers
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="transaction.jsp" class="nav-link">
                            <i class="bi bi-cart"></i> Transactions
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="stock.jsp" class="nav-link">
                            <i class="bi bi-box"></i> Stock
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="user.jsp" class="nav-link">
                            <i class="bi bi-person-gear"></i> Users
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="help.jsp" class="nav-link">
                            <i class="bi bi-question-circle"></i> Help
                        </a>
                    </div>
                </nav>
                
                <div class="sidebar-footer">
                    <a href="login.jsp" class="logout-btn">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <div class="header">
                    <div class="header-left">
                        <button class="menu-toggle" onclick="toggleSidebar()">
                            <i class="bi bi-list"></i>
                        </button>
                        <h1>View Customer</h1>
                    </div>
                    <div class="user-info">
                        <div class="user-avatar">
                            <i class="bi bi-person"></i>
                        </div>
                        <span>Admin User</span>
                    </div>
                </div>

                <div class="content-card">
                    <div class="card-title">
                        <span>Customer Details</span>
                        <div>
                            <a href="customer.jsp" class="btn btn-secondary me-2">
                                <i class="bi bi-arrow-left"></i> Back to List
                            </a>
                            <a href="customer_edit.jsp?customer_id=${param.customer_id != null ? param.customer_id : param.id}" class="btn btn-primary me-2">
                                <i class="bi bi-pencil"></i> Edit
                            </a>
                        </div>
                    </div>

                    <%
                        CustomerDAO customerDAO = new CustomerDAO();
                        Customer customer = null;
                        String errorMessage = "";
                        
                        try {
                            // Try both parameter names to handle different URL patterns
                            String customerIdParam = request.getParameter("customer_id");
                            if (customerIdParam == null) {
                                customerIdParam = request.getParameter("id");
                            }
                            
                            if (customerIdParam == null) {
                                errorMessage = "No customer ID provided";
                            } else {
                                int customerId = Integer.parseInt(customerIdParam);
                                customer = customerDAO.getCustomerById(customerId);
                                
                                if (customer == null) {
                                    errorMessage = "Customer not found with ID: " + customerId;
                                }
                            }
                        } catch (NumberFormatException e) {
                            errorMessage = "Invalid customer ID provided";
                        } catch (Exception e) {
                            errorMessage = "Error retrieving customer: " + e.getMessage();
                        }
                    %>

                    <% if (!errorMessage.isEmpty()) { %>
                        <div class="alert alert-danger">
                            <i class="bi bi-exclamation-triangle"></i> <%= errorMessage %>
                        </div>
                    <% } else if (customer != null) { %>
                        <form>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Customer ID</label>
                                        <input type="text" class="form-control" value="<%= customer.getCustomerId() %>" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Account Number</label>
                                        <input type="text" class="form-control" value="<%= customer.getAccountNumber() != null ? customer.getAccountNumber() : "" %>" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Name</label>
                                        <input type="text" class="form-control" value="<%= customer.getName() != null ? customer.getName() : "" %>" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Phone</label>
                                        <input type="text" class="form-control" value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Username</label>
                                        <input type="text" class="form-control" value="<%= customer.getUsername() != null ? customer.getUsername() : "" %>" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Email</label>
                                        <input type="email" class="form-control" value="<%= customer.getEmail() != null ? customer.getEmail() : "" %>" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group">
                                        <label class="form-label">Address</label>
                                        <textarea class="form-control" rows="3" readonly><%= customer.getAddress() != null ? customer.getAddress() : "" %></textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Role</label>
                                        <input type="text" class="form-control" value="<%= customer.getRole() != null ? customer.getRole().getRoleName() : "N/A" %>" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Created By</label>
                                        <input type="text" class="form-control" value="<%= customer.getCreatedBy() != null ? customer.getCreatedBy().getUsername() : "N/A" %>" readonly>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Created At</label>
                                        <input type="text" class="form-control" value="<%= customer.getCreatedAt() != null ? customer.getCreatedAt().toString() : "N/A" %>" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Updated At</label>
                                        <input type="text" class="form-control" value="<%= customer.getUpdatedAt() != null ? customer.getUpdatedAt().toString() : "N/A" %>" readonly>
                                    </div>
                                </div>
                            </div>
                        </form>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
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
