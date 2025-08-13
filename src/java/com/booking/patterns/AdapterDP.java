/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.patterns;

import com.booking.models.User;
import com.booking.models.Customer;

/**
 * Adapter Design Pattern
 * Adapts different authentication interfaces to work together
 * @author pruso
 */
public class AdapterDP {
    
    // Target interface that the client expects
    public interface AuthenticationService {
        boolean authenticate(String username, String password);
        User getUser(String username, String password);
        Customer getCustomer(String username, String password);
    }
    
    // Adaptee interface - external authentication service
    public interface ExternalAuthService {
        boolean validateCredentials(String username, String password);
        Object getUserInfo(String username);
        String getAuthToken(String username, String password);
    }
    
    // Concrete adaptee - LDAP authentication service
    public static class LDAPAuthService implements ExternalAuthService {
        @Override
        public boolean validateCredentials(String username, String password) {
            // Simulate LDAP authentication
            System.out.println("LDAP: Validating credentials for user: " + username);
            return username != null && password != null && !username.isEmpty() && !password.isEmpty();
        }
        
        @Override
        public Object getUserInfo(String username) {
            // Simulate getting user info from LDAP
            System.out.println("LDAP: Getting user info for: " + username);
            return new Object(); // Placeholder
        }
        
        @Override
        public String getAuthToken(String username, String password) {
            // Simulate getting auth token from LDAP
            if (validateCredentials(username, password)) {
                return "LDAP_TOKEN_" + username + "_" + System.currentTimeMillis();
            }
            return null;
        }
    }
    
    // Concrete adaptee - OAuth authentication service
    public static class OAuthAuthService implements ExternalAuthService {
        @Override
        public boolean validateCredentials(String username, String password) {
            // Simulate OAuth authentication
            System.out.println("OAuth: Validating credentials for user: " + username);
            return username != null && password != null && !username.isEmpty() && !password.isEmpty();
        }
        
        @Override
        public Object getUserInfo(String username) {
            // Simulate getting user info from OAuth
            System.out.println("OAuth: Getting user info for: " + username);
            return new Object(); // Placeholder
        }
        
        @Override
        public String getAuthToken(String username, String password) {
            // Simulate getting auth token from OAuth
            if (validateCredentials(username, password)) {
                return "OAUTH_TOKEN_" + username + "_" + System.currentTimeMillis();
            }
            return null;
        }
    }
    
    // Adapter class that adapts ExternalAuthService to AuthenticationService
    public static class ExternalAuthAdapter implements AuthenticationService {
        private final ExternalAuthService externalAuthService;
        private final com.booking.dao.UserDAO userDAO;
        private final com.booking.dao.CustomerDAO customerDAO;
        
        public ExternalAuthAdapter(ExternalAuthService externalAuthService) {
            this.externalAuthService = externalAuthService;
            this.userDAO = new com.booking.dao.UserDAO();
            this.customerDAO = new com.booking.dao.CustomerDAO();
        }
        
        @Override
        public boolean authenticate(String username, String password) {
            // Use external service to validate credentials
            boolean externalAuth = externalAuthService.validateCredentials(username, password);
            
            if (externalAuth) {
                // If external auth succeeds, also check if user exists in our system
                User user = userDAO.authenticateUser(username, password);
                Customer customer = customerDAO.authenticateCustomer(username, password);
                return user != null || customer != null;
            }
            
            return false;
        }
        
        @Override
        public User getUser(String username, String password) {
            // Try to get user from external service first
            if (externalAuthService.validateCredentials(username, password)) {
                // Get user from our database
                return userDAO.authenticateUser(username, password);
            }
            return null;
        }
        
        @Override
        public Customer getCustomer(String username, String password) {
            // Try to get customer from external service first
            if (externalAuthService.validateCredentials(username, password)) {
                // Get customer from our database
                return customerDAO.authenticateCustomer(username, password);
            }
            return null;
        }
        
        public String getExternalAuthToken(String username, String password) {
            return externalAuthService.getAuthToken(username, password);
        }
    }
    
    // Client code that uses the adapter
    public static class AuthenticationClient {
        private final AuthenticationService authService;
        
        public AuthenticationClient(AuthenticationService authService) {
            this.authService = authService;
        }
        
        public boolean login(String username, String password) {
            return authService.authenticate(username, password);
        }
        
        public User getUser(String username, String password) {
            return authService.getUser(username, password);
        }
        
        public Customer getCustomer(String username, String password) {
            return authService.getCustomer(username, password);
        }
    }
}
