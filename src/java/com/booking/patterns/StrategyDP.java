/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.patterns;

import com.booking.models.User;

/**
 *
 * @author pruso
 */
public class StrategyDP {
    
    // Strategy interface
    public interface AuthenticationStrategy {
        boolean authenticate(String username, String password);
        User getUser(String username, String password);
    }
    
    // Concrete strategy for database authentication
    public static class DatabaseAuthenticationStrategy implements AuthenticationStrategy {
        private final com.booking.dao.UserDAO userDAO;
        
        public DatabaseAuthenticationStrategy() {
            this.userDAO = new com.booking.dao.UserDAO();
        }
        
        @Override
        public boolean authenticate(String username, String password) {
            User user = userDAO.authenticateUser(username, password);
            return user != null;
        }
        
        @Override
        public User getUser(String username, String password) {
            return userDAO.authenticateUser(username, password);
        }
    }
    
    // Concrete strategy for LDAP authentication (placeholder for future implementation)
    public static class LDAPAuthenticationStrategy implements AuthenticationStrategy {
        @Override
        public boolean authenticate(String username, String password) {
            // Placeholder for LDAP authentication
            System.out.println("LDAP authentication not implemented yet");
            return false;
        }
        
        @Override
        public User getUser(String username, String password) {
            // Placeholder for LDAP user retrieval
            return null;
        }
    }
    
    // Context class that uses the strategy
    public static class AuthenticationContext {
        private AuthenticationStrategy strategy;
        
        public AuthenticationContext(AuthenticationStrategy strategy) {
            this.strategy = strategy;
        }
        
        public void setStrategy(AuthenticationStrategy strategy) {
            this.strategy = strategy;
        }
        
        public boolean authenticate(String username, String password) {
            return strategy.authenticate(username, password);
        }
        
        public User getUser(String username, String password) {
            return strategy.getUser(username, password);
        }
    }
} 