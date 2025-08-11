/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

import com.booking.models.Customer;
import com.booking.models.User;
import com.booking.models.UserRole;
import com.booking.patterns.FacadeDP;
import com.booking.patterns.ObserverDP;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author pruso
 */
public class CustomerServlet extends HttpServlet {

    private FacadeDP facade;
    private ObserverDP.SystemEventManager eventManager;

    @Override
    public void init() throws ServletException {
        super.init();
        facade = new FacadeDP();
        eventManager = ObserverDP.SystemEventManager.getInstance();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        
        // If no action specified, default to list (load the page with data)
        if (action == null || action.isEmpty()) {
            action = "list";
        }

        // Handle customer registration (no authentication required)
        if ("register".equals(action)) {
            handleCustomerRegistration(request, response);
            return;
        }
        
        // For other actions, require authentication
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        switch (action) {
            case "create":
                handleCreateCustomer(request, response, session);
                break;
            case "update":
                handleUpdateCustomer(request, response, session);
                break;
            case "delete":
                handleDeleteCustomer(request, response, session);
                break;
            case "view":
                handleViewCustomer(request, response, session);
                break;
            case "list":
                handleListCustomers(request, response, session);
                break;
            default:
                response.sendRedirect("customer.jsp?error=Invalid action.");
        }
    }

    private void handleCustomerRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Validate required fields
            if (name == null || name.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                response.sendRedirect("login.jsp?error=All fields are required.");
                return;
            }

            // Generate unique account number
            String accountNumber = facade.generateUniqueAccountNumber();

            // Check if username already exists
            if (facade.isUsernameExists(username.trim())) {
                response.sendRedirect("login.jsp?error=Username already exists.");
                return;
            }

            // Check if email already exists
            if (facade.isEmailExists(email.trim())) {
                response.sendRedirect("login.jsp?error=Email already exists.");
                return;
            }

            Customer customer = new Customer();
            customer.setAccountNumber(accountNumber);
            customer.setName(name);
            customer.setAddress(address);
            customer.setPhone(phone);
            customer.setUsername(username);
            customer.setEmail(email);
            customer.setPassword(password);
            
            // Set role to CUSTOMER (role_id = 4)
            UserRole role = new UserRole();
            role.setRoleId(4);
            role.setRoleName("CUSTOMER");
            customer.setRole(role);
            
            // For customer registration, set created_by to null or a default admin user
            // You might want to create a default admin user or handle this differently
            User defaultAdmin = new User();
            defaultAdmin.setUserId(1); // Assuming admin user_id is 1
            customer.setCreatedBy(defaultAdmin);

            boolean success = facade.createCustomer(customer);

            if (success) {
                eventManager.logEvent("Customer registered successfully: " + accountNumber, "INFO");
                response.sendRedirect("login.jsp?message=Registration successful! You can now login with your username and password.");
            } else {
                eventManager.logEvent("Customer registration failed: " + accountNumber, "ERROR");
                response.sendRedirect("login.jsp?error=Failed to create account. Please try again.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer registration error: " + e.getMessage(), "ERROR");
            response.sendRedirect("login.jsp?error=Error creating account: " + e.getMessage());
        }
    }

    private void handleCreateCustomer(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // Validate required fields
            if (name == null || name.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                response.sendRedirect("customer.jsp?error=All fields are required.");
                return;
            }

            // Generate unique account number
            String accountNumber = facade.generateUniqueAccountNumber();

            // Check if username already exists
            if (facade.isUsernameExists(username.trim())) {
                response.sendRedirect("customer.jsp?error=Username already exists.");
                return;
            }

            // Check if email already exists
            if (facade.isEmailExists(email.trim())) {
                response.sendRedirect("customer.jsp?error=Email already exists.");
                return;
            }

            Customer customer = new Customer();
            customer.setAccountNumber(accountNumber);
            customer.setName(name);
            customer.setAddress(address);
            customer.setPhone(phone);
            customer.setUsername(username);
            customer.setEmail(email);
            customer.setPassword(password);
            
            // Set role to CUSTOMER (role_id = 4)
            UserRole role = new UserRole();
            role.setRoleId(4);
            role.setRoleName("CUSTOMER");
            customer.setRole(role);
            
            customer.setCreatedBy((User) session.getAttribute("user"));

            boolean success = facade.createCustomer(customer);

            if (success) {
                eventManager.logEvent("Customer created successfully: " + accountNumber, "INFO");
                response.sendRedirect("customer.jsp?message=Customer created successfully.");
            } else {
                eventManager.logEvent("Customer creation failed: " + accountNumber, "ERROR");
                response.sendRedirect("customer.jsp?error=Failed to create customer.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer creation error: " + e.getMessage(), "ERROR");
            response.sendRedirect("customer.jsp?error=Error creating customer: " + e.getMessage());
        }
    }

    private void handleUpdateCustomer(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customer_id"));
            String accountNumber = request.getParameter("account_number");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            Customer customer = facade.getCustomerById(customerId);
            if (customer == null) {
                response.sendRedirect("customer.jsp?error=Customer not found.");
                return;
            }

            customer.setAccountNumber(accountNumber);
            customer.setName(name);
            customer.setAddress(address);
            customer.setPhone(phone);

            boolean success = facade.updateCustomer(customer);

            if (success) {
                eventManager.logEvent("Customer updated successfully: " + accountNumber, "INFO");
                response.sendRedirect("customer.jsp?message=Customer updated successfully.");
            } else {
                eventManager.logEvent("Customer update failed: " + accountNumber, "ERROR");
                response.sendRedirect("customer.jsp?error=Failed to update customer.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer update error: " + e.getMessage(), "ERROR");
            response.sendRedirect("customer.jsp?error=Error updating customer: " + e.getMessage());
        }
    }

    private void handleDeleteCustomer(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customer_id"));

            // Check if customer has transactions before attempting deletion
            int transactionCount = facade.getCustomerTransactionCount(customerId);
            
            if (transactionCount > 0) {
                eventManager.logEvent("Customer deletion blocked: ID " + customerId + " has " + transactionCount + " transactions", "WARNING");
                
                // Check if this is an AJAX request
                String xRequestedWith = request.getHeader("X-Requested-With");
                boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
                
                if (isAjaxRequest) {
                    // Return JSON response for AJAX
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"Cannot delete customer. Customer has " + transactionCount + " transaction(s). Please delete transactions first.\"}");
                } else {
                    // Redirect for regular requests
                    response.sendRedirect("customer.jsp?error=Cannot delete customer. Customer has " + transactionCount + " transaction(s). Please delete transactions first.");
                }
                return;
            }

            boolean success = facade.deleteCustomer(customerId);

            // Check if this is an AJAX request
            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);

            if (success) {
                eventManager.logEvent("Customer deleted successfully: ID " + customerId, "INFO");
                if (isAjaxRequest) {
                    // Return JSON response for AJAX
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": true, \"message\": \"Customer deleted successfully.\"}");
                } else {
                    // Redirect for regular requests
                    response.sendRedirect("customer.jsp?message=Customer deleted successfully.");
                }
            } else {
                eventManager.logEvent("Customer deletion failed: ID " + customerId, "ERROR");
                if (isAjaxRequest) {
                    // Return JSON response for AJAX
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"Failed to delete customer. Please try again.\"}");
                } else {
                    // Redirect for regular requests
                    response.sendRedirect("customer.jsp?error=Failed to delete customer. Please try again.");
                }
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer deletion error: " + e.getMessage(), "ERROR");
            // Check if this is an AJAX request
            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
            
            if (isAjaxRequest) {
                // Return JSON response for AJAX
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Error deleting customer: " + e.getMessage() + "\"}");
            } else {
                // Redirect for regular requests
                response.sendRedirect("customer.jsp?error=Error deleting customer: " + e.getMessage());
            }
        }
    }

    private void handleViewCustomer(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customer_id"));
            Customer customer = facade.getCustomerById(customerId);
            
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("customer_view.jsp").forward(request, response);
            } else {
                response.sendRedirect("customer.jsp?error=Customer not found.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer view error: " + e.getMessage(), "ERROR");
            response.sendRedirect("customer.jsp?error=Error viewing customer: " + e.getMessage());
        }
    }

    private void handleListCustomers(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            List<Customer> customers = facade.getAllCustomers();
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("customer.jsp").forward(request, response);

        } catch (Exception e) {
            eventManager.logEvent("Customer list error: " + e.getMessage(), "ERROR");
            response.sendRedirect("customer.jsp?error=Error loading customers: " + e.getMessage());
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
        return "Customer Management Servlet";
    }
} 