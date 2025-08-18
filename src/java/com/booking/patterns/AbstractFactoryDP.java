/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.patterns;

import com.booking.dao.UserDAO;
import com.booking.dao.CustomerDAO;
import com.booking.dao.BookDAO;
import com.booking.dao.TransactionDAO;
import com.booking.dao.HelpSectionDAO;
import com.booking.dao.UserRoleDAO;
import com.booking.dao.BookCategoryDAO;

/**
 * Abstract Factory Pattern Implementation
 * Creates families of related DAO objects
 * @author pruso
 */
public class AbstractFactoryDP {
    
    public interface DAOFactory {
        UserDAO createUserDAO();
        CustomerDAO createCustomerDAO();
        BookDAO createBookDAO();
        TransactionDAO createTransactionDAO();
        BookCategoryDAO createBookCategoryDAO();
        UserRoleDAO createUserRoleDAO();
        HelpSectionDAO createHelpSectionDAO();
    }
    
    public static class MySQLDAOFactory implements DAOFactory {
        @Override
        public UserDAO createUserDAO() {
            return new UserDAO();
        }
        
        @Override
        public CustomerDAO createCustomerDAO() {
            return new CustomerDAO();
        }
        
        @Override
        public BookDAO createBookDAO() {
            return new BookDAO();
        }
        
        @Override
        public TransactionDAO createTransactionDAO() {
            return new TransactionDAO();
        }
        
        @Override
        public BookCategoryDAO createBookCategoryDAO() {
            return new BookCategoryDAO();
        }
        
        @Override
        public UserRoleDAO createUserRoleDAO() {
            return new UserRoleDAO();
        }
        
        @Override
        public HelpSectionDAO createHelpSectionDAO() {
            return new HelpSectionDAO();
        }
    }
    
    public static class PostgreSQLDAOFactory implements DAOFactory {
        @Override
        public UserDAO createUserDAO() {
            return new UserDAO();
        }
        
        @Override
        public CustomerDAO createCustomerDAO() {
            return new CustomerDAO(); 
        }
        
        @Override
        public BookDAO createBookDAO() {
            return new BookDAO(); 
        }
        
        @Override
        public TransactionDAO createTransactionDAO() {
            return new TransactionDAO(); 
        }
        
        @Override
        public BookCategoryDAO createBookCategoryDAO() {
            return new BookCategoryDAO(); 
        }
        
        @Override
        public UserRoleDAO createUserRoleDAO() {
            return new UserRoleDAO(); 
        }
        
        @Override
        public HelpSectionDAO createHelpSectionDAO() {
            return new HelpSectionDAO(); 
        }
    }
    
    public static class DAOFactoryCreator {
        public static DAOFactory createFactory(String databaseType) {
            if ("mysql".equalsIgnoreCase(databaseType)) {
                return new MySQLDAOFactory();
            } else if ("postgresql".equalsIgnoreCase(databaseType)) {
                return new PostgreSQLDAOFactory();
            } else {
                throw new IllegalArgumentException("Unknown database type: " + databaseType);
            }
        }
    }
}
