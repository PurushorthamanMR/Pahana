<%-- 
    Document   : pos
    Created on : Aug 3, 2025, 9:10:02 AM
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
        <title>Pahana - Point of Sale</title>
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

            /* Bill Modal Styles */
            .bill-container {
                max-width: 100%;
                margin: 0 auto;
                padding: 0;
            }

            .bill-header {
                text-align: center;
                border-bottom: 2px solid #dee2e6;
                padding-bottom: 15px;
                margin-bottom: 15px;
            }

            .bill-header h4 {
                color: #1e3c72;
                margin-bottom: 10px;
                font-weight: bold;
            }

            .bill-header p {
                margin-bottom: 5px;
                color: #6c757d;
                font-size: 0.9rem;
            }

            .bill-items {
                margin-bottom: 15px;
            }

            .bill-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 8px 0;
                border-bottom: 1px solid #f1f3f4;
                font-size: 0.95rem;
            }

            .bill-item:last-child {
                border-bottom: none;
            }

            .bill-total {
                border-top: 2px solid #dee2e6;
                padding-top: 15px;
                font-weight: bold;
                font-size: 1.1rem;
                color: #1e3c72;
            }

            /* Modal specific styles */
            #billModal .modal-content {
                border-radius: 12px;
                border: none;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            #billModal .modal-header {
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
                border-bottom: none;
                border-radius: 12px 12px 0 0;
            }

            #billModal .modal-title {
                color: white;
                font-weight: 600;
            }

            #billModal .btn-close-white {
                filter: invert(1);
            }

            /* Enhanced Cart Item Styles */
            .cart-item {
                background: white;
                border: 1px solid #e9ecef;
                border-radius: 8px;
                padding: 12px;
                margin-bottom: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }

            .cart-item-info {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 8px;
            }

            .cart-item-title {
                flex: 1;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 4px;
            }

            .cart-item-details {
                flex: 1;
                font-size: 0.85rem;
            }

            .cart-item-price {
                text-align: right;
                color: #28a745;
                font-weight: 600;
            }

            .cart-item-quantity {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                background: #f8f9fa;
                padding: 6px 12px;
                border-radius: 6px;
            }

            .quantity-btn {
                background: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                width: 24px;
                height: 24px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            .quantity-btn:hover {
                background: #0056b3;
            }

            .quantity-btn:active {
                transform: scale(0.95);
            }

            /* Order Summary Styles */
            #orderSummary .d-flex {
                border-bottom: 1px solid #f1f3f4;
                padding: 8px 0;
            }

            #orderSummary .d-flex:last-child {
                border-bottom: none;
            }

            #orderSummary .text-start {
                flex: 1;
            }

            #orderSummary .text-end {
                min-width: 80px;
                text-align: right;
            }

            #orderSummary strong {
                color: #2c3e50;
            }

            #orderSummary small {
                font-size: 0.8rem;
                color: #6c757d;
            }

            /* Main Content Styles */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 0;
                background-color: #f8f9fa;
            }

            .header {
                background: white;
                padding: 1rem 2rem;
                border-bottom: 1px solid #e9ecef;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
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
                color: #333;
                cursor: pointer;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 1rem;
                color: #666;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                background: #667eea;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
            }

            /* POS Container Styles */
            .pos-container {
                display: grid;
                grid-template-columns: 1fr 2fr 1fr;
                gap: 2rem;
                padding: 2rem;
                height: calc(100vh - 80px);
            }

            .category-section, .books-section, .cart-section {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                display: flex;
                flex-direction: column;
            }

            .section-title {
                font-size: 1.3rem;
                font-weight: 600;
                color: #333;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid #e9ecef;
            }

            /* Category Styles */
            .category-list {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }

            .category-item {
                padding: 0.75rem 1rem;
                background: #f8f9fa;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 500;
                color: #495057;
            }

            .category-item:hover {
                background: #e9ecef;
                border-color: #667eea;
                transform: translateX(5px);
            }

            .category-item.active {
                background: #667eea;
                color: white;
                border-color: #667eea;
            }

            /* Book Table Styles */
            .table-responsive {
                max-height: 400px;
                overflow-y: auto;
            }

            .table th {
                position: sticky;
                top: 0;
                background-color: #343a40;
                color: white;
                z-index: 10;
            }

            .table tbody tr:hover {
                background-color: #f8f9fa;
                cursor: pointer;
            }

            .table td {
                vertical-align: middle;
            }

            .btn-sm {
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
            }

            /* Cart Styles */
            .cart-items {
                flex: 1;
                overflow-y: auto;
                margin-bottom: 1rem;
            }

            .cart-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.75rem 0;
                border-bottom: 1px solid #e9ecef;
            }

            .cart-item:last-child {
                border-bottom: none;
            }

            .cart-item-info {
                flex: 1;
            }

            .cart-item-title {
                font-weight: 600;
                color: #333;
                font-size: 0.9rem;
            }

            .cart-item-price {
                color: #28a745;
                font-weight: 600;
                font-size: 0.9rem;
            }

            .cart-item-quantity {
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .quantity-btn {
                background: #667eea;
                color: white;
                border: none;
                border-radius: 4px;
                width: 25px;
                height: 25px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                font-size: 0.8rem;
            }

            .quantity-btn:hover {
                background: #5a6fd8;
            }

            .cart-total {
                border-top: 2px solid #e9ecef;
                padding-top: 1rem;
                margin-top: auto;
            }

            .total-amount {
                font-size: 1.3rem;
                font-weight: 700;
                color: #333;
                text-align: right;
            }

            .checkout-btn {
                width: 100%;
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                color: white;
                border: none;
                padding: 1rem;
                border-radius: 8px;
                font-weight: 600;
                margin-top: 1rem;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .checkout-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
            }

            .checkout-btn:disabled {
                background: #6c757d;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            /* Modal Styles */
            .modal-content {
                border-radius: 12px;
                border: none;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            }

            .modal-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 12px 12px 0 0;
                border: none;
            }

            .modal-body {
                padding: 2rem;
            }

            .quantity-input {
                width: 100%;
                padding: 0.75rem;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                font-size: 1.1rem;
                text-align: center;
            }

            .quantity-input:focus {
                border-color: #667eea;
                outline: none;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            /* Customer Selection Styles */
            .customer-search {
                margin-bottom: 1rem;
            }

            .customer-list {
                max-height: 300px;
                overflow-y: auto;
            }

            .customer-item {
                padding: 0.75rem;
                border: 1px solid #e9ecef;
                border-radius: 8px;
                margin-bottom: 0.5rem;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .customer-item:hover {
                background: #f8f9fa;
                border-color: #667eea;
            }

            .customer-item.selected {
                background: #667eea;
                color: white;
                border-color: #667eea;
            }

            /* Bill Styles */
            .bill-container {
                background: white;
                padding: 2rem;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                max-width: 400px;
                margin: 0 auto;
            }

            .bill-header {
                text-align: center;
                border-bottom: 2px solid #e9ecef;
                padding-bottom: 1rem;
                margin-bottom: 1rem;
            }

            .bill-items {
                margin-bottom: 1rem;
            }

            .bill-item {
                display: flex;
                justify-content: space-between;
                padding: 0.5rem 0;
                border-bottom: 1px solid #f8f9fa;
            }

            .bill-total {
                border-top: 2px solid #e9ecef;
                padding-top: 1rem;
                font-weight: 700;
                font-size: 1.2rem;
            }

            /* Responsive Design */
            @media (max-width: 1200px) {
                .pos-container {
                    grid-template-columns: 1fr 1.5fr 1fr;
                }
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

                .pos-container {
                    grid-template-columns: 1fr;
                    grid-template-rows: auto auto 1fr;
                }

                .menu-toggle {
                    display: block;
                }
            }
            
            /* Email Loading Overlay Styles */
            .email-loading-overlay {
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
            
            .email-loading-content {
                background: white;
                padding: 2rem;
                border-radius: 10px;
                text-align: center;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
                max-width: 400px;
                width: 90%;
            }
            
            .email-loading-content .spinner-border {
                width: 3rem;
                height: 3rem;
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
            boolean canAccess = "MANAGER".equals(role) || "CASHIER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied.");
                return;
            }
            
            // Load categories
            BookCategoryDAO categoryDAO = new BookCategoryDAO();
            List<BookCategory> categories = categoryDAO.getAllBookCategories();
            request.setAttribute("categories", categories);
            
            // Load all books
            BookDAO bookDAO = new BookDAO();
            List<Book> allBooks = bookDAO.getAllBooks();
            request.setAttribute("allBooks", allBooks);
            
            // Load customers for checkout
            CustomerDAO customerDAO = new CustomerDAO();
            List<Customer> customers = customerDAO.getAllCustomers();
            request.setAttribute("customers", customers);
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "pos");
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
                        <h1 class="h3 mb-0">Point of Sale</h1>
                    </div>
                    <div class="user-info">
                        <span>Welcome, <%= username %> (<%= role %>)</span>
                        <div class="user-avatar">
                            <i class="bi bi-person"></i>
                        </div>
                    </div>
                </div>

                <!-- POS Container -->
                <div class="pos-container">
                    <!-- Book Category Section -->
                    <div class="category-section">
                        <h3 class="section-title">
                            <i class="bi bi-tags me-2"></i>Categories
                        </h3>
                        
                        <div class="category-list" id="categoryList">
                            <div class="category-item active" onclick="selectCategory(0, 'All Categories')">
                                <i class="bi bi-collection me-2"></i>All Categories
                            </div>
                            <% for (BookCategory category : categories) { %>
                                <div class="category-item" onclick="selectCategory(<%= category.getCategoryId() %>, '<%= category.getCategoryName() %>')">
                                    <i class="bi bi-tag me-2"></i><%= category.getCategoryName() %>
                                </div>
                            <% } %>
                        </div>
                    </div>

                    <!-- Books Section -->
                    <div class="books-section">
                        <h3 class="section-title">
                            <i class="bi bi-book me-2"></i>Books
                            <span id="categoryTitle" class="ms-2 text-muted">(All Categories)</span>
                        </h3>
                        
                        <div class="table-responsive" id="bookTable">
                            <table class="table table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Price</th>
                                        <th>Stock</th>
                                        <th>Category</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="bookTableBody">
                                    <% 
                                    List<Book> booksList = (List<Book>) request.getAttribute("allBooks");
                                    if (booksList != null && !booksList.isEmpty()) {
                                        for (Book book : booksList) {
                                    %>
                                    <tr data-category-id="<%= book.getCategory().getCategoryId() %>">
                                        <td><%= book.getBookId() %></td>
                                        <td><%= book.getTitle() %></td>
                                        <td><%= book.getPricePerUnit() %></td>
                                        <td><%= book.getStockQuantity() %></td>
                                        <td><%= book.getCategory().getCategoryName() %></td>
                                        <td>
                                            <button class="btn btn-sm btn-primary" onclick="showQuantityModal({
                                                id: <%= book.getBookId() %>,
                                                title: '<%= book.getTitle().replace("'", "\\'") %>',
                                                price: <%= book.getPricePerUnit() %>,
                                                stock: <%= book.getStockQuantity() %>,
                                                category: '<%= book.getCategory().getCategoryName().replace("'", "\\'") %>'
                                            })">
                                                Add to Cart
                                            </button>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted">
                                            <i class="bi bi-book" style="font-size: 2rem;"></i>
                                            <p>No books found</p>
                                        </td>
                                    </tr>
                                    <%
                                    }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Cart Section -->
                    <div class="cart-section">
                        <h3 class="section-title">
                            <i class="bi bi-cart me-2"></i>Shopping Cart
                        </h3>
                        
                        <div class="cart-items" id="cartItems">
                            <div class="text-center text-muted">
                                <i class="bi bi-cart" style="font-size: 2rem;"></i>
                                <p>Cart is empty</p>
                            </div>
                        </div>
                        
                        <div class="cart-total">
                            <div class="total-amount">
                                Total: <span id="cartTotal">0.00</span>
                            </div>
                            <button class="checkout-btn" id="checkoutBtn" disabled onclick="showCheckoutModal()">
                                <i class="bi bi-credit-card me-2"></i>Checkout
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quantity Modal -->
        <div class="modal fade" id="quantityModal" tabindex="-1" aria-labelledby="quantityModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="quantityModalLabel">
                            <i class="bi bi-plus-circle me-2"></i>Add to Cart
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center mb-3">
                            <h6 id="bookTitle" class="mb-2"></h6>
                            <p class="text-muted mb-3">Price: <span id="bookPrice"></span></p>
                            <p class="text-muted">Available Stock: <span id="bookStock"></span></p>
                        </div>
                        <div class="mb-3">
                            <label for="quantityInput" class="form-label">Quantity:</label>
                            <input type="number" class="form-control quantity-input" id="quantityInput" min="1" value="1" max="999">
                        </div>
                        <div class="d-flex justify-content-between">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary" onclick="confirmAddToCart()">Add to Cart</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Checkout Modal -->
        <div class="modal fade" id="checkoutModal" tabindex="-1" aria-labelledby="checkoutModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="checkoutModalLabel">
                            <i class="bi bi-credit-card me-2"></i>Checkout
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="mb-3">Select Customer</h6>
                                <div class="customer-search">
                                    <input type="text" class="form-control" id="customerSearch" placeholder="Search customers...">
                                </div>
                                <div class="customer-list" id="customerList">
                                    <% for (Customer customer : customers) { %>
                                        <div class="customer-item" onclick="selectCustomer(<%= customer.getCustomerId() %>, '<%= customer.getName().replace("'", "\\'") %>', '<%= customer.getEmail() != null ? customer.getEmail().replace("'", "\\'") : "" %>')">
                                            <strong><%= customer.getName() %></strong><br>
                                            <small class="text-muted">Account: <%= customer.getAccountNumber() %></small><br>
                                            <small class="text-muted">Email: <%= customer.getEmail() != null ? customer.getEmail() : "No email" %></small>
                                        </div>
                                    <% } %>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h6 class="mb-3">Order Summary</h6>
                                <div id="orderSummary">
                                    <!-- Order summary will be populated here -->
                                </div>
                                <div class="mt-3">
                                    <strong>Total: $<span id="modalTotal">0.00</span></strong>
                                </div>
                            </div>
                        </div>
                        <div class="mt-4 d-flex justify-content-between">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-success" id="confirmCheckoutBtn" disabled onclick="processTransaction()">
                                <i class="bi bi-check-circle me-2"></i>Confirm Transaction
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bill Modal -->
        <div class="modal fade" id="billModal" tabindex="-1" aria-labelledby="billModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="billModalLabel">
                            <i class="bi bi-receipt me-2"></i>Transaction Receipt
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="bill-container" id="billContent">
                            <!-- Bill content will be populated here -->
                        </div>
                        <div class="text-center mt-3">
                            <button type="button" class="btn btn-primary me-2" onclick="printBill()">
                                <i class="bi bi-printer me-2"></i>Print Bill
                            </button>
                            <button type="button" class="btn btn-success me-2" onclick="sendBillToEmail()" id="sendEmailBtn">
                                <i class="bi bi-envelope me-2"></i>Send to Email
                            </button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="refreshPage()">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Email Loading Overlay -->
        <div id="emailLoadingOverlay" class="email-loading-overlay" style="display: none;">
            <div class="email-loading-content">
                <div class="spinner-border text-primary mb-3" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <h5 class="text-primary mb-2">Sending Bill to Email...</h5>
                <p class="text-muted mb-0" id="emailLoadingMessage">Please wait while we send the bill to the customer's email.</p>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Global variables
            let cart = [];
            let selectedCategoryId = 0;
            let selectedCategoryName = 'All Categories';
            let selectedCustomer = null;
            let currentBook = null;
            let transactionId = null;
            let billCustomer = null; // Separate variable for bill customer data

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

            // Select category
            function selectCategory(categoryId, categoryName) {
                selectedCategoryId = categoryId;
                selectedCategoryName = categoryName;
                
                // Update active category
                document.querySelectorAll('.category-item').forEach(item => {
                    item.classList.remove('active');
                });
                event.target.closest('.category-item').classList.add('active');
                
                // Update category title
                document.getElementById('categoryTitle').textContent = `(${categoryName})`;
                
                // Filter books by category
                filterBooksByCategory(categoryId);
            }

            // Filter books by category
            function filterBooksByCategory(categoryId) {
                const bookRows = document.querySelectorAll('#bookTableBody tr');
                
                bookRows.forEach(row => {
                    if (categoryId === 0) {
                        // Show all books
                        row.style.display = '';
                    } else {
                        // Show only books from selected category
                        const rowCategoryId = parseInt(row.getAttribute('data-category-id'));
                        row.style.display = rowCategoryId === categoryId ? '' : 'none';
                    }
                });
                
                // Check if any books are visible
                const visibleRows = document.querySelectorAll('#bookTableBody tr:not([style*="display: none"])');
                if (visibleRows.length === 0) {
                    // Show "no books" message
                    const noBooksRow = document.createElement('tr');
                    noBooksRow.innerHTML = `
                        <td colspan="6" class="text-center text-muted">
                            <i class="bi bi-book" style="font-size: 2rem;"></i>
                            <p>No books found in this category</p>
                        </td>
                    `;
                    document.getElementById('bookTableBody').appendChild(noBooksRow);
                }
            }

            // Show quantity modal
            function showQuantityModal(book) {
                currentBook = book;
                document.getElementById('bookTitle').textContent = book.title;
                document.getElementById('bookPrice').textContent = book.price.toFixed(2);
                document.getElementById('bookStock').textContent = book.stock;
                document.getElementById('quantityInput').value = 1;
                document.getElementById('quantityInput').max = book.stock;
                
                const modal = new bootstrap.Modal(document.getElementById('quantityModal'));
                modal.show();
            }

            // Confirm add to cart
            function confirmAddToCart() {
                const quantity = parseInt(document.getElementById('quantityInput').value);
                const stock = currentBook.stock;
                
                if (quantity < 1) {
                    alert('Quantity must be at least 1');
                    return;
                }
                
                if (quantity > stock) {
                    alert('Quantity cannot exceed available stock');
                    return;
                }
                
                const existingItem = cart.find(item => item.id === currentBook.id);
                
                if (existingItem) {
                    const newTotal = existingItem.quantity + quantity;
                    if (newTotal > stock) {
                        alert('Total quantity cannot exceed available stock');
                        return;
                    }
                    existingItem.quantity += quantity;
                } else {
                    cart.push({
                        id: currentBook.id,
                        title: currentBook.title,
                        price: currentBook.price,
                        quantity: quantity,
                        stock: currentBook.stock
                    });
                }
                
                updateCartDisplay();
                
                // Close modal
                const modal = bootstrap.Modal.getInstance(document.getElementById('quantityModal'));
                modal.hide();
                
                // Show success message
                showToast('Item added to cart successfully!', 'success');
            }

            // Update cart display
            function updateCartDisplay() {
                const cartItems = document.getElementById('cartItems');
                const cartTotal = document.getElementById('cartTotal');
                const checkoutBtn = document.getElementById('checkoutBtn');
                
                if (cart.length === 0) {
                    cartItems.innerHTML = `
                        <div class="text-center text-muted">
                            <i class="bi bi-cart" style="font-size: 2rem;"></i>
                            <p>Cart is empty</p>
                        </div>
                    `;
                    checkoutBtn.disabled = true;
                } else {
                    cartItems.innerHTML = '';
                    let total = 0;
                    
                    cart.forEach(item => {
                        const itemTotal = item.price * item.quantity;
                        total += itemTotal;
                        
                        const cartItem = document.createElement('div');
                        cartItem.className = 'cart-item';
                        cartItem.innerHTML = '<div class="cart-item-info">' +
                            '<div class="cart-item-title"><strong>' + item.title + '</strong></div>' +
                            '<div class="cart-item-details">' +
                            '<small class="text-muted">ID: ' + item.id + '</small><br>' +
                            '<small class="text-muted">Price: ' + item.price.toFixed(2) + ' x ' + item.quantity + '</small>' +
                            '</div>' +
                            '<div class="cart-item-price"><strong>' + itemTotal.toFixed(2) + '</strong></div>' +
                            '</div>' +
                            '<div class="cart-item-quantity">' +
                            '<button class="quantity-btn" onclick="updateQuantity(' + item.id + ', -1)">-</button>' +
                            '<span>' + item.quantity + '</span>' +
                            '<button class="quantity-btn" onclick="updateQuantity(' + item.id + ', 1)">+</button>' +
                            '</div>';
                        
                        cartItems.appendChild(cartItem);
                    });
                    
                    cartTotal.textContent = total.toFixed(2);
                    checkoutBtn.disabled = false;
                }
            }

            // Update quantity
            function updateQuantity(productId, change) {
                const item = cart.find(item => item.id === productId);
                
                if (item) {
                    const newQuantity = item.quantity + change;
                    
                    if (newQuantity <= 0) {
                        cart = cart.filter(item => item.id !== productId);
                    } else if (newQuantity > item.stock) {
                        alert('Quantity cannot exceed available stock');
                        return;
                    } else {
                        item.quantity = newQuantity;
                    }
                    
                    updateCartDisplay();
                }
            }

            // Reset checkout modal state
            function resetCheckoutModal() {
                selectedCustomer = null;
                document.getElementById('confirmCheckoutBtn').disabled = true;
                document.getElementById('modalTotal').textContent = '0.00';
                document.getElementById('orderSummary').innerHTML = '';
                document.querySelectorAll('.customer-item').forEach(item => {
                    item.classList.remove('selected');
                });
            }

            // Show checkout modal
            function showCheckoutModal() {
                if (cart.length === 0) {
                    alert('Cart is empty!');
                    return;
                }
                
                // Reset checkout modal state
                resetCheckoutModal();
                
                // Update order summary
                updateOrderSummary();
                
                const modal = new bootstrap.Modal(document.getElementById('checkoutModal'));
                modal.show();
            }

            // Select customer
            function selectCustomer(customerId, customerName, customerEmail) {
                selectedCustomer = { 
                    id: customerId, 
                    name: customerName, 
                    email: customerEmail 
                };
                
                console.log('Customer selected:', selectedCustomer);
                
                // Update UI
                document.querySelectorAll('.customer-item').forEach(item => {
                    item.classList.remove('selected');
                });
                event.target.closest('.customer-item').classList.add('selected');
                
                document.getElementById('confirmCheckoutBtn').disabled = false;
            }

            // Update order summary
            function updateOrderSummary() {
                const orderSummary = document.getElementById('orderSummary');
                const modalTotal = document.getElementById('modalTotal');
                let total = 0;
                
                let summaryHTML = '';
                cart.forEach(item => {
                    const itemTotal = item.price * item.quantity;
                    total += itemTotal;
                    
                    summaryHTML += '<div class="d-flex justify-content-between mb-2">' +
                        '<div class="text-start">' +
                        '<div><strong>' + item.title + '</strong></div>' +
                        '<small class="text-muted">ID: ' + item.id + ' | Price: ' + item.price.toFixed(2) + ' x ' + item.quantity + '</small>' +
                        '</div>' +
                        '<div class="text-end">' +
                        '<strong>' + itemTotal.toFixed(2) + '</strong>' +
                        '</div>' +
                        '</div>';
                });
                
                orderSummary.innerHTML = summaryHTML;
                modalTotal.textContent = total.toFixed(2);
            }

            // Process transaction
            function processTransaction() {
                console.log('=== PROCESS TRANSACTION DEBUG ===');
                console.log('selectedCustomer at start:', selectedCustomer);
                
                if (!selectedCustomer) {
                    alert('Please select a customer');
                    return;
                }
                
                if (cart.length === 0) {
                    alert('Cart is empty');
                    return;
                }
                
                // Calculate total amount from cart
                let totalAmount = 0;
                cart.forEach(item => {
                    totalAmount += item.price * item.quantity;
                });
                
                // Prepare transaction data
                const transactionData = {
                    customerId: selectedCustomer.id,
                    items: cart.map(item => ({
                        bookId: item.id,
                        quantity: item.quantity,
                        price: item.price
                    })),
                    totalAmount: totalAmount
                };
                
                // Debug: Log the transaction data
                console.log('Transaction data:', transactionData);
                console.log('JSON string:', JSON.stringify(transactionData));
                
                // Send transaction to server
                fetch('TransactionServlet?action=create', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(transactionData)
                })
                .then(response => response.json())
                .then(data => {
                    console.log('Server response:', data);
                    if (data.success) {
                        transactionId = data.transactionId;
                        showBill(data.transaction);
                        
                        // Clear cart
                        cart = [];
                        updateCartDisplay();
                        
                        // Reset modal total and clear order summary
                        document.getElementById('modalTotal').textContent = '0.00';
                        document.getElementById('orderSummary').innerHTML = '';
                        
                        // Close checkout modal
                        const modal = bootstrap.Modal.getInstance(document.getElementById('checkoutModal'));
                        modal.hide();
                        
                        // Reset checkout modal state
                        resetCheckoutModal();
                        
                        showToast('Transaction completed successfully!', 'success');
                    } else {
                        alert('Error: ' + data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    console.error('Error details:', error.message);
                    alert('An error occurred while processing the transaction');
                });
            }

            // Show bill
            function showBill(transaction) {
                console.log('=== SHOW BILL DEBUG ===');
                console.log('showBill called with transaction:', transaction);
                console.log('Transaction customerId:', transaction.customerId);
                console.log('Transaction customerName:', transaction.customerName);
                console.log('Current selectedCustomer before update:', selectedCustomer);
                
                const billContent = document.getElementById('billContent');
                const billModal = document.getElementById('billModal');
                
                console.log('billContent element:', billContent);
                console.log('billModal element:', billModal);
                
                const currentDate = new Date().toLocaleDateString();
                const currentTime = new Date().toLocaleTimeString();
                
                let itemsHTML = '';
                let total = 0;
                
                // Check if transaction and items exist
                if (!transaction) {
                    console.error('Transaction is null or undefined');
                    return;
                }
                
                if (!transaction.items || !Array.isArray(transaction.items)) {
                    console.error('Transaction items is null, undefined, or not an array:', transaction.items);
                    return;
                }
                
                console.log('Transaction items:', transaction.items);
                
                transaction.items.forEach(item => {
                    console.log('Processing item:', item);
                    if (!item || !item.title || !item.quantity || !item.price) {
                        console.error('Invalid item data:', item);
                        return;
                    }
                    const itemTotal = item.price * item.quantity;
                    total += itemTotal;
                    
                    itemsHTML += '<div class="bill-item">' +
                                            '<span>' + item.title + ' x' + item.quantity + '</span>' +
                    '<span>' + itemTotal.toFixed(2) + '</span>' +
                        '</div>';
                });
                
                const billHTML = '<div class="bill-header">' +
                    '<h4>Pahana</h4>' +
                    '<p class="mb-1">Transaction Receipt</p>' +
                    '<p class="mb-1">Date: ' + currentDate + '</p>' +
                    '<p class="mb-1">Time: ' + currentTime + '</p>' +
                    '<p class="mb-1">Transaction ID: ' + (transaction.transactionId || 'N/A') + '</p>' +
                    '<p class="mb-1">Customer: ' + (transaction.customerName || 'N/A') + '</p>' +
                    '</div>' +
                    '<div class="bill-items">' +
                    (itemsHTML || '<div class="text-center text-muted">No items to display</div>') +
                    '</div>' +
                    '<div class="bill-total d-flex justify-content-between">' +
                    '<span>Total:</span>' +
                    '<span>' + total.toFixed(2) + '</span>' +
                    '</div>' +
                    '<div class="text-center mt-3">' +
                    '<p class="text-muted">Thank you for your purchase!</p>' +
                    '</div>';
                
                console.log('Generated bill HTML:', billHTML);
                billContent.innerHTML = billHTML;
                
                // Update the billCustomer variable with the transaction customer info
                // This ensures the email functionality works properly
                if (transaction.customerId && transaction.customerName) {
                    // Store the current selectedCustomer email before updating
                    const currentEmail = selectedCustomer ? selectedCustomer.email : null;
                    
                    billCustomer = {
                        id: transaction.customerId,
                        name: transaction.customerName,
                        email: currentEmail // Preserve the email from customer selection
                    };
                    console.log('Updated billCustomer for bill:', billCustomer);
                    console.log('Customer ID:', billCustomer.id);
                    console.log('Customer Name:', billCustomer.name);
                    console.log('Customer Email:', billCustomer.email);
                } else {
                    console.error('Missing customerId or customerName in transaction:', {
                        customerId: transaction.customerId,
                        customerName: transaction.customerName
                    });
                }
                
                const modal = new bootstrap.Modal(document.getElementById('billModal'));
                console.log('Showing bill modal');
                modal.show();
                console.log('Bill modal should be visible now');
            }

            // Print bill
            function printBill() {
                const billContent = document.getElementById('billContent').innerHTML;
                const printWindow = window.open('', '_blank');
                printWindow.document.write(
                    '<html>' +
                    '<head>' +
                    '<title>Transaction Receipt</title>' +
                    '<style>' +
                    'body { font-family: Arial, sans-serif; margin: 20px; }' +
                    '.bill-container { max-width: 400px; margin: 0 auto; }' +
                    '.bill-header { text-align: center; border-bottom: 2px solid #ccc; padding-bottom: 10px; margin-bottom: 10px; }' +
                    '.bill-item { display: flex; justify-content: space-between; padding: 5px 0; border-bottom: 1px solid #eee; }' +
                    '.bill-total { border-top: 2px solid #ccc; padding-top: 10px; font-weight: bold; font-size: 1.2em; }' +
                    '@media print { body { margin: 0; } }' +
                    '</style>' +
                    '</head>' +
                    '<body>' +
                    '<div class="bill-container">' +
                    billContent +
                    '</div>' +
                    '</body>' +
                    '</html>'
                );
                printWindow.document.close();
                printWindow.print();
            }

            // Show toast notification
            function showToast(message, type = 'info') {
                // Create toast element
                const toast = document.createElement('div');
                toast.className = 'alert alert-' + type + ' alert-dismissible fade show position-fixed';
                toast.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
                toast.innerHTML = message +
                    '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                
                document.body.appendChild(toast);
                
                // Auto remove after 3 seconds
                setTimeout(() => {
                    if (toast.parentNode) {
                        toast.parentNode.removeChild(toast);
                    }
                }, 3000);
            }

            // Customer search functionality
            document.getElementById('customerSearch').addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                const customerItems = document.querySelectorAll('.customer-item');
                
                customerItems.forEach(item => {
                    const customerName = item.querySelector('strong').textContent.toLowerCase();
                    const accountNumber = item.querySelector('small').textContent.toLowerCase();
                    
                    if (customerName.includes(searchTerm) || accountNumber.includes(searchTerm)) {
                        item.style.display = '';
                    } else {
                        item.style.display = 'none';
                    }
                });
            });

            // Initialize POS
            document.addEventListener('DOMContentLoaded', function() {
                console.log('POS initialized with enhanced functionality');
            });
            
            // Send bill to customer email
            function sendBillToEmail() {
                console.log('=== SEND BILL EMAIL DEBUG ===');
                console.log('selectedCustomer:', selectedCustomer);
                console.log('billCustomer:', billCustomer);
                console.log('transactionId:', transactionId);
                
                // Use billCustomer if available, otherwise fall back to selectedCustomer
                let customerToUse = billCustomer || selectedCustomer;
                
                if (!customerToUse || !customerToUse.id) {
                    console.error('No customer data available for email');
                    showToast('No customer data available for email', 'error');
                    return;
                }
                
                if (!transactionId) {
                    console.error('No transaction ID found');
                    showToast('No transaction found', 'error');
                    return;
                }
                
                // Show loading overlay
                showEmailLoadingOverlay();
                
                // Prepare email data - only send customerId and transactionId
                // The servlet will fetch the customer details from database using foreign key
                const emailData = {
                    customerId: customerToUse.id,
                    transactionId: transactionId
                };
                
                console.log('Sending bill to email:', emailData);
                console.log('Using customer data:', customerToUse);
                
                // Send email request
                fetch('TransactionServlet?action=send-bill-email', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(emailData)
                })
                .then(response => response.json())
                .then(data => {
                    console.log('Email response:', data);
                    hideEmailLoadingOverlay();
                    
                    if (data.success) {
                        showToast('Bill sent to customer email successfully!', 'success');
                        // Update button to show success
                        const sendEmailBtn = document.getElementById('sendEmailBtn');
                        sendEmailBtn.innerHTML = '<i class="bi bi-check-circle me-2"></i>Email Sent';
                        sendEmailBtn.className = 'btn btn-success me-2';
                        sendEmailBtn.disabled = true;
                    } else {
                        showToast('Failed to send email: ' + data.message, 'error');
                    }
                })
                .catch(error => {
                    console.error('Email error:', error);
                    hideEmailLoadingOverlay();
                    showToast('Error sending email. Please try again.', 'error');
                });
            }
            
            // Show email loading overlay
            function showEmailLoadingOverlay() {
                const overlay = document.getElementById('emailLoadingOverlay');
                overlay.style.display = 'flex';
                
                // Disable the send email button
                const sendEmailBtn = document.getElementById('sendEmailBtn');
                if (sendEmailBtn) {
                    sendEmailBtn.disabled = true;
                }
            }
            
            // Hide email loading overlay
            function hideEmailLoadingOverlay() {
                const overlay = document.getElementById('emailLoadingOverlay');
                overlay.style.display = 'none';
                
                // Re-enable the send email button
                const sendEmailBtn = document.getElementById('sendEmailBtn');
                if (sendEmailBtn) {
                    sendEmailBtn.disabled = false;
                }
            }
            
            // Refresh page function
            function refreshPage() {
                // Close the modal first
                const modal = bootstrap.Modal.getInstance(document.getElementById('billModal'));
                if (modal) {
                    modal.hide();
                }
                
                // Wait a bit for modal to close, then refresh
                setTimeout(() => {
                    window.location.reload();
                }, 300);
            }
            
            // Add event listener to bill modal close events
            document.addEventListener('DOMContentLoaded', function() {
                const billModal = document.getElementById('billModal');
                if (billModal) {
                    billModal.addEventListener('hidden.bs.modal', function() {
                        // Refresh page when modal is closed
                        setTimeout(() => {
                            window.location.reload();
                        }, 100);
                    });
                }
            });
        </script>
    </body>
</html> 