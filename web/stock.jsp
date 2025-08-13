<%-- 
    Document   : stock
    Created on : Aug 3, 2025, 9:10:17 AM
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
        <title>Pahana - Stock Management</title>
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
            
            // Check role-based access - only ADMIN and MANAGER can access stock
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied.");
                return;
            }
            
            // If no books data is loaded, redirect to servlet to load data
            if (request.getAttribute("books") == null) {
                response.sendRedirect("StockServlet?action=list");
                return;
            }
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "stock");
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
                        <h1 class="h3 mb-0">Stock Management</h1>
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

                <!-- Stock Management Content -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-boxes me-2"></i>Stock Management</span>
                        <a href="StockServlet?action=list" class="btn btn-primary">
                            <i class="bi bi-arrow-clockwise me-2"></i>Refresh
                        </a>
                    </h3>
                    

                    
                    <!-- Stock Table -->
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Current Stock</th>
                                    <th>Add Stock</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                List<Book> books = (List<Book>) request.getAttribute("books");
                                if (books != null && !books.isEmpty()) {
                                    for (Book book : books) {
                                %>
                                <tr>
                                    <td><%= book.getBookId() %></td>
                                    <td><strong><%= book.getTitle() %></strong></td>
                                    <td>
                                        <span class="badge <%= book.getStockQuantity() > 10 ? "bg-success" : book.getStockQuantity() > 0 ? "bg-warning" : "bg-danger" %>">
                                            <%= book.getStockQuantity() %>
                                        </span>
                                    </td>
                                    <td>
                                        <div class="input-group input-group-sm">
                                            <input type="number" class="form-control add-stock-input" 
                                                   id="addStock_<%= book.getBookId() %>" 
                                                   placeholder="0" min="0" value="0">
                                            <button class="btn btn-outline-success" 
                                                    onclick="addStock(<%= book.getBookId() %>, '<%= book.getTitle() %>', <%= book.getStockQuantity() %>)">
                                                <i class="bi bi-plus-circle"></i> Add
                                            </button>
                                        </div>
                                    </td>
                                    <td>
                                        <button class="btn btn-sm btn-edit" 
                                                onclick="editStock(<%= book.getBookId() %>, '<%= book.getTitle() %>', <%= book.getStockQuantity() %>)" title="Update Stock">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="5" class="text-center text-muted">
                                        <i class="bi bi-inbox me-2"></i>No books found
                                    </td>
                                </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Update Stock Modal -->
                <div class="modal fade" id="updateStockModal" tabindex="-1" aria-labelledby="updateStockModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="updateStockModalLabel">
                                    <i class="bi bi-pencil me-2"></i>Set Stock Quantity
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="StockServlet" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="bookId" id="updateBookId">
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label class="form-label">Book Title</label>
                                        <input type="text" class="form-control" id="updateBookTitle" readonly>
                                    </div>
                                    <div class="mb-3">
                                        <label for="stockQuantity" class="form-label">Stock Quantity *</label>
                                        <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" 
                                               min="0" required placeholder="Enter new stock quantity">
                                        <small class="text-muted">This will replace the current stock quantity</small>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-check-circle me-2"></i>Set Stock
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

            // Edit stock function
            function editStock(bookId, bookTitle, currentStock) {
                document.getElementById('updateBookId').value = bookId;
                document.getElementById('updateBookTitle').value = bookTitle;
                document.getElementById('stockQuantity').value = currentStock;
                new bootstrap.Modal(document.getElementById('updateStockModal')).show();
            }
            
            // Add stock function
            function addStock(bookId, bookTitle, currentStock) {
                const addStockInput = document.getElementById('addStock_' + bookId);
                const addQuantity = parseInt(addStockInput.value) || 0;
                
                if (addQuantity <= 0) {
                    alert('Please enter a valid quantity to add.');
                    return;
                }
                
                // Create a form and submit it
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'StockServlet';
                
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'add';
                form.appendChild(actionInput);
                
                const bookIdInput = document.createElement('input');
                bookIdInput.type = 'hidden';
                bookIdInput.name = 'bookId';
                bookIdInput.value = bookId;
                form.appendChild(bookIdInput);
                
                const stockQuantityInput = document.createElement('input');
                stockQuantityInput.type = 'hidden';
                stockQuantityInput.name = 'stockQuantity';
                stockQuantityInput.value = addQuantity;
                form.appendChild(stockQuantityInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        </script>
    </body>
</html> 