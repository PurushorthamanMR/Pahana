<%-- 
    Document   : profile
    Created on : Aug 3, 2025, 9:10:11 AM
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
        <title>Pahana - Profile</title>
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

            /* Content Card Styles */
            .content-card {
                background: white;
                border-radius: 12px;
                padding: 2rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
            }

            .card-title {
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 1.5rem;
                font-weight: 600;
                color: #333;
                margin-bottom: 2rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid #f1f3f4;
            }

            .profile-avatar {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto 2rem;
                font-size: 3rem;
                color: white;
            }

            .form-label {
                font-weight: 600;
                color: #495057;
                margin-bottom: 0.5rem;
            }

            .form-control-plaintext {
                padding: 0.5rem 0;
                color: #333;
                font-weight: 500;
                border-bottom: 1px solid #e9ecef;
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

                .card-title {
                    flex-direction: column;
                    gap: 1rem;
                    align-items: flex-start;
                }
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

            /* Profile Styles */
            .profile-avatar {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 3rem;
                font-weight: 600;
                margin: 0 auto 2rem;
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
            
            // Get user data based on user type
            String userType = (String) session.getAttribute("userType");
            User user = null;
            com.booking.models.Customer customer = null;
            
            if ("user".equals(userType)) {
                user = (User) session.getAttribute("user");
            } else if ("customer".equals(userType)) {
                customer = (com.booking.models.Customer) session.getAttribute("user");
            }
        %>

        <%
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "profile");
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
                        <h1 class="h3 mb-0">Profile</h1>
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

                <!-- Profile Content -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-person-circle me-2"></i>Login ID Details</span>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                            <i class="bi bi-pencil me-2"></i>Update Profile
                        </button>
                    </h3>
                    
                    <div class="text-center mb-4">
                        <div class="profile-avatar">
                            <i class="bi bi-person"></i>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Login ID (Username)</label>
                                <p class="form-control-plaintext"><%= username %></p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">User Role</label>
                                <p class="form-control-plaintext"><%= role %></p>
                            </div>
                        </div>
                    </div>
                    
                    <% if (user != null) { %>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">User ID</label>
                                <p class="form-control-plaintext"><%= user.getUserId() %></p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Email Address</label>
                                <p class="form-control-plaintext"><%= user.getEmail() != null ? user.getEmail() : "Not provided" %></p>
                            </div>
                        </div>
                    </div>
                    <% } else if (customer != null) { %>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Customer ID</label>
                                <p class="form-control-plaintext"><%= customer.getCustomerId() %></p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Full Name</label>
                                <p class="form-control-plaintext"><%= customer.getName() != null ? customer.getName() : "Not provided" %></p>
                            </div>
                        </div>
                    </div>
                    <% } %>
                    

                </div>

                <!-- Edit Profile Modal -->
                <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editProfileModalLabel">
                                    <i class="bi bi-pencil me-2"></i>Update Profile
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="ProfileServlet" method="post">
                                <input type="hidden" name="action" value="update">
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="currentPassword" class="form-label">Current Password *</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('currentPassword')">
                                                <i class="bi bi-eye" id="currentPasswordIcon"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label">New Password</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="newPassword" name="newPassword" 
                                                   placeholder="Leave blank to keep current password">
                                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('newPassword')">
                                                <i class="bi bi-eye" id="newPasswordIcon"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                        <div class="input-group">
                                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                                                   placeholder="Leave blank to keep current password">
                                            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword')">
                                                <i class="bi bi-eye" id="confirmPasswordIcon"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <% if (user != null) { %>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" 
                                               value="<%= user.getEmail() != null ? user.getEmail() : "" %>">
                                    </div>
                                    <% } else if (customer != null) { %>
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Name</label>
                                        <input type="text" class="form-control" id="name" name="name" 
                                               value="<%= customer.getName() != null ? customer.getName() : "" %>">
                                    </div>
                                    <% } %>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-check-circle me-2"></i>Update Profile
                                    </button>
                                </div>
                            </form>
                        </div>
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

            // Toggle password visibility
            function togglePassword(inputId) {
                const input = document.getElementById(inputId);
                const icon = document.getElementById(inputId + 'Icon');
                
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                } else {
                    input.type = 'password';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                }
            }
        </script>
    </body>
</html> 
