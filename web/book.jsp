

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.models.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pahana - Book Management</title>
        
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
            
            
            boolean canAccess = "ADMIN".equals(role) || "MANAGER".equals(role) || "CASHIER".equals(role);
            if (!canAccess) {
                response.sendRedirect("dashboard.jsp?error=Access denied.");
                return;
            }
            
            
            if (request.getAttribute("books") == null) {
                response.sendRedirect("BookServlet?action=list");
                return;
            }
            
            
            request.setAttribute("currentPage", "book");
        %>

        <div class="main-container">
            
            <jsp:include page="includes/sidebar.jsp" />

            
            <div class="main-content">
                
                <div class="header">
                    <div class="header-left">
                        <button class="menu-toggle" onclick="toggleSidebar()">
                            <i class="bi bi-list"></i>
                        </button>
                        <h1 class="h3 mb-0">Book Management</h1>
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
                        <span><i class="bi bi-book me-2"></i>Book Management</span>
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookModal">
                            <i class="bi bi-plus-circle me-2"></i>Add Book
                        </button>
                    </h3>
                    
                    
                    <div class="table-responsive">
                        
                        <div class="mb-3">
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-search"></i>
                                </span>
                                <input type="text" class="form-control" id="bookSearch" placeholder="Search books by ID, title, category, price, or stock...">
                                <button class="btn btn-outline-secondary" type="button" onclick="clearBookSearch()">
                                    <i class="bi bi-x-lg"></i>
                                </button>
                            </div>
                        </div>
                        
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Created By</th>
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
                                    <td>
                                        <strong><%= book.getTitle() %></strong>
                                        <% if (book.getDescription() != null && !book.getDescription().isEmpty()) { %>
                                        <br><small class="text-muted"><%= book.getDescription() %></small>
                                        <% } %>
                                    </td>
                                    <td><span class="badge bg-secondary"><%= book.getCategory().getCategoryName() %></span></td>
                                    <td><%= book.getPricePerUnit() %></td>
                                    <td>
                                        <span class="badge <%= book.getStockQuantity() > 10 ? "bg-success" : book.getStockQuantity() > 0 ? "bg-warning" : "bg-danger" %>">
                                            <%= book.getStockQuantity() %>
                                        </span>
                                    </td>
                                    <td><%= book.getCreatedBy().getUsername() %></td>
                                    <td>
                                        <button class="btn btn-sm btn-edit" 
                                                onclick="editBook(<%= book.getBookId() %>)" title="Edit Book">
                                            <i class="bi bi-pencil"></i>
                                        </button>
                                        <button class="btn btn-sm btn-delete" 
                                                onclick="deleteBook(<%= book.getBookId() %>, '<%= book.getTitle() %>')" title="Delete Book">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="7" class="text-center text-muted">
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

                
                <div class="modal fade" id="addBookModal" tabindex="-1" aria-labelledby="addBookModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addBookModalLabel">
                                    <i class="bi bi-plus-circle me-2"></i>Add New Book
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form action="BookServlet" method="post" onsubmit="return validateAddBook(event)">
                                <input type="hidden" name="action" value="add">
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="title" class="form-label">Book Title *</label>
                                                <input type="text" class="form-control" id="title" name="title" 
                                                       required placeholder="Enter book title">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="categoryId" class="form-label">Category *</label>
                                                <select class="form-select" id="categoryId" name="categoryId" required>
                                                    <option value="">Select Category</option>
                                                    <% 
                                                    List<BookCategory> categories = (List<BookCategory>) request.getAttribute("categories");
                                                    if (categories == null) {
                                                        
                                                        
                                                    } else {
                                                        for (BookCategory category : categories) {
                                                    %>
                                                    <option value="<%= category.getCategoryId() %>"><%= category.getCategoryName() %></option>
                                                    <%
                                                        }
                                                    }
                                                    %>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="price" class="form-label">Price *</label>
                                                <input type="number" class="form-control" id="price" name="price" 
                                                       step="0.01" min="0.01" required placeholder="0.00" oninput="hideAddBookWarnings()">
                                                <div id="addPriceWarning" class="text-danger mt-1" style="display:none;">
                                                    <i class="bi bi-exclamation-triangle me-1"></i>
                                                    <small>Price must be greater than 0.</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="stock" class="form-label">Stock Quantity *</label>
                                                <input type="number" class="form-control" id="stock" name="stock" 
                                                       min="1" required placeholder="1" oninput="hideAddBookWarnings()">
                                                <div id="addStockWarning" class="text-danger mt-1" style="display:none;">
                                                    <i class="bi bi-exclamation-triangle me-1"></i>
                                                    <small>Stock must be at least 1.</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" id="description" name="description" 
                                                  rows="3" placeholder="Enter book description (optional)"></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Add Book
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                
                <div class="modal fade" id="deleteBookModal" tabindex="-1" aria-labelledby="deleteBookModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteBookModalLabel">
                                    <i class="bi bi-exclamation-triangle me-2"></i>Confirm Delete
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>Are you sure you want to delete the book "<span id="deleteBookTitle"></span>"?</p>
                                <p class="text-danger"><small>This action cannot be undone.</small></p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <a href="#" id="confirmDeleteBookBtn" class="btn btn-danger">
                                    <i class="bi bi-trash me-2"></i>Delete Book
                                </a>
                            </div>
                        </div>
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


            function hideAddBookWarnings(){
                const pw = document.getElementById('addPriceWarning');
                const sw = document.getElementById('addStockWarning');
                if (pw) pw.style.display = 'none';
                if (sw) sw.style.display = 'none';
            }

            function validateAddBook(e){
                const priceInput = document.getElementById('price');
                const stockInput = document.getElementById('stock');
                const priceVal = parseFloat(priceInput.value);
                const stockVal = parseInt(stockInput.value, 10);
                let valid = true;
                if (isNaN(priceVal) || priceVal <= 0){
                    const pw = document.getElementById('addPriceWarning');
                    if (pw) pw.style.display = 'block';
                    valid = false;
                }
                if (isNaN(stockVal) || stockVal <= 0){
                    const sw = document.getElementById('addStockWarning');
                    if (sw) sw.style.display = 'block';
                    valid = false;
                }
                if (!valid){
                    e.preventDefault();
                    return false;
                }
                return true;
            }


            function editBook(bookId) {
                window.location.href = 'BookServlet?action=edit&id=' + bookId;
            }


            function deleteBook(bookId, bookTitle) {
                document.getElementById('deleteBookTitle').textContent = bookTitle;
                document.getElementById('confirmDeleteBookBtn').href = 'BookServlet?action=delete&id=' + bookId;
                new bootstrap.Modal(document.getElementById('deleteBookModal')).show();
            }


            function searchBooks(searchTerm) {
                const tableRows = document.querySelectorAll('tbody tr');
                let visibleCount = 0;
                
                tableRows.forEach(row => {
                    const bookId = row.cells[0].textContent.toLowerCase();
                    const bookTitle = row.cells[1].textContent.toLowerCase();
                    const bookCategory = row.cells[2].textContent.toLowerCase();
                    const bookPrice = row.cells[3].textContent.toLowerCase();
                    const bookStock = row.cells[4].textContent.toLowerCase();
                    
                    const matchesSearch = bookId.includes(searchTerm) || 
                                        bookTitle.includes(searchTerm) || 
                                        bookCategory.includes(searchTerm) || 
                                        bookPrice.includes(searchTerm) || 
                                        bookStock.includes(searchTerm);
                    
                    if (matchesSearch) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });
                

                if (visibleCount === 0) {

                    const existingNoResults = document.querySelector('#noResultsRow');
                    if (existingNoResults) {
                        existingNoResults.remove();
                    }
                    
                    const noResultsRow = document.createElement('tr');
                    noResultsRow.id = 'noResultsRow';
                    noResultsRow.innerHTML = `
                        <td colspan="7" class="text-center text-muted">
                            <i class="bi bi-search" style="font-size: 2rem;"></i>
                            <p>No books found matching "${searchTerm}"</p>
                        </td>
                    `;
                    document.querySelector('tbody').appendChild(noResultsRow);
                } else {

                    const existingNoResults = document.querySelector('#noResultsRow');
                    if (existingNoResults) {
                        existingNoResults.remove();
                    }
                }
            }


            function clearBookSearch() {
                document.getElementById('bookSearch').value = '';

                const tableRows = document.querySelectorAll('tbody tr');
                tableRows.forEach(row => {
                    row.style.display = '';
                });
                

                const existingNoResults = document.querySelector('#noResultsRow');
                if (existingNoResults) {
                    existingNoResults.remove();
                }
            }


            document.addEventListener('DOMContentLoaded', function() {
                const bookSearchInput = document.getElementById('bookSearch');
                if (bookSearchInput) {
                    bookSearchInput.addEventListener('input', function() {
                        const searchTerm = this.value.toLowerCase().trim();
                        if (searchTerm === '') {

                            clearBookSearch();
                        } else {

                            searchBooks(searchTerm);
                        }
                    });
                }
            });
        </script>
    </body>
</html> 