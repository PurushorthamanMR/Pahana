/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.dao;

import com.booking.models.HelpSection;
import com.booking.patterns.SingletonDP;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author pruso
 */
public class HelpSectionDAO {
    
    public boolean createHelpSection(HelpSection helpSection) {
        String sql = "INSERT INTO help_sections (title, content) VALUES (?, ?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, helpSection.getTitle());
            pstmt.setString(2, helpSection.getContent());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating help section: " + e.getMessage());
            return false;
        }
    }
    
    public List<HelpSection> getAllHelpSections() {
        List<HelpSection> helpSections = new ArrayList<>();
        String sql = "SELECT * FROM help_sections ORDER BY help_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                HelpSection helpSection = new HelpSection();
                helpSection.setHelpId(rs.getInt("help_id"));
                helpSection.setTitle(rs.getString("title"));
                helpSection.setContent(rs.getString("content"));
                helpSections.add(helpSection);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all help sections: " + e.getMessage());
        }
        return helpSections;
    }
    
    public HelpSection getHelpSectionById(int helpId) {
        String sql = "SELECT * FROM help_sections WHERE help_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, helpId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    HelpSection helpSection = new HelpSection();
                    helpSection.setHelpId(rs.getInt("help_id"));
                    helpSection.setTitle(rs.getString("title"));
                    helpSection.setContent(rs.getString("content"));
                    return helpSection;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting help section by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateHelpSection(HelpSection helpSection) {
        String sql = "UPDATE help_sections SET title = ?, content = ? WHERE help_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, helpSection.getTitle());
            pstmt.setString(2, helpSection.getContent());
            pstmt.setInt(3, helpSection.getHelpId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating help section: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteHelpSection(int helpId) {
        String sql = "DELETE FROM help_sections WHERE help_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, helpId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting help section: " + e.getMessage());
            return false;
        }
    }
} 