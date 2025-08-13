<%-- 
    Document   : user_role
    Created on : Aug 3, 2025, 9:11:24 AM
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
        <title>Pahana - User Role Management</title>
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

            /* Table Styles */
            .table {
                font-size: 0.9rem;
            }

            .table th {
                font-size: 0.85rem;
                font-weight: 600;
                padding: 0.6rem;
            }

            .table td {
                padding: 0.6rem;
                vertical-align: middle;
            }

            .badge {
                font-size: 0.75rem;
                padding: 0.3rem 0.6rem;
            }

            .btn-sm {
                padding: 0.3rem 0.6rem;
                font-size: 0.8rem;
                border-radius: 4px;
            }

            .text-muted.small {
                font-size: 0.75rem;
            }

            /* Action Button Styles */
            .btn-edit {
                background-color: #ffc107;
                border-color: #ffc107;
                color: #212529;
                transition: all 0.3s ease;
            }

            .btn-edit:hover {
                background-color: #e0a800;
                border-color: #d39e00;
                color: #212529;
                transform: translateY(-1px);
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .btn-delete {
                background-color: #dc3545;
                border-color: #dc3545;
                color: white;
                transition: all 0.3s ease;
            }

            .btn-delete:hover {
                background-color: #c82333;
                border-color: #bd2130;
                color: white;
                transform: translateY(-1px);
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
                
                .btn-primary {
                    padding: 0.35rem 0.7rem;
                    font-size: 0.8rem;
                }
                
                .table {
                    font-size: 0.85rem;
                }
                
                .table th,
                .table td {
                    padding: 0.5rem;
                }
                
                .badge {
                    font-size: 0.7rem;
                    padding: 0.25rem 0.5rem;
                }
                
                .btn-sm {
                    padding: 0.25rem 0.5rem;
                    font-size: 0.75rem;
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
            
            // Check role-based access - only ADMIN can access user roles
            if (!"ADMIN".equals(role)) {
                response.sendRedirect("dashboard.jsp?error=Access denied. Only administrators can manage user roles.");
                return;
            }
        %>

        <%
            // Set current page for sidebar highlighting
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
                        <h1 class="h3 mb-0">User Role Management</h1>
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

                <!-- Add User Role Form -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-shield-plus me-2"></i>Add New User Role</span>
                    </h3>
                    
                    <form action="UserRoleServlet" method="post">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="role_name" class="form-label">Role Name</label>
                                    <input type="text" class="form-control" id="role_name" name="role_name" 
                                           placeholder="Enter role name (e.g., EDITOR)" required>
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-plus-circle me-2"></i>Add Role
                            </button>
                        </div>
                    </form>
                </div>

                <!-- User Role List -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-shield-check me-2"></i>User Role List</span>
                        <a href="UserRoleServlet?action=list" class="btn btn-primary">
                            <i class="bi bi-arrow-clockwise me-2"></i>Refresh
                        </a>
                    </h3>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Role Name</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<UserRole> userRoles = (List<UserRole>) request.getAttribute("userRoles");
                                    if (userRoles != null && !userRoles.isEmpty()) {
                                        for (UserRole userRole : userRoles) {
                                %>
                                <tr>
                                    <td><%= userRole.getRoleId() %></td>
                                    <td><span class="badge bg-primary"><%= userRole.getRoleName() %></span></td>
                                    <td>
                                        <button class="btn btn-edit btn-sm" onclick="editRole(<%= userRole.getRoleId() %>, '<%= userRole.getRoleName() %>')" title="Edit Role">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                                                                 <% if (userRole.getRoleId() > 4) { %>
                                         <button class="btn btn-delete btn-sm" onclick="deleteRole(<%= userRole.getRoleId() %>)" title="Delete Role">
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
                                    <td colspan="3" class="text-center">No user roles found.</td>
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

            // User role management functions
            function editRole(roleId, roleName) {
                // Redirect to the edit page with role information
                window.location.href = 'user_role_edit.jsp?role_id=' + roleId + '&role_name=' + encodeURIComponent(roleName);
            }

            function deleteRole(roleId) {
                if (confirm('Are you sure you want to delete this role?')) {
                    window.location.href = 'UserRoleServlet?action=delete&role_id=' + roleId;
                }
            }
        </script>
    </body>
</html> 
