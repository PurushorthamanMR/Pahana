<%-- 
    Document   : customer
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
        <title>Pahana - Customer Management</title>
        
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
                margin-left: 260px;
                padding: 1rem;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
                padding: 0.5rem 0;
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
                padding: 1rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 1rem;
            }

            .card-title {
                font-size: 1.3rem;
                font-weight: 600;
                color: #333;
                margin-bottom: 1rem;
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
                font-size: 0.9rem;
            }

            .table th {
                border-top: none;
                font-weight: 600;
                color: #333;
                background-color: #f8f9fa;
                padding: 0.5rem;
            }

            .table td {
                vertical-align: middle;
                padding: 0.5rem;
            }

            .btn-sm {
                padding: 0.2rem 0.4rem;
                font-size: 0.8rem;
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

            .btn-view {
                background-color: #17a2b8;
                border-color: #17a2b8;
                color: white;
            }

            
            .form-group {
                margin-bottom: 0.75rem;
            }

            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 0.3rem;
                font-size: 0.9rem;
            }

            .form-control {
                border: 2px solid #e9ecef;
                border-radius: 6px;
                padding: 0.5rem;
                transition: border-color 0.3s ease;
            }

            .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            
            .alert {
                border-radius: 8px;
                border: none;
                padding: 0.75rem;
                margin-bottom: 1rem;
            }

            .alert-success {
                background-color: #d4edda;
                color: #155724;
            }

            .alert-danger {
                background-color: #f8d7da;
                color: #721c24;
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
            
            
            if (request.getAttribute("customers") == null) {
                response.sendRedirect("CustomerServlet?action=list");
                return;
            }
            
            
            request.setAttribute("currentPage", "customer");
        %>

        <div class="main-container">
            
            <jsp:include page="includes/sidebar.jsp" />

            
            <div class="main-content">
                
                <div class="header">
                    <div class="header-left">
                        <button class="menu-toggle" onclick="toggleSidebar()">
                            <i class="bi bi-list"></i>
                        </button>
                        <h2 class="h4 mb-0">Customer Management</h2>
                    </div>
                    <div class="user-info">
                        <span>Welcome, <%= username %> (<%= role %>)</span>
                        <div class="user-avatar">
                            <i class="bi bi-person"></i>
                        </div>
                    </div>
                </div>

                
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

                
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-person-plus me-2"></i>Add New Customer</span>
                    </h3>
                    

                    
                    <form action="CustomerServlet" method="post">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="row mb-2">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="name" class="form-label">Customer Name</label>
                                    <input type="text" class="form-control" id="name" name="name" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="phone" class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" required onblur="checkPhoneNumberOnBlur(this.value)">
                                    <div id="phoneWarning" class="text-danger mt-1" style="display: none;">
                                        <i class="bi bi-exclamation-triangle me-1"></i>
                                        <small>This phone number is already registered in our system.</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mb-2">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="address" class="form-label">Address</label>
                                    <textarea class="form-control" id="address" name="address" rows="2" required></textarea>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mb-2">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="username" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" required onblur="checkUsernameOnBlur(this.value)">
                                    <div id="usernameWarning" class="text-danger mt-1" style="display: none;">
                                        <i class="bi bi-exclamation-triangle me-1"></i>
                                        <small>This username is already taken. Please choose a different one.</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="email" class="form-label">Email</label>
                                    <div class="input-group">
                                        <input type="email" class="form-control" id="email" name="email" required>
                                        <button class="btn btn-outline-primary" type="button" id="sendVerificationBtn" onclick="sendVerificationCode()">
                                            <i class="bi bi-envelope"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="password" class="form-label">Password</label>
                                    <div class="input-group">
                                        <input type="password" class="form-control" id="password" name="password" required>
                                        <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('password')">
                                            <i class="bi bi-eye" id="passwordIcon"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="row mb-2">
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
                        
                        <div class="text-end mt-3">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-plus-circle me-2"></i>Add Customer
                            </button>
                        </div>
                    </form>
                </div>

                
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-people me-2"></i>Customer List</span>
                        <a href="CustomerServlet?action=list" class="btn btn-primary btn-sm">
                            <i class="bi bi-arrow-clockwise me-1"></i>Refresh
                        </a>
                    </h3>
                    
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Account Number</th>
                                    <th>Name</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Created By</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                                    if (customers != null && !customers.isEmpty()) {
                                        for (Customer customer : customers) {
                                %>
                                <tr>
                                    <td><%= customer.getCustomerId() %></td>
                                    <td><%= customer.getAccountNumber() %></td>
                                    <td><%= customer.getName() %></td>
                                    <td><%= customer.getUsername() != null ? customer.getUsername() : "N/A" %></td>
                                    <td><%= customer.getEmail() != null ? customer.getEmail() : "N/A" %></td>
                                    <td><%= customer.getPhone() %></td>
                                    <td><%= customer.getAddress() %></td>
                                    <td><%= customer.getCreatedBy() != null ? customer.getCreatedBy().getUsername() : "N/A" %></td>
                                    <td>
                                        <a href="CustomerServlet?action=view&customer_id=<%= customer.getCustomerId() %>" 
                                           class="btn btn-view btn-sm">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                        <button class="btn btn-edit btn-sm" onclick="editCustomer(<%= customer.getCustomerId() %>)">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button class="btn btn-delete btn-sm" onclick="deleteCustomer(<%= customer.getCustomerId() %>)" 
                                                title="Delete customer">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="9" class="text-center">No customers found.</td>
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

        
        <div id="loadingOverlay" class="loading-overlay" style="display: none;">
            <div class="loading-content">
                <div class="spinner-border text-primary mb-3" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <h5 class="text-white mb-2">Creating Customer...</h5>
                <p class="text-white-50 mb-0">Please wait while we process your request.</p>
            </div>
        </div>

        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            
            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.8);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            .loading-content {
                text-align: center;
                background-color: rgba(255, 255, 255, 0.1);
                padding: 2rem;
                border-radius: 12px;
                backdrop-filter: blur(10px);
            }

            .loading-content .spinner-border {
                width: 3rem;
                height: 3rem;
            }
            
            
            .form-control-sm {
                padding: 0.375rem 0.5rem;
                font-size: 0.875rem;
                border-radius: 0.375rem;
            }
            
            .badge {
                font-size: 0.75rem;
                padding: 0.25rem 0.5rem;
            }
            
            .spinner-border-sm {
                width: 1rem;
                height: 1rem;
            }
            
            
            .content-card + .content-card {
                margin-top: 0.5rem;
            }
        </style>

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


            function showLoadingScreen() {
                const loadingOverlay = document.getElementById('loadingOverlay');
                const addCustomerBtn = document.querySelector('button[type="submit"]');
                
                if (loadingOverlay) {
                    loadingOverlay.style.display = 'flex';
                }
                
                if (addCustomerBtn) {
                    addCustomerBtn.disabled = true;
                    addCustomerBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Creating Customer...';
                }
                

                showAlert('Creating customer, please wait...', 'info');
            }

            function hideLoadingScreen() {
                const loadingOverlay = document.getElementById('loadingOverlay');
                const addCustomerBtn = document.querySelector('button[type="submit"]');
                
                if (loadingOverlay) {
                    loadingOverlay.style.display = 'none';
                }
                
                if (addCustomerBtn) {
                    addCustomerBtn.disabled = false;
                    addCustomerBtn.innerHTML = '<i class="bi bi-plus-circle me-2"></i>Add Customer';
                }
            }


            function editCustomer(customerId) {

                window.location.href = 'customer_edit.jsp?customer_id=' + customerId;
            }

            function deleteCustomer(customerId) {

                const popup = document.createElement('div');
                popup.className = 'custom-popup-overlay';
                popup.innerHTML = 
                    '<div class="custom-popup">' +
                        '<div class="custom-popup-header">' +
                            '<h5>Confirm Delete</h5>' +
                            '<button type="button" class="btn-close" onclick="closePopup()">&times;</button>' +
                        '</div>' +
                        '<div class="custom-popup-body">' +
                            '<p>Are you sure you want to delete this customer?</p>' +
                        '</div>' +
                        '<div class="custom-popup-footer">' +
                            '<button type="button" class="btn btn-secondary" onclick="closePopup()">Cancel</button>' +
                            '<button type="button" class="btn btn-danger" onclick="confirmDelete(' + customerId + ')">Delete</button>' +
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

            function confirmDelete(customerId) {

                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=delete&customer_id=' + customerId, true);
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

                                showAlert('Customer deleted successfully!', 'success');
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1500);
                            }
                        } else {

                            showAlert('Failed to delete customer. Please try again.', 'error');
                        }
                    }
                };
                
                xhr.send();
            }

            function showAlert(message, type) {
                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-' + (type === 'success' ? 'success' : type === 'error' ? 'danger' : 'info') + ' alert-dismissible fade show';
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
                                    showAlert(response.message, 'success');
                                    document.getElementById('emailStatus').textContent = 'Verified';
                                    document.getElementById('emailStatus').className = 'badge bg-success';
                                    emailVerified = true;
                                    

                                    document.getElementById('verificationPin').disabled = true;
                                    document.getElementById('verifyPinBtn').disabled = true;
                                    document.getElementById('sendVerificationBtn').disabled = true;
                                    

                                    document.getElementById('addCustomerBtn').disabled = false;
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
                                

                                document.getElementById('addCustomerBtn').disabled = false;
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
                const addCustomerBtn = document.querySelector('button[type="submit"]');
                if (addCustomerBtn) {
                    addCustomerBtn.id = 'addCustomerBtn';
                    addCustomerBtn.disabled = true;
                    addCustomerBtn.title = 'Please verify your email first';
                }
                

                const form = document.querySelector('form[action="CustomerServlet"]');
                if (form) {
                    form.addEventListener('submit', function(e) {
                        e.preventDefault(); 
                        
                        if (!emailVerified) {
                            showAlert('Please verify your email address before adding the customer.', 'error');
                            return false;
                        }
                        

                        const username = document.getElementById('username').value.trim();
                        if (username) {
                            checkUsernameExists(username, function(exists) {
                                if (exists) {
                                    showAlert('This username is already taken. Please choose a different username.', 'error');
                                    return false;
                                } else {

                                    const phone = document.getElementById('phone').value.trim();
                                    if (phone) {
                                        checkPhoneNumberExists(phone, function(phoneExists) {
                                            if (phoneExists) {
                                                showAlert('This phone number is already registered in our system. Please use a different phone number.', 'error');
                                                return false;
                                            } else {

                                                showLoadingScreen();
                                                setTimeout(() => {
                                                    form.submit();
                                                }, 100);
                                            }
                                        });
                                    } else {

                                        showLoadingScreen();
                                        setTimeout(() => {
                                            form.submit();
                                        }, 100);
                                    }
                                }
                            });
                        } else {

                            showLoadingScreen();
                            setTimeout(() => {
                                form.submit();
                            }, 100);
                        }
                    });
                }
            });
            

            function checkPhoneNumberExists(phone, callback) {
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=check-phone-exists', true);
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
                
                xhr.send('phone=' + encodeURIComponent(phone));
            }


            function checkPhoneNumberOnBlur(phone) {
                if (phone) {
                    checkPhoneNumberExists(phone, function(exists) {
                        const phoneWarning = document.getElementById('phoneWarning');
                        if (exists) {
                            phoneWarning.style.display = 'block';


                        } else {
                            phoneWarning.style.display = 'none';
                        }
                    });
                }
            }
            

            function checkUsernameExists(username, callback) {
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=check-username-exists', true);
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
