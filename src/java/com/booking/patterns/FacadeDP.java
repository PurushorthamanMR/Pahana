/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.patterns;

import com.booking.models.*;
import com.booking.dao.*;
import java.util.List;

/**
 *
 * @author pruso
 */
public class FacadeDP {
    
    private final UserDAO userDAO;
    private final CustomerDAO customerDAO;
    private final BookDAO bookDAO;
    private final TransactionDAO transactionDAO;
    private final UserRoleDAO userRoleDAO;
    private final BookCategoryDAO bookCategoryDAO;
    private final HelpSectionDAO helpSectionDAO;
    
    public FacadeDP() {
        this.userDAO = new UserDAO();
        this.customerDAO = new CustomerDAO();
        this.bookDAO = new BookDAO();
        this.transactionDAO = new TransactionDAO();
        this.userRoleDAO = new UserRoleDAO();
        this.bookCategoryDAO = new BookCategoryDAO();
        this.helpSectionDAO = new HelpSectionDAO();
    }
    
    // Authentication Facade
    public User authenticateUser(String username, String password) {
        return userDAO.authenticateUser(username, password);
    }
    
    public boolean registerUser(User user) {
        return userDAO.createUser(user);
    }
    
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }
    
    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }
    
    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }
    
    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }
    
    // Customer Management Facade
    public boolean createCustomer(Customer customer) {
        return customerDAO.createCustomer(customer);
    }
    
    public Customer authenticateCustomer(String username, String password) {
        return customerDAO.authenticateCustomer(username, password);
    }
    
    public List<Customer> getAllCustomers() {
        return customerDAO.getAllCustomers();
    }
    
    public Customer getCustomerById(int customerId) {
        return customerDAO.getCustomerById(customerId);
    }
    
    public boolean updateCustomer(Customer customer) {
        return customerDAO.updateCustomer(customer);
    }
    
    public boolean deleteCustomer(int customerId) {
        return customerDAO.deleteCustomer(customerId);
    }
    
    public boolean isAccountNumberExists(String accountNumber) {
        return customerDAO.isAccountNumberExists(accountNumber);
    }
    
    public boolean isUsernameExists(String username) {
        return customerDAO.isUsernameExists(username);
    }
    
    public boolean isEmailExists(String email) {
        return customerDAO.isEmailExists(email);
    }
    
    public int getCustomerTransactionCount(int customerId) {
        return customerDAO.getTransactionCount(customerId);
    }
    
    public List<java.util.Map<String, Object>> getTransactionSalesData(int days) {
        return transactionDAO.getTransactionSalesData(days);
    }
    
    public String generateUniqueAccountNumber() {
        return customerDAO.generateUniqueAccountNumber();
    }
    
    // Book Management Facade
    public boolean createBook(Book book) {
        return bookDAO.createBook(book);
    }
    
    public List<Book> getAllBooks() {
        return bookDAO.getAllBooks();
    }
    
    public Book getBookById(int bookId) {
        return bookDAO.getBookById(bookId);
    }
    
    public boolean updateBook(Book book) {
        return bookDAO.updateBook(book);
    }
    
    public boolean deleteBook(int bookId) {
        return bookDAO.deleteBook(bookId);
    }
    
    // Transaction Management Facade
    public boolean createTransaction(Transaction transaction) {
        return transactionDAO.createTransaction(transaction);
    }
    
    public List<Transaction> getAllTransactions() {
        return transactionDAO.getAllTransactions();
    }
    
    public List<Transaction> getTransactionsByCustomer(int customerId) {
        return transactionDAO.getTransactionsByCustomer(customerId);
    }
    
    public Transaction getTransactionById(int transactionId) {
        return transactionDAO.getTransactionById(transactionId);
    }
    
    // User Role Management Facade
    public List<UserRole> getAllUserRoles() {
        return userRoleDAO.getAllUserRoles();
    }
    
    public UserRole getUserRoleById(int roleId) {
        return userRoleDAO.getUserRoleById(roleId);
    }
    
    public boolean createUserRole(UserRole userRole) {
        return userRoleDAO.createUserRole(userRole);
    }
    
    public boolean updateUserRole(UserRole userRole) {
        return userRoleDAO.updateUserRole(userRole);
    }
    
    public boolean deleteUserRole(int roleId) {
        return userRoleDAO.deleteUserRole(roleId);
    }
    
    // Book Category Management Facade
    public List<BookCategory> getAllBookCategories() {
        return bookCategoryDAO.getAllBookCategories();
    }
    
    public BookCategory getBookCategoryById(int categoryId) {
        return bookCategoryDAO.getBookCategoryById(categoryId);
    }
    
    public boolean createBookCategory(BookCategory bookCategory) {
        return bookCategoryDAO.createBookCategory(bookCategory);
    }
    
    public boolean updateBookCategory(BookCategory bookCategory) {
        return bookCategoryDAO.updateBookCategory(bookCategory);
    }
    
    public boolean deleteBookCategory(int categoryId) {
        return bookCategoryDAO.deleteBookCategory(categoryId);
    }
    
    // Help Section Management Facade
    public List<HelpSection> getAllHelpSections() {
        return helpSectionDAO.getAllHelpSections();
    }
    
    public HelpSection getHelpSectionById(int helpId) {
        return helpSectionDAO.getHelpSectionById(helpId);
    }
    
    public boolean createHelpSection(HelpSection helpSection) {
        return helpSectionDAO.createHelpSection(helpSection);
    }
    
    public boolean updateHelpSection(HelpSection helpSection) {
        return helpSectionDAO.updateHelpSection(helpSection);
    }
    
    public boolean deleteHelpSection(int helpId) {
        return helpSectionDAO.deleteHelpSection(helpId);
    }
    
    // Dashboard Statistics Facade
    public DashboardStats getDashboardStats() {
        DashboardStats stats = new DashboardStats();
        
        stats.setTotalBooks(bookDAO.getAllBooks().size());
        stats.setTotalCustomers(customerDAO.getAllCustomers().size());
        stats.setTotalTransactions(transactionDAO.getAllTransactions().size());
        stats.setTotalUsers(userDAO.getAllUsers().size());
        
        return stats;
    }
    
    // Inner class for dashboard statistics
    public static class DashboardStats {
        private int totalBooks;
        private int totalCustomers;
        private int totalTransactions;
        private int totalUsers;
        
        // Getters and Setters
        public int getTotalBooks() { return totalBooks; }
        public void setTotalBooks(int totalBooks) { this.totalBooks = totalBooks; }
        
        public int getTotalCustomers() { return totalCustomers; }
        public void setTotalCustomers(int totalCustomers) { this.totalCustomers = totalCustomers; }
        
        public int getTotalTransactions() { return totalTransactions; }
        public void setTotalTransactions(int totalTransactions) { this.totalTransactions = totalTransactions; }
        
        public int getTotalUsers() { return totalUsers; }
        public void setTotalUsers(int totalUsers) { this.totalUsers = totalUsers; }
    }
} 