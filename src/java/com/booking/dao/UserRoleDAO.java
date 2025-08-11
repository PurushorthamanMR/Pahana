/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.dao;

import com.booking.models.UserRole;
import com.booking.patterns.SingletonDP;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author pruso
 */
public class UserRoleDAO {
    
    public boolean createUserRole(UserRole userRole) {
        String sql = "INSERT INTO user_roles (role_name) VALUES (?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userRole.getRoleName());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating user role: " + e.getMessage());
            return false;
        }
    }
    
    public List<UserRole> getAllUserRoles() {
        List<UserRole> userRoles = new ArrayList<>();
        String sql = "SELECT * FROM user_roles ORDER BY role_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                UserRole userRole = new UserRole();
                userRole.setRoleId(rs.getInt("role_id"));
                userRole.setRoleName(rs.getString("role_name"));
                userRoles.add(userRole);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all user roles: " + e.getMessage());
        }
        return userRoles;
    }
    
    public UserRole getUserRoleById(int roleId) {
        String sql = "SELECT * FROM user_roles WHERE role_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, roleId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    UserRole userRole = new UserRole();
                    userRole.setRoleId(rs.getInt("role_id"));
                    userRole.setRoleName(rs.getString("role_name"));
                    return userRole;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting user role by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateUserRole(UserRole userRole) {
        String sql = "UPDATE user_roles SET role_name = ? WHERE role_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, userRole.getRoleName());
            pstmt.setInt(2, userRole.getRoleId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating user role: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteUserRole(int roleId) {
        String sql = "DELETE FROM user_roles WHERE role_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, roleId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting user role: " + e.getMessage());
            return false;
        }
    }
} 