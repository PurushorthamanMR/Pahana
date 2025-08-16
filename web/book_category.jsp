<%-- 
    Document   : book_category
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
        <title>Pahana - Book Category Management</title>
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

            .alert-info {
                background-color: #d1ecf1;
                color: #0c5460;
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

            .btn-delete {
                background-color: #dc3545;
                border-color: #dc3545;
                color: white;
                transition: all 0.3s ease;
            }

            .btn-delete:hover {
                background-color: #c82333;
                border-color: #bd2130;
                color: white;
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
            
            // Check role-based access
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied.");
                return;
            }
            
            // If no book categories data is loaded, redirect to servlet to load data
            if (request.getAttribute("bookCategories") == null) {
                response.sendRedirect("BookCategoryServlet?action=list");
                return;
            }
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "bookcategory");
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
                        <h1 class="h3 mb-0">Book Category Management</h1>
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

                <!-- Book Category Management Content -->
                <div class="content-card">
                    <h3 class="card-title">
                        <span><i class="bi bi-tags me-2"></i>Book Category Management</span>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal" onclick="resetAddCategoryModal()">
                            <i class="bi bi-plus-circle me-2"></i>Add Category
                        </button>
                    </h3>
                    
                    <!-- Book Categories Table -->
                    <div class="table-responsive">
                        <!-- Search Bar -->
                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-search"></i>
                                </span>
                                <input type="text" class="form-control" id="categorySearch" placeholder="Search categories by ID or name...">
                                <button class="btn btn-outline-secondary" type="button" onclick="clearCategorySearch()">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Category Name</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                List<BookCategory> bookCategories = (List<BookCategory>) request.getAttribute("bookCategories");
                                if (bookCategories != null && !bookCategories.isEmpty()) {
                                    for (BookCategory category : bookCategories) {
                                %>
                                <tr>
                                    <td><%= category.getCategoryId() %></td>
                                    <td><%= category.getCategoryName() %></td>
                                    <td>
                                        <button class="btn btn-sm btn-edit" 
                                                onclick="editCategory(<%= category.getCategoryId() %>, '<%= category.getCategoryName() %>')" title="Edit Category">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button class="btn btn-sm btn-delete" 
                                                onclick="deleteCategory(<%= category.getCategoryId() %>, '<%= category.getCategoryName() %>')" title="Delete Category">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="3" class="text-center text-muted">
                                        <i class="bi bi-inbox me-2"></i>No book categories found
                                    </td>
                                </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Add Category Modal -->
                <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addCategoryModalLabel">
                                    <i class="bi bi-plus-circle me-2"></i>Add New Category
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="BookCategoryServlet" method="post" onsubmit="return validateAddCategory(event)">
                                <input type="hidden" name="action" value="add">
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="categoryName" class="form-label">Category Name</label>
                                        <input type="text" class="form-control" id="categoryName" name="categoryName" oninput="hideAddDupWarning()" 
                                               required placeholder="Enter category name">
                                        <div id="addDupWarning" class="text-danger mt-1" style="display:none;">
                                            <i class="bi bi-exclamation-triangle me-1"></i>
                                            <small>Category name already exists.</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Add Category
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Edit Category Modal -->
                <div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editCategoryModalLabel">
                                    <i class="bi bi-pencil me-2"></i>Edit Category
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="BookCategoryServlet" method="post" onsubmit="return validateEditCategory(event)">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="categoryId" id="editCategoryId">
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="editCategoryName" class="form-label">Category Name</label>
                                        <input type="text" class="form-control" id="editCategoryName" name="categoryName" oninput="hideEditDupWarning()"
                                               required placeholder="Enter category name">
                                        <div id="editDupWarning" class="text-danger mt-1" style="display:none;">
                                            <i class="bi bi-exclamation-triangle me-1"></i>
                                            <small>Category name already exists.</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-check-circle me-2"></i>Update Category
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Delete Confirmation Modal -->
                <div class="modal fade" id="deleteCategoryModal" tabindex="-1" aria-labelledby="deleteCategoryModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteCategoryModalLabel">
                                    <i class="bi bi-exclamation-triangle me-2"></i>Confirm Delete
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to delete the category "<span id="deleteCategoryName"></span>"?</p>
                                <p class="text-danger"><small>This action cannot be undone.</small></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                                    <i class="bi bi-trash me-2"></i>Delete Category
                                </a>
                            </div>
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

            // Edit category function
            function editCategory(categoryId, categoryName) {
                document.getElementById('editCategoryId').value = categoryId;
                document.getElementById('editCategoryName').value = categoryName;
                hideEditDupWarning();
                new bootstrap.Modal(document.getElementById('editCategoryModal')).show();
            }

            // Delete category function
            function deleteCategory(categoryId, categoryName) {
                document.getElementById('deleteCategoryName').textContent = categoryName;
                document.getElementById('confirmDeleteBtn').href = 'BookCategoryServlet?action=delete&id=' + categoryId;
                new bootstrap.Modal(document.getElementById('deleteCategoryModal')).show();
            }

            // Search categories function
            function searchCategories(searchTerm) {
                const tableRows = document.querySelectorAll('tbody tr');
                let visibleCount = 0;
                
                tableRows.forEach(row => {
                    const categoryId = row.cells[0].textContent.toLowerCase();
                    const categoryName = row.cells[1].textContent.toLowerCase();
                    
                    const matchesSearch = categoryId.includes(searchTerm) || 
                                        categoryName.includes(searchTerm);
                    
                    if (matchesSearch) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });
                
                // Show "no results" message if no categories match search
                if (visibleCount === 0) {
                    // Remove existing "no results" row if it exists
                    const existingNoResults = document.querySelector('#noResultsRow');
                    if (existingNoResults) {
                        existingNoResults.remove();
                    }
                    
                    const noResultsRow = document.createElement('tr');
                    noResultsRow.id = 'noResultsRow';
                    noResultsRow.innerHTML = `
                        <td colspan="3" class="text-center text-muted">
                            <i class="bi bi-search" style="font-size: 2rem;"></i>
                            <p>No categories found matching "${searchTerm}"</p>
                        </td>
                    `;
                    document.querySelector('tbody').appendChild(noResultsRow);
                } else {
                    // Remove "no results" row if it exists and we have results
                    const existingNoResults = document.querySelector('#noResultsRow');
                    if (existingNoResults) {
                        existingNoResults.remove();
                    }
                }
            }

            // Clear category search
            function clearCategorySearch() {
                document.getElementById('categorySearch').value = '';
                // Show all categories
                const tableRows = document.querySelectorAll('tbody tr');
                tableRows.forEach(row => {
                    row.style.display = '';
                });
                
                // Remove "no results" row if it exists
                const existingNoResults = document.querySelector('#noResultsRow');
                if (existingNoResults) {
                    existingNoResults.remove();
                }
            }

            // Initialize search functionality
            document.addEventListener('DOMContentLoaded', function() {
                const categorySearchInput = document.getElementById('categorySearch');
                if (categorySearchInput) {
                    categorySearchInput.addEventListener('input', function() {
                        const searchTerm = this.value.toLowerCase().trim();
                        if (searchTerm === '') {
                            // If search is empty, show all categories
                            clearCategorySearch();
                        } else {
                            // Apply search filter
                            searchCategories(searchTerm);
                        }
                    });
                }
            });

            // Duplicate validation helpers
            function resetAddCategoryModal(){
                const input = document.getElementById('categoryName');
                if (input) input.value = '';
                hideAddDupWarning();
            }

            function hideAddDupWarning(){
                const warn = document.getElementById('addDupWarning');
                if (warn) warn.style.display = 'none';
            }

            function hideEditDupWarning(){
                const warn = document.getElementById('editDupWarning');
                if (warn) warn.style.display = 'none';
            }

            function validateAddCategory(e){
                const name = document.getElementById('categoryName').value.trim();
                if (!name) return true;
                e.preventDefault();
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'BookCategoryServlet?action=check-name', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                xhr.onreadystatechange = function(){
                    if (xhr.readyState === 4){
                        try {
                            const res = JSON.parse(xhr.responseText);
                            if (res.success && res.exists){
                                const warn = document.getElementById('addDupWarning');
                                if (warn) warn.style.display = 'block';
                            } else {
                                e.target.submit();
                            }
                        } catch(ex){
                            e.target.submit();
                        }
                    }
                };
                xhr.send('name=' + encodeURIComponent(name));
                return false;
            }

            function validateEditCategory(e){
                const name = document.getElementById('editCategoryName').value.trim();
                const id = document.getElementById('editCategoryId').value;
                if (!name) return true;
                e.preventDefault();
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'BookCategoryServlet?action=check-name', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                xhr.onreadystatechange = function(){
                    if (xhr.readyState === 4){
                        try {
                            const res = JSON.parse(xhr.responseText);
                            if (res.success && res.exists){
                                const warn = document.getElementById('editDupWarning');
                                if (warn) warn.style.display = 'block';
                            } else {
                                e.target.submit();
                            }
                        } catch(ex){
                            e.target.submit();
                        }
                    }
                };
                xhr.send('name=' + encodeURIComponent(name) + '&excludeId=' + encodeURIComponent(id));
                return false;
            }
        </script>
    </body>
</html> 
