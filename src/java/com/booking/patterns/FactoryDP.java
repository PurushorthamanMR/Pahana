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
 *
 * @author pruso
 */
public class FactoryDP {
    
    public enum DAOType {
        USER, CUSTOMER, BOOK, TRANSACTION, HELP_SECTION, USER_ROLE, BOOK_CATEGORY
    }
    
    public static Object createDAO(DAOType type) {
        switch (type) {
            case USER:
                return new UserDAO();
            case CUSTOMER:
                return new CustomerDAO();
            case BOOK:
                return new BookDAO();
            case TRANSACTION:
                return new TransactionDAO();
            case HELP_SECTION:
                return new HelpSectionDAO();
            case USER_ROLE:
                return new UserRoleDAO();
            case BOOK_CATEGORY:
                return new BookCategoryDAO();
            default:
                throw new IllegalArgumentException("Unknown DAO type: " + type);
        }
    }
} 
