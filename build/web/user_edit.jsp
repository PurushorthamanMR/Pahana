<%-- 
    Document   : user_edit
    Created on : Aug 3, 2025, 9:11:12 AM
    Author     : pruso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.models.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookShop - Edit User</title>
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

            /* Main Content Styles */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 2rem;
                background-color: #f8f9fa;
                min-height: 100vh;
            }

            .content-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 2rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid #e9ecef;
            }

            .content-title {
                font-size: 2rem;
                font-weight: 700;
                color: #333;
                margin: 0;
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

            .user-details {
                text-align: right;
            }

            .user-name {
                font-weight: 600;
                color: #333;
                margin: 0;
            }

            .user-role {
                font-size: 0.875rem;
                color: #6c757d;
                margin: 0;
            }

            /* Card Styles */
            .content-card {
                background: white;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                padding: 2rem;
                margin-bottom: 2rem;
            }

            .card-title {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 1px solid #e9ecef;
                font-size: 1.5rem;
                font-weight: 600;
                color: #333;
            }

            /* Form Styles */
            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 0.5rem;
            }

            .form-control {
                border: 2px solid #e9ecef;
                border-radius: 6px;
                padding: 0.75rem;
                transition: border-color 0.3s ease;
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            /* Button Styles */
            .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 6px;
                font-weight: 500;
                transition: all 0.3s ease;
                border: none;
                cursor: pointer;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
            }

            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }

            .btn-secondary:hover {
                background-color: #5a6268;
                color: white;
            }

            .btn-danger {
                background-color: #dc3545;
                color: white;
            }

            .btn-danger:hover {
                background-color: #c82333;
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

                .content-header {
                    flex-direction: column;
                    gap: 1rem;
                    align-items: flex-start;
                }

                .user-info {
                    align-self: flex-end;
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
            
            // Check role-based access
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied.");
                return;
            }
            
            // Get user to edit
            User userToEdit = (User) request.getAttribute("user");
            if (userToEdit == null) {
                response.sendRedirect("user.jsp?error=User not found.");
                return;
            }
        %>

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
                            <i class="bi bi-speedometer2"></i>Dashboard
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="pos.jsp" class="nav-link">
                            <i class="bi bi-cart"></i>POS
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="transaction.jsp" class="nav-link">
                            <i class="bi bi-receipt"></i>Transactions
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="customer.jsp" class="nav-link">
                            <i class="bi bi-people"></i>Customers
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="book_category.jsp" class="nav-link">
                            <i class="bi bi-tags"></i>Book Categories
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="book.jsp" class="nav-link">
                            <i class="bi bi-book"></i>Books
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="stock.jsp" class="nav-link">
                            <i class="bi bi-box"></i>Stocks
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="user.jsp" class="nav-link active">
                            <i class="bi bi-person"></i>Users
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="user_role.jsp" class="nav-link">
                            <i class="bi bi-shield"></i>User Roles
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="profile.jsp" class="nav-link">
                            <i class="bi bi-person-circle"></i>Profile
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="help_content.jsp" class="nav-link">
                            <i class="bi bi-question-circle"></i>Help Content
                        </a>
                    </div>
                </nav>
                
                <div class="sidebar-footer">
                    <a href="logout.jsp" class="nav-link">
                        <i class="bi bi-box-arrow-right"></i>Logout
                    </a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <div class="content-header">
                    <h1 class="content-title">Edit User</h1>
                    <div class="user-info">
                        <div class="user-avatar">
                            <%= String.valueOf(username.charAt(0)).toUpperCase() %>
                        </div>
                        <div class="user-details">
                            <p class="user-name">Welcome, <%= username %> (<%= role %>)</p>
                        </div>
                    </div>
                </div>

                <!-- Alert Messages -->
                <%
                    String message = request.getParameter("message");
                    String error = request.getParameter("error");
                    
                    if (message != null && !message.isEmpty()) {
                %>
                <div class="alert alert-success">
                    <%= message %>
                </div>
                <%
                    }
                    
                    if (error != null && !error.isEmpty()) {
                %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
                <%
                    }
                %>

                <!-- Edit User Form -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-person-edit me-2"></i>Edit User Information</span>
                    </h3>
                    
                    <form action="UserServlet?action=update" method="post">
                        <input type="hidden" name="user_id" value="<%= userToEdit.getUserId() %>">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="username" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" 
                                           value="<%= userToEdit.getUsername() %>" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="<%= userToEdit.getEmail() %>" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           placeholder="Leave blank to keep current password">
                                    <small class="form-text text-muted">Leave blank to keep the current password</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="role_id" class="form-label">User Role</label>
                                    <select class="form-control" id="role_id" name="role_id" required>
                                        <option value="">Select Role</option>
                                        <%
                                            List<UserRole> userRoles = (List<UserRole>) request.getAttribute("userRoles");
                                            if (userRoles != null) {
                                                for (UserRole userRole : userRoles) {
                                                    // Role-based filtering - ADMIN can only edit system users (ADMIN, MANAGER, CASHIER)
                                                    boolean canEdit = false;
                                                    if ("ADMIN".equals(role)) {
                                                        // Admin can only edit ADMIN, MANAGER, CASHIER (system users)
                                                        canEdit = !"CUSTOMER".equals(userRole.getRoleName());
                                                    } else if ("MANAGER".equals(role)) {
                                                        canEdit = "CASHIER".equals(userRole.getRoleName());
                                                    }
                                                    
                                                    if (canEdit) {
                                                        String selected = (userToEdit.getRole().getRoleId() == userRole.getRoleId()) ? "selected" : "";
                                        %>
                                        <option value="<%= userRole.getRoleId() %>" <%= selected %>><%= userRole.getRoleName() %></option>
                                        <%
                                                    }
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-end">
                            <a href="user.jsp" class="btn btn-secondary me-2">
                                <i class="bi bi-arrow-left me-2"></i>Back to Users
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle me-2"></i>Update User
                            </button>
                        </div>
                    </form>
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
