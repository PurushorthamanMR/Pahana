/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

import com.booking.dao.BookCategoryDAO;
import com.booking.models.BookCategory;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author pruso
 */
public class BookCategoryServlet extends HttpServlet {

    private BookCategoryDAO bookCategoryDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        bookCategoryDAO = new BookCategoryDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession();
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

        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listBookCategories(request, response);
                    break;
                case "add":
                    addBookCategory(request, response);
                    break;
                case "check-name":
                    checkCategoryName(request, response);
                    break;
                case "edit":
                    editBookCategory(request, response);
                    break;
                case "update":
                    updateBookCategory(request, response);
                    break;
                case "delete":
                    deleteBookCategory(request, response);
                    break;
                default:
                    listBookCategories(request, response);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in BookCategoryServlet: " + e.getMessage());
            response.sendRedirect("book_category.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    private void listBookCategories(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<BookCategory> bookCategories = bookCategoryDAO.getAllBookCategories();
        request.setAttribute("bookCategories", bookCategories);
        request.getRequestDispatcher("book_category.jsp").forward(request, response);
    }

    private void addBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryName = request.getParameter("categoryName");
        
        if (categoryName == null || categoryName.trim().isEmpty()) {
            response.sendRedirect("book_category.jsp?error=Category name is required.");
            return;
        }

        // Duplicate validation
        if (bookCategoryDAO.isCategoryNameExists(categoryName.trim())) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Category name already exists.");
            return;
        }

        BookCategory bookCategory = new BookCategory();
        bookCategory.setCategoryName(categoryName.trim());

        boolean success = bookCategoryDAO.createBookCategory(bookCategory);
        
        if (success) {
            response.sendRedirect("BookCategoryServlet?action=list&message=Category added successfully.");
        } else {
            response.sendRedirect("book_category.jsp?error=Failed to add category.");
        }
    }

    private void editBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdStr = request.getParameter("id");
        
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Category ID is required.");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            BookCategory bookCategory = bookCategoryDAO.getBookCategoryById(categoryId);
            
            if (bookCategory != null) {
                request.setAttribute("bookCategory", bookCategory);
                request.getRequestDispatcher("book_category_edit.jsp").forward(request, response);
            } else {
                response.sendRedirect("BookCategoryServlet?action=list&error=Category not found.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Invalid category ID.");
        }
    }

    private void updateBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdStr = request.getParameter("categoryId");
        String categoryName = request.getParameter("categoryName");
        
        if (categoryIdStr == null || categoryName == null || 
            categoryIdStr.trim().isEmpty() || categoryName.trim().isEmpty()) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Category ID and name are required.");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            
            // Duplicate validation excluding current id
            if (bookCategoryDAO.isCategoryNameExistsExcludingId(categoryName.trim(), categoryId)) {
                response.sendRedirect("BookCategoryServlet?action=list&error=Category name already exists.");
                return;
            }

            BookCategory bookCategory = new BookCategory();
            bookCategory.setCategoryId(categoryId);
            bookCategory.setCategoryName(categoryName.trim());

            boolean success = bookCategoryDAO.updateBookCategory(bookCategory);
            
            if (success) {
                response.sendRedirect("BookCategoryServlet?action=list&message=Category updated successfully.");
            } else {
                response.sendRedirect("BookCategoryServlet?action=list&error=Failed to update category.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Invalid category ID.");
        }
    }

    private void checkCategoryName(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        String name = request.getParameter("name");
        String excludeIdStr = request.getParameter("excludeId");
        if (name == null || name.trim().isEmpty()) {
            response.getWriter().write("{\"success\":false,\"message\":\"Name is required\"}");
            return;
        }
        boolean exists;
        try {
            if (excludeIdStr != null && !excludeIdStr.trim().isEmpty()) {
                int excludeId = Integer.parseInt(excludeIdStr);
                exists = bookCategoryDAO.isCategoryNameExistsExcludingId(name.trim(), excludeId);
            } else {
                exists = bookCategoryDAO.isCategoryNameExists(name.trim());
            }
            response.getWriter().write("{\"success\":true,\"exists\":" + exists + "}");
        } catch (Exception e) {
            response.getWriter().write("{\"success\":false,\"message\":\"Error: " + e.getMessage().replace("\"", "'") + "\"}");
        }
    }

    private void deleteBookCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String categoryIdStr = request.getParameter("id");
        
        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Category ID is required.");
            return;
        }

        try {
            int categoryId = Integer.parseInt(categoryIdStr);
            
            boolean success = bookCategoryDAO.deleteBookCategory(categoryId);
            
            if (success) {
                response.sendRedirect("BookCategoryServlet?action=list&message=Category deleted successfully.");
            } else {
                response.sendRedirect("BookCategoryServlet?action=list&error=Failed to delete category.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("BookCategoryServlet?action=list&error=Invalid category ID.");
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
        return "Book Category Management Servlet";
    }
} 