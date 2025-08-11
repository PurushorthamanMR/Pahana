<%-- 
    Document   : customer_edit
    Created on : Aug 3, 2025, 9:08:14 AM
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
        <title>Pahana - Edit Customer</title>
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
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
                outline: none;
            }

            .form-control.is-invalid {
                border-color: #dc3545;
            }

            .invalid-feedback {
                display: block;
                width: 100%;
                margin-top: 0.25rem;
                font-size: 0.875em;
                color: #dc3545;
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
            
            /* Email verification styles */
            #emailVerificationSection {
                margin-top: 10px;
                padding: 15px;
                border: 1px solid #dee2e6;
                border-radius: 6px;
                background-color: #f8f9fa;
            }
            
            #verificationPin {
                max-width: 200px;
            }
            
            .badge {
                font-size: 0.75em;
                padding: 0.5em 0.75em;
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
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "customer");
            
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = null;
            String errorMessage = "";
            String successMessage = "";
            
            // Handle form submission
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                try {
                    int customerId = Integer.parseInt(request.getParameter("customerId"));
                    String name = request.getParameter("name");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");
                    String customerUsername = request.getParameter("username");
                    String email = request.getParameter("email");
                    
                    // Validation
                    if (name == null || name.trim().isEmpty()) {
                        errorMessage = "Customer name is required";
                    } else if (phone == null || phone.trim().isEmpty()) {
                        errorMessage = "Phone number is required";
                    } else {
                        // Get existing customer
                        customer = customerDAO.getCustomerById(customerId);
                        if (customer != null) {
                            // Update customer details
                            customer.setName(name.trim());
                            customer.setPhone(phone.trim());
                            customer.setAddress(address != null ? address.trim() : "");
                            customer.setUsername(customerUsername != null ? customerUsername.trim() : "");
                            customer.setEmail(email != null ? email.trim() : "");
                            
                            if (customerDAO.updateCustomer(customer)) {
                                successMessage = "Customer updated successfully!";
                            } else {
                                errorMessage = "Failed to update customer";
                            }
                        } else {
                            errorMessage = "Customer not found";
                        }
                    }
                } catch (NumberFormatException e) {
                    errorMessage = "Invalid customer ID";
                } catch (Exception e) {
                    errorMessage = "Error updating customer: " + e.getMessage();
                }
            }
            
            // Load customer data for editing
            if (customer == null) {
                try {
                    String customerIdParam = request.getParameter("customer_id");
                    if (customerIdParam == null) {
                        customerIdParam = request.getParameter("id");
                    }
                    
                    if (customerIdParam != null) {
                        int customerId = Integer.parseInt(customerIdParam);
                        customer = customerDAO.getCustomerById(customerId);
                        
                        if (customer == null) {
                            errorMessage = "Customer not found with ID: " + customerId;
                        }
                    } else {
                        errorMessage = "No customer ID provided";
                    }
                } catch (NumberFormatException e) {
                    errorMessage = "Invalid customer ID provided";
                } catch (Exception e) {
                    errorMessage = "Error retrieving customer: " + e.getMessage();
                }
            }
        %>

        <div class="main-container">
            <!-- Sidebar -->
            <jsp:include page="includes/sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <div class="header">
                    <div class="header-left">
                        <button class="menu-toggle" onclick="toggleSidebar()">
                            <i class="bi bi-list"></i>
                        </button>
                        <h1>Edit Customer</h1>
                    </div>
                    <div class="user-info">
                        <span>Welcome, <%= username %> (<%= role %>)</span>
                        <div class="user-avatar">
                            <i class="bi bi-person"></i>
                        </div>
                    </div>
                </div>

                <div class="content-card">
                    <div class="card-title">
                        <span>Edit Customer Details</span>
                        <div>
                            <a href="customer.jsp" class="btn btn-secondary me-2">
                                <i class="bi bi-arrow-left"></i> Back to List
                            </a>
                        </div>
                    </div>

                    <% if (!errorMessage.isEmpty()) { %>
                        <div class="alert alert-danger">
                            <i class="bi bi-exclamation-triangle"></i> <%= errorMessage %>
                        </div>
                    <% } %>

                    <% if (!successMessage.isEmpty()) { %>
                        <div class="alert alert-success">
                            <i class="bi bi-check-circle"></i> <%= successMessage %>
                        </div>
                    <% } %>

                    <% if (customer != null) { %>
                        <form id="customerEditForm">
                            <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
                            
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
                                        <label class="form-label">Customer Name *</label>
                                        <input type="text" class="form-control" name="name" value="<%= customer.getName() != null ? customer.getName() : "" %>" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Phone Number *</label>
                                        <input type="text" class="form-control" name="phone" value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>" required>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Username</label>
                                        <input type="text" class="form-control" name="username" value="<%= customer.getUsername() != null ? customer.getUsername() : "" %>">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label">Email</label>
                                        <div class="input-group">
                                            <input type="email" class="form-control" id="customerEmail" name="email" value="<%= customer.getEmail() != null ? customer.getEmail() : "" %>" onchange="checkEmailChanged()">
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
                                <div class="col-12">
                                    <div class="form-group">
                                        <label class="form-label">Address</label>
                                        <textarea class="form-control" name="address" rows="3"><%= customer.getAddress() != null ? customer.getAddress() : "" %></textarea>
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

                            <div class="row">
                                <div class="col-12">
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-check-circle"></i> Update Customer
                                        </button>
                                        <a href="customer_view.jsp?customer_id=<%= customer.getCustomerId() %>" class="btn btn-secondary ms-2">
                                            <i class="bi bi-eye"></i> View Customer
                                        </a>
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
            let emailVerified = false;
            let originalEmail = '<%= customer != null && customer.getEmail() != null ? customer.getEmail() : "" %>';
            
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.toggle('show');
            }
            
            function checkEmailChanged() {
                const emailInput = document.getElementById('customerEmail');
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
                const email = document.getElementById('customerEmail').value.trim();
                if (!email) {
                    showErrorMessage('Please enter an email address first.');
                    return;
                }
                
                document.getElementById('verificationSpinner').style.display = 'inline-block';
                document.getElementById('sendVerificationBtn').disabled = true;
                document.getElementById('emailStatus').textContent = 'Sending...';
                document.getElementById('emailStatus').className = 'badge bg-info';
                
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=send-verification', true);
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
                const email = document.getElementById('customerEmail').value.trim();
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
                xhr.open('POST', 'CustomerServlet?action=verify-email', true);
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
                                    showSuccessMessage('Email verified successfully! You can now update the customer.');
                                } else {
                                    document.getElementById('emailStatus').textContent = 'Invalid Code';
                                    document.getElementById('emailStatus').className = 'badge bg-danger';
                                    showErrorMessage(response.message);
                                }
                            } catch (e) {
                                document.getElementById('emailStatus').textContent = 'Verified';
                                document.getElementById('emailStatus').className = 'badge bg-success';
                                emailVerified = true;
                                alert('Email verified successfully! You can now update the customer.');
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

            // Form validation
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.querySelector('form');
                if (form) {
                    form.addEventListener('submit', function(e) {
                        const name = document.querySelector('input[name="name"]').value.trim();
                        const phone = document.querySelector('input[name="phone"]').value.trim();
                        const email = document.getElementById('customerEmail').value.trim();
                        
                        if (!name) {
                            e.preventDefault();
                            showErrorMessage('Customer name is required');
                            return false;
                        }
                        
                        if (!phone) {
                            e.preventDefault();
                            showErrorMessage('Phone number is required');
                            return false;
                        }
                        
                        // Check if email has changed and requires verification
                        if (email !== originalEmail && !emailVerified) {
                            e.preventDefault();
                            showErrorMessage('Please verify the new email address before updating the customer.');
                            return false;
                        }
                        
                        // If email verification is not required or is completed, submit via AJAX
                        e.preventDefault();
                        submitCustomerUpdate();
                    });
                }
            });
            
            function submitCustomerUpdate() {
                console.log('=== SUBMIT CUSTOMER UPDATE DEBUG ===');
                
                const formData = new FormData(document.getElementById('customerEditForm'));
                const customerId = formData.get('customerId');
                const name = formData.get('name');
                const phone = formData.get('phone');
                const address = formData.get('address');
                const username = formData.get('username');
                const email = formData.get('email');
                
                console.log('Form data collected:');
                console.log('Customer ID:', customerId);
                console.log('Name:', name);
                console.log('Phone:', phone);
                console.log('Address:', address);
                console.log('Username:', username);
                console.log('Email:', email);
                
                // Get account number from readonly field
                const accountNumberField = document.querySelector('input[readonly]');
                const accountNumber = accountNumberField ? accountNumberField.value : '';
                console.log('Account Number:', accountNumber);
                
                // Create the request data
                const data = 'customer_id=' + encodeURIComponent(customerId) +
                           '&account_number=' + encodeURIComponent(accountNumber) +
                           '&name=' + encodeURIComponent(name) +
                           '&phone=' + encodeURIComponent(phone) +
                           '&address=' + encodeURIComponent(address) +
                           '&username=' + encodeURIComponent(username) +
                           '&email=' + encodeURIComponent(email);
                
                console.log('Request data:', data);
                console.log('Sending to: CustomerServlet?action=update');
                
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=update', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    console.log('AJAX response state:', xhr.readyState, 'Status:', xhr.status);
                    
                    if (xhr.readyState === 4) {
                        console.log('Response received:');
                        console.log('Status:', xhr.status);
                        console.log('Response text:', xhr.responseText);
                        
                        if (xhr.status === 200) {
                            console.log('Success response received');
                            // Show success message on the same page
                            showSuccessMessage('Customer updated successfully!');
                            
                            // Reset email verification status
                            emailVerified = false;
                            originalEmail = document.getElementById('customerEmail').value.trim();
                            
                            // Hide verification section
                            document.getElementById('emailVerificationSection').style.display = 'none';
                            document.getElementById('sendVerificationBtn').style.display = 'none';
                        } else {
                            console.log('Error response received');
                            showErrorMessage('Failed to update customer. Please try again.');
                        }
                    }
                };
                
                xhr.onerror = function() {
                    console.log('AJAX network error occurred');
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
                const contentCard = document.querySelector('.content-card');
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
        </script>
    </body>
</html> 