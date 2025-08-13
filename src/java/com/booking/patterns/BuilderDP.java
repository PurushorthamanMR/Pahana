/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.patterns;

import com.booking.models.Book;
import com.booking.models.BookCategory;
import com.booking.models.Customer;
import com.booking.models.User;
import com.booking.models.UserRole;

/**
 * Builder Design Pattern
 * Constructs complex objects step by step
 * @author pruso
 */
public class BuilderDP {
    
    // Book Builder
    public static class BookBuilder {
        private int bookId;
        private String title;
        private String description;
        private java.math.BigDecimal pricePerUnit;
        private int stockQuantity;
        private BookCategory category;
        private User createdBy;
        private java.sql.Timestamp createdAt;
        
        public BookBuilder() {
            // Initialize with default values
            this.stockQuantity = 0;
            this.pricePerUnit = java.math.BigDecimal.ZERO;
        }
        
        public BookBuilder bookId(int bookId) {
            this.bookId = bookId;
            return this;
        }
        
        public BookBuilder title(String title) {
            this.title = title;
            return this;
        }
        
        public BookBuilder description(String description) {
            this.description = description;
            return this;
        }
        
        public BookBuilder pricePerUnit(java.math.BigDecimal pricePerUnit) {
            this.pricePerUnit = pricePerUnit;
            return this;
        }
        
        public BookBuilder stockQuantity(int stockQuantity) {
            this.stockQuantity = stockQuantity;
            return this;
        }
        
        public BookBuilder category(BookCategory category) {
            this.category = category;
            return this;
        }
        
        public BookBuilder createdBy(User createdBy) {
            this.createdBy = createdBy;
            return this;
        }
        
        public BookBuilder createdAt(java.sql.Timestamp createdAt) {
            this.createdAt = createdAt;
            return this;
        }
        
        public Book build() {
            Book book = new Book();
            book.setBookId(this.bookId);
            book.setTitle(this.title);
            book.setDescription(this.description);
            book.setPricePerUnit(this.pricePerUnit);
            book.setStockQuantity(this.stockQuantity);
            book.setCategory(this.category);
            book.setCreatedBy(this.createdBy);
            book.setCreatedAt(this.createdAt);
            return book;
        }
    }
    
    // Customer Builder
    public static class CustomerBuilder {
        private int customerId;
        private String accountNumber;
        private String name;
        private String address;
        private String phone;
        private String username;
        private String email;
        private String password;
        private UserRole role;
        private User createdBy;
        private java.sql.Timestamp createdAt;
        private java.sql.Timestamp updatedAt;
        
        public CustomerBuilder() {
            // Initialize with default values
        }
        
        public CustomerBuilder customerId(int customerId) {
            this.customerId = customerId;
            return this;
        }
        
        public CustomerBuilder accountNumber(String accountNumber) {
            this.accountNumber = accountNumber;
            return this;
        }
        
        public CustomerBuilder name(String name) {
            this.name = name;
            return this;
        }
        
        public CustomerBuilder address(String address) {
            this.address = address;
            return this;
        }
        
        public CustomerBuilder phone(String phone) {
            this.phone = phone;
            return this;
        }
        
        public CustomerBuilder username(String username) {
            this.username = username;
            return this;
        }
        
        public CustomerBuilder email(String email) {
            this.email = email;
            return this;
        }
        
        public CustomerBuilder password(String password) {
            this.password = password;
            return this;
        }
        
        public CustomerBuilder role(UserRole role) {
            this.role = role;
            return this;
        }
        
        public CustomerBuilder createdBy(User createdBy) {
            this.createdBy = createdBy;
            return this;
        }
        
        public CustomerBuilder createdAt(java.sql.Timestamp createdAt) {
            this.createdAt = createdAt;
            return this;
        }
        
        public CustomerBuilder updatedAt(java.sql.Timestamp updatedAt) {
            this.updatedAt = updatedAt;
            return this;
        }
        
        public Customer build() {
            Customer customer = new Customer();
            customer.setCustomerId(this.customerId);
            customer.setAccountNumber(this.accountNumber);
            customer.setName(this.name);
            customer.setAddress(this.address);
            customer.setPhone(this.phone);
            customer.setUsername(this.username);
            customer.setEmail(this.email);
            customer.setPassword(this.password);
            customer.setRole(this.role);
            customer.setCreatedBy(this.createdBy);
            customer.setCreatedAt(this.createdAt);
            customer.setUpdatedAt(this.updatedAt);
            return customer;
        }
    }
    
    // User Builder
    public static class UserBuilder {
        private int userId;
        private String username;
        private String password;
        private String email;
        private UserRole role;
        private java.sql.Timestamp createdAt;
        private java.sql.Timestamp updatedAt;
        
        public UserBuilder() {
            // Initialize with default values
        }
        
        public UserBuilder userId(int userId) {
            this.userId = userId;
            return this;
        }
        
        public UserBuilder username(String username) {
            this.username = username;
            return this;
        }
        
        public UserBuilder password(String password) {
            this.password = password;
            return this;
        }
        
        public UserBuilder email(String email) {
            this.email = email;
            return this;
        }
        
        public UserBuilder role(UserRole role) {
            this.role = role;
            return this;
        }
        
        public UserBuilder createdAt(java.sql.Timestamp createdAt) {
            this.createdAt = createdAt;
            return this;
        }
        
        public UserBuilder updatedAt(java.sql.Timestamp updatedAt) {
            this.updatedAt = updatedAt;
            return this;
        }
        
        public User build() {
            User user = new User();
            user.setUserId(this.userId);
            user.setUsername(this.username);
            user.setPassword(this.password);
            user.setEmail(this.email);
            user.setRole(this.role);
            user.setCreatedAt(this.createdAt);
            user.setUpdatedAt(this.updatedAt);
            return user;
        }
    }
}
