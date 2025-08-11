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
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            dataSource = (DataSource) envContext.lookup("jdbc/booking");
            System.out.println("Singleton: DataSource initialized successfully");
        } catch (NamingException e) {
            System.err.println("Singleton: Error initializing DataSource: " + e.getMessage());
        }
    }
    
    public Connection getConnection() throws SQLException {
        if (dataSource != null) {
            return dataSource.getConnection();
        } else {
            // Fallback to direct connection
            String url = "jdbc:mysql://localhost:3306/booking?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            String username = "root";
            String password = "password";
            return DriverManager.getConnection(url, username, password);
        }
    }
} 