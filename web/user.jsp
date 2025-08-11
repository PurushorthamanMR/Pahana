<%-- 
    Document   : user
    Created on : Aug 3, 2025, 9:11:03 AM
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
        <title>BookShop - User Management</title>
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

            /* Table Styles */
            .table {
                margin-bottom: 0;
            }

            .table th {
                border-top: none;
                font-weight: 600;
                color: #333;
                background-color: #f8f9fa;
            }

            .table td {
                vertical-align: middle;
            }

            .btn-sm {
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
                border-radius: 4px;
            }

            .btn-edit {
                background-color: #ffc107;
                border-color: #ffc107;
                color: #212529;
            }

            .btn-delete {
                background-color: #dc3545;
                border-color: #dc3545;
                color: white;
            }



            /* Form Styles */
            .form-group {
                margin-bottom: 1rem;
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

            /* Role Badge Styles */
            .role-badge {
                padding: 0.25rem 0.5rem;
                border-radius: 4px;
                font-size: 0.75rem;
                font-weight: 600;
                text-transform: uppercase;
            }

            .role-admin {
                background-color: #dc3545;
                color: white;
            }

            .role-manager {
                background-color: #fd7e14;
                color: white;
            }

            .role-cashier {
                background-color: #20c997;
                color: white;
            }

            .role-customer {
                background-color: #6c757d;
                color: white;
            }

            /* Custom Popup Styles */
            .custom-popup-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            .custom-popup {
                background: white;
                border-radius: 8px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
                width: 90%;
                max-width: 400px;
                animation: popupFadeIn 0.3s ease;
            }

            @keyframes popupFadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.8);
                }
                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }

            .custom-popup-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem 1.5rem;
                border-bottom: 1px solid #e9ecef;
            }

            .custom-popup-header h5 {
                margin: 0;
                color: #333;
                font-weight: 600;
            }

            .custom-popup-header .btn-close {
                background: none;
                border: none;
                font-size: 1.5rem;
                color: #6c757d;
                cursor: pointer;
                padding: 0;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .custom-popup-header .btn-close:hover {
                color: #dc3545;
            }

            .custom-popup-body {
                padding: 1.5rem;
            }

            .custom-popup-body p {
                margin: 0;
                color: #666;
                font-size: 1rem;
            }

            .custom-popup-footer {
                display: flex;
                justify-content: flex-end;
                gap: 0.5rem;
                padding: 1rem 1.5rem;
                border-top: 1px solid #e9ecef;
            }

            .custom-popup-footer .btn {
                padding: 0.5rem 1rem;
                border-radius: 4px;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .custom-popup-footer .btn-secondary {
                background-color: #6c757d;
                border-color: #6c757d;
                color: white;
            }

            .custom-popup-footer .btn-secondary:hover {
                background-color: #5a6268;
                border-color: #545b62;
            }

            .custom-popup-footer .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
                color: white;
            }

            .custom-popup-footer .btn-danger:hover {
                background-color: #c82333;
                border-color: #bd2130;
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

                .custom-popup {
                    width: 95%;
                    margin: 1rem;
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
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied.");
                return;
            }
        %>

        <%
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "user");
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
                        <h1 class="h3 mb-0">User Management</h1>
                    </div>
                    <div class="user-info">
                        <span>Welcome, <%= username %> (<%= role %>)</span>
                        <div class="user-avatar">
                            <i class="bi bi-person"></i>
                        </div>
                    </div>
                </div>

                <!-- Messages -->
                <% 
                    String message = (String) request.getAttribute("message");
                    if (message == null) {
                        message = request.getParameter("message");
                    }
                    String error = (String) request.getAttribute("error");
                    if (error == null) {
                        error = request.getParameter("error");
                    }
                %>
                
                <% if (message != null && !message.isEmpty()) { %>
                <div class="alert alert-success">
                    <i class="bi bi-check-circle me-2"></i><%= message %>
                </div>
                <% } %>
                
                <% if (error != null && !error.isEmpty()) { %>
                <div class="alert alert-danger">
                    <i class="bi bi-exclamation-triangle me-2"></i><%= error %>
                </div>
                <% } %>

                <!-- Add User Form -->
                <% if (!"CASHIER".equals(role)) { %>
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-person-plus me-2"></i>Add New User</span>
                    </h3>
                    
                    <form action="UserServlet" method="post">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="username" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="role_id" class="form-label">User Role</label>
                                    <select class="form-control" id="role_id" name="role_id" required>
                                        <option value="">Select Role</option>
                                        <!-- Note: ADMIN can only create system users (ADMIN, MANAGER, CASHIER). CUSTOMER accounts are created through customer registration. -->
                                        <%
                                            List<UserRole> userRoles = (List<UserRole>) request.getAttribute("userRoles");
                                            if (userRoles != null) {
                                                for (UserRole userRole : userRoles) {
                                                    // Role-based filtering - ADMIN can only create system users (ADMIN, MANAGER, CASHIER)
                                                    boolean canCreate = false;
                                                    if ("ADMIN".equals(role)) {
                                                        // Admin can only create ADMIN, MANAGER, CASHIER (system users)
                                                        canCreate = !"CUSTOMER".equals(userRole.getRoleName());
                                                    } else if ("MANAGER".equals(role)) {
                                                        canCreate = "CASHIER".equals(userRole.getRoleName());
                                                    } else if ("CASHIER".equals(role)) {
                                                        canCreate = "CUSTOMER".equals(userRole.getRoleName());
                                                    }
                                                    
                                                    if (canCreate) {
                                        %>
                                        <option value="<%= userRole.getRoleId() %>"><%= userRole.getRoleName() %></option>
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
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-plus-circle me-2"></i>Add User
                            </button>
                        </div>
                    </form>
                </div>
                <% } %>

                <!-- User List -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-people me-2"></i>User List</span>
                        <div>
                            <a href="UserServlet?action=list" class="btn btn-primary">
                                <i class="bi bi-arrow-clockwise me-2"></i>Refresh
                            </a>
                        </div>
                    </h3>
                    
                    <%
                        // Auto-load user data if not already loaded
                        if (request.getAttribute("users") == null) {
                            // Preserve any message or error parameters
                            String redirectMessage = request.getParameter("message");
                            String redirectError = request.getParameter("error");
                            String redirectUrl = "UserServlet?action=list";
                            
                            if (redirectMessage != null && !redirectMessage.isEmpty()) {
                                redirectUrl += "&message=" + java.net.URLEncoder.encode(redirectMessage, "UTF-8");
                            }
                            if (redirectError != null && !redirectError.isEmpty()) {
                                redirectUrl += "&error=" + java.net.URLEncoder.encode(redirectError, "UTF-8");
                            }
                            
                            response.sendRedirect(redirectUrl);
                            return;
                        }
                    %>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Created At</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<User> users = (List<User>) request.getAttribute("users");
                                    if (users != null && !users.isEmpty()) {
                                        for (User user : users) {
                                            String roleClass = "";
                                            switch (user.getRole().getRoleName()) {
                                                case "ADMIN":
                                                    roleClass = "role-admin";
                                                    break;
                                                case "MANAGER":
                                                    roleClass = "role-manager";
                                                    break;
                                                case "CASHIER":
                                                    roleClass = "role-cashier";
                                                    break;
                                                case "CUSTOMER":
                                                    roleClass = "role-customer";
                                                    break;
                                            }
                                %>
                                <tr>
                                    <td><%= user.getUserId() %></td>
                                    <td><%= user.getUsername() %></td>
                                    <td><%= user.getEmail() %></td>
                                    <td><span class="role-badge <%= roleClass %>"><%= user.getRole().getRoleName() %></span></td>
                                    <td><%= user.getCreatedAt() != null ? user.getCreatedAt().toString() : "N/A" %></td>
                                    <td>
                                        <% if (!"CASHIER".equals(role)) { %>
                                        <button class="btn btn-edit btn-sm" onclick="editUser(<%= user.getUserId() %>)">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button class="btn btn-delete btn-sm" onclick="deleteUser(<%= user.getUserId() %>)">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                        <% } %>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="6" class="text-center">No users found.</td>
                                </tr>
                                <%
                                    }
                                %>
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

            // User management functions
            function editUser(userId) {
                // Navigate to edit page
                window.location.href = 'UserServlet?action=view&user_id=' + userId;
            }

            function deleteUser(userId) {
                // Create custom popup
                const popup = document.createElement('div');
                popup.className = 'custom-popup-overlay';
                popup.innerHTML = 
                    '<div class="custom-popup">' +
                        '<div class="custom-popup-header">' +
                            '<h5>Confirm Delete</h5>' +
                            '<button type="button" class="btn-close" onclick="closePopup()">&times;</button>' +
                        '</div>' +
                        '<div class="custom-popup-body">' +
                            '<p>Are you sure you want to delete this user?</p>' +
                        '</div>' +
                        '<div class="custom-popup-footer">' +
                            '<button type="button" class="btn btn-secondary" onclick="closePopup()">Cancel</button>' +
                            '<button type="button" class="btn btn-danger" onclick="confirmDelete(' + userId + ')">Delete</button>' +
                        '</div>' +
                    '</div>';
                document.body.appendChild(popup);
            }

            function closePopup() {
                const popup = document.querySelector('.custom-popup-overlay');
                if (popup) {
                    popup.remove();
                }
            }

            function confirmDelete(userId) {
                // Create AJAX request
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'UserServlet?action=delete&user_id=' + userId, true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        closePopup();
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.success) {
                                    // Show success message
                                    showAlert(response.message, 'success');
                                    // Reload the page after a short delay
                                    setTimeout(() => {
                                        window.location.reload();
                                    }, 1500);
                                } else {
                                    // Show error message
                                    showAlert(response.message, 'error');
                                }
                            } catch (e) {
                                // Fallback for non-JSON responses
                                showAlert('User deleted successfully!', 'success');
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1500);
                            }
                        } else {
                            // Show error message
                            showAlert('Failed to delete user. Please try again.', 'error');
                        }
                    }
                };
                
                xhr.send();
            }

            function showAlert(message, type) {
                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-' + (type === 'success' ? 'success' : 'danger') + ' alert-dismissible fade show';
                alertDiv.style.position = 'fixed';
                alertDiv.style.top = '20px';
                alertDiv.style.right = '20px';
                alertDiv.style.zIndex = '9999';
                alertDiv.style.minWidth = '300px';
                alertDiv.innerHTML = 
                    message +
                    '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                document.body.appendChild(alertDiv);
                
                // Auto remove after 3 seconds
                setTimeout(() => {
                    if (alertDiv.parentNode) {
                        alertDiv.remove();
                    }
                }, 3000);
            }


        </script>
    </body>
</html> 
