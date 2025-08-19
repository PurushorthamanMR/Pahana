<%-- 
    Document   : transaction_view
    Created on : Aug 3, 2025, 9:07:20 AM
    Author     : pruso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.models.*"%>
<%@page import="com.booking.patterns.FacadeDP"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pahana - View Transaction</title>
        
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

            
            .transaction-details {
                background-color: #f8f9fa;
                border-radius: 6px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
            }

            .transaction-info {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 1.25rem;
                margin-bottom: 1.5rem;
            }

            .info-item {
                background: white;
                padding: 1rem;
                border-radius: 6px;
                border-left: 3px solid #007bff;
            }

            .info-label {
                font-weight: 600;
                color: #495057;
                margin-bottom: 0.4rem;
                font-size: 0.9rem;
            }

            .info-value {
                color: #2c3e50;
                font-size: 1rem;
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
                
                .transaction-details {
                    padding: 1.25rem;
                    margin-bottom: 1.25rem;
                }
                
                .transaction-info {
                    gap: 1rem;
                    margin-bottom: 1.25rem;
                }
                
                .info-item {
                    padding: 0.8rem;
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
            
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            
            if (username == null || role == null) {
                response.sendRedirect("login.jsp?error=Please login first.");
                return;
            }
            
            
            Transaction transaction = (Transaction) request.getAttribute("transaction");
            
            if (transaction == null) {
                response.sendRedirect("TransactionServlet?action=list&error=Transaction not found.");
                return;
            }
            
            request.setAttribute("currentPage", "transaction");
        %>

        <div class="main-container">
            
            <jsp:include page="includes/sidebar.jsp" />

            
            <div class="main-content">
                
                <div class="header">
                    <div class="header-left">
                        <button class="menu-toggle" onclick="toggleSidebar()">
                            <i class="bi bi-list"></i>
                        </button>
                        <h1 class="h3 mb-0">View Transaction</h1>
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
                        <span><i class="bi bi-receipt me-2"></i>Transaction Details</span>
                        <a href="TransactionServlet?action=list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Back to Transactions
                        </a>
                    </h3>
                    
                    <div class="transaction-details">
                        <div class="transaction-info">
                            <div class="info-item">
                                <div class="info-label">Transaction ID</div>
                                <div class="info-value"><%= transaction.getTransactionId() %></div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">Customer</div>
                                <div class="info-value">
                                    <%= transaction.getCustomer().getName() %> 
                                    (<%= transaction.getCustomer().getAccountNumber() %>)
                                </div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">Total Amount</div>
                                <div class="info-value"><%= transaction.getTotalAmount() %></div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">Created By</div>
                                <div class="info-value"><%= transaction.getCreatedBy().getUsername() %></div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">Date</div>
                                <div class="info-value"><%= transaction.getCreatedAt() %></div>
                            </div>
                            
                            <div class="info-item">
                                <div class="info-label">Items Count</div>
                                <div class="info-value"><%= transaction.getItems().size() %> items</div>
                            </div>
                        </div>
                    </div>
                </div>

                
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-list-ul me-2"></i>Transaction Items</span>
                    </h3>
                    
                    <% if (transaction.getItems() != null && !transaction.getItems().isEmpty()) { %>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Book Title</th>
                                    <th>Quantity</th>
                                    <th>Unit Price</th>
                                    <th>Total Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    int itemNumber = 1;
                                    for (TransactionItem item : transaction.getItems()) { 
                                %>
                                <tr>
                                    <td><%= itemNumber++ %></td>
                                    <td><%= item.getBook().getTitle() %></td>
                                    <td><%= item.getQuantity() %></td>
                                    <td><%= item.getBook().getPricePerUnit() %></td>
                                    <td><%= item.getPrice() %></td>
                                </tr>
                                <% } %>
                            </tbody>
                            <tfoot>
                                <tr class="table-primary">
                                    <td colspan="4" class="text-end"><strong>Total:</strong></td>
                                    <td><strong><%= transaction.getTotalAmount() %></strong></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <% } else { %>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle me-2"></i>No items found for this transaction.
                    </div>
                    <% } %>
                </div>
            </div>
        </div>

        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        <script>

            function toggleSidebar() {
                const sidebar = document.querySelector('.sidebar');
                sidebar.classList.toggle('show');
            }
        </script>
    </body>
</html> 