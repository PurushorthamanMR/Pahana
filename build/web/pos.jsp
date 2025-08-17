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
                font-size: 0.85rem; /* Decreased base font size for laptop screens */
            }

            .main-container {
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar Styles */
            .sidebar {
                width: 240px; /* Decreased from 260px for laptop screens */
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
                padding: 0;
                position: fixed;
                height: 100vh;
                overflow-y: auto;
                z-index: 1000;
            }

            .sidebar-header {
                padding: 1.25rem 1rem; /* Decreased padding */
                border-bottom: 1px solid rgba(255,255,255,0.1);
                text-align: center;
            }

            .logo {
                font-size: 1.4rem; /* Decreased from 1.6rem */
                font-weight: 700;
                color: white;
                text-decoration: none;
            }

            .logo:hover {
                color: #ffd700;
                text-decoration: none;
            }

            .nav-menu {
                padding: 0.6rem 0; /* Decreased padding */
                flex-grow: 1;
            }

            .nav-item {
                margin: 0.3rem 0.6rem; /* Decreased margins */
            }

            .nav-link {
                display: flex;
                align-items: center;
                padding: 0.5rem 0.7rem; /* Decreased padding */
                color: rgba(255,255,255,0.8);
                text-decoration: none;
                border-radius: 6px; /* Decreased border radius */
                transition: all 0.3s ease;
                font-weight: 500;
                font-size: 0.8rem; /* Decreased from 0.9rem */
            }

            .nav-link:hover {
                background: rgba(255,255,255,0.1);
                color: white;
                text-decoration: none;
            }

            .nav-link.active {
                background: rgba(255,255,255,0.2);
                color: white;
                border-left: 3px solid #ffd700; /* Decreased border width */
            }

            .nav-link i {
                margin-right: 0.5rem; /* Decreased margin */
                font-size: 0.9rem; /* Decreased from 1rem */
                width: 16px; /* Decreased width */
            }

            .sidebar-footer {
                padding: 0.8rem 1.25rem; /* Decreased padding */
                border-top: 1px solid rgba(255,255,255,0.1);
                margin-top: auto;
            }

            .logout-btn {
                width: 100%;
                background: rgba(255,255,255,0.1);
                border: 1px solid rgba(255,255,255,0.2);
                color: white;
                padding: 0.6rem 0.8rem; /* Decreased padding */
                border-radius: 6px; /* Decreased border radius */
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
                font-size: 0.8rem; /* Added font size */
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
                margin-left: 240px; /* Updated to match new sidebar width */
                padding: 0;
                background-color: #f8f9fa;
            }

            .header {
                background: white;
                padding: 0.6rem 1.5rem; /* Further decreased padding for 1920x1200 */
                border-bottom: 1px solid #e9ecef;
                display: flex;
                justify-content: space-between;
                align-items: center;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                min-height: 50px; /* Optimized height for 1920x1200 */
            }

            .header-left {
                display: flex;
                align-items: center;
                gap: 0.8rem; /* Decreased gap */
            }

            .menu-toggle {
                display: none;
                background: none;
                border: none;
                font-size: 1.3rem; /* Decreased font size */
                color: #333;
                cursor: pointer;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 0.8rem; /* Decreased gap */
                color: #666;
                font-size: 0.85rem; /* Added font size */
            }

            .user-avatar {
                width: 35px; /* Decreased size */
                height: 35px; /* Decreased size */
                background: #667eea;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 0.9rem; /* Added font size */
            }

            /* POS Container Styles */
            .pos-container {
                display: grid;
                grid-template-columns: 1fr 2fr 1fr;
                gap: 1.5rem; /* Decreased gap */
                padding: 1.5rem; /* Decreased padding */
                height: calc(100vh - 60px); /* Optimized for 1920x1200 - reduced header height */
                min-height: calc(100vh - 60px); /* Ensure minimum height */
            }

            .category-section, .books-section, .cart-section {
                background: white;
                border-radius: 10px; /* Decreased border radius */
                padding: 1.25rem; /* Decreased padding */
                box-shadow: 0 3px 5px rgba(0,0,0,0.1); /* Decreased shadow */
                display: flex;
                flex-direction: column;
            }

            .section-title {
                font-size: 1.1rem; /* Decreased from 1.3rem */
                font-weight: 600;
                color: #333;
                margin-bottom: 1.25rem; /* Decreased margin */
                display: flex;
                align-items: center;
                padding-bottom: 0.4rem; /* Decreased padding */
                border-bottom: 2px solid #e9ecef;
            }

            /* Category Styles */
            .category-list {
                display: flex;
                flex-direction: column;
                gap: 0.4rem; /* Decreased gap */
                max-height: calc(100vh - 200px); /* Optimized for 1920x1200 - dynamic height */
                min-height: 500px; /* Minimum height for smaller screens */
                overflow-y: auto;
                padding-right: 5px;
            }

            .category-list::-webkit-scrollbar {
                width: 5px; /* Decreased scrollbar width */
            }

            .category-list::-webkit-scrollbar-track {
                background: #f1f1f1;
                border-radius: 3px;
            }

            .category-list::-webkit-scrollbar-thumb {
                background: #667eea;
                border-radius: 3px;
            }

            .category-list::-webkit-scrollbar-thumb:hover {
                background: #5a6fd8;
            }

            .category-item {
                padding: 0.6rem 0.8rem; /* Decreased padding */
                background: #f8f9fa;
                border: 2px solid #e9ecef;
                border-radius: 6px; /* Decreased border radius */
                cursor: pointer;
                transition: all 0.3s ease;
                font-weight: 500;
                color: #495057;
                font-size: 0.8rem; /* Added font size */
            }

            .category-item:hover {
                background: #e9ecef;
                border-color: #667eea;
                transform: translateX(3px); /* Decreased transform */
            }

            .category-item.active {
                background: #667eea;
                color: white;
                border-color: #667eea;
            }

            /* Book Table Styles */
            .table-responsive {
                max-height: calc(100vh - 300px); /* Optimized for 1920x1200 - dynamic height */
                min-height: 450px; /* Minimum height for smaller screens */
                overflow-y: auto;
            }

            .table th {
                position: sticky;
                top: 0;
                background-color: #343a40;
                color: white;
                z-index: 10;
                font-size: 0.8rem; /* Added font size */
                padding: 0.5rem 0.75rem; /* Decreased padding */
            }

            .table tbody tr:hover {
                background-color: #f8f9fa;
                cursor: pointer;
            }

            .table td {
                vertical-align: middle;
                font-size: 0.8rem; /* Added font size */
                padding: 0.5rem 0.75rem; /* Decreased padding */
            }

            .btn-sm {
                padding: 0.2rem 0.4rem; /* Decreased padding */
                font-size: 0.75rem; /* Decreased font size */
            }

            /* Search Bar Styles */
            .book-search-container {
                margin-bottom: 1.25rem; /* Decreased margin */
            }

            .book-search-container .input-group {
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                border-radius: 6px; /* Decreased border radius */
                overflow: hidden;
            }

            .book-search-container .input-group-text {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 0.6rem 0.8rem; /* Decreased padding */
                font-size: 0.8rem; /* Added font size */
            }

            .book-search-container .form-control {
                border: 2px solid #e9ecef;
                border-left: none;
                padding: 0.6rem 0.8rem; /* Decreased padding */
                font-size: 0.8rem; /* Decreased font size */
            }

            .book-search-container .form-control:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            }

            .book-search-container .btn-outline-secondary {
                border: 2px solid #e9ecef;
                border-left: none;
                padding: 0.6rem 0.8rem; /* Decreased padding */
                color: #6c757d;
                background: white;
                font-size: 0.8rem; /* Added font size */
            }

            /* Cart Styles */
            .cart-items {
                flex: 1;
                overflow-y: auto;
                margin-bottom: 0.8rem; /* Decreased margin */
                max-height: calc(100vh - 350px); /* Optimized for 1920x1200 - dynamic height */
                min-height: 300px; /* Minimum height for smaller screens */
            }

            .cart-items::-webkit-scrollbar {
                width: 5px; /* Decreased scrollbar width */
            }

            .cart-items::-webkit-scrollbar-track {
                background: #f1f1f1;
                border-radius: 3px;
            }

            .cart-items::-webkit-scrollbar-thumb {
                background: #667eea;
                border-radius: 3px;
            }

            .cart-items::-webkit-scrollbar-thumb:hover {
                background: #5a6fd8;
            }

            .cart-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.6rem 0; /* Decreased padding */
                border-bottom: 1px solid #e9ecef;
                font-size: 0.8rem; /* Added font size */
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
                font-size: 0.8rem; /* Decreased font size */
            }

            .cart-item-price {
                color: #28a745;
                font-weight: 600;
                font-size: 0.8rem; /* Decreased font size */
            }

            .cart-item-quantity {
                display: flex;
                align-items: center;
                gap: 0.4rem; /* Decreased gap */
            }

            .quantity-btn {
                background: #667eea;
                color: white;
                border: none;
                border-radius: 3px; /* Decreased border radius */
                width: 22px; /* Decreased width */
                height: 22px; /* Decreased height */
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                font-size: 0.7rem; /* Decreased font size */
            }

            .quantity-btn:hover {
                background: #5a6fd8;
            }

            .cart-total {
                border-top: 2px solid #e9ecef;
                padding-top: 0.8rem; /* Decreased padding */
                margin-top: auto;
            }

            .total-amount {
                font-size: 1.1rem; /* Decreased from 1.3rem */
                font-weight: 700;
                color: #333;
                text-align: right;
            }

            .checkout-btn {
                width: 100%;
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                color: white;
                border: none;
                padding: 0.8rem; /* Decreased padding */
                border-radius: 6px; /* Decreased border radius */
                font-weight: 600;
                margin-top: 0.8rem; /* Decreased margin */
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 0.85rem; /* Added font size */
            }

            .checkout-btn:hover {
                transform: translateY(-1px); /* Decreased transform */
                box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3); /* Decreased shadow */
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
            @media (min-width: 1366px) and (max-width: 1920px) {
                /* Laptop screen optimizations */
                body {
                    font-size: 0.8rem; /* Even smaller for laptop screens */
                }
                
                .sidebar {
                    width: 220px; /* Smaller sidebar for laptop */
                }
                
                .main-content {
                    margin-left: 220px;
                }
                
                .pos-container {
                    gap: 1.25rem; /* Smaller gaps */
                    padding: 1.25rem;
                    height: calc(100vh - 55px); /* Optimized height for laptop screens */
                }
                
                .category-section, .books-section, .cart-section {
                    padding: 1rem; /* Smaller padding */
                }
                
                .section-title {
                    font-size: 1rem; /* Smaller titles */
                    margin-bottom: 1rem;
                }
                
                .category-item {
                    padding: 0.5rem 0.7rem; /* Smaller category items */
                    font-size: 0.75rem;
                }
                
                .table th, .table td {
                    font-size: 0.75rem; /* Smaller table text */
                    padding: 0.4rem 0.6rem;
                }
                
                .btn-sm {
                    padding: 0.15rem 0.3rem;
                    font-size: 0.7rem;
                }
                
                .search-bar input,
                .search-bar button {
                    font-size: 0.75rem;
                    padding: 0.5rem 0.7rem;
                }
                
                .cart-item {
                    padding: 0.5rem 0;
                    font-size: 0.75rem;
                }
                
                .quantity-btn {
                    width: 20px;
                    height: 20px;
                    font-size: 0.65rem;
                }
                
                .total-amount {
                    font-size: 1rem;
                }
                
                .checkout-btn {
                    padding: 0.7rem;
                    font-size: 0.8rem;
                }
            }

            /* Specific optimization for 1920x1200 resolution */
            @media (min-width: 1920px) and (max-height: 1200px) {
                .pos-container {
                    height: calc(100vh - 50px); /* Optimized for 1920x1200 */
                    gap: 1.25rem;
                    padding: 1.25rem;
                }
                
                .category-list {
                    max-height: calc(100vh - 180px); /* Optimized height for 1920x1200 */
                }
                
                .table-responsive {
                    max-height: calc(100vh - 280px); /* Optimized height for 1920x1200 */
                }
                
                .cart-items {
                    max-height: calc(100vh - 320px); /* Optimized height for 1920x1200 */
                }
            }

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
                                <div class="category-item" data-category-id="<%= category.getCategoryId() %>" data-category-name="<%= category.getCategoryName().replace("\"", "&quot;") %>" onclick="selectCategoryFromItem(this)">
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
                        
                        <!-- Search Bar -->
                        <div class="book-search-container">
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-search"></i>
                                </span>
                                <input type="text" class="form-control" id="bookSearch" placeholder="Search books by title, ID, or category...">
                                <button class="btn btn-outline-secondary" type="button" onclick="clearBookSearch()">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        
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
                                            if (book.getStockQuantity() <= 0) { continue; }
                                    %>
                                    <tr data-category-id="<%= book.getCategory().getCategoryId() %>">
                                        <td><%= book.getBookId() %></td>
                                        <td><%= book.getTitle() %></td>
                                        <td><%= book.getPricePerUnit() %></td>
                                        <td><%= book.getStockQuantity() %></td>
                                        <td><%= book.getCategory().getCategoryName() %></td>
                                        <td>
                                            <button class="btn btn-sm btn-primary" 
                                                data-book-id="<%= book.getBookId() %>"
                                                data-book-title="<%= book.getTitle().replace("\"", "&quot;") %>"
                                                data-book-price="<%= book.getPricePerUnit() %>"
                                                data-book-stock="<%= book.getStockQuantity() %>"
                                                data-book-category="<%= book.getCategory().getCategoryName().replace("\"", "&quot;") %>"
                                                onclick="showQuantityFromButton(this)">
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
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h6 class="mb-0">Select Customer</h6>
                                    <button type="button" class="btn btn-sm btn-primary" onclick="showAddCustomerModal()">
                                        <i class="bi bi-person-plus me-1"></i>Add Customer
                                    </button>
                                </div>
                                <div class="customer-search">
                                    <input type="text" class="form-control" id="customerSearch" placeholder="Search customers...">
                                </div>
                                <div class="customer-list" id="customerList">
                                    <% for (Customer customer : customers) { %>
                                        <div class="customer-item" 
                                             data-customer-id="<%= customer.getCustomerId() %>"
                                             data-customer-name="<%= customer.getName().replace("\"", "&quot;") %>"
                                             data-customer-email="<%= customer.getEmail() != null ? customer.getEmail().replace("\"", "&quot;") : "" %>"
                                             onclick="selectCustomerFromItem(this)">
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
                                    <strong>Total: <span id="modalTotal">0.00</span></strong>
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

        <!-- Add Customer Modal (with email verification, same as Customer Management) -->
        <div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCustomerModalLabel">
                            <i class="bi bi-person-plus me-2"></i>Add New Customer
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-2">
                            <div class="col-md-6">
                                <label class="form-label">Customer Name<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="posName">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Phone Number<span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="posPhone" onblur="posCheckPhoneOnBlur(this.value)">
                                <div id="posPhoneWarning" class="text-danger mt-1" style="display: none;">
                                    <i class="bi bi-exclamation-triangle me-1"></i>
                                    <small>This phone number is already registered.</small>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-2">
                            <div class="col-md-12">
                                <label class="form-label">Address<span class="text-danger">*</span></label>
                                <textarea class="form-control" id="posAddress" rows="2"></textarea>
                            </div>
                        </div>

                        <div class="row mb-2">
                            <div class="col-md-4">
                                <label class="form-label">Username<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="posUsername" onblur="posCheckUsernameOnBlur(this.value)">
                                <div id="posUsernameWarning" class="text-danger mt-1" style="display: none;">
                                    <i class="bi bi-exclamation-triangle me-1"></i>
                                    <small>This username is already taken.</small>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Email<span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input type="email" class="form-control" id="posEmail">
                                    <button class="btn btn-outline-primary" type="button" id="posSendVerificationBtn" onclick="posSendVerificationCode()">
                                        <i class="bi bi-envelope"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label">Password<span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="posPassword">
                                    <button class="btn btn-outline-secondary" type="button" onclick="posTogglePassword()">
                                        <i class="bi bi-eye" id="posPasswordIcon"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Verification Pin</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="posVerificationPin" placeholder="Enter 6-digit code" maxlength="6" disabled>
                                    <button class="btn btn-outline-success" type="button" id="posVerifyPinBtn" onclick="posVerifyPin()" disabled>
                                        <i class="bi bi-check-circle"></i>
                                    </button>
                                </div>
                                <small class="form-text text-muted">Click the envelope button to receive code</small>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Email Status</label>
                                <div class="d-flex align-items-center">
                                    <span id="posEmailStatus" class="badge bg-secondary">Not Verified</span>
                                    <div id="posVerificationSpinner" class="spinner-border spinner-border-sm ms-2" style="display: none;"></div>
                                </div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary" id="posAddCustomerBtn" onclick="saveNewCustomer()" disabled>
                                <i class="bi bi-save me-1"></i>Save Customer & Confirm
                            </button>
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
            let bookStockMap = {}; // bookId -> remaining stock (client-side)

            function initBookStockMap() {
                const rows = document.querySelectorAll('#bookTableBody tr');
                rows.forEach(row => {
                    const idCell = row.cells && row.cells[0];
                    const stockCell = row.cells && row.cells[3];
                    if (!idCell || !stockCell) return;
                    const id = parseInt(idCell.textContent.trim());
                    const stock = parseInt(stockCell.textContent.trim());
                    if (!isNaN(id) && !isNaN(stock)) {
                        if (bookStockMap[id] == null) {
                            bookStockMap[id] = stock;
                        }
                        updateRowStockUI(id, bookStockMap[id]);
                    }
                });
            }

            function getRemainingStock(bookId) {
                if (bookStockMap[bookId] != null) return bookStockMap[bookId];
                // Fallback: read from table
                const rows = document.querySelectorAll('#bookTableBody tr');
                for (const row of rows) {
                    const id = parseInt(row.cells[0].textContent.trim());
                    if (id === bookId) {
                        const stock = parseInt(row.cells[3].textContent.trim());
                        bookStockMap[bookId] = isNaN(stock) ? 0 : stock;
                        return bookStockMap[bookId];
                    }
                }
                return 0;
            }

            function updateRowStockUI(bookId, remaining) {
                const rows = document.querySelectorAll('#bookTableBody tr');
                for (const row of rows) {
                    const id = parseInt(row.cells[0].textContent.trim());
                    if (id === bookId) {
                        // Update stock cell
                        row.cells[3].textContent = String(remaining);
                        // Toggle Add to Cart button
                        const btn = row.querySelector('button.btn.btn-sm.btn-primary');
                        if (btn) {
                            if (remaining <= 0) {
                                btn.disabled = true;
                                btn.textContent = 'Out of Stock';
                            } else {
                                btn.disabled = false;
                                btn.textContent = 'Add to Cart';
                            }
                        }
                        break;
                    }
                }
            }

            // Toggle sidebar on mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.toggle('show');
            }

            // Safe onclick wrappers to avoid inline parsing issues
            function selectCategoryFromItem(el) {
                const id = parseInt(el.getAttribute('data-category-id'));
                const name = el.getAttribute('data-category-name');
                selectCategory(id, name);
            }

            function showQuantityFromButton(btn) {
                const book = {
                    id: parseInt(btn.getAttribute('data-book-id')),
                    title: btn.getAttribute('data-book-title'),
                    price: parseFloat(btn.getAttribute('data-book-price')),
                    stock: parseInt(btn.getAttribute('data-book-stock')),
                    category: btn.getAttribute('data-book-category')
                };
                showQuantityModal(book);
            }

            function selectCustomerFromItem(el) {
                const id = parseInt(el.getAttribute('data-customer-id'));
                const name = el.getAttribute('data-customer-name');
                const email = el.getAttribute('data-customer-email') || '';
                selectCustomer(id, name, email);
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

            // Search books function
            function searchBooks(searchTerm) {
                const bookRows = document.querySelectorAll('#bookTableBody tr');
                let visibleCount = 0;
                
                bookRows.forEach(row => {
                    // Skip rows that are already hidden by category filter
                    if (row.style.display === 'none') {
                        return;
                    }
                    
                    const bookId = row.cells[0].textContent.toLowerCase();
                    const bookTitle = row.cells[1].textContent.toLowerCase();
                    const bookPrice = row.cells[2].textContent.toLowerCase();
                    const bookStock = row.cells[3].textContent.toLowerCase();
                    const bookCategory = row.cells[4].textContent.toLowerCase();
                    
                    const matchesSearch = bookId.includes(searchTerm) || 
                                       bookTitle.includes(searchTerm) || 
                                       bookPrice.includes(searchTerm) || 
                                       bookStock.includes(searchTerm) || 
                                       bookCategory.includes(searchTerm);
                    
                    if (matchesSearch) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });
                
                // Show "no results" message if no books match search
                if (visibleCount === 0) {
                    // Remove existing "no results" row if it exists
                    const existingNoResults = document.querySelector('#noResultsRow');
                    if (existingNoResults) {
                        existingNoResults.remove();
                    }
                    
                    const noResultsRow = document.createElement('tr');
                    noResultsRow.id = 'noResultsRow';
                    noResultsRow.innerHTML = `
                        <td colspan="6" class="text-center text-muted">
                            <i class="bi bi-search" style="font-size: 2rem;"></i>
                            <p>No books found matching "${searchTerm}"</p>
                        </td>
                    `;
                    document.getElementById('bookTableBody').appendChild(noResultsRow);
                } else {
                    // Remove "no results" row if it exists and we have results
                    const existingNoResults = document.querySelector('#noResultsRow');
                    if (existingNoResults) {
                        existingNoResults.remove();
                    }
                }
            }

            // Clear book search
            function clearBookSearch() {
                document.getElementById('bookSearch').value = '';
                // Re-apply category filter to show all books in current category
                filterBooksByCategory(selectedCategoryId);
            }

            // Show quantity modal
            function showQuantityModal(book) {
                // Override stock with remaining stock map
                const remaining = getRemainingStock(book.id);
                currentBook = Object.assign({}, book, { stock: remaining });
                document.getElementById('bookTitle').textContent = book.title;
                document.getElementById('bookPrice').textContent = book.price.toFixed(2);
                document.getElementById('bookStock').textContent = remaining;
                document.getElementById('quantityInput').value = 1;
                document.getElementById('quantityInput').max = Math.max(remaining, 0);
                
                const modal = new bootstrap.Modal(document.getElementById('quantityModal'));
                modal.show();
            }

            // Confirm add to cart
            function confirmAddToCart() {
                const quantity = parseInt(document.getElementById('quantityInput').value);
                const stock = currentBook.stock;
                
                if (quantity < 1) {
                    showToast('Quantity must be at least 1', 'warning');
                    return;
                }
                
                if (quantity > stock) {
                    showToast('Quantity cannot exceed available stock', 'warning');
                    return;
                }
                
                const existingItem = cart.find(item => item.id === currentBook.id);
                
                if (existingItem) {
                    const newTotal = existingItem.quantity + quantity;
                    if (newTotal > stock) {
                        showToast('Total quantity cannot exceed available stock', 'warning');
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
                
                // Update remaining stock and UI
                const remaining = Math.max(getRemainingStock(currentBook.id) - quantity, 0);
                bookStockMap[currentBook.id] = remaining;
                updateRowStockUI(currentBook.id, remaining);

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
                    
                    // Display cart items in reverse order (newest first)
                    cart.slice().reverse().forEach(item => {
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
                if (!item) return;

                const remaining = getRemainingStock(productId);
                const currentQty = item.quantity;
                const newQuantity = currentQty + change;

                if (change === 1) {
                    // Increase quantity: require available remaining stock
                    if (remaining <= 0) {
                        showToast('Quantity cannot exceed available stock', 'warning');
                        return;
                    }
                    item.quantity = currentQty + 1;
                    bookStockMap[productId] = remaining - 1;
                    updateRowStockUI(productId, bookStockMap[productId]);
                } else if (change === -1) {
                    // Decrease quantity: restore stock
                    if (newQuantity <= 0) {
                        // Removing entire item from cart, restore all its quantity
                        bookStockMap[productId] = remaining + currentQty;
                        cart = cart.filter(i => i.id !== productId);
                    } else {
                        item.quantity = newQuantity;
                        bookStockMap[productId] = remaining + 1;
                    }
                    updateRowStockUI(productId, bookStockMap[productId]);
                } else {
                    // Other changes not supported
                    return;
                }

                updateCartDisplay();
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
                
                // Add event listener for book search
                const bookSearchInput = document.getElementById('bookSearch');
                if (bookSearchInput) {
                    bookSearchInput.addEventListener('input', function() {
                        const searchTerm = this.value.toLowerCase().trim();
                        if (searchTerm === '') {
                            // If search is empty, re-apply category filter
                            filterBooksByCategory(selectedCategoryId);
                        } else {
                            // Apply search filter
                            searchBooks(searchTerm);
                        }
                    });
                }

                // Initialize client-side stock snapshot
                initBookStockMap();
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

            // Show Add Customer Modal
            function showAddCustomerModal() {
                // Reset form
                ['posName','posEmail','posPhone','posAddress','posUsername','posPassword','posVerificationPin']
                    .forEach(id => { const el = document.getElementById(id); if (el) el.value = ''; });
                document.getElementById('posEmailStatus').textContent = 'Not Verified';
                document.getElementById('posEmailStatus').className = 'badge bg-secondary';
                document.getElementById('posVerificationSpinner').style.display = 'none';
                document.getElementById('posSendVerificationBtn').disabled = false;
                document.getElementById('posVerificationPin').disabled = true;
                document.getElementById('posVerifyPinBtn').disabled = true;
                document.getElementById('posAddCustomerBtn').disabled = true;
                const modal = new bootstrap.Modal(document.getElementById('addCustomerModal'));
                modal.show();
            }

            // Save new customer via AJAX then auto confirm transaction
            function saveNewCustomer() {
                const name = document.getElementById('posName').value.trim();
                const email = document.getElementById('posEmail').value.trim();
                const phone = document.getElementById('posPhone').value.trim();
                const address = document.getElementById('posAddress').value.trim();
                const username = document.getElementById('posUsername').value.trim();
                const password = document.getElementById('posPassword').value.trim();

                if (!name || !email || !phone || !address) {
                    showToast('Name, Email, Phone and Address are required', 'warning');
                    return;
                }

                if (cart.length === 0) {
                    showToast('Cart is empty. Add items before creating a customer.', 'warning');
                    return;
                }

                const btn = document.getElementById('posAddCustomerBtn');
                btn.disabled = true;
                btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Saving...';

                const params = new URLSearchParams();
                params.append('name', name);
                params.append('email', email);
                params.append('phone', phone);
                params.append('address', address);
                params.append('username', username);
                params.append('password', password);

                fetch('CustomerServlet?action=create-ajax', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: params.toString()
                })
                .then(r => r.json())
                .then(data => {
                    if (data.success) {
                        selectedCustomer = { id: data.customerId, name: data.name, email: data.email };
                        showToast('Customer created successfully. Processing transaction...', 'success');
                        const modal = bootstrap.Modal.getInstance(document.getElementById('addCustomerModal'));
                        if (modal) modal.hide();
                        // Proceed to process transaction
                        processTransaction();
                    } else {
                        showToast(data.message || 'Failed to create customer', 'error');
                    }
                })
                .catch(err => {
                    console.error('Create customer error:', err);
                    showToast('Error creating customer. Please try again.', 'error');
                })
                .finally(() => {
                    btn.disabled = false;
                    btn.innerHTML = '<i class="bi bi-save me-1"></i>Save Customer & Confirm';
                });
            }

            // POS email verification logic (mirrors customer.jsp)
            let posEmailVerified = false;
            function posSendVerificationCode() {
                const email = document.getElementById('posEmail').value.trim();
                if (!email) { showToast('Enter email first', 'warning'); return; }
                document.getElementById('posVerificationSpinner').style.display = 'inline-block';
                document.getElementById('posSendVerificationBtn').disabled = true;
                document.getElementById('posEmailStatus').textContent = 'Checking email...';
                document.getElementById('posEmailStatus').className = 'badge bg-warning';

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
                                    document.getElementById('posVerificationSpinner').style.display = 'none';
                                    document.getElementById('posSendVerificationBtn').disabled = false;
                                    document.getElementById('posEmailStatus').textContent = 'Email Exists';
                                    document.getElementById('posEmailStatus').className = 'badge bg-danger';
                                    showToast('Email already registered. Use a different email.', 'error');
                                    return;
                                } else {
                                    posSendVerificationEmail(email);
                                }
                            } catch (e) {
                                posSendVerificationEmail(email);
                            }
                        } else {
                            posSendVerificationEmail(email);
                        }
                    }
                };
                checkEmailXhr.onerror = function(){ posSendVerificationEmail(email); };
                checkEmailXhr.send('email=' + encodeURIComponent(email));
            }

            function posSendVerificationEmail(email) {
                document.getElementById('posVerificationSpinner').style.display = 'inline-block';
                document.getElementById('posSendVerificationBtn').disabled = true;
                document.getElementById('posEmailStatus').textContent = 'Sending...';
                document.getElementById('posEmailStatus').className = 'badge bg-warning';
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=send-verification', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        document.getElementById('posVerificationSpinner').style.display = 'none';
                        document.getElementById('posSendVerificationBtn').disabled = false;
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.status === 'success') {
                                    showToast('Verification code sent to email', 'success');
                                    document.getElementById('posEmailStatus').textContent = 'Code Sent';
                                    document.getElementById('posEmailStatus').className = 'badge bg-info';
                                    document.getElementById('posVerificationPin').disabled = false;
                                    document.getElementById('posVerifyPinBtn').disabled = false;
                                } else {
                                    showToast(response.message || 'Failed to send code', 'error');
                                    document.getElementById('posEmailStatus').textContent = 'Failed';
                                    document.getElementById('posEmailStatus').className = 'badge bg-danger';
                                }
                            } catch (e) {
                                showToast('Verification code sent', 'success');
                                document.getElementById('posEmailStatus').textContent = 'Code Sent';
                                document.getElementById('posEmailStatus').className = 'badge bg-info';
                                document.getElementById('posVerificationPin').disabled = false;
                                document.getElementById('posVerifyPinBtn').disabled = false;
                            }
                        } else {
                            showToast('Failed to send code', 'error');
                            document.getElementById('posEmailStatus').textContent = 'Failed';
                            document.getElementById('posEmailStatus').className = 'badge bg-danger';
                        }
                    }
                };
                xhr.send('email=' + encodeURIComponent(email) + '&context=pos');
            }

            function posVerifyPin() {
                const email = document.getElementById('posEmail').value.trim();
                const pin = document.getElementById('posVerificationPin').value.trim();
                if (!pin) { showToast('Enter the verification code', 'warning'); return; }
                document.getElementById('posVerificationSpinner').style.display = 'inline-block';
                document.getElementById('posVerifyPinBtn').disabled = true;
                document.getElementById('posEmailStatus').textContent = 'Verifying...';
                document.getElementById('posEmailStatus').className = 'badge bg-warning';
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=verify-email', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        document.getElementById('posVerificationSpinner').style.display = 'none';
                        document.getElementById('posVerifyPinBtn').disabled = false;
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.status === 'success') {
                                    showToast('Email verified', 'success');
                                    document.getElementById('posEmailStatus').textContent = 'Verified';
                                    document.getElementById('posEmailStatus').className = 'badge bg-success';
                                    posEmailVerified = true;
                                    document.getElementById('posVerificationPin').disabled = true;
                                    document.getElementById('posVerifyPinBtn').disabled = true;
                                    document.getElementById('posSendVerificationBtn').disabled = true;
                                    document.getElementById('posAddCustomerBtn').disabled = false;
                                } else {
                                    showToast(response.message || 'Invalid code', 'error');
                                    document.getElementById('posEmailStatus').textContent = 'Invalid Code';
                                    document.getElementById('posEmailStatus').className = 'badge bg-danger';
                                }
                            } catch (e) {
                                showToast('Email verified', 'success');
                                document.getElementById('posEmailStatus').textContent = 'Verified';
                                document.getElementById('posEmailStatus').className = 'badge bg-success';
                                posEmailVerified = true;
                                document.getElementById('posVerificationPin').disabled = true;
                                document.getElementById('posVerifyPinBtn').disabled = true;
                                document.getElementById('posSendVerificationBtn').disabled = true;
                                document.getElementById('posAddCustomerBtn').disabled = false;
                            }
                        } else {
                            showToast('Failed to verify code', 'error');
                            document.getElementById('posEmailStatus').textContent = 'Failed';
                            document.getElementById('posEmailStatus').className = 'badge bg-danger';
                        }
                    }
                };
                xhr.send('email=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(pin));
            }

            function posCheckPhoneOnBlur(phone) {
                if (!phone) return; 
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=check-phone-exists', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                xhr.onreadystatechange = function(){
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        try { const res = JSON.parse(xhr.responseText); 
                            document.getElementById('posPhoneWarning').style.display = (res.status==='success' && res.exists) ? 'block' : 'none';
                        } catch(e) { document.getElementById('posPhoneWarning').style.display = 'none'; }
                    }
                };
                xhr.send('phone=' + encodeURIComponent(phone));
            }

            function posCheckUsernameExists(username, callback){
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=check-username-exists', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                xhr.onreadystatechange = function(){
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            try { const res = JSON.parse(xhr.responseText); callback(res.status==='success' && res.exists); } catch(e){ callback(false); }
                        } else { callback(false); }
                    }
                };
                xhr.send('username=' + encodeURIComponent(username));
            }

            function posCheckUsernameOnBlur(username){
                if (!username) return;
                posCheckUsernameExists(username, function(exists){
                    document.getElementById('posUsernameWarning').style.display = exists ? 'block' : 'none';
                });
            }

            function posTogglePassword(){
                const input = document.getElementById('posPassword');
                const icon = document.getElementById('posPasswordIcon');
                if (input.type === 'password') { input.type = 'text'; icon.classList.remove('bi-eye'); icon.classList.add('bi-eye-slash'); }
                else { input.type = 'password'; icon.classList.remove('bi-eye-slash'); icon.classList.add('bi-eye'); }
            }
        </script>
    </body>
</html> 