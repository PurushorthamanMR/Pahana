/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

import com.booking.dao.UserDAO;
import com.booking.dao.CustomerDAO;
import com.booking.models.User;
import com.booking.models.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author pruso
 */
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO;
    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
        customerDAO = new CustomerDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        
        if (username == null || role == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        String action = request.getParameter("action");
        
        if (action == null) {
            action = "view";
        }

        try {
            switch (action) {
                case "update":
                    updateProfile(request, response);
                    break;
                default:
                    response.sendRedirect("profile.jsp");
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in ProfileServlet: " + e.getMessage());
            response.sendRedirect("profile.jsp?error=An error occurred: " + e.getMessage());
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (currentPassword == null || currentPassword.trim().isEmpty()) {
            response.sendRedirect("profile.jsp?error=Current password is required.");
            return;
        }
        
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect("profile.jsp?error=New passwords do not match.");
                return;
            }
        }

        HttpSession session = request.getSession();
        String userType = (String) session.getAttribute("userType");
        
        if ("user".equals(userType)) {
            updateUserProfile(request, response, currentPassword, newPassword);
        } else if ("customer".equals(userType)) {
            updateCustomerProfile(request, response, currentPassword, newPassword);
        } else {
            response.sendRedirect("profile.jsp?error=Invalid user type.");
        }
    }

    private void updateUserProfile(HttpServletRequest request, HttpServletResponse response, 
                                 String currentPassword, String newPassword) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        String email = request.getParameter("email");
        
        User user = userDAO.getUserByUsername(currentUser.getUsername());
        if (user == null || !user.getPassword().equals(currentPassword)) {
            response.sendRedirect("profile.jsp?error=Current password is incorrect.");
            return;
        }
        
        user.setEmail(email != null ? email.trim() : user.getEmail());
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            user.setPassword(newPassword.trim());
        }
        
        boolean success = userDAO.updateUser(user);
        
        if (success) {
            session.setAttribute("user", user);
            response.sendRedirect("profile.jsp?message=Profile updated successfully.");
        } else {
            response.sendRedirect("profile.jsp?error=Failed to update profile.");
        }
    }

    private void updateCustomerProfile(HttpServletRequest request, HttpServletResponse response, 
                                     String currentPassword, String newPassword) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Customer currentCustomer = (Customer) session.getAttribute("user");
        String name = request.getParameter("name");
        
        Customer customer = customerDAO.getCustomerByUsername(currentCustomer.getUsername());
        if (customer == null || !customer.getPassword().equals(currentPassword)) {
            response.sendRedirect("profile.jsp?error=Current password is incorrect.");
            return;
        }
        
        customer.setName(name != null ? name.trim() : customer.getName());
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            customer.setPassword(newPassword.trim());
        }
        
        boolean success = customerDAO.updateCustomer(customer);
        
        if (success) {
            session.setAttribute("user", customer);
            response.sendRedirect("profile.jsp?message=Profile updated successfully.");
        } else {
            response.sendRedirect("profile.jsp?error=Failed to update profile.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Profile Management Servlet";
    }
} 