<%-- 
    Document   : user
    Created on : Aug 3, 2025, 9:07:20 AM
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
        <title>Pahana - User Management</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        
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

            
            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.8);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            .loading-content {
                text-align: center;
                background: rgba(42, 82, 152, 0.9);
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                max-width: 400px;
                width: 90%;
            }

            .loading-content .spinner-border {
                width: 3rem;
                height: 3rem;
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
        
        <div id="loadingOverlay" class="loading-overlay" style="display: none;">
            <div class="loading-content">
                <div class="spinner-border text-primary mb-3" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <h5 class="text-white mb-2">Creating User Account</h5>
                <p class="text-white-50 mb-0">Please wait while we set up your account and send welcome email...</p>
            </div>
        </div>
        <%
            
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            
            if (username == null || role == null) {
                response.sendRedirect("login.jsp?error=Please login first.");
                return;
            }
            
            
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied.");
                return;
            }
        %>

        <%
            
            request.setAttribute("currentPage", "user");
        %>

        <div class="main-container">
            
            <jsp:include page="includes/sidebar.jsp" />

            
            <div class="main-content">
                
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

                
                <% if (!"CASHIER".equals(role)) { %>
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-person-plus me-2"></i>Add New User</span>
                    </h3>
                    
                    <form action="UserServlet" method="post" id="addUserForm">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="username" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" required onblur="checkUsernameOnBlur(this.value)">
                                    <div id="usernameWarning" class="text-danger mt-1" style="display: none;">
                                        <i class="bi bi-exclamation-triangle me-1"></i>
                                        <small>This username is already taken. Please choose a different one.</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="email" class="form-label">Email Address</label>
                                    <div class="input-group">
                                        <input type="email" class="form-control" id="email" name="email" required>
                                        <button class="btn btn-outline-primary" type="button" id="sendVerificationBtn" onclick="sendVerificationCode()">
                                            <i class="bi bi-envelope"></i>
                                        </button>
                                    </div>
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
                                        
                                        <%
                                            List<UserRole> userRoles = (List<UserRole>) request.getAttribute("userRoles");
                                            if (userRoles != null) {
                                                for (UserRole userRole : userRoles) {
                                                    
                                                    boolean canCreate = false;
                                                    if ("ADMIN".equals(role)) {
                                                        
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
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="verificationPin" class="form-label">Verification Pin</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="verificationPin" name="verificationPin" placeholder="Enter 6-digit code" maxlength="6" disabled>
                                        <button class="btn btn-outline-success" type="button" id="verifyPinBtn" onclick="verifyPin()" disabled>
                                            <i class="bi bi-check-circle"></i>
                                        </button>
                                    </div>
                                    <small class="form-text text-muted">Click the envelope button next to email to receive verification code</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Email Status</label>
                                    <div class="d-flex align-items-center">
                                        <span id="emailStatus" class="badge bg-secondary">Not Verified</span>
                                        <div id="verificationSpinner" class="spinner-border spinner-border-sm ms-2" style="display: none;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="text-end">
                            <button type="submit" class="btn btn-primary" id="addUserBtn">
                                <i class="bi bi-plus-circle me-2"></i>Add User
                            </button>
                        </div>
                    </form>
                </div>
                <% } %>

                
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
                        
                        if (request.getAttribute("users") == null) {
                            
                    %>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle me-2"></i>
                        Click the "Refresh" button to load the user list.
                    </div>
                    <%
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

        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>

            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.toggle('show');
            }


            document.addEventListener('click', function(event) {
                const sidebar = document.getElementById('sidebar');
                const menuToggle = document.querySelector('.menu-toggle');
                
                if (window.innerWidth <= 768) {
                    if (!sidebar.contains(event.target) && !menuToggle.contains(event.target)) {
                        sidebar.classList.remove('show');
                    }
                }
            });


            function editUser(userId) {

                window.location.href = 'UserServlet?action=view&user_id=' + userId;
            }

            function deleteUser(userId) {

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

                                    showAlert(response.message, 'success');

                                    setTimeout(() => {
                                        window.location.reload();
                                    }, 1500);
                                } else {

                                    showAlert(response.message, 'error');
                                }
                            } catch (e) {

                                showAlert('User deleted successfully!', 'success');
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1500);
                            }
                        } else {

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
                

                setTimeout(() => {
                    if (alertDiv.parentNode) {
                        alertDiv.remove();
                    }
                }, 3000);
            }
            

            let emailVerified = false;
            
            function sendVerificationCode() {
                const email = document.getElementById('email').value.trim();
                if (!email) {
                    showAlert('Please enter an email address first.', 'error');
                    return;
                }
                

                document.getElementById('verificationSpinner').style.display = 'inline-block';
                document.getElementById('sendVerificationBtn').disabled = true;
                document.getElementById('emailStatus').textContent = 'Checking email...';
                document.getElementById('emailStatus').className = 'badge bg-warning';
                

                const checkEmailXhr = new XMLHttpRequest();
                checkEmailXhr.open('POST', 'CustomerServlet?action=check-email-exists', true);
                checkEmailXhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                checkEmailXhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                checkEmailXhr.onreadystatechange = function() {
                    if (checkEmailXhr.readyState === 4) {
                        if (checkEmailXhr.status === 200) {
                            try {
                                const response = JSON.parse(checkEmailXhr.responseText);
                                if (response.status === 'success' && response.exists) {

                                    document.getElementById('verificationSpinner').style.display = 'none';
                                    document.getElementById('sendVerificationBtn').disabled = false;
                                    document.getElementById('emailStatus').textContent = 'Email Exists';
                                    document.getElementById('emailStatus').className = 'badge bg-danger';
                                    showAlert('This email address is already registered in our system. Please use a different email address.', 'error');
                                    return;
                                } else {

                                    sendVerificationEmail(email);
                                }
                            } catch (e) {
                                console.log('Error parsing email check response:', e);

                                sendVerificationEmail(email);
                            }
                        } else {

                            sendVerificationEmail(email);
                        }
                    }
                };
                
                checkEmailXhr.onerror = function() {

                    sendVerificationEmail(email);
                };
                
                checkEmailXhr.send('email=' + encodeURIComponent(email));
            }
            
            function sendVerificationEmail(email) {

                document.getElementById('verificationSpinner').style.display = 'inline-block';
                document.getElementById('sendVerificationBtn').disabled = true;
                document.getElementById('emailStatus').textContent = 'Sending...';
                document.getElementById('emailStatus').className = 'badge bg-warning';
                

                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'UserServlet?action=send-verification', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        document.getElementById('verificationSpinner').style.display = 'none';
                        document.getElementById('sendVerificationBtn').disabled = false;
                        
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.status === 'success') {
                                    showAlert(response.message, 'success');
                                    document.getElementById('emailStatus').textContent = 'Code Sent';
                                    document.getElementById('emailStatus').className = 'badge bg-info';
                                    

                                    document.getElementById('verificationPin').disabled = false;
                                    document.getElementById('verifyPinBtn').disabled = false;
                                    document.getElementById('verificationPin').focus();
                                } else {
                                    showAlert(response.message, 'error');
                                    document.getElementById('emailStatus').textContent = 'Failed';
                                    document.getElementById('emailStatus').className = 'badge bg-danger';
                                }
                            } catch (e) {
                                showAlert('Verification code sent successfully!', 'success');
                                document.getElementById('emailStatus').textContent = 'Code Sent';
                                document.getElementById('emailStatus').className = 'badge bg-info';
                                

                                document.getElementById('verificationPin').disabled = false;
                                document.getElementById('verifyPinBtn').disabled = false;
                                document.getElementById('verificationPin').focus();
                            }
                        } else {
                            showAlert('Failed to send verification code. Please try again.', 'error');
                            document.getElementById('emailStatus').textContent = 'Failed';
                            document.getElementById('emailStatus').className = 'badge bg-danger';
                        }
                    }
                };
                
                xhr.onerror = function() {
                    document.getElementById('verificationSpinner').style.display = 'none';
                    document.getElementById('sendVerificationBtn').disabled = false;
                    showAlert('Network error occurred. Please try again.', 'error');
                    document.getElementById('emailStatus').textContent = 'Failed';
                    document.getElementById('emailStatus').className = 'badge bg-danger';
                };
                
                xhr.send('email=' + encodeURIComponent(email));
            }
            
            function verifyPin() {
                const email = document.getElementById('email').value.trim();
                const pin = document.getElementById('verificationPin').value.trim();
                
                if (!pin) {
                    showAlert('Please enter the verification code.', 'error');
                    return;
                }
                

                document.getElementById('verificationSpinner').style.display = 'inline-block';
                document.getElementById('verifyPinBtn').disabled = true;
                document.getElementById('emailStatus').textContent = 'Verifying...';
                document.getElementById('emailStatus').className = 'badge bg-warning';
                

                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'UserServlet?action=verify-email', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        document.getElementById('verificationSpinner').style.display = 'none';
                        document.getElementById('verifyPinBtn').disabled = false;
                        
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.status === 'success') {
                                    showAlert(response.message, 'success');
                                    document.getElementById('emailStatus').textContent = 'Verified';
                                    document.getElementById('emailStatus').className = 'badge bg-success';
                                    emailVerified = true;
                                    

                                    document.getElementById('verificationPin').disabled = true;
                                    document.getElementById('verifyPinBtn').disabled = true;
                                    document.getElementById('sendVerificationBtn').disabled = true;
                                    

                                    document.getElementById('addUserBtn').disabled = false;
                                } else {
                                    showAlert(response.message, 'error');
                                    document.getElementById('emailStatus').textContent = 'Invalid Code';
                                    document.getElementById('emailStatus').className = 'badge bg-danger';
                                }
                            } catch (e) {
                                showAlert('Email verified successfully!', 'success');
                                document.getElementById('emailStatus').textContent = 'Verified';
                                document.getElementById('emailStatus').className = 'badge bg-success';
                                emailVerified = true;
                                

                                document.getElementById('verificationPin').disabled = true;
                                document.getElementById('verifyPinBtn').disabled = true;
                                document.getElementById('sendVerificationBtn').disabled = true;
                                

                                document.getElementById('addUserBtn').disabled = false;
                            }
                        } else {
                            showAlert('Failed to verify code. Please try again.', 'error');
                            document.getElementById('emailStatus').textContent = 'Failed';
                            document.getElementById('emailStatus').className = 'badge bg-danger';
                        }
                    }
                };
                
                xhr.send('email=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(pin));
            }
            

            document.addEventListener('DOMContentLoaded', function() {
                const addUserBtn = document.getElementById('addUserBtn');
                if (addUserBtn) {
                    addUserBtn.disabled = true;
                    addUserBtn.title = 'Please verify your email first';
                }
                

                const form = document.getElementById('addUserForm');
                if (form) {
                    form.addEventListener('submit', function(e) {
                        if (!emailVerified) {
                            e.preventDefault();
                            showAlert('Please verify your email address before adding the user.', 'error');
                            return false;
                        }
                        

                        const username = document.getElementById('username').value.trim();
                        if (username) {
                            checkUsernameExists(username, function(exists) {
                                if (exists) {
                                    e.preventDefault();
                                    showAlert('This username is already taken. Please choose a different username.', 'error');
                                    return false;
                                } else {

                                    showLoadingScreen();

                                    setTimeout(() => {
                                        form.submit();
                                    }, 500);
                                }
                            });
                            e.preventDefault(); 
                            return false;
                        }
                        

                        showLoadingScreen();
                    });
                }
            });
            

            function showLoadingScreen() {
                const loadingOverlay = document.getElementById('loadingOverlay');
                const addUserBtn = document.getElementById('addUserBtn');
                const form = document.getElementById('addUserForm');
                
                if (loadingOverlay) {
                    loadingOverlay.style.display = 'flex';
                }
                

                if (form) {
                    form.style.pointerEvents = 'none';
                }
                
                if (addUserBtn) {
                    addUserBtn.disabled = true;
                    addUserBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Creating User...';
                }
                

                showAlert('Creating user account... Please wait.', 'info');
            }
            

            function hideLoadingScreen() {
                const loadingOverlay = document.getElementById('loadingOverlay');
                const addUserBtn = document.getElementById('addUserBtn');
                const form = document.getElementById('addUserForm');
                
                if (loadingOverlay) {
                    loadingOverlay.style.display = 'none';
                }
                
                if (form) {
                    form.style.pointerEvents = 'auto';
                }
                
                if (addUserBtn) {
                    addUserBtn.disabled = false;
                    addUserBtn.innerHTML = 'Add User';
                }
            }
            

            function checkUsernameExists(username, callback) {
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'UserServlet?action=check-username-exists', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.status === 'success') {
                                    callback(response.exists);
                                } else {
                                    callback(false); 
                                }
                            } catch (e) {
                                callback(false); 
                            }
                        } else {
                            callback(false); 
                        }
                    }
                };
                
                xhr.onerror = function() {
                    callback(false); 
                };
                
                xhr.send('username=' + encodeURIComponent(username));
            }

            function checkUsernameOnBlur(username) {
                if (username) {
                    checkUsernameExists(username, function(exists) {
                        const usernameWarning = document.getElementById('usernameWarning');
                        if (exists) {
                            usernameWarning.style.display = 'block';
                        } else {
                            usernameWarning.style.display = 'none';
                        }
                    });
                }
            }

        </script>
    </body>
</html> 
