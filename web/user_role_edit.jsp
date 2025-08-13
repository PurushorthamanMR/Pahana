<%-- 
    Document   : user_role_edit
    Created on : Aug 3, 2025, 9:11:24 AM
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
        <title>Pahana - Edit User Role</title>
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
                width: 240px;
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
                padding: 0;
                position: fixed;
                height: 100vh;
                overflow-y: auto;
                z-index: 1000;
            }

            .sidebar-header {
                padding: 1.25rem 1rem;
                border-bottom: 1px solid rgba(255,255,255,0.1);
                text-align: center;
            }

            .logo {
                font-size: 1.4rem;
                font-weight: 700;
                color: white;
                text-decoration: none;
            }

            .logo:hover {
                color: #ffd700;
                text-decoration: none;
            }

            .nav-menu {
                padding: 0.6rem 0;
                flex-grow: 1;
            }

            .nav-item {
                margin: 0.3rem 0.6rem;
            }

            .nav-link {
                display: flex;
                align-items: center;
                padding: 0.5rem 0.7rem;
                color: rgba(255,255,255,0.8);
                text-decoration: none;
                border-radius: 6px;
                transition: all 0.3s ease;
                font-weight: 500;
                font-size: 0.85rem;
            }

            .nav-link:hover {
                background: rgba(255,255,255,0.1);
                color: white;
                text-decoration: none;
            }

            .nav-link.active {
                background: rgba(255,255,255,0.2);
                color: white;
                border-left: 3px solid #ffd700;
            }

            .nav-link i {
                margin-right: 0.5rem;
                font-size: 0.9rem;
                width: 16px;
            }

            .sidebar-footer {
                padding: 0.8rem 1.25rem;
                border-top: 1px solid rgba(255,255,255,0.1);
                margin-top: auto;
            }

            .logout-btn {
                width: 100%;
                background: rgba(255,255,255,0.1);
                border: 1px solid rgba(255,255,255,0.2);
                color: white;
                padding: 0.6rem 0.8rem;
                border-radius: 6px;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
                font-size: 0.85rem;
            }

            .logout-btn:hover {
                background: rgba(255,255,255,0.2);
                color: white;
                text-decoration: none;
            }

            /* Main Content Styles */
            .main-content {
                flex: 1;
                margin-left: 260px;
                padding: 1.5rem;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                padding: 0.8rem 0;
            }

            .header-left {
                display: flex;
                align-items: center;
            }

            .menu-toggle {
                background: none;
                border: none;
                font-size: 1.3rem;
                color: #333;
                margin-right: 0.8rem;
                cursor: pointer;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 0.8rem;
                font-size: 0.9rem;
            }

            .user-avatar {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 600;
                font-size: 0.9rem;
            }

            /* Content Cards */
            .content-card {
                background: white;
                border-radius: 10px;
                padding: 1.25rem;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                margin-bottom: 1.5rem;
            }

            .card-title {
                font-size: 1.3rem;
                font-weight: 600;
                color: #333;
                margin-bottom: 1.25rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                border: none;
                padding: 0.4rem 0.8rem;
                border-radius: 5px;
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                font-size: 0.85rem;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
                color: white;
            }

            .btn-secondary {
                background-color: #6c757d;
                border: none;
                padding: 0.4rem 0.8rem;
                border-radius: 5px;
                color: white;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                font-size: 0.85rem;
            }

            .btn-secondary:hover {
                background-color: #545b62;
                transform: translateY(-2px);
                color: white;
            }

            /* Alert Styles */
            .alert {
                border-radius: 6px;
                border: none;
                padding: 0.8rem;
                margin-bottom: 1.25rem;
                font-size: 0.9rem;
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

            /* Form Styles */
            .form-group {
                margin-bottom: 1.25rem;
            }

            .form-label {
                font-weight: 600;
                color: #495057;
                margin-bottom: 0.4rem;
                font-size: 0.9rem;
            }

            .form-control {
                border: 2px solid #e9ecef;
                border-radius: 5px;
                padding: 0.6rem;
                transition: border-color 0.3s ease;
                font-size: 0.9rem;
            }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
            }

            .form-control:disabled {
                background-color: #e9ecef;
                opacity: 0.6;
            }

            /* Breadcrumb Styles */
            .breadcrumb {
                background-color: #f8f9fa;
                border-radius: 6px;
                padding: 0.8rem 1rem;
                margin-bottom: 0;
                border: 1px solid #e9ecef;
            }

            .breadcrumb-item a {
                color: #007bff;
                text-decoration: none;
                font-size: 0.9rem;
            }

            .breadcrumb-item a:hover {
                color: #0056b3;
                text-decoration: underline;
            }

            .breadcrumb-item.active {
                color: #6c757d;
                font-weight: 500;
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

            /* High-resolution desktop optimizations */
            @media (min-width: 1920px) and (max-height: 1200px) {
                .sidebar {
                    width: 220px;
                }
                
                .main-content {
                    margin-left: 240px;
                    padding: 1.25rem;
                }
                
                .content-card {
                    padding: 1rem;
                    margin-bottom: 1.25rem;
                }
                
                .card-title {
                    font-size: 1.2rem;
                    margin-bottom: 1rem;
                }
                
                .header {
                    margin-bottom: 1.25rem;
                    padding: 0.6rem 0;
                }
                
                .form-group {
                    margin-bottom: 1rem;
                }
                
                .form-control {
                    padding: 0.5rem;
                    font-size: 0.85rem;
                }
                
                .btn-primary,
                .btn-secondary {
                    padding: 0.35rem 0.7rem;
                    font-size: 0.8rem;
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
            
            // Check role-based access - only ADMIN can edit user roles
            if (!"ADMIN".equals(role)) {
                response.sendRedirect("dashboard.jsp?error=Access denied. Only administrators can edit user roles.");
                return;
            }
            
            // Get role ID from request parameter
            String roleId = request.getParameter("role_id");
            if (roleId == null || roleId.trim().isEmpty()) {
                response.sendRedirect("user_role.jsp?error=Role ID is required.");
                return;
            }
            
            // Get role name from request parameter
            String roleName = request.getParameter("role_name");
            if (roleName == null) {
                roleName = "";
            }
            
            request.setAttribute("currentPage", "userrole");
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
                        <h1 class="h3 mb-0">Edit User Role: <%= roleName.isEmpty() ? "ID " + roleId : roleName %></h1>
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

                <!-- Breadcrumb Navigation -->
                <nav aria-label="breadcrumb" class="mb-3">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="dashboard.jsp">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="user_role.jsp">User Roles</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Edit Role</li>
                    </ol>
                </nav>

                <!-- Edit User Role Form -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-pencil-square me-2"></i>Edit User Role</span>
                        <a href="user_role.jsp" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Roles
                        </a>
                    </h3>
                    
                                         <form action="UserRoleServlet" method="post" id="editRoleForm">
                         <input type="hidden" name="action" value="update">
                         <input type="hidden" name="role_id" value="<%= roleId %>">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="role_id_display" class="form-label">Role ID</label>
                                    <input type="text" class="form-control" id="role_id_display" 
                                           value="<%= roleId %>" disabled>
                                    <small class="form-text text-muted">Role ID cannot be changed</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="role_name" class="form-label">Role Name</label>
                                    <input type="text" class="form-control" id="role_name" name="role_name" 
                                           value="<%= roleName %>" placeholder="Enter role name (e.g., EDITOR)" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-end">
                            <a href="user_role.jsp" class="btn btn-secondary me-2">
                                <i class="bi bi-x-circle me-2"></i>Cancel
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-circle me-2"></i>Update Role
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

            // Form validation and submission
            document.getElementById('editRoleForm').addEventListener('submit', function(e) {
                const roleName = document.getElementById('role_name').value.trim();
                
                if (roleName === '') {
                    e.preventDefault();
                    alert('Please enter a role name.');
                    return false;
                }
                
                if (roleName.length < 2) {
                    e.preventDefault();
                    alert('Role name must be at least 2 characters long.');
                    return false;
                }
                
                if (roleName.length > 50) {
                    e.preventDefault();
                    alert('Role name must be less than 50 characters.');
                    return false;
                }
                
                // Show loading state
                const submitBtn = this.querySelector('button[type="submit"]');
                const originalText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Updating...';
                submitBtn.disabled = true;
                
                // Allow form submission
                return true;
            });

            // Check for success/error messages on page load
            window.addEventListener('load', function() {
                const urlParams = new URLSearchParams(window.location.search);
                const message = urlParams.get('message');
                const error = urlParams.get('error');
                
                if (message) {
                    // Show success message
                    const alertDiv = document.createElement('div');
                    alertDiv.className = 'alert alert-success';
                    alertDiv.innerHTML = '<i class="bi bi-check-circle me-2"></i>' + message;
                    
                    const header = document.querySelector('.header');
                    header.parentNode.insertBefore(alertDiv, header.nextSibling);
                    
                    // Auto-remove after 5 seconds
                    setTimeout(() => {
                        alertDiv.remove();
                    }, 5000);
                }
                
                if (error) {
                    // Show error message
                    const alertDiv = document.createElement('div');
                    alertDiv.className = 'alert alert-danger';
                    alertDiv.innerHTML = '<i class="bi bi-exclamation-triangle me-2"></i>' + error;
                    
                    const header = document.querySelector('.header');
                    header.parentNode.insertBefore(alertDiv, header.nextSibling);
                    
                    // Auto-remove after 5 seconds
                    setTimeout(() => {
                        alertDiv.remove();
                    }, 5000);
                }
            });
        </script>
    </body>
</html>
