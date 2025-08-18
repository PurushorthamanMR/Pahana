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
import com.booking.models.UserRole;

/**
 *
 * @author pruso
 */
public class HelpSectionDAO {
    
    public boolean createHelpSection(HelpSection helpSection) {
        String sql = "INSERT INTO help_sections (title, content, role_id) VALUES (?, ?, ?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, helpSection.getTitle());
            pstmt.setString(2, helpSection.getContent());
            pstmt.setInt(3, helpSection.getRole() != null ? helpSection.getRole().getRoleId() : null);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating help section: " + e.getMessage());
            return false;
        }
    }
    
    public List<HelpSection> getAllHelpSections() {
        List<HelpSection> helpSections = new ArrayList<>();
        String sql = "SELECT h.*, r.role_name FROM help_sections h " +
                    "LEFT JOIN user_roles r ON h.role_id = r.role_id " +
                    "ORDER BY h.help_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                HelpSection helpSection = new HelpSection();
                helpSection.setHelpId(rs.getInt("help_id"));
                helpSection.setTitle(rs.getString("title"));
                helpSection.setContent(rs.getString("content"));
                
                if (rs.getInt("role_id") != 0) {
                    UserRole role = new UserRole();
                    role.setRoleId(rs.getInt("role_id"));
                    role.setRoleName(rs.getString("role_name"));
                    helpSection.setRole(role);
                }
                
                helpSection.setCreatedAt(rs.getString("created_at"));
                helpSection.setUpdatedAt(rs.getString("updated_at"));
                helpSections.add(helpSection);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all help sections: " + e.getMessage());
        }
        return helpSections;
    }
    
    public HelpSection getHelpSectionById(int helpId) {
        String sql = "SELECT h.*, r.role_name FROM help_sections h " +
                    "LEFT JOIN user_roles r ON h.role_id = r.role_id " +
                    "WHERE h.help_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, helpId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    HelpSection helpSection = new HelpSection();
                    helpSection.setHelpId(rs.getInt("help_id"));
                    helpSection.setTitle(rs.getString("title"));
                    helpSection.setContent(rs.getString("content"));
                    
                    if (rs.getInt("role_id") != 0) {
                        UserRole role = new UserRole();
                        role.setRoleId(rs.getInt("role_id"));
                        role.setRoleName(rs.getString("role_name"));
                        helpSection.setRole(role);
                    }
                    
                    helpSection.setCreatedAt(rs.getString("created_at"));
                    helpSection.setUpdatedAt(rs.getString("updated_at"));
                    return helpSection;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting help section by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateHelpSection(HelpSection helpSection) {
        String sql = "UPDATE help_sections SET title = ?, content = ?, role_id = ? WHERE help_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, helpSection.getTitle());
            pstmt.setString(2, helpSection.getContent());
            pstmt.setInt(3, helpSection.getRole() != null ? helpSection.getRole().getRoleId() : null);
            pstmt.setInt(4, helpSection.getHelpId());
            
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
    
    /**
     * Get help sections by role ID
     */
    public List<HelpSection> getHelpSectionsByRole(int roleId) {
        List<HelpSection> helpSections = new ArrayList<>();
        String sql = "SELECT h.*, r.role_name FROM help_sections h " +
                    "LEFT JOIN user_roles r ON h.role_id = r.role_id " +
                    "WHERE h.role_id = ? ORDER BY h.help_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, roleId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    HelpSection helpSection = new HelpSection();
                    helpSection.setHelpId(rs.getInt("help_id"));
                    helpSection.setTitle(rs.getString("title"));
                    helpSection.setContent(rs.getString("content"));
                   
                    if (rs.getInt("role_id") != 0) {
                        UserRole role = new UserRole();
                        role.setRoleId(rs.getInt("role_id"));
                        role.setRoleName(rs.getString("role_name"));
                        helpSection.setRole(role);
                    }
                    
                    helpSection.setCreatedAt(rs.getString("created_at"));
                    helpSection.setUpdatedAt(rs.getString("updated_at"));
                    helpSections.add(helpSection);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting help sections by role: " + e.getMessage());
        }
        return helpSections;
    }
} 