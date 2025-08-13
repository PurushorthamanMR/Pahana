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
        <title>Pahana - Edit User</title>
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

            /* Main Content Styles */
            .main-content {
                flex: 1;
                margin-left: 260px;
                padding: 1.5rem;
                background-color: #f8f9fa;
                min-height: 100vh;
            }

            .content-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                padding-bottom: 0.8rem;
                border-bottom: 2px solid #e9ecef;
            }

            .content-title {
                font-size: 1.6rem;
                font-weight: 700;
                color: #333;
                margin: 0;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 0.8rem;
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

            .user-details {
                text-align: right;
            }

            .user-name {
                font-weight: 600;
                color: #333;
                margin: 0;
                font-size: 0.9rem;
            }

            .user-role {
                font-size: 0.8rem;
                color: #6c757d;
                margin: 0;
            }

            /* Card Styles */
            .content-card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
                padding: 1.5rem;
                margin-bottom: 1.5rem;
            }

            .card-title {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.25rem;
                padding-bottom: 0.8rem;
                border-bottom: 1px solid #e9ecef;
                font-size: 1.3rem;
                font-weight: 600;
                color: #333;
            }

            /* Form Styles */
            .form-group {
                margin-bottom: 1.25rem;
            }

            .form-label {
                font-weight: 600;
                color: #333;
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
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            /* Button Styles */
            .btn {
                padding: 0.6rem 1.25rem;
                border-radius: 5px;
                font-weight: 500;
                transition: all 0.3s ease;
                border: none;
                cursor: pointer;
                font-size: 0.85rem;
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
                    gap: 0.8rem;
                    align-items: flex-start;
                }

                .user-info {
                    align-self: flex-end;
                }
            }
            
            /* Email verification styles */
            #emailVerificationSection {
                margin-top: 8px;
                padding: 12px;
                border: 1px solid #dee2e6;
                border-radius: 5px;
                background-color: #f8f9fa;
            }
            
            #verificationPin {
                max-width: 180px;
            }
            
            .badge {
                font-size: 0.7em;
                padding: 0.4em 0.6em;
            }
            
            /* Loading overlay styles */
            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.7);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }
            
            .loading-content {
                background: white;
                padding: 1.5rem;
                border-radius: 8px;
                text-align: center;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.3);
                max-width: 350px;
                width: 90%;
            }
            
            .loading-content .spinner-border {
                width: 2.5rem;
                height: 2.5rem;
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
                    padding: 1.25rem;
                    margin-bottom: 1.25rem;
                }
                
                .card-title {
                    font-size: 1.2rem;
                    margin-bottom: 1rem;
                    padding-bottom: 0.6rem;
                }
                
                .content-header {
                    margin-bottom: 1.25rem;
                    padding-bottom: 0.6rem;
                }
                
                .content-title {
                    font-size: 1.4rem;
                }
                
                .form-group {
                    margin-bottom: 1rem;
                }
                
                .form-control {
                    padding: 0.5rem;
                    font-size: 0.85rem;
                }
                
                .btn {
                    padding: 0.5rem 1rem;
                    font-size: 0.8rem;
                }
                
                .loading-content {
                    padding: 1.25rem;
                    max-width: 300px;
                }
                
                .loading-content .spinner-border {
                    width: 2rem;
                    height: 2rem;
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
                        <i class="bi bi-book"></i> Pahana
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
                    
                    <form id="userEditForm">
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
                                    <div class="input-group">
                                        <input type="email" class="form-control" id="userEmail" name="email" 
                                               value="<%= userToEdit.getEmail() %>" onchange="checkEmailChanged()" required>
                                        <button type="button" class="btn btn-outline-primary" id="sendVerificationBtn" onclick="sendVerificationCode()" style="display: none;">
                                            <i class="bi bi-envelope"></i>
                                        </button>
                                    </div>
                                    <div id="emailVerificationSection" style="display: none;">
                                        <div class="input-group mt-2">
                                            <input type="text" class="form-control" id="verificationPin" placeholder="Enter 6-digit verification code" maxlength="6">
                                            <button type="button" class="btn btn-outline-success" id="verifyPinBtn" onclick="verifyPin()">
                                                <i class="bi bi-check-circle"></i> Verify
                                            </button>
                                        </div>
                                        <div class="mt-2">
                                            <span id="emailStatus" class="badge bg-secondary">Pending Verification</span>
                                            <span id="verificationSpinner" class="spinner-border spinner-border-sm ms-2" style="display: none;"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           placeholder="Leave blank to keep current password">
                                    <small class="form-text text-muted">Leave blank to keep the current password. If changed, the new password will be sent to the user's email.</small>
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
                            <a href="UserServlet?action=list" class="btn btn-secondary me-2">
                                <i class="bi bi-arrow-left me-2"></i>Back to Users
                            </a>
                            <button type="submit" class="btn btn-primary" id="updateUserBtn">
                                <i class="bi bi-check-circle me-2"></i>Update User
                            </button>
                        </div>
                    </form>
                    
                    <!-- Loading Overlay -->
                    <div id="loadingOverlay" class="loading-overlay" style="display: none;">
                        <div class="loading-content">
                            <div class="spinner-border text-primary mb-3" role="status">
                                <span class="visually-hidden">Loading...</span>
                            </div>
                            <h5 class="text-primary mb-2">Updating User...</h5>
                            <p class="text-muted mb-0" id="loadingMessage">Please wait while we update the user information.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            let emailVerified = false;
            let originalEmail = '<%= userToEdit != null && userToEdit.getEmail() != null ? userToEdit.getEmail() : "" %>';
            
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
            
            function checkEmailChanged() {
                const emailInput = document.getElementById('userEmail');
                const sendVerificationBtn = document.getElementById('sendVerificationBtn');
                const emailVerificationSection = document.getElementById('emailVerificationSection');
                const emailStatus = document.getElementById('emailStatus');
                
                const currentEmail = emailInput.value.trim();
                
                if (currentEmail !== originalEmail && currentEmail !== '') {
                    // Email has changed, show verification button
                    sendVerificationBtn.style.display = 'inline-block';
                    emailVerificationSection.style.display = 'block';
                    emailStatus.textContent = 'Email Changed - Verification Required';
                    emailStatus.className = 'badge bg-warning';
                    emailVerified = false;
                    showSuccessMessage('Email changed. Please verify the new email address.');
                } else if (currentEmail === originalEmail) {
                    // Email is back to original, hide verification
                    sendVerificationBtn.style.display = 'none';
                    emailVerificationSection.style.display = 'none';
                    emailStatus.textContent = 'Pending Verification';
                    emailStatus.className = 'badge bg-secondary';
                    emailVerified = false;
                }
            }
            
            function sendVerificationCode() {
                const email = document.getElementById('userEmail').value.trim();
                if (!email) {
                    showErrorMessage('Please enter an email address first.');
                    return;
                }
                
                document.getElementById('verificationSpinner').style.display = 'inline-block';
                document.getElementById('sendVerificationBtn').disabled = true;
                document.getElementById('emailStatus').textContent = 'Sending...';
                document.getElementById('emailStatus').className = 'badge bg-info';
                
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
                                    document.getElementById('emailStatus').textContent = 'Code Sent';
                                    document.getElementById('emailStatus').className = 'badge bg-info';
                                    document.getElementById('verificationPin').focus();
                                } else {
                                    document.getElementById('emailStatus').textContent = 'Failed';
                                    document.getElementById('emailStatus').className = 'badge bg-danger';
                                    showErrorMessage(response.message);
                                }
                            } catch (e) {
                                document.getElementById('emailStatus').textContent = 'Code Sent';
                                document.getElementById('emailStatus').className = 'badge bg-info';
                                document.getElementById('verificationPin').focus();
                            }
                        } else {
                            document.getElementById('emailStatus').textContent = 'Failed';
                            document.getElementById('emailStatus').className = 'badge bg-danger';
                            showErrorMessage('Failed to send verification code. Please try again.');
                        }
                    }
                };
                
                xhr.onerror = function() {
                    document.getElementById('verificationSpinner').style.display = 'none';
                    document.getElementById('sendVerificationBtn').disabled = false;
                    document.getElementById('emailStatus').textContent = 'Failed';
                    document.getElementById('emailStatus').className = 'badge bg-danger';
                    showErrorMessage('Network error occurred. Please try again.');
                };
                
                xhr.send('email=' + encodeURIComponent(email) + '&context=email-change');
            }
            
            function verifyPin() {
                const email = document.getElementById('userEmail').value.trim();
                const pin = document.getElementById('verificationPin').value.trim();
                
                if (!email || !pin) {
                    showErrorMessage('Please enter both email and verification code.');
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
                                    document.getElementById('emailStatus').textContent = 'Verified';
                                    document.getElementById('emailStatus').className = 'badge bg-success';
                                    emailVerified = true;
                                    showSuccessMessage('Email verified successfully! You can now update the user.');
                                } else {
                                    document.getElementById('emailStatus').textContent = 'Invalid Code';
                                    document.getElementById('emailStatus').className = 'badge bg-danger';
                                    showErrorMessage(response.message);
                                }
                            } catch (e) {
                                document.getElementById('emailStatus').textContent = 'Verified';
                                document.getElementById('emailStatus').className = 'badge bg-success';
                                emailVerified = true;
                                showSuccessMessage('Email verified successfully! You can now update the user.');
                            }
                        } else {
                            document.getElementById('emailStatus').textContent = 'Failed';
                            document.getElementById('emailStatus').className = 'badge bg-danger';
                            showErrorMessage('Failed to verify code. Please try again.');
                        }
                    }
                };
                
                xhr.onerror = function() {
                    document.getElementById('verificationSpinner').style.display = 'none';
                    document.getElementById('verifyPinBtn').disabled = false;
                    document.getElementById('emailStatus').textContent = 'Failed';
                    document.getElementById('emailStatus').className = 'badge bg-danger';
                    showErrorMessage('Network error occurred. Please try again.');
                };
                
                xhr.send('email=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(pin));
            }
            
            // Form validation and submission
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.getElementById('userEditForm');
                if (form) {
                    form.addEventListener('submit', function(e) {
                        e.preventDefault();
                        
                        const username = document.querySelector('input[name="username"]').value.trim();
                        const email = document.getElementById('userEmail').value.trim();
                        const roleId = document.querySelector('select[name="role_id"]').value;
                        
                        if (!username) {
                            showErrorMessage('Username is required.');
                            return false;
                        }
                        
                        if (!email) {
                            showErrorMessage('Email is required.');
                            return false;
                        }
                        
                        if (!roleId) {
                            showErrorMessage('User role is required.');
                            return false;
                        }
                        
                        // Check if email has changed and requires verification
                        if (email !== originalEmail && !emailVerified) {
                            showErrorMessage('Please verify the new email address before updating the user.');
                            return false;
                        }
                        
                        // If email verification is not required or is completed, submit via AJAX
                        submitUserUpdate();
                    });
                }
            });
            
            function submitUserUpdate() {
                console.log('=== SUBMIT USER UPDATE DEBUG ===');
                
                const formData = new FormData(document.getElementById('userEditForm'));
                const userId = formData.get('user_id');
                const username = formData.get('username');
                const email = formData.get('email');
                const password = formData.get('password');
                const roleId = formData.get('role_id');
                
                console.log('Form data collected:');
                console.log('User ID:', userId);
                console.log('Username:', username);
                console.log('Email:', email);
                console.log('Password length:', password ? password.length : 0);
                console.log('Role ID:', roleId);
                
                // Show loading overlay with appropriate message
                if (password && password.trim() !== '') {
                    showLoadingOverlay('Updating user information and sending new password to email...');
                } else {
                    showLoadingOverlay('Updating user information...');
                }
                
                // Create the request data
                const data = 'user_id=' + encodeURIComponent(userId) +
                           '&username=' + encodeURIComponent(username) +
                           '&email=' + encodeURIComponent(email) +
                           '&password=' + encodeURIComponent(password || '') +
                           '&role_id=' + encodeURIComponent(roleId);
                
                console.log('Request data:', data);
                console.log('Sending to: UserServlet?action=update');
                
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'UserServlet?action=update', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    console.log('AJAX response state:', xhr.readyState, 'Status:', xhr.status);
                    
                    if (xhr.readyState === 4) {
                        console.log('Response received:');
                        console.log('Status:', xhr.status);
                        console.log('Response text:', xhr.responseText);
                        
                        // Hide loading overlay
                        hideLoadingOverlay();
                        
                        if (xhr.status === 200) {
                            console.log('Success response received');
                            // Show success message on the same page
                            showSuccessMessage('User updated successfully!');
                            
                            // Reset email verification status
                            emailVerified = false;
                            originalEmail = document.getElementById('userEmail').value.trim();
                            
                            // Hide verification section
                            document.getElementById('emailVerificationSection').style.display = 'none';
                            document.getElementById('sendVerificationBtn').style.display = 'none';
                        } else {
                            console.log('Error response received');
                            showErrorMessage('Failed to update user. Please try again.');
                        }
                    }
                };
                
                xhr.onerror = function() {
                    console.log('AJAX network error occurred');
                    hideLoadingOverlay();
                    showErrorMessage('Network error occurred. Please try again.');
                };
                
                xhr.send(data);
            }
            
            function showSuccessMessage(message) {
                // Remove any existing messages
                removeMessages();
                
                // Create success message
                const successDiv = document.createElement('div');
                successDiv.className = 'alert alert-success alert-dismissible fade show';
                successDiv.innerHTML = '<i class="bi bi-check-circle"></i> ' + message + 
                    '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>';
                
                // Insert at the top of the content card
                const contentCard = document.querySelector('.content-card');
                contentCard.insertBefore(successDiv, contentCard.firstChild);
                
                // Auto-hide after 5 seconds
                setTimeout(() => {
                    if (successDiv.parentNode) {
                        successDiv.remove();
                    }
                }, 5000);
            }
            
            function showErrorMessage(message) {
                // Remove any existing messages
                removeMessages();
                
                // Create error message
                const errorDiv = document.createElement('div');
                errorDiv.className = 'alert alert-danger alert-dismissible fade show';
                errorDiv.innerHTML = '<i class="bi bi-exclamation-triangle"></i> ' + message + 
                    '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>';
                
                // Insert at the top of the content card
                contentCard.insertBefore(errorDiv, contentCard.firstChild);
                
                // Auto-hide after 5 seconds
                setTimeout(() => {
                    if (errorDiv.parentNode) {
                        errorDiv.remove();
                    }
                }, 5000);
            }
            
            function removeMessages() {
                // Remove any existing alert messages
                const existingAlerts = document.querySelectorAll('.alert');
                existingAlerts.forEach(alert => alert.remove());
            }
            
            function showLoadingOverlay(message) {
                const overlay = document.getElementById('loadingOverlay');
                const loadingMessage = document.getElementById('loadingMessage');
                
                if (loadingMessage) {
                    loadingMessage.textContent = message || 'Please wait while we update the user information.';
                }
                
                overlay.style.display = 'flex';
                
                // Disable the update button
                const updateBtn = document.getElementById('updateUserBtn');
                if (updateBtn) {
                    updateBtn.disabled = true;
                }
            }
            
            function hideLoadingOverlay() {
                const overlay = document.getElementById('loadingOverlay');
                overlay.style.display = 'none';
                
                // Re-enable the update button
                const updateBtn = document.getElementById('updateUserBtn');
                if (updateBtn) {
                    updateBtn.disabled = false;
                }
            }
            
            function updateLoadingMessage(message) {
                const loadingMessage = document.getElementById('loadingMessage');
                if (loadingMessage) {
                    loadingMessage.textContent = message;
                }
            }
        </script>
    </body>
</html> 
