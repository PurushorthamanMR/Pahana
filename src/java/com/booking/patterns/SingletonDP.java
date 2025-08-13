/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.booking.patterns;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author pruso
 */
public class SingletonDP {
    private static SingletonDP instance;
    private DataSource dataSource;
    
    private SingletonDP() {
        initializeDataSource();
    }
    
    public static synchronized SingletonDP getInstance() {
        if (instance == null) {
            instance = new SingletonDP();
        }
        return instance;
    }
    
    private void initializeDataSource() {
        try {
            // Try to initialize DataSource via JNDI (only works in servlet container)
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/pahana");
            System.out.println("Singleton: DataSource initialized successfully via JNDI");
        } catch (NamingException e) {
            System.out.println("Singleton: JNDI DataSource not available (running in standalone mode)");
            System.out.println("Singleton: Will use direct database connection as fallback");
            // In standalone mode, we don't have JNDI, so dataSource remains null
            // The getConnection method will handle the fallback
        } catch (Exception e) {
            System.err.println("Singleton: Unexpected error during DataSource initialization: " + e.getMessage());
        }
    }
    
    public Connection getConnection() throws SQLException {
        if (dataSource != null) {
            return dataSource.getConnection();
        } else {
            // Fallback to direct connection for standalone execution
            try {
                String url = "jdbc:mysql://localhost:3306/pahana?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
                String username = "root";
                String password = "password";
                System.out.println("Singleton: Creating direct database connection...");
                Connection conn = DriverManager.getConnection(url, username, password);
                System.out.println("Singleton: Direct database connection successful");
                return conn;
            } catch (SQLException e) {
                System.err.println("Singleton: Failed to create direct database connection: " + e.getMessage());
                System.err.println("Singleton: Please ensure MySQL is running and credentials are correct");
                throw e;
            }
        }
    }
} 