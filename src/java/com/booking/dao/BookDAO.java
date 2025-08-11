/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.dao;

import com.booking.models.Book;
import com.booking.models.BookCategory;
import com.booking.models.User;
import com.booking.patterns.SingletonDP;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author pruso
 */
public class BookDAO {
    
    public boolean createBook(Book book) {
        String sql = "INSERT INTO books (title, description, price_per_unit, stock_quantity, category_id, created_by) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getDescription());
            pstmt.setBigDecimal(3, book.getPricePerUnit());
            pstmt.setInt(4, book.getStockQuantity());
            pstmt.setInt(5, book.getCategory().getCategoryId());
            pstmt.setInt(6, book.getCreatedBy().getUserId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating book: " + e.getMessage());
            return false;
        }
    }
    
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name, u.username as created_by_name FROM books b " +
                    "LEFT JOIN book_categories c ON b.category_id = c.category_id " +
                    "LEFT JOIN users u ON b.created_by = u.user_id " +
                    "ORDER BY b.book_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Book book = new Book();
                book.setBookId(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setDescription(rs.getString("description"));
                book.setPricePerUnit(rs.getBigDecimal("price_per_unit"));
                book.setStockQuantity(rs.getInt("stock_quantity"));
                book.setCreatedAt(rs.getTimestamp("created_at"));
                
                // Set category
                BookCategory category = new BookCategory();
                category.setCategoryId(rs.getInt("category_id"));
                category.setCategoryName(rs.getString("category_name"));
                book.setCategory(category);
                
                // Set created by user
                User createdBy = new User();
                createdBy.setUserId(rs.getInt("created_by"));
                createdBy.setUsername(rs.getString("created_by_name"));
                book.setCreatedBy(createdBy);
                
                books.add(book);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all books: " + e.getMessage());
        }
        return books;
    }
    
    public Book getBookById(int bookId) {
        String sql = "SELECT b.*, c.category_name, u.username as created_by_name FROM books b " +
                    "LEFT JOIN book_categories c ON b.category_id = c.category_id " +
                    "LEFT JOIN users u ON b.created_by = u.user_id " +
                    "WHERE b.book_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setBookId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setDescription(rs.getString("description"));
                    book.setPricePerUnit(rs.getBigDecimal("price_per_unit"));
                    book.setStockQuantity(rs.getInt("stock_quantity"));
                    book.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    // Set category
                    BookCategory category = new BookCategory();
                    category.setCategoryId(rs.getInt("category_id"));
                    category.setCategoryName(rs.getString("category_name"));
                    book.setCategory(category);
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    book.setCreatedBy(createdBy);
                    
                    return book;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting book by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateBook(Book book) {
        String sql = "UPDATE books SET title = ?, description = ?, price_per_unit = ?, stock_quantity = ?, category_id = ? WHERE book_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, book.getTitle());
            pstmt.setString(2, book.getDescription());
            pstmt.setBigDecimal(3, book.getPricePerUnit());
            pstmt.setInt(4, book.getStockQuantity());
            pstmt.setInt(5, book.getCategory().getCategoryId());
            pstmt.setInt(6, book.getBookId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating book: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteBook(int bookId) {
        String sql = "DELETE FROM books WHERE book_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, bookId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting book: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateStockQuantity(int bookId, int newQuantity) {
        String sql = "UPDATE books SET stock_quantity = ? WHERE book_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, newQuantity);
            pstmt.setInt(2, bookId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating stock quantity: " + e.getMessage());
            return false;
        }
    }
    
    public List<Book> getBooksByCategory(int categoryId) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT b.*, c.category_name, u.username as created_by_name FROM books b " +
                    "LEFT JOIN book_categories c ON b.category_id = c.category_id " +
                    "LEFT JOIN users u ON b.created_by = u.user_id " +
                    "WHERE b.category_id = ? " +
                    "ORDER BY b.book_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, categoryId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book();
                    book.setBookId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("title"));
                    book.setDescription(rs.getString("description"));
                    book.setPricePerUnit(rs.getBigDecimal("price_per_unit"));
                    book.setStockQuantity(rs.getInt("stock_quantity"));
                    book.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    // Set category
                    BookCategory category = new BookCategory();
                    category.setCategoryId(rs.getInt("category_id"));
                    category.setCategoryName(rs.getString("category_name"));
                    book.setCategory(category);
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    book.setCreatedBy(createdBy);
                    
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting books by category: " + e.getMessage());
        }
        return books;
    }
} 