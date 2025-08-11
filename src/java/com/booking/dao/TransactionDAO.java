/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.dao;

import com.booking.models.Transaction;
import com.booking.models.TransactionItem;
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
public class TransactionDAO {
    
    public boolean createTransaction(Transaction transaction) {
        String sql = "INSERT INTO transactions (customer_id, total_amount, created_by) VALUES (?, ?, ?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, transaction.getCustomer().getCustomerId());
            pstmt.setBigDecimal(2, transaction.getTotalAmount());
            pstmt.setInt(3, transaction.getCreatedBy().getUserId());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int transactionId = generatedKeys.getInt(1);
                        transaction.setTransactionId(transactionId);
                        
                        // Create transaction items
                        return createTransactionItems(transaction);
                    }
                }
            }
            
            return false;
        } catch (SQLException e) {
            System.err.println("Error creating transaction: " + e.getMessage());
            return false;
        }
    }
    
    private boolean createTransactionItems(Transaction transaction) {
        String sql = "INSERT INTO transaction_items (transaction_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            for (TransactionItem item : transaction.getItems()) {
                pstmt.setInt(1, transaction.getTransactionId());
                pstmt.setInt(2, item.getBook().getBookId());
                pstmt.setInt(3, item.getQuantity());
                pstmt.setBigDecimal(4, item.getPrice());
                pstmt.addBatch();
            }
            
            int[] results = pstmt.executeBatch();
            for (int result : results) {
                if (result <= 0) {
                    return false;
                }
            }
            
            return true;
        } catch (SQLException e) {
            System.err.println("Error creating transaction items: " + e.getMessage());
            return false;
        }
    }
    
    public List<Transaction> getAllTransactions() {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, c.account_number, c.name as customer_name, u.username as created_by_name " +
                    "FROM transactions t " +
                    "LEFT JOIN customers c ON t.customer_id = c.customer_id " +
                    "LEFT JOIN users u ON t.created_by = u.user_id " +
                    "ORDER BY t.transaction_id DESC";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Transaction transaction = new Transaction();
                transaction.setTransactionId(rs.getInt("transaction_id"));
                transaction.setTotalAmount(rs.getBigDecimal("total_amount"));
                transaction.setCreatedAt(rs.getTimestamp("created_at"));
                
                // Set customer
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setName(rs.getString("customer_name"));
                transaction.setCustomer(customer);
                
                // Set created by user
                User createdBy = new User();
                createdBy.setUserId(rs.getInt("created_by"));
                createdBy.setUsername(rs.getString("created_by_name"));
                transaction.setCreatedBy(createdBy);
                
                // Load transaction items
                transaction.setItems(getTransactionItems(transaction.getTransactionId()));
                
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all transactions: " + e.getMessage());
        }
        return transactions;
    }
    
    public List<Transaction> getTransactionsByCustomer(int customerId) {
        List<Transaction> transactions = new ArrayList<>();
        String sql = "SELECT t.*, c.account_number, c.name as customer_name, u.username as created_by_name " +
                    "FROM transactions t " +
                    "LEFT JOIN customers c ON t.customer_id = c.customer_id " +
                    "LEFT JOIN users u ON t.created_by = u.user_id " +
                    "WHERE t.customer_id = ? " +
                    "ORDER BY t.transaction_id DESC";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, customerId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Transaction transaction = new Transaction();
                    transaction.setTransactionId(rs.getInt("transaction_id"));
                    transaction.setTotalAmount(rs.getBigDecimal("total_amount"));
                    transaction.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    // Set customer
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("customer_name"));
                    transaction.setCustomer(customer);
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    transaction.setCreatedBy(createdBy);
                    
                    // Load transaction items
                    transaction.setItems(getTransactionItems(transaction.getTransactionId()));
                    
                    transactions.add(transaction);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting transactions by customer: " + e.getMessage());
        }
        return transactions;
    }
    
    public Transaction getTransactionById(int transactionId) {
        String sql = "SELECT t.*, c.account_number, c.name as customer_name, u.username as created_by_name " +
                    "FROM transactions t " +
                    "LEFT JOIN customers c ON t.customer_id = c.customer_id " +
                    "LEFT JOIN users u ON t.created_by = u.user_id " +
                    "WHERE t.transaction_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, transactionId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Transaction transaction = new Transaction();
                    transaction.setTransactionId(rs.getInt("transaction_id"));
                    transaction.setTotalAmount(rs.getBigDecimal("total_amount"));
                    transaction.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    // Set customer
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("customer_name"));
                    transaction.setCustomer(customer);
                    
                    // Set created by user
                    User createdBy = new User();
                    createdBy.setUserId(rs.getInt("created_by"));
                    createdBy.setUsername(rs.getString("created_by_name"));
                    transaction.setCreatedBy(createdBy);
                    
                    // Load transaction items
                    transaction.setItems(getTransactionItems(transaction.getTransactionId()));
                    
                    return transaction;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting transaction by ID: " + e.getMessage());
        }
        return null;
    }
    
    private List<TransactionItem> getTransactionItems(int transactionId) {
        List<TransactionItem> items = new ArrayList<>();
        String sql = "SELECT ti.*, b.title as book_title, b.price_per_unit " +
                    "FROM transaction_items ti " +
                    "LEFT JOIN books b ON ti.book_id = b.book_id " +
                    "WHERE ti.transaction_id = ?";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, transactionId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    TransactionItem item = new TransactionItem();
                    item.setTransactionItemId(rs.getInt("transaction_item_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getBigDecimal("price"));
                    
                    // Set book
                    com.booking.models.Book book = new com.booking.models.Book();
                    book.setBookId(rs.getInt("book_id"));
                    book.setTitle(rs.getString("book_title"));
                    book.setPricePerUnit(rs.getBigDecimal("price_per_unit"));
                    item.setBook(book);
                    
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting transaction items: " + e.getMessage());
        }
        return items;
    }
    
    public List<java.util.Map<String, Object>> getTransactionSalesData(int days) {
        List<java.util.Map<String, Object>> salesData = new ArrayList<>();
        String sql = "SELECT DATE(created_at) as sale_date, SUM(total_amount) as daily_total " +
                    "FROM transactions " +
                    "WHERE created_at >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " +
                    "GROUP BY DATE(created_at) " +
                    "ORDER BY sale_date ASC";
        
        try (Connection conn = SingletonDP.getInstance().getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, days);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    java.util.Map<String, Object> dataPoint = new java.util.HashMap<>();
                    dataPoint.put("created_at", rs.getTimestamp("sale_date"));
                    dataPoint.put("total_amount", rs.getDouble("daily_total"));
                    salesData.add(dataPoint);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting transaction sales data: " + e.getMessage());
        }
        return salesData;
    }
} 