/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.dao;

import com.booking.models.Customer;
import com.booking.models.User;
import com.booking.patterns.SingletonDP;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author pruso
 */
public class CustomerDAO {
    
    public boolean createCustomer(Customer customer) {
        String sql = "INSERT INTO customers (account_number, name, address, phone, username, email, password, role_id, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, customer.getAccountNumber());
            pstmt.setString(2, customer.getName());
            pstmt.setString(3, customer.getAddress());
            pstmt.setString(4, customer.getPhone());
            pstmt.setString(5, customer.getUsername());
            pstmt.setString(6, customer.getEmail());
            pstmt.setString(7, customer.getPassword());
            pstmt.setInt(8, customer.getRole().getRoleId());
            pstmt.setInt(9, customer.getCreatedBy().getUserId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating customer: " + e.getMessage());
            return false;
        }
    }
    
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT c.*, u.username as created_by_name FROM customers c " +
                    "LEFT JOIN users u ON c.created_by = u.user_id " +
                    "ORDER BY c.customer_id";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setName(rs.getString("name"));
                customer.setAddress(rs.getString("address"));
                customer.setPhone(rs.getString("phone"));
                customer.setUsername(rs.getString("username"));
                customer.setEmail(rs.getString("email"));
                customer.setPassword(rs.getString("password"));
                customer.setCreatedAt(rs.getTimestamp("created_at"));
                customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                // Set role
                if (rs.getInt("role_id") > 0) {
                    com.booking.models.UserRole role = new com.booking.models.UserRole();
                    role.setRoleId(rs.getInt("role_id"));
                    customer.setRole(role);
                }
                
                // Set created by user
                User createdBy = new User();
                createdBy.setUserId(rs.getInt("created_by"));
                createdBy.setUsername(rs.getString("created_by_name"));
                customer.setCreatedBy(createdBy);
                
                customers.add(customer);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all customers: " + e.getMessage());
        }
        return customers;
    }
    
    public Customer getCustomerById(int customerId) {
        String sql = "SELECT c.*, u.username as created_by_name FROM customers c " +
                    "LEFT JOIN users u ON c.created_by = u.user_id " +
                    "WHERE c.customer_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setUsername(rs.getString("username"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPassword(rs.getString("password"));
                    customer.setCreatedAt(rs.getTimestamp("created_at"));
                    customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                    
                    // Set role
                    if (rs.getInt("role_id") > 0) {
                        com.booking.models.UserRole role = new com.booking.models.UserRole();
                        role.setRoleId(rs.getInt("role_id"));
                        customer.setRole(role);
                    }
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    customer.setCreatedBy(createdBy);
                    
                    return customer;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting customer by ID: " + e.getMessage());
        }
        return null;
    }
    
    public Customer getCustomerByAccountNumber(String accountNumber) {
        String sql = "SELECT c.*, u.username as created_by_name FROM customers c " +
                    "LEFT JOIN users u ON c.created_by = u.user_id " +
                    "WHERE c.account_number = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, accountNumber);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setUsername(rs.getString("username"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPassword(rs.getString("password"));
                    customer.setCreatedAt(rs.getTimestamp("created_at"));
                    customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                    
                    // Set role
                    if (rs.getInt("role_id") > 0) {
                        com.booking.models.UserRole role = new com.booking.models.UserRole();
                        role.setRoleId(rs.getInt("role_id"));
                        customer.setRole(role);
                    }
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    customer.setCreatedBy(createdBy);
                    
                    return customer;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting customer by account number: " + e.getMessage());
        }
        return null;
    }
    
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE customers SET account_number = ?, name = ?, address = ?, phone = ?, username = ?, email = ?, password = ? WHERE customer_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, customer.getAccountNumber());
            pstmt.setString(2, customer.getName());
            pstmt.setString(3, customer.getAddress());
            pstmt.setString(4, customer.getPhone());
            pstmt.setString(5, customer.getUsername());
            pstmt.setString(6, customer.getEmail());
            pstmt.setString(7, customer.getPassword());
            pstmt.setInt(8, customer.getCustomerId());
            
            System.out.println("=== CUSTOMER UPDATE DEBUG ===");
            System.out.println("Customer ID: " + customer.getCustomerId());
            System.out.println("Name: " + customer.getName());
            System.out.println("Username: " + customer.getUsername());
            System.out.println("Email: " + customer.getEmail());
            System.out.println("Password: " + customer.getPassword());
            System.out.println("SQL: " + sql);
            System.out.println("=============================");
            
            int rowsAffected = pstmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            System.out.println("=============================");
            
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Error updating customer: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateCustomerPassword(String email, String newPassword) {
        // First, let's check if the email exists
        String checkSql = "SELECT COUNT(*) FROM customers WHERE email = ?";
        String updateSql = "UPDATE customers SET password = ? WHERE email = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection()) {
            
            System.out.println("=== FORGOT PASSWORD DEBUG START ===");
            System.out.println("Attempting to update password for email: " + email);
            System.out.println("New password: " + newPassword);
            
            // Check if email exists
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, email);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        System.out.println("Email check: " + email + " exists: " + (count > 0));
                        System.out.println("Count: " + count);
                        
                        if (count == 0) {
                            System.out.println("ERROR: Email not found in database!");
                            return false;
                        }
                    }
                }
            }
            
            // Let's also check what emails are actually in the database
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT email FROM customers WHERE email LIKE '%@%'")) {
                System.out.println("=== DATABASE EMAILS ===");
                while (rs.next()) {
                    System.out.println("DB Email: '" + rs.getString("email") + "'");
                }
                System.out.println("=====================");
            }
            
            // Now try to update
            try (PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                pstmt.setString(1, newPassword);
                pstmt.setString(2, email);
                
                System.out.println("Executing SQL: " + updateSql);
                System.out.println("Parameters - Email: " + email + ", New Password: " + newPassword);
                
                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);
                
                if (rowsAffected > 0) {
                    System.out.println("SUCCESS: Password updated successfully!");
                } else {
                    System.out.println("WARNING: No rows were affected by the update");
                }
                
                System.out.println("=== FORGOT PASSWORD DEBUG END ===");
                return rowsAffected > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR in updateCustomerPassword: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteCustomer(int customerId) {
        // First check if customer has any transactions
        String checkSql = "SELECT COUNT(*) FROM transactions WHERE customer_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            
            checkStmt.setInt(1, customerId);
            
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    System.err.println("Cannot delete customer: Customer has existing transactions");
                    return false;
                }
            }
            
            // If no transactions exist, proceed with deletion
            String deleteSql = "DELETE FROM customers WHERE customer_id = ?";
            
            try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
                deleteStmt.setInt(1, customerId);
                return deleteStmt.executeUpdate() > 0;
            }
            
        } catch (SQLException e) {
            System.err.println("Error deleting customer: " + e.getMessage());
            return false;
        }
    }
    
    public boolean isAccountNumberExists(String accountNumber) {
        String sql = "SELECT COUNT(*) FROM customers WHERE account_number = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, accountNumber);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking account number existence: " + e.getMessage());
        }
        return false;
    }
    
    public Customer authenticateCustomer(String username, String password) {
        String sql = "SELECT c.*, u.username as created_by_name, ur.role_name FROM customers c " +
                    "LEFT JOIN users u ON c.created_by = u.user_id " +
                    "LEFT JOIN user_roles ur ON c.role_id = ur.role_id " +
                    "WHERE c.username = ? AND c.password = ? AND c.role_id = 4";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setUsername(rs.getString("username"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPassword(rs.getString("password"));
                    customer.setCreatedAt(rs.getTimestamp("created_at"));
                    customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                    
                    // Set role
                    com.booking.models.UserRole role = new com.booking.models.UserRole();
                    role.setRoleId(4); // CUSTOMER role
                    role.setRoleName(rs.getString("role_name"));
                    customer.setRole(role);
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    customer.setCreatedBy(createdBy);
                    
                    return customer;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error authenticating customer: " + e.getMessage());
        }
        return null;
    }
    
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM customers WHERE username = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking username existence: " + e.getMessage());
        }
        return false;
    }
    
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM customers WHERE email = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, email);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking email existence: " + e.getMessage());
        }
        return false;
    }
    
    public boolean isPhoneNumberExists(String phone) {
        String sql = "SELECT COUNT(*) FROM customers WHERE phone = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, phone);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking phone number existence: " + e.getMessage());
        }
        return false;
    }
    
    public int getTransactionCount(int customerId) {
        String sql = "SELECT COUNT(*) FROM transactions WHERE customer_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting transaction count: " + e.getMessage());
        }
        return 0;
    }
    
    public String generateUniqueAccountNumber() {
        // Generate a 6-digit account number
        String sql = "SELECT MAX(CAST(account_number AS UNSIGNED)) FROM customers";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                int maxAccountNumber = rs.getInt(1);
                // Start from 100000 if no existing account numbers
                int nextAccountNumber = Math.max(100000, maxAccountNumber + 1);
                return String.valueOf(nextAccountNumber);
            }
        } catch (SQLException e) {
            System.err.println("Error generating account number: " + e.getMessage());
        }
        
        // Fallback: return a default account number
        return "100000";
    }
    
    public Customer getCustomerByUsername(String username) {
        String sql = "SELECT c.*, u.username as created_by_name, ur.role_name FROM customers c " +
                    "LEFT JOIN users u ON c.created_by = u.user_id " +
                    "LEFT JOIN user_roles ur ON c.role_id = ur.role_id " +
                    "WHERE c.username = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, username);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setUsername(rs.getString("username"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPassword(rs.getString("password"));
                    customer.setCreatedAt(rs.getTimestamp("created_at"));
                    customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                    
                    // Set role
                    com.booking.models.UserRole role = new com.booking.models.UserRole();
                    role.setRoleId(rs.getInt("role_id"));
                    role.setRoleName(rs.getString("role_name"));
                    customer.setRole(role);
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    customer.setCreatedBy(createdBy);
                    
                    return customer;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting customer by username: " + e.getMessage());
        }
        return null;
    }
} 
