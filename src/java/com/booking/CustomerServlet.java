/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

import com.booking.models.Customer;
import com.booking.models.User;
import com.booking.models.UserRole;
import com.booking.models.HelpSection;
import com.booking.patterns.FacadeDP;
import com.booking.patterns.ObserverDP;
import com.booking.EmailService;
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
        
        if (action == null || action.isEmpty()) {
            action = "list";
        }

        if ("register".equals(action)) {
            handleCustomerRegistration(request, response);
            return;
        }
        
        if ("send-verification".equals(action)) {
            handleSendVerificationCode(request, response);
            return;
        }
        
        if ("verify-email".equals(action)) {
            handleVerifyEmailCode(request, response);
            return;
        }
        
        if ("check-email-exists".equals(action)) {
            handleCheckEmailExists(request, response);
            return;
        }
        
        if ("check-phone-exists".equals(action)) {
            handleCheckPhoneExists(request, response);
            return;
        }
        
        if ("reset-password".equals(action)) {
            handlePasswordReset(request, response);
            return;
        }

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        switch (action) {
            case "create-ajax":
                handleCreateCustomerAjax(request, response, session);
                break;
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
            case "send-verification":
                handleSendVerificationCode(request, response);
                break;
            case "verify-email":
                handleVerifyEmailCode(request, response);
                break;
            case "check-email-exists":
                handleCheckEmailExists(request, response);
                break;
            case "check-username-exists":
                handleCheckUsernameExists(request, response);
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

            if (name == null || name.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                response.sendRedirect("login.jsp?error=All fields are required.");
                return;
            }

            String accountNumber = facade.generateUniqueAccountNumber();

            if (facade.isUsernameExistsInAnyTable(username.trim())) {
                response.sendRedirect("login.jsp?error=Username already exists in our system. Please use a different username.");
                return;
            }

            if (facade.isEmailExistsInAnyTable(email.trim())) {
                response.sendRedirect("login.jsp?error=Email already exists in our system. Please use a different email address.");
                return;
            }

            if (facade.isPhoneNumberExists(phone.trim())) {
                response.sendRedirect("login.jsp?error=Phone number already exists in our system. Please use a different phone number.");
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
            
            UserRole role = new UserRole();
            role.setRoleId(4);
            role.setRoleName("CUSTOMER");
            customer.setRole(role);
            
            User defaultAdmin = new User();
            defaultAdmin.setUserId(1);
            customer.setCreatedBy(defaultAdmin);

            boolean success = facade.createCustomer(customer);

            if (success) {
                try {
                    sendCustomerHelpSectionsEmail(customer);
                } catch (Exception emailException) {
                    System.err.println("Error sending help sections email: " + emailException.getMessage());
                }
                
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

            if (name == null || name.trim().isEmpty() ||
                address == null || address.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                username == null || username.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
                response.sendRedirect("customer.jsp?error=All fields are required.");
                return;
            }

            String accountNumber = facade.generateUniqueAccountNumber();

            if (facade.isUsernameExistsInAnyTable(username.trim())) {
                response.sendRedirect("customer.jsp?error=Username already exists in our system. Please use a different username.");
                return;
            }

            if (facade.isEmailExistsInAnyTable(email.trim())) {
                response.sendRedirect("customer.jsp?error=Email already exists in our system. Please use a different email address.");
                return;
            }

            if (facade.isPhoneNumberExists(phone.trim())) {
                response.sendRedirect("customer.jsp?error=Phone number already exists in our system. Please use a different phone number.");
                return;
            }

            UserRole role = new UserRole();
            role.setRoleId(4);
            role.setRoleName("CUSTOMER");
            
            Customer customer = new com.booking.patterns.BuilderDP.CustomerBuilder()
                .accountNumber(accountNumber)
                .name(name)
                .address(address)
                .phone(phone)
                .username(username)
                .email(email)
                .password(password)
                .role(role)
                .createdBy((User) session.getAttribute("user"))
                .build();

            boolean success = facade.createCustomer(customer);

            if (success) {
                try {
                    sendCustomerHelpSectionsEmail(customer);
                } catch (Exception emailException) {
                    System.err.println("Error sending help sections email: " + emailException.getMessage());
                }
                
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

    /**
     * Create customer via AJAX and return JSON with the new customer details.
     * This is used from POS checkout to quickly create a customer and proceed with the transaction.
     */
    private void handleCreateCustomerAjax(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            response.setContentType("application/json;charset=UTF-8");

            if (session == null || session.getAttribute("user") == null) {
                response.getWriter().write("{\"success\": false, \"message\": \"Please login first.\"}");
                return;
            }

            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (name == null || name.trim().isEmpty() ||
                phone == null || phone.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"Name, phone and email are required.\"}");
                return;
            }

            if (facade.isEmailExistsInAnyTable(email.trim())) {
                response.getWriter().write("{\"success\": false, \"message\": \"Email already exists.\"}");
                return;
            }
            if (facade.isPhoneNumberExists(phone.trim())) {
                response.getWriter().write("{\"success\": false, \"message\": \"Phone number already exists.\"}");
                return;
            }

            if (username == null || username.trim().isEmpty()) {
                String base = (name.replaceAll("[^A-Za-z0-9]", "").toLowerCase());
                if (base.length() < 4) {
                    base = "cust" + base;
                }
                username = base;
                int suffix = 1;
                while (facade.isUsernameExistsInAnyTable(username)) {
                    username = base + (suffix++);
                }
            } else if (facade.isUsernameExistsInAnyTable(username.trim())) {
                response.getWriter().write("{\"success\": false, \"message\": \"Username already exists.\"}");
                return;
            }

            if (password == null || password.trim().isEmpty()) {
                password = "Pahana" + (int)(Math.random() * 900000 + 100000);
            }

            String accountNumber = facade.generateUniqueAccountNumber();

            UserRole role = new UserRole();
            role.setRoleId(4);
            role.setRoleName("CUSTOMER");

            Customer customer = new com.booking.patterns.BuilderDP.CustomerBuilder()
                .accountNumber(accountNumber)
                .name(name)
                .address(address)
                .phone(phone)
                .username(username)
                .email(email)
                .password(password)
                .role(role)
                .createdBy((User) session.getAttribute("user"))
                .build();

            boolean success = facade.createCustomer(customer);
            if (success) {
                Customer created = facade.getCustomerById(facade.getCustomerByUsername(username).getCustomerId());
                int newId = created != null ? created.getCustomerId() : -1;
                String resp = String.format("{\"success\": true, \"customerId\": %d, \"name\": \"%s\", \"email\": \"%s\"}",
                        newId, escapeJson(name), email == null ? "" : escapeJson(email));
                response.getWriter().write(resp);
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to create customer.\"}");
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer AJAX creation error: " + e.getMessage(), "ERROR");
            response.getWriter().write("{\"success\": false, \"message\": \"Error creating customer: " + e.getMessage().replace("\"", "'") + "\"}");
        }
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }

    private void handleUpdateCustomer(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            System.out.println("=== CUSTOMER UPDATE DEBUG ===");
            System.out.println("Method called: handleUpdateCustomer");
            
            int customerId = Integer.parseInt(request.getParameter("customer_id"));
            String accountNumber = request.getParameter("account_number");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            
            System.out.println("Parameters received:");
            System.out.println("Customer ID: " + customerId);
            System.out.println("Account Number: " + accountNumber);
            System.out.println("Name: " + name);
            System.out.println("Address: " + address);
            System.out.println("Phone: " + phone);
            System.out.println("Username: " + username);
            System.out.println("Email: " + email);

            Customer customer = facade.getCustomerById(customerId);
            if (customer == null) {
                System.out.println("ERROR: Customer not found with ID: " + customerId);
                if (isAjaxRequest(request)) {
                    sendAjaxResponse(response, false, "Customer not found.");
                } else {
                    response.sendRedirect("customer.jsp?error=Customer not found.");
                }
                return;
            }

            customer.setAccountNumber(accountNumber);
            customer.setName(name);
            customer.setAddress(address);
            customer.setPhone(phone);
            customer.setUsername(username);
            customer.setEmail(email);

            System.out.println("Updating customer with new values:");
            System.out.println("New email: " + email);
            System.out.println("New username: " + username);

            boolean success = facade.updateCustomer(customer);

            System.out.println("Update result: " + success);

            if (success) {
                eventManager.logEvent("Customer updated successfully: " + accountNumber, "INFO");
                if (isAjaxRequest(request)) {
                    sendAjaxResponse(response, true, "Customer updated successfully.");
                } else {
                    response.sendRedirect("customer.jsp?message=Customer updated successfully.");
                }
            } else {
                eventManager.logEvent("Customer update failed: " + accountNumber, "ERROR");
                if (isAjaxRequest(request)) {
                    sendAjaxResponse(response, false, "Failed to update customer.");
                } else {
                    response.sendRedirect("customer.jsp?error=Failed to update customer.");
                }
            }

        } catch (Exception e) {
            System.out.println("ERROR in handleUpdateCustomer: " + e.getMessage());
            e.printStackTrace();
            eventManager.logEvent("Customer update error: " + e.getMessage(), "ERROR");
            if (isAjaxRequest(request)) {
                sendAjaxResponse(response, false, "Error updating customer: " + e.getMessage());
            } else {
                response.sendRedirect("customer.jsp?error=Error updating customer: " + e.getMessage());
            }
        }
    }

    private void handleDeleteCustomer(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customer_id"));

            int transactionCount = facade.getCustomerTransactionCount(customerId);
            
            if (transactionCount > 0) {
                eventManager.logEvent("Customer deletion blocked: ID " + customerId + " has " + transactionCount + " transactions", "WARNING");
                
                String xRequestedWith = request.getHeader("X-Requested-With");
                boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
                
                if (isAjaxRequest) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"Cannot delete customer. Customer has " + transactionCount + " transaction(s). Please delete transactions first.\"}");
                } else {
                    response.sendRedirect("customer.jsp?error=Cannot delete customer. Customer has " + transactionCount + " transaction(s). Please delete transactions first.");
                }
                return;
            }

            boolean success = facade.deleteCustomer(customerId);

            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);

            if (success) {
                eventManager.logEvent("Customer deleted successfully: ID " + customerId, "INFO");
                if (isAjaxRequest) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": true, \"message\": \"Customer deleted successfully.\"}");
                } else {
                    response.sendRedirect("customer.jsp?message=Customer deleted successfully.");
                }
            } else {
                eventManager.logEvent("Customer deletion failed: ID " + customerId, "ERROR");
                if (isAjaxRequest) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"Failed to delete customer. Please try again.\"}");
                } else {
                    response.sendRedirect("customer.jsp?error=Failed to delete customer. Please try again.");
                }
            }

        } catch (Exception e) {
            eventManager.logEvent("Customer deletion error: " + e.getMessage(), "ERROR");
            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
            
            if (isAjaxRequest) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Error deleting customer: " + e.getMessage() + "\"}");
            } else {
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

    private void handleSendVerificationCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("application/json;charset=UTF-8");
            
            String email = request.getParameter("email");
            String context = request.getParameter("context");
            
            if (email == null || email.trim().isEmpty()) {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Email is required\"}");
                return;
            }
            
            EmailService emailService = new EmailService();
            String verificationCode = emailService.generateVerificationCode();
            
            HttpSession session = request.getSession();
            session.setAttribute("verification_code_" + email, verificationCode);
            session.setAttribute("verification_email", email);
            
            System.out.println("=== SEND VERIFICATION DEBUG ===");
            System.out.println("Session ID: " + session.getId());
            System.out.println("Email: " + email);
            System.out.println("Context: " + context);
            System.out.println("Verification code: " + verificationCode);
            System.out.println("Session attributes set:");
            System.out.println("  verification_code_" + email + " = " + verificationCode);
            System.out.println("  verification_email = " + email);
            System.out.println("===============================");
            
            boolean emailSent;
            if ("forgot-password".equals(context)) {
                emailSent = emailService.sendForgotPasswordVerificationEmail(email, verificationCode);
            } else if ("email-change".equals(context)) {
                emailSent = emailService.sendEmailChangeVerificationEmail(email, verificationCode);
            } else {
                emailSent = emailService.sendVerificationEmail(email, verificationCode);
            }
            
            if (emailSent) {
                response.getWriter().write("{\"status\":\"success\",\"message\":\"Verification code sent to " + email + "\"}");
            } else {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Failed to send verification email\"}");
            }
            
        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error: " + e.getMessage() + "\"}");
        }
    }
    
    private void handleVerifyEmailCode(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("application/json;charset=UTF-8");
            
            String email = request.getParameter("email");
            String code = request.getParameter("code");
            
            if (email == null || code == null || email.trim().isEmpty() || code.trim().isEmpty()) {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Email and verification code are required\"}");
                return;
            }
            
            HttpSession session = request.getSession();
            String storedCode = (String) session.getAttribute("verification_code_" + email);
            String storedEmail = (String) session.getAttribute("verification_email");
            
            System.out.println("=== VERIFICATION DEBUG ===");
            System.out.println("Session ID: " + session.getId());
            System.out.println("Email to verify: " + email);
            System.out.println("Stored code: " + storedCode);
            System.out.println("Stored email: " + storedEmail);
            System.out.println("Code matches: " + (storedCode != null && storedCode.equals(code)));
            System.out.println("Email matches: " + (storedEmail != null && storedEmail.equals(email)));
            System.out.println("=========================");
            
            boolean isValid = storedCode != null && storedCode.equals(code) && 
                            storedEmail != null && storedEmail.equals(email);
            
            if (isValid) {
                session.setAttribute("email_verified_" + email, true);
                session.removeAttribute("verification_code_" + email);
                
                System.out.println("=== EMAIL VERIFICATION SUCCESS ===");
                System.out.println("Email verified: " + email);
                System.out.println("Session attribute set: email_verified_" + email + " = true");
                System.out.println("================================");
                
                response.getWriter().write("{\"status\":\"success\",\"message\":\"Email verified successfully\"}");
            } else {
                System.out.println("=== EMAIL VERIFICATION FAILED ===");
                System.out.println("Email: " + email);
                System.out.println("Stored code: " + storedCode);
                System.out.println("Stored email: " + storedEmail);
                System.out.println("================================");
                
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid verification code\"}");
            }
            
        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error: " + e.getMessage() + "\"}");
        }
    }

    private void handleCheckEmailExists(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("application/json;charset=UTF-8");
            
            String email = request.getParameter("email");
            
            if (email == null || email.trim().isEmpty()) {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Email is required\"}");
                return;
            }
            
            boolean exists = facade.isEmailExistsForVerification(email.trim());
            
            response.getWriter().write("{\"status\":\"success\",\"exists\":" + exists + "}");
            
        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error: " + e.getMessage() + "\"}");
        }
    }

    private void handleCheckPhoneExists(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("application/json;charset=UTF-8");
            
            String phone = request.getParameter("phone");
            
            if (phone == null || phone.trim().isEmpty()) {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Phone number is required\"}");
                return;
            }
            
            boolean exists = facade.isPhoneNumberExists(phone.trim());
            
            response.getWriter().write("{\"status\":\"success\",\"exists\":" + exists + "}");
            
        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error: " + e.getMessage() + "\"}");
        }
    }

    private void handleCheckUsernameExists(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("application/json;charset=UTF-8");
            
            String username = request.getParameter("username");
            
            if (username == null || username.trim().isEmpty()) {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Username is required\"}");
                return;
            }
            
            boolean exists = facade.isUsernameExistsInAnyTable(username.trim());
            
            response.getWriter().write("{\"status\":\"success\",\"exists\":" + exists + "}");
            
        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error: " + e.getMessage() + "\"}");
        }
    }

    private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("=== PASSWORD RESET METHOD CALLED ===");
        System.out.println("Method: " + request.getMethod());
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Query string: " + request.getQueryString());
        System.out.println("=====================================");
        
        try {
            response.setContentType("application/json;charset=UTF-8");
            
            String email = request.getParameter("email");
            String newPassword = request.getParameter("newPassword");
            
            if (email == null || newPassword == null || email.trim().isEmpty() || newPassword.trim().isEmpty()) {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Email and new password are required\"}");
                return;
            }
            
            HttpSession session = request.getSession();
            Boolean emailVerified = (Boolean) session.getAttribute("email_verified_" + email);
            
            System.out.println("=== PASSWORD RESET VERIFICATION CHECK ===");
            System.out.println("Session ID: " + session.getId());
            System.out.println("Email requesting password reset: " + email);
            System.out.println("Verification status: " + emailVerified);
            System.out.println("=========================================");
            
            if (emailVerified == null || !emailVerified) {
                System.out.println("ACCESS DENIED: Email " + email + " not verified!");
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Email must be verified before password reset\"}");
                return;
            }
            
            System.out.println("ACCESS GRANTED: Email " + email + " verified, proceeding with password reset");
            
            System.out.println("=== SERVLET DEBUG ===");
            System.out.println("Email received: " + email);
            System.out.println("New password received: " + newPassword);
            
            System.out.println("Email verification status for " + email + ": " + emailVerified);
            
            System.out.println("=== SESSION VERIFICATION STATUS ===");
            java.util.Enumeration<String> sessionKeys = session.getAttributeNames();
            while (sessionKeys.hasMoreElements()) {
                String key = sessionKeys.nextElement();
                if (key.startsWith("email_verified_")) {
                    System.out.println("Session key: " + key + " = " + session.getAttribute(key));
                }
            }
            System.out.println("==================================");
            System.out.println("====================");
            
            System.out.println("=== SPECIFIC EMAIL VERIFICATION CHECK ===");
            System.out.println("Looking for session attribute: email_verified_" + email);
            System.out.println("Value found: " + session.getAttribute("email_verified_" + email));
            System.out.println("==========================================");
            
            boolean passwordUpdated = facade.updateCustomerPassword(email, newPassword);
            
            System.out.println("=== UPDATE RESULT ===");
            System.out.println("Password update result: " + passwordUpdated);
            System.out.println("=====================");
            
            if (passwordUpdated) {
                eventManager.logEvent("Password reset successful for email: " + email, "INFO");
                session.removeAttribute("email_verified_" + email);
                response.getWriter().write("{\"status\":\"success\",\"message\":\"Password reset successfully\"}");
            } else {
                eventManager.logEvent("Password reset failed for email: " + email, "ERROR");
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Failed to update password in database\"}");
            }
            
        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error: " + e.getMessage() + "\"}");
        }
    }

    private boolean isAjaxRequest(HttpServletRequest request) {
        String xRequestedWith = request.getHeader("X-Requested-With");
        return "XMLHttpRequest".equals(xRequestedWith);
    }
    
    private void sendAjaxResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String jsonResponse = "{\"success\": " + success + ", \"message\": \"" + message + "\"}";
        response.getWriter().write(jsonResponse);
    }
    
    /**
     * Send CUSTOMER role-based help sections to newly created customer
     */
    private void sendCustomerHelpSectionsEmail(Customer customer) {
        try {
            List<HelpSection> customerHelpSections = facade.getHelpSectionsByRole(4);
            
            if (customerHelpSections != null && !customerHelpSections.isEmpty()) {
                EmailService emailService = new EmailService();
                
                String subject = "Welcome to Pahana BookStore - Help & Guidelines";
                String emailContent = buildCustomerHelpEmailContent(customer, customerHelpSections);
                
                emailService.sendEmail(customer.getEmail(), subject, emailContent);
                
                eventManager.logEvent("Help sections email sent to new customer: " + customer.getEmail(), "INFO");
            } else {
                eventManager.logEvent("No CUSTOMER help sections found for email to: " + customer.getEmail(), "INFO");
            }
            
        } catch (Exception e) {
            eventManager.logEvent("Error sending help sections email to customer: " + customer.getEmail() + " - " + e.getMessage(), "ERROR");
            throw e; 
        }
    }
    
    /**
     * Build email content with customer help sections
     */
    private String buildCustomerHelpEmailContent(Customer customer, List<HelpSection> helpSections) {
        StringBuilder content = new StringBuilder();
        
        content.append("<html><body>");
        content.append("<h2>Welcome to Pahana BookStore!</h2>");
        content.append("<p>Dear ").append(customer.getName()).append(",</p>");
        content.append("<p>Welcome to Pahana BookStore! Your account has been successfully created.</p>");
        content.append("<p><strong>Account Details:</strong></p>");
        content.append("<ul>");
        content.append("<li><strong>Account Number:</strong> ").append(customer.getAccountNumber()).append("</li>");
        content.append("<li><strong>Username:</strong> ").append(customer.getUsername()).append("</li>");
        content.append("<li><strong>Email:</strong> ").append(customer.getEmail()).append("</li>");
        content.append("</ul>");
        
        content.append("<h3>Help & Guidelines</h3>");
        content.append("<p>Here are some helpful resources to get you started:</p>");
        
        for (HelpSection helpSection : helpSections) {
            content.append("<div style='margin-bottom: 20px; padding: 15px; border: 1px solid #ddd; border-radius: 5px;'>");
            content.append("<h4 style='color: #2a5298; margin-top: 0;'>").append(helpSection.getTitle()).append("</h4>");
            content.append("<p>").append(helpSection.getContent()).append("</p>");
            content.append("</div>");
        }
        
        content.append("<p>If you have any questions, please don't hesitate to contact our support team.</p>");
        content.append("<p>Best regards,<br>Pahana BookStore Team</p>");
        content.append("</body></html>");
        
        return content.toString();
    }
    
    @Override
    public String getServletInfo() {
        return "Customer Management Servlet";
    }
} 