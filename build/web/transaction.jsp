<%-- 
    Document   : transaction
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
        <title>Pahana - Transaction Management</title>
        
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
            
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");
            
            if (username == null || role == null) {
                response.sendRedirect("login.jsp?error=Please login first.");
                return;
            }
            
            
            request.setAttribute("currentPage", "transaction");
            
            
            if (request.getAttribute("transactions") == null) {
                try {
                    FacadeDP facade = new FacadeDP();
                    List<Transaction> transactions;
                    
                    
                    if ("CUSTOMER".equals(role)) {
                        int customerId = (Integer) session.getAttribute("userId");
                        transactions = facade.getTransactionsByCustomer(customerId);
                    } else {
                        
                        transactions = facade.getAllTransactions();
                    }
                    
                    request.setAttribute("transactions", transactions);
                } catch (Exception e) {
                    
                }
            }
        %>

        <div class="main-container">
            
            <jsp:include page="includes/sidebar.jsp" />

            
            <div class="main-content">
                
                <div class="header">
                    <div class="header-left">
                        <button class="menu-toggle" onclick="toggleSidebar()">
                            <i class="bi bi-list"></i>
                        </button>
                        <h1 class="h3 mb-0">
                            <% if ("CUSTOMER".equals(role)) { %>
                            My Purchase History
                            <% } else { %>
                            Transaction Management
                            <% } %>
                        </h1>
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
                        <span><i class="bi bi-receipt me-2"></i>
                            <% if ("CUSTOMER".equals(role)) { %>
                            My Transactions
                            <% } else { %>
                            Transaction List
                            <% } %>
                        </span>
                        <div>
                            <a href="TransactionServlet?action=list" class="btn btn-secondary me-2">
                                <i class="bi bi-arrow-clockwise me-2"></i>Refresh
                            </a>
                        </div>
                    </h3>
                    
                    <div class="table-responsive">
                        
                        <div class="row g-2 mb-3 align-items-end">
                            <div class="col-md-3">
                                <label class="form-label mb-1">Start Date</label>
                                <input type="date" class="form-control" id="filterStartDate">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label mb-1">End Date</label>
                                <input type="date" class="form-control" id="filterEndDate">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label mb-1">Filter By</label>
                                <select class="form-select" id="filterField">
                                    <option value="id">Transaction ID</option>
                                    <option value="customer">Customer</option>
                                    <option value="created_by">Created By</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label mb-1">Search</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="filterSearch" placeholder="Type to search...">
                                    <button class="btn btn-outline-secondary" type="button" id="clearFiltersBtn">
                                        <i class="bi bi-x-lg"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Transaction ID</th>
                                    <% if (!"CUSTOMER".equals(role)) { %>
                                    <th>Customer</th>
                                    <% } %>
                                    <th>Total Amount</th>
                                    <th>Created By</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
                                    if (transactions != null && !transactions.isEmpty()) {
                                        for (Transaction transaction : transactions) {
                                %>
                                <%
                                    String _createdDateStr = "";
                                    try {
                                        java.util.Date _cd = transaction.getCreatedAt();
                                        if (_cd != null) {
                                            _createdDateStr = new java.text.SimpleDateFormat("yyyy-MM-dd").format(_cd);
                                        }
                                    } catch (Exception _e) { _createdDateStr = ""; }
                                %>
                                <tr data-id="<%= String.valueOf(transaction.getTransactionId()) %>" data-customer="<%= transaction.getCustomer().getName() != null ? transaction.getCustomer().getName().toLowerCase() : "" %>" data-created-by="<%= transaction.getCreatedBy() != null ? (transaction.getCreatedBy().getUsername() != null ? transaction.getCreatedBy().getUsername().toLowerCase() : "") : "" %>" data-created-at="<%= _createdDateStr %>">
                                    <td><%= transaction.getTransactionId() %></td>
                                    <% if (!"CUSTOMER".equals(role)) { %>
                                    <td>
                                        <%= transaction.getCustomer().getName() %>
                                        <br><small class="text-muted">(<%= transaction.getCustomer().getAccountNumber() %>)</small>
                                    </td>
                                    <% } %>
                                    <td><strong><%= transaction.getTotalAmount() %></strong></td>
                                    <td><%= transaction.getCreatedBy().getUsername() %></td>
                                    <td><%= transaction.getCreatedAt() %></td>
                                    <td>
                                        <a href="TransactionServlet?action=view&transaction_id=<%= transaction.getTransactionId() %>" 
                                           class="btn btn-sm btn-info">
                                            <i class="bi bi-eye me-1"></i>View
                                        </a>
                                    </td>
                                </tr>
                                <% 
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="<%= "CUSTOMER".equals(role) ? "5" : "6" %>" class="text-center text-muted">
                                        <i class="bi bi-inbox me-2"></i>No transactions found.
                                        <% if ("CUSTOMER".equals(role)) { %>
                                        <br><small>You haven't made any purchases yet.</small>
                                        <% } else { %>
                                        <br><small>Create your first transaction using the POS system.</small>
                                        <% } %>
                                    </td>
                                </tr>
                                <% } %>
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


            const startDateEl = document.getElementById('filterStartDate');
            const endDateEl = document.getElementById('filterEndDate');
            const fieldEl = document.getElementById('filterField');
            const searchEl = document.getElementById('filterSearch');
            const clearBtn = document.getElementById('clearFiltersBtn');

            function applyFilters() {
                const startDate = startDateEl && startDateEl.value ? startDateEl.value : null; // yyyy-MM-dd
                const endDate = endDateEl && endDateEl.value ? endDateEl.value : null;       // yyyy-MM-dd
                const field = fieldEl ? fieldEl.value : 'id';
                const query = (searchEl ? searchEl.value : '').toLowerCase().trim();

                const rows = document.querySelectorAll('table.table tbody tr');
                rows.forEach(row => {

                    if (!row.hasAttribute('data-id')) { return; }

                    const rowDate = row.getAttribute('data-created-at'); // yyyy-MM-dd
                    const matchesDate = (!startDate || rowDate >= startDate) && (!endDate || rowDate <= endDate);

                    let fieldValue = '';
                    if (field === 'id') fieldValue = row.getAttribute('data-id') || '';
                    if (field === 'customer') fieldValue = row.getAttribute('data-customer') || '';
                    if (field === 'created_by') fieldValue = row.getAttribute('data-created-by') || '';

                    const matchesQuery = query === '' || (fieldValue.toLowerCase().includes(query));

                    row.style.display = (matchesDate && matchesQuery) ? '' : 'none';
                });
            }

            if (startDateEl) startDateEl.addEventListener('change', applyFilters);
            if (endDateEl) endDateEl.addEventListener('change', applyFilters);
            if (fieldEl) fieldEl.addEventListener('change', applyFilters);
            if (searchEl) searchEl.addEventListener('input', applyFilters);
            if (clearBtn) clearBtn.addEventListener('click', () => {
                if (startDateEl) startDateEl.value = '';
                if (endDateEl) endDateEl.value = '';
                if (fieldEl) fieldEl.value = 'id';
                if (searchEl) searchEl.value = '';
                applyFilters();
            });
        

            applyFilters();
        </script>
    </body>
</html> 