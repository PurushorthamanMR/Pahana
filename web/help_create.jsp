<%-- 
    Document   : help_create
    Created on : Aug 3, 2025, 9:09:13 AM
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
        <title>Pahana - Create Help Section</title>
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
                background-color: #f8f9fa;
                min-height: 100vh;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 2rem;
                padding: 1rem 0;
                border-bottom: 1px solid #dee2e6;
            }

            .header-left {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .menu-toggle {
                display: none;
                background: none;
                border: none;
                font-size: 1.5rem;
                color: #495057;
                cursor: pointer;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 1rem;
                color: #6c757d;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                background-color: #e9ecef;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #6c757d;
            }

            /* Content Card Styles */
            .content-card {
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 2rem;
                margin-bottom: 2rem;
            }

            .card-title {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid #e9ecef;
                color: #2c3e50;
            }

            .card-title span {
                font-size: 1.5rem;
                font-weight: 600;
            }

            /* Form Styles */
            .form-group {
                margin-bottom: 1.5rem;
            }

            .form-label {
                font-weight: 600;
                color: #495057;
                margin-bottom: 0.5rem;
            }

            .form-control {
                border: 2px solid #e9ecef;
                border-radius: 8px;
                padding: 0.75rem;
                transition: border-color 0.3s ease;
            }

            .form-control:focus {
                border-color: #007bff;
                box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
            }

            .form-control.is-invalid {
                border-color: #dc3545;
            }

            .invalid-feedback {
                color: #dc3545;
                font-size: 0.875rem;
                margin-top: 0.25rem;
            }

            /* Button Styles */
            .btn {
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s ease;
                border: none;
                cursor: pointer;
            }

            .btn-primary {
                background-color: #007bff;
                color: white;
            }

            .btn-primary:hover {
                background-color: #0056b3;
                transform: translateY(-1px);
            }

            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }

            .btn-secondary:hover {
                background-color: #545b62;
                transform: translateY(-1px);
            }

            .btn-danger {
                background-color: #dc3545;
                color: white;
            }

            .btn-danger:hover {
                background-color: #c82333;
                transform: translateY(-1px);
            }

            /* Alert Styles */
            .alert {
                border-radius: 8px;
                padding: 1rem;
                margin-bottom: 1rem;
                border: none;
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

                .menu-toggle {
                    display: block;
                }

                .card-title {
                    flex-direction: column;
                    gap: 1rem;
                    align-items: flex-start;
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
            
            // Check if user has permission to create help sections
            if (!"ADMIN".equals(role) && !"MANAGER".equals(role)) {
                response.sendRedirect("help.jsp?error=Access denied. You don't have permission to create help sections.");
                return;
            }
            
            request.setAttribute("currentPage", "help");
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
                        <h1 class="h3 mb-0">Create Help Section</h1>
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

                <!-- Create Help Section Form -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-plus-circle me-2"></i>Create New Help Section</span>
                        <a href="HelpServlet?action=list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Help
                        </a>
                    </h3>
                    
                    <form action="HelpServlet" method="POST" id="helpForm">
                        <input type="hidden" name="action" value="create">
                        
                        <div class="form-group">
                            <label for="title" class="form-label">Title *</label>
                            <input type="text" class="form-control" id="title" name="title" 
                                   placeholder="Enter help section title" required>
                            <div class="invalid-feedback" id="titleError"></div>
                        </div>
                        
                        <div class="form-group">
                            <label for="content" class="form-label">Content *</label>
                            <textarea class="form-control" id="content" name="content" rows="10" 
                                      placeholder="Enter help section content" required></textarea>
                            <div class="invalid-feedback" id="contentError"></div>
                        </div>
                        
                        <div class="form-group">
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-save me-2"></i>Create Help Section
                            </button>
                            <a href="HelpServlet?action=list" class="btn btn-secondary ms-2">
                                <i class="bi bi-x-circle me-2"></i>Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>
            // Form validation
            document.getElementById('helpForm').addEventListener('submit', function(e) {
                let isValid = true;
                const title = document.getElementById('title').value.trim();
                const content = document.getElementById('content').value.trim();
                
                // Reset previous errors
                document.getElementById('title').classList.remove('is-invalid');
                document.getElementById('content').classList.remove('is-invalid');
                document.getElementById('titleError').textContent = '';
                document.getElementById('contentError').textContent = '';
                
                // Validate title
                if (!title) {
                    document.getElementById('title').classList.add('is-invalid');
                    document.getElementById('titleError').textContent = 'Title is required';
                    isValid = false;
                } else if (title.length > 150) {
                    document.getElementById('title').classList.add('is-invalid');
                    document.getElementById('titleError').textContent = 'Title must be 150 characters or less';
                    isValid = false;
                }
                
                // Validate content
                if (!content) {
                    document.getElementById('content').classList.add('is-invalid');
                    document.getElementById('contentError').textContent = 'Content is required';
                    isValid = false;
                }
                
                if (!isValid) {
                    e.preventDefault();
                }
            });
            
            // Sidebar toggle for mobile
            function toggleSidebar() {
                const sidebar = document.querySelector('.sidebar');
                sidebar.classList.toggle('show');
            }
        </script>
    </body>
</html> 
