<%-- 
    Document   : help_view
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
        <title>Pahana - View Help Section</title>
        
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
                display: flex;
                flex-direction: column;
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
                font-size: 0.85rem;
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
                margin-right: 0.5rem;
                width: 16px;
                text-align: center;
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

            
            .main-content {
                flex: 1;
                margin-left: 260px;
                padding: 1.5rem;
                background-color: #f8f9fa;
                min-height: 100vh;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.5rem;
                padding: 0.8rem 0;
                border-bottom: 1px solid #dee2e6;
            }

            .header-left {
                display: flex;
                align-items: center;
                gap: 0.8rem;
            }

            .menu-toggle {
                display: none;
                background: none;
                border: none;
                font-size: 1.3rem;
                color: #495057;
                cursor: pointer;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 0.8rem;
                color: #6c757d;
                font-size: 0.9rem;
            }

            .user-avatar {
                width: 36px;
                height: 36px;
                background-color: #e9ecef;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #6c757d;
                font-size: 0.9rem;
            }

            
            .content-card {
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.08);
                padding: 1.5rem;
                margin-bottom: 1.5rem;
            }

            .card-title {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1.25rem;
                padding-bottom: 0.8rem;
                border-bottom: 2px solid #e9ecef;
                color: #2c3e50;
            }

            .card-title span {
                font-size: 1.3rem;
                font-weight: 600;
            }

            
            .help-section-display {
                background-color: #f8f9fa;
                border-radius: 6px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
            }

            .help-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 0.8rem;
                padding-bottom: 0.4rem;
                border-bottom: 2px solid #007bff;
            }

            .help-content {
                font-size: 1rem;
                line-height: 1.6;
                color: #495057;
                white-space: pre-wrap;
                text-align: left;
                text-align-last: left;
                direction: ltr;
                float: left;
                width: 100%;
            }

            .help-meta {
                margin-top: 1.5rem;
                padding-top: 0.8rem;
                border-top: 1px solid #dee2e6;
                color: #6c757d;
                font-size: 0.85rem;
            }

            
            .btn {
                padding: 0.6rem 1.25rem;
                border-radius: 6px;
                font-weight: 600;
                transition: all 0.3s ease;
                border: none;
                cursor: pointer;
                font-size: 0.85rem;
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

            .btn-warning {
                background-color: #ffc107;
                color: #212529;
            }

            .btn-warning:hover {
                background-color: #e0a800;
                transform: translateY(-1px);
            }

            
            .alert {
                border-radius: 6px;
                padding: 0.8rem;
                margin-bottom: 1rem;
                border: none;
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
                    gap: 0.8rem;
                    align-items: flex-start;
                }
            }

            
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
                
                .card-title span {
                    font-size: 1.2rem;
                }
                
                .header {
                    margin-bottom: 1.25rem;
                    padding: 0.6rem 0;
                }
                
                .help-section-display {
                    padding: 1.25rem;
                    margin-bottom: 1.25rem;
                }
                
                .help-title {
                    font-size: 1.3rem;
                    margin-bottom: 0.6rem;
                    padding-bottom: 0.3rem;
                }
                
                .help-content {
                    font-size: 0.95rem;
                    line-height: 1.5;
                }
                
                .help-meta {
                    margin-top: 1.25rem;
                    padding-top: 0.6rem;
                    font-size: 0.8rem;
                }
                
                .btn {
                    padding: 0.5rem 1rem;
                    font-size: 0.8rem;
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
            
            
            HelpSection helpSection = (HelpSection) request.getAttribute("helpSection");
            
            if (helpSection == null) {
                response.sendRedirect("help.jsp?error=Help section not found.");
                return;
            }
            
            request.setAttribute("currentPage", "help");
        %>

        <div class="main-container">
            
            <jsp:include page="includes/sidebar.jsp" />

            
            <div class="main-content">
                
                <div class="header">
                    <div class="header-left">
                        <button class="menu-toggle" onclick="toggleSidebar()">
                            <i class="bi bi-list"></i>
                        </button>
                        <h1 class="h3 mb-0">View Help Section</h1>
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
                        <span><i class="bi bi-eye me-2"></i>Help Section Details</span>
                        <a href="HelpServlet?action=list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Help
                        </a>
                    </h3>
                    
                    <div class="help-section-display">
                        <div class="help-title">
                            <%= helpSection.getTitle() %>
                        </div>
                        
                        <div class="help-content">
                            <%= helpSection.getContent() %>
                        </div>
                        
                        <div class="help-meta">
                            <strong>Help ID:</strong> <%= helpSection.getHelpId() %>
                        </div>
                    </div>
                    
                    
                    <div class="d-flex gap-2">
                        <a href="HelpServlet?action=list" class="btn btn-secondary">
                            <i class="bi bi-list me-2"></i>Back to List
                        </a>
                        
                        <% if ("ADMIN".equals(role) || "MANAGER".equals(role)) { %>
                        <a href="help_edit.jsp?help_id=<%= helpSection.getHelpId() %>" class="btn btn-warning">
                            <i class="bi bi-pencil-square me-2"></i>Edit
                        </a>
                        
                        <button type="button" class="btn btn-danger" onclick="confirmDelete()">
                            <i class="bi bi-trash me-2"></i>Delete
                        </button>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this help section "<%= helpSection.getTitle() %>"?
                        This action cannot be undone.
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <form action="HelpServlet" method="POST" style="display: inline;">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="help_id" value="<%= helpSection.getHelpId() %>">
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>

            function confirmDelete() {
                const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
                deleteModal.show();
            }
            

            function toggleSidebar() {
                const sidebar = document.querySelector('.sidebar');
                sidebar.classList.toggle('show');
            }
        </script>
    </body>
</html> 
