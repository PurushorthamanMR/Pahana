/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

import com.booking.dao.BookDAO;
import com.booking.dao.BookCategoryDAO;
import com.booking.models.Book;
import com.booking.models.BookCategory;
import com.booking.models.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
import java.io.PrintWriter;

/**
 *
 * @author pruso
 */
public class BookServlet extends HttpServlet {

    private BookDAO bookDAO;
    private BookCategoryDAO bookCategoryDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        bookDAO = new BookDAO();
        bookCategoryDAO = new BookCategoryDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
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

        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listBooks(request, response);
                    break;
                case "add":
                    addBook(request, response);
                    break;
                case "edit":
                    editBook(request, response);
                    break;
                case "update":
                    updateBook(request, response);
                    break;
                case "delete":
                    deleteBook(request, response);
                    break;
                case "getBooksByCategory":
                    getBooksByCategory(request, response);
                    break;
                default:
                    listBooks(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in BookServlet: " + e.getMessage());
            response.sendRedirect("book.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Book> books = bookDAO.getAllBooks();
        List<BookCategory> categories = bookCategoryDAO.getAllBookCategories();
        
        request.setAttribute("books", books);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("book.jsp").forward(request, response);
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String categoryIdStr = request.getParameter("categoryId");

        if (title == null || title.trim().isEmpty()) {
            response.sendRedirect("book.jsp?error=Book title is required.");
            return;
        }
        
        if (priceStr == null || priceStr.trim().isEmpty()) {
            response.sendRedirect("book.jsp?error=Price is required.");
            return;
        }
        
        if (stockStr == null || stockStr.trim().isEmpty()) {
            response.sendRedirect("book.jsp?error=Stock quantity is required.");
            return;
        }
        
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendRedirect("book.jsp?error=Category is required.");
            return;
        }

        try {
            BigDecimal price = new BigDecimal(priceStr);
            int stock = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("user");

            BookCategory category = new BookCategory();
            category.setCategoryId(categoryId);

            Book book = new com.booking.patterns.BuilderDP.BookBuilder()
                .title(title.trim())
                .description(description != null ? description.trim() : "")
                .pricePerUnit(price)
                .stockQuantity(stock)
                .category(category)
                .createdBy(currentUser)
                .build();

            boolean success = bookDAO.createBook(book);
            
            if (success) {
                response.sendRedirect("BookServlet?action=list&message=Book added successfully.");
            } else {
                response.sendRedirect("book.jsp?error=Failed to add book.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("book.jsp?error=Invalid price or stock quantity.");
        }
    }

    private void editBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookIdStr = request.getParameter("id");
        
        if (bookIdStr == null || bookIdStr.trim().isEmpty()) {
            response.sendRedirect("BookServlet?action=list&error=Book ID is required.");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            Book book = bookDAO.getBookById(bookId);
            
            if (book != null) {
                List<BookCategory> categories = bookCategoryDAO.getAllBookCategories();
                request.setAttribute("book", book);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("book_edit.jsp").forward(request, response);
            } else {
                response.sendRedirect("BookServlet?action=list&error=Book not found.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookServlet?action=list&error=Invalid book ID.");
        }
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookIdStr = request.getParameter("bookId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock");
        String categoryIdStr = request.getParameter("categoryId");

        if (bookIdStr == null || title == null || priceStr == null || 
            stockStr == null || categoryIdStr == null ||
            bookIdStr.trim().isEmpty() || title.trim().isEmpty() || 
            priceStr.trim().isEmpty() || stockStr.trim().isEmpty() || 
            categoryIdStr.trim().isEmpty()) {
            response.sendRedirect("BookServlet?action=list&error=All fields are required.");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            BigDecimal price = new BigDecimal(priceStr);
            int stock = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            Book book = new Book();
            book.setBookId(bookId);
            book.setTitle(title.trim());
            book.setDescription(description != null ? description.trim() : "");
            book.setPricePerUnit(price);
            book.setStockQuantity(stock);

            BookCategory category = new BookCategory();
            category.setCategoryId(categoryId);
            book.setCategory(category);

            boolean success = bookDAO.updateBook(book);
            
            if (success) {
                response.sendRedirect("BookServlet?action=list&message=Book updated successfully.");
            } else {
                response.sendRedirect("BookServlet?action=list&error=Failed to update book.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookServlet?action=list&error=Invalid price, stock quantity, or book ID.");
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String bookIdStr = request.getParameter("id");
        
        if (bookIdStr == null || bookIdStr.trim().isEmpty()) {
            response.sendRedirect("BookServlet?action=list&error=Book ID is required.");
            return;
        }

        try {
            int bookId = Integer.parseInt(bookIdStr);
            
            boolean success = bookDAO.deleteBook(bookId);
            
            if (success) {
                response.sendRedirect("BookServlet?action=list&message=Book deleted successfully.");
            } else {
                response.sendRedirect("BookServlet?action=list&error=Failed to delete book.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookServlet?action=list&error=Invalid book ID.");
        }
    }

    private void getBooksByCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("getBooksByCategory called");
        
        String categoryIdStr = request.getParameter("categoryId");
        
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category ID is required");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            List<Book> books;
            
            System.out.println("Getting books for category ID: " + categoryId);
            
            if (categoryId == 0) {
                books = bookDAO.getAllBooks();
                System.out.println("Retrieved " + (books != null ? books.size() : 0) + " books from getAllBooks()");
            } else {
                books = bookDAO.getBooksByCategory(categoryId);
                System.out.println("Retrieved " + (books != null ? books.size() : 0) + " books from getBooksByCategory(" + categoryId + ")");
            }
            
            if (books == null) {
                books = new ArrayList<>();
                System.out.println("Books list was null, created empty list");
            }
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            PrintWriter out = response.getWriter();
            out.print("[");
            
            for (int i = 0; i < books.size(); i++) {
                Book book = books.get(i);
                System.out.println("Processing book: " + book.getTitle() + " (ID: " + book.getBookId() + ")");
                
                out.print("{");
                out.print("\"id\":" + book.getBookId() + ",");
                out.print("\"title\":\"" + (book.getTitle() != null ? book.getTitle().replace("\"", "\\\"") : "") + "\",");
                out.print("\"price\":" + book.getPricePerUnit() + ",");
                out.print("\"stock\":" + book.getStockQuantity() + ",");
                out.print("\"category\":\"" + (book.getCategory() != null && book.getCategory().getCategoryName() != null ? book.getCategory().getCategoryName().replace("\"", "\\\"") : "") + "\"");
                out.print("}");
                
                if (i < books.size() - 1) {
                    out.print(",");
                }
            }
            
            out.print("]");
            out.flush();
            
            System.out.println("JSON response sent successfully");
            
        } catch (NumberFormatException e) {
            System.err.println("NumberFormatException: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid category ID");
        } catch (Exception e) {
            System.err.println("Exception in getBooksByCategory: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request: " + e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Book Management Servlet";
    }
} 