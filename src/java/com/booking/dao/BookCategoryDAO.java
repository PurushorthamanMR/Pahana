/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.dao;

import com.booking.models.BookCategory;
import com.booking.patterns.SingletonDP;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author pruso
 */
public class BookCategoryDAO {
    
    public boolean createBookCategory(BookCategory bookCategory) {
        String sql = "INSERT INTO book_categories (category_name) VALUES (?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bookCategory.getCategoryName());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating book category: " + e.getMessage());
            return false;
        }
    }
    
    public List<BookCategory> getAllBookCategories() {
        List<BookCategory> bookCategories = new ArrayList<>();
        String sql = "SELECT * FROM book_categories ORDER BY category_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                BookCategory bookCategory = new BookCategory();
                bookCategory.setCategoryId(rs.getInt("category_id"));
                bookCategory.setCategoryName(rs.getString("category_name"));
                bookCategories.add(bookCategory);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all book categories: " + e.getMessage());
        }
        return bookCategories;
    }
    
    public BookCategory getBookCategoryById(int categoryId) {
        String sql = "SELECT * FROM book_categories WHERE category_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, categoryId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    BookCategory bookCategory = new BookCategory();
                    bookCategory.setCategoryId(rs.getInt("category_id"));
                    bookCategory.setCategoryName(rs.getString("category_name"));
                    return bookCategory;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting book category by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateBookCategory(BookCategory bookCategory) {
        String sql = "UPDATE book_categories SET category_name = ? WHERE category_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, bookCategory.getCategoryName());
            pstmt.setInt(2, bookCategory.getCategoryId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating book category: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteBookCategory(int categoryId) {
        String sql = "DELETE FROM book_categories WHERE category_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, categoryId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting book category: " + e.getMessage());
            return false;
        }
    }
} 