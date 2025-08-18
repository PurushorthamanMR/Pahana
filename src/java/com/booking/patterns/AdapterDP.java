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
    
    public interface AuthenticationService {
        boolean authenticate(String username, String password);
        User getUser(String username, String password);
        Customer getCustomer(String username, String password);
    }
    
    public interface ExternalAuthService {
        boolean validateCredentials(String username, String password);
        Object getUserInfo(String username);
        String getAuthToken(String username, String password);
    }
    
    public static class LDAPAuthService implements ExternalAuthService {
        @Override
        public boolean validateCredentials(String username, String password) {
            System.out.println("LDAP: Validating credentials for user: " + username);
            return username != null && password != null && !username.isEmpty() && !password.isEmpty();
        }
        
        @Override
        public Object getUserInfo(String username) {
            System.out.println("LDAP: Getting user info for: " + username);
            return new Object(); 
        }
        
        @Override
        public String getAuthToken(String username, String password) {
            if (validateCredentials(username, password)) {
                return "LDAP_TOKEN_" + username + "_" + System.currentTimeMillis();
            }
            return null;
        }
    }
    
    public static class OAuthAuthService implements ExternalAuthService {
        @Override
        public boolean validateCredentials(String username, String password) {
            System.out.println("OAuth: Validating credentials for user: " + username);
            return username != null && password != null && !username.isEmpty() && !password.isEmpty();
        }
        
        @Override
        public Object getUserInfo(String username) {
            System.out.println("OAuth: Getting user info for: " + username);
            return new Object(); 
        }
        
        @Override
        public String getAuthToken(String username, String password) {
            if (validateCredentials(username, password)) {
                return "OAUTH_TOKEN_" + username + "_" + System.currentTimeMillis();
            }
            return null;
        }
    }
    
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
            boolean externalAuth = externalAuthService.validateCredentials(username, password);
            
            if (externalAuth) {
                User user = userDAO.authenticateUser(username, password);
                Customer customer = customerDAO.authenticateCustomer(username, password);
                return user != null || customer != null;
            }
            
            return false;
        }
        
        @Override
        public User getUser(String username, String password) {
            if (externalAuthService.validateCredentials(username, password)) {
                return userDAO.authenticateUser(username, password);
            }
            return null;
        }
        
        @Override
        public Customer getCustomer(String username, String password) {
            if (externalAuthService.validateCredentials(username, password)) {
                return customerDAO.authenticateCustomer(username, password);
            }
            return null;
        }
        
        public String getExternalAuthToken(String username, String password) {
            return externalAuthService.getAuthToken(username, password);
        }
    }
    
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
