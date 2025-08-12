/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

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
import java.util.ArrayList;

/**
 *
 * @author pruso
 */
public class UserServlet extends HttpServlet {

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
        
        // Handle unauthenticated password reset actions first
        if ("check-email-exists".equals(action) || "reset-password".equals(action) || "send-verification".equals(action)) {
            switch (action) {
                case "check-email-exists":
                    handleCheckEmailExists(request, response);
                    break;
                case "send-verification":
                    handleSendVerificationCode(request, response);
                    break;
                case "reset-password":
                    handlePasswordReset(request, response);
                    break;
            }
            return;
        }
        
        // For other actions, require authentication
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        // Get current user's role
        String currentUserRole = (String) session.getAttribute("role");
        
        // Check role-based access
        if (!hasAccess(currentUserRole, action)) {
            response.sendRedirect("dashboard.jsp?error=Access denied.");
            return;
        }

        switch (action) {
            case "create":
                handleCreateUser(request, response, session);
                break;
            case "update":
                handleUpdateUser(request, response, session);
                break;
            case "delete":
                handleDeleteUser(request, response, session);
                break;
            case "view":
                handleViewUser(request, response, session);
                break;
            case "list":
                handleListUsers(request, response, session);
                break;
            case "send-verification":
                handleSendVerificationCode(request, response);
                break;
            case "verify-email":
                handleVerifyEmailCode(request, response);
                break;

            default:
                response.sendRedirect("user.jsp?error=Invalid action.");
        }
    }

    private boolean hasAccess(String currentUserRole, String action) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin has access to everything
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can manage CASHIER and CUSTOMER users
            return "create".equals(action) || "update".equals(action) || 
                   "delete".equals(action) || "view".equals(action) || "list".equals(action);
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can only view users (no create, update, delete)
            return "view".equals(action) || "list".equals(action);
        }
        return false;
    }

    private void handleCreateUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            int roleId = Integer.parseInt(request.getParameter("role_id"));

            // Role-based validation
            String currentUserRole = (String) session.getAttribute("role");
            if (!canCreateRole(currentUserRole, roleId)) {
                if ("ADMIN".equals(currentUserRole) && roleId == 4) {
                    response.sendRedirect("user.jsp?error=CUSTOMER accounts should be created through customer registration, not user management.");
                } else {
                    response.sendRedirect("user.jsp?error=You don't have permission to create users with this role.");
                }
                return;
            }

            // Check if username already exists in ANY table (customers or users)
            if (facade.isUsernameExistsInAnyTable(username.trim())) {
                response.sendRedirect("user.jsp?error=Username already exists in our system. Please use a different username.");
                return;
            }

            // Check if email already exists in ANY table (customers or users)
            if (facade.isEmailExistsInAnyTable(email.trim())) {
                response.sendRedirect("user.jsp?error=Email already exists in our system. Please use a different email address.");
                return;
            }

            UserRole role = new UserRole();
            role.setRoleId(roleId);
            
            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            boolean success = facade.registerUser(user);

            if (success) {
                // Send role-specific help sections via email
                try {
                    sendUserHelpSectionsEmail(user);
                } catch (Exception emailException) {
                    // Log email error but don't fail user creation
                    System.err.println("Error sending help sections email: " + emailException.getMessage());
                }
                
                eventManager.logEvent("User created successfully: " + username, "INFO");
                response.sendRedirect("user.jsp?message=User created successfully.");
            } else {
                eventManager.logEvent("User creation failed: " + username, "ERROR");
                response.sendRedirect("user.jsp?error=Failed to create user. Username or email might already exist.");
            }

        } catch (Exception e) {
            eventManager.logEvent("User creation error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user.jsp?error=Error creating user: " + e.getMessage());
        }
    }

    private boolean canCreateRole(String currentUserRole, int targetRoleId) {
        if ("ADMIN".equals(currentUserRole)) {
            // Admin can only create system users (ADMIN=1, MANAGER=2, CASHIER=3)
            // CUSTOMER (role_id=4) should be created through customer registration
            return targetRoleId >= 1 && targetRoleId <= 3;
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can only create CASHIER (role_id=3)
            return targetRoleId == 3;
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can only create CUSTOMER (role_id=4)
            return targetRoleId == 4;
        }
        return false;
    }

    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            System.out.println("=== USER UPDATE DEBUG ===");
            System.out.println("Method called: handleUpdateUser");
            
            int userId = Integer.parseInt(request.getParameter("user_id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            int roleId = Integer.parseInt(request.getParameter("role_id"));
            
            System.out.println("Parameters received:");
            System.out.println("User ID: " + userId);
            System.out.println("Username: " + username);
            System.out.println("Email: " + email);
            System.out.println("Password length: " + (password != null ? password.length() : 0));
            System.out.println("Role ID: " + roleId);

            // Role-based validation
            String currentUserRole = (String) session.getAttribute("role");
            if (!canUpdateUser(currentUserRole, userId, roleId)) {
                System.out.println("ERROR: Permission denied for role: " + currentUserRole);
                if (isAjaxRequest(request)) {
                    sendAjaxResponse(response, false, "You don't have permission to update this user.");
                } else {
                    response.sendRedirect("user.jsp?error=You don't have permission to update this user.");
                }
                return;
            }

            UserRole role = new UserRole();
            role.setRoleId(roleId);
            
            User user = new User();
            user.setUserId(userId);
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            System.out.println("Updating user with new values:");
            System.out.println("New email: " + email);
            System.out.println("New username: " + username);

            boolean success = facade.updateUser(user);

            System.out.println("Update result: " + success);

            if (success) {
                // Check if password was changed and send email if needed
                if (password != null && !password.trim().isEmpty()) {
                    try {
                        System.out.println("Password was changed, sending email to: " + email);
                        EmailService emailService = new EmailService();
                        boolean emailSent = emailService.sendPasswordEmail(email, password);
                        
                        if (emailSent) {
                            System.out.println("✓ Password email sent successfully to: " + email);
                            eventManager.logEvent("Password email sent successfully to: " + email, "INFO");
                        } else {
                            System.out.println("✗ Failed to send password email to: " + email);
                            eventManager.logEvent("Failed to send password email to: " + email, "ERROR");
                        }
                    } catch (Exception e) {
                        System.out.println("ERROR sending password email: " + e.getMessage());
                        e.printStackTrace();
                        eventManager.logEvent("Error sending password email: " + e.getMessage(), "ERROR");
                    }
                } else {
                    System.out.println("No password change detected, skipping email");
                }
                
                eventManager.logEvent("User updated successfully: " + username, "INFO");
                if (isAjaxRequest(request)) {
                    sendAjaxResponse(response, true, "User updated successfully. " + 
                        (password != null && !password.trim().isEmpty() ? "New password has been sent to the user's email." : ""));
                } else {
                    response.sendRedirect("user.jsp?message=User updated successfully." + 
                        (password != null && !password.trim().isEmpty() ? " New password has been sent to the user's email." : ""));
                }
            } else {
                eventManager.logEvent("User update failed: " + username, "ERROR");
                if (isAjaxRequest(request)) {
                    sendAjaxResponse(response, false, "Failed to update user.");
                } else {
                    response.sendRedirect("user.jsp?error=Failed to update user.");
                }
            }

        } catch (Exception e) {
            System.out.println("ERROR in handleUpdateUser: " + e.getMessage());
            e.printStackTrace();
            eventManager.logEvent("User update error: " + e.getMessage(), "ERROR");
            if (isAjaxRequest(request)) {
                sendAjaxResponse(response, false, "Error updating user: " + e.getMessage());
            } else {
                response.sendRedirect("user.jsp?error=Error updating user: " + e.getMessage());
            }
        }
    }

    private boolean canUpdateUser(String currentUserRole, int targetUserId, int targetRoleId) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin can update any user
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can only update CASHIER users
            return targetRoleId == 3;
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can only update CUSTOMER users
            return targetRoleId == 4;
        }
        return false;
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("user_id"));

            // Role-based validation
            String currentUserRole = (String) session.getAttribute("role");
            User targetUser = facade.getUserById(userId);
            
            if (targetUser == null) {
                // Check if this is an AJAX request
                String xRequestedWith = request.getHeader("X-Requested-With");
                boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
                
                if (isAjaxRequest) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"User not found.\"}");
                } else {
                    response.sendRedirect("user.jsp?error=User not found.");
                }
                return;
            }

            if (!canDeleteUser(currentUserRole, targetUser.getRole().getRoleId())) {
                // Check if this is an AJAX request
                String xRequestedWith = request.getHeader("X-Requested-With");
                boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
                
                if (isAjaxRequest) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"You don't have permission to delete this user.\"}");
                } else {
                    response.sendRedirect("user.jsp?error=You don't have permission to delete this user.");
                }
                return;
            }

            boolean success = facade.deleteUser(userId);

            // Check if this is an AJAX request
            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);

            if (success) {
                eventManager.logEvent("User deleted successfully: ID " + userId, "INFO");
                if (isAjaxRequest) {
                    // Return JSON response for AJAX
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": true, \"message\": \"User deleted successfully.\"}");
                } else {
                    // Redirect for regular requests
                    response.sendRedirect("user.jsp?message=User deleted successfully.");
                }
            } else {
                eventManager.logEvent("User deletion failed: ID " + userId, "ERROR");
                if (isAjaxRequest) {
                    // Return JSON response for AJAX
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\": false, \"message\": \"Failed to delete user.\"}");
                } else {
                    // Redirect for regular requests
                    response.sendRedirect("user.jsp?error=Failed to delete user.");
                }
            }

        } catch (Exception e) {
            eventManager.logEvent("User deletion error: " + e.getMessage(), "ERROR");
            // Check if this is an AJAX request
            String xRequestedWith = request.getHeader("X-Requested-With");
            boolean isAjaxRequest = "XMLHttpRequest".equals(xRequestedWith);
            
            if (isAjaxRequest) {
                // Return JSON response for AJAX
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"success\": false, \"message\": \"Error deleting user: " + e.getMessage() + "\"}");
            } else {
                // Redirect for regular requests
                response.sendRedirect("user.jsp?error=Error deleting user: " + e.getMessage());
            }
        }
    }

    private boolean canDeleteUser(String currentUserRole, int targetRoleId) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin can delete any user
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can only delete CASHIER users
            return targetRoleId == 3;
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can only delete CUSTOMER users
            return targetRoleId == 4;
        }
        return false;
    }

    private void handleViewUser(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int userId = Integer.parseInt(request.getParameter("user_id"));
            User user = facade.getUserById(userId);
            
            if (user != null) {
                // Check if current user has permission to view this user
                String currentUserRole = (String) session.getAttribute("role");
                if (canViewUser(currentUserRole, user.getRole().getRoleId())) {
                    request.setAttribute("user", user);
                    request.setAttribute("userRoles", facade.getAllUserRoles());
                    request.getRequestDispatcher("user_edit.jsp").forward(request, response);
                } else {
                    response.sendRedirect("user.jsp?error=You don't have permission to view this user.");
                }
            } else {
                response.sendRedirect("user.jsp?error=User not found.");
            }

        } catch (Exception e) {
            eventManager.logEvent("User view error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user.jsp?error=Error viewing user: " + e.getMessage());
        }
    }

    private boolean canViewUser(String currentUserRole, int targetRoleId) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin can view any user
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can only view CASHIER users
            return targetRoleId == 3;
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can view CASHIER and CUSTOMER users
            return targetRoleId == 3 || targetRoleId == 4;
        }
        return false;
    }

    private void handleListUsers(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            List<User> allUsers = facade.getAllUsers();
            String currentUserRole = (String) session.getAttribute("role");
            
            // Filter users based on current user's role
            List<User> filteredUsers = filterUsersByRole(allUsers, currentUserRole);
            
            request.setAttribute("users", filteredUsers);
            request.setAttribute("userRoles", facade.getAllUserRoles());
            
            // Preserve any message or error parameters
            String message = request.getParameter("message");
            String error = request.getParameter("error");
            
            if (message != null && !message.isEmpty()) {
                request.setAttribute("message", message);
            }
            if (error != null && !error.isEmpty()) {
                request.setAttribute("error", error);
            }
            
            request.getRequestDispatcher("user.jsp").forward(request, response);

        } catch (Exception e) {
            eventManager.logEvent("User list error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user.jsp?error=Error loading users: " + e.getMessage());
        }
    }

    private List<User> filterUsersByRole(List<User> allUsers, String currentUserRole) {
        if ("ADMIN".equals(currentUserRole)) {
            return allUsers; // Admin can see all users
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can only see CASHIER users
            return allUsers.stream()
                .filter(user -> {
                    int roleId = user.getRole().getRoleId();
                    return roleId == 3;
                })
                .collect(java.util.stream.Collectors.toList());
        } else if ("CASHIER".equals(currentUserRole)) {
            // Cashier can see CASHIER and CUSTOMER users
            return allUsers.stream()
                .filter(user -> {
                    int roleId = user.getRole().getRoleId();
                    return roleId == 3 || roleId == 4;
                })
                .collect(java.util.stream.Collectors.toList());
        }
        return new java.util.ArrayList<>();
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
            String context = request.getParameter("context"); // New parameter to distinguish context
            
            if (email == null || email.trim().isEmpty()) {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Email is required\"}");
                return;
            }
            
            // Create email service and send verification code
            EmailService emailService = new EmailService();
            String verificationCode = emailService.generateVerificationCode();
            
            // Store the code in session for verification (in production, use Redis or database)
            HttpSession session = request.getSession();
            session.setAttribute("verification_code_" + email, verificationCode);
            session.setAttribute("verification_email", email);
            
            // Send email based on context
            boolean emailSent;
            if ("email-change".equals(context)) {
                emailSent = emailService.sendEmailChangeVerificationEmail(email, verificationCode);
            } else if ("forgot-password".equals(context)) {
                emailSent = emailService.sendForgotPasswordVerificationEmail(email, verificationCode);
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
            
            // Get stored verification code from session
            HttpSession session = request.getSession();
            String storedCode = (String) session.getAttribute("verification_code_" + email);
            String storedEmail = (String) session.getAttribute("verification_email");
            
            // Check if code matches and email is correct
            boolean isValid = storedCode != null && storedCode.equals(code) && 
                            storedEmail != null && storedEmail.equals(email);
            
            if (isValid) {
                // Mark email as verified in session
                session.setAttribute("email_verified_" + email, true);
                // Remove the used code
                session.removeAttribute("verification_code_" + email);
                response.getWriter().write("{\"status\":\"success\",\"message\":\"Email verified successfully\"}");
            } else {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Invalid verification code\"}");
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
    
    private void handleCheckEmailExists(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("application/json;charset=UTF-8");
            
            String email = request.getParameter("email");
            
            if (email == null || email.trim().isEmpty()) {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Email is required\"}");
                return;
            }
            
            // Check if email exists in users table
            boolean exists = facade.isUserEmailExists(email.trim());
            
            response.getWriter().write("{\"status\":\"success\",\"exists\":" + exists + "}");
            
        } catch (Exception e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error: " + e.getMessage() + "\"}");
        }
    }
    
    private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("application/json;charset=UTF-8");
            
            String email = request.getParameter("email");
            String newPassword = request.getParameter("newPassword");
            
            if (email == null || email.trim().isEmpty() || newPassword == null || newPassword.trim().isEmpty()) {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Email and new password are required\"}");
                return;
            }
            
            // Update user password
            boolean success = facade.updateUserPassword(email.trim(), newPassword.trim());
            
            if (success) {
                eventManager.logEvent("User password reset successfully: " + email, "INFO");
                response.getWriter().write("{\"status\":\"success\",\"message\":\"Password reset successfully! You can now login with your new password.\"}");
            } else {
                eventManager.logEvent("User password reset failed: " + email, "ERROR");
                response.getWriter().write("{\"status\":\"error\",\"message\":\"Failed to reset password. Please try again.\"}");
            }
            
        } catch (Exception e) {
            eventManager.logEvent("User password reset error: " + e.getMessage(), "ERROR");
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Error: " + e.getMessage() + "\"}");
        }
    }
    
    @Override
    public String getServletInfo() {
        return "User Management Servlet";
    }
    
    /**
     * Send role-specific help sections to newly created user
     */
    private void sendUserHelpSectionsEmail(User user) {
        try {
            // Get help sections based on user's role ID
            List<HelpSection> helpSections = null;
            int roleId = user.getRole().getRoleId();
            String roleName = getRoleNameById(roleId);
            
            switch (roleId) {
                case 1: // ADMIN
                    // Admin gets all help sections
                    helpSections = facade.getAllHelpSections();
                    break;
                case 2: // MANAGER
                    // Manager gets MANAGER role help sections
                    helpSections = facade.getHelpSectionsByRole(2);
                    break;
                case 3: // CASHIER
                    // Cashier gets CASHIER role help sections
                    helpSections = facade.getHelpSectionsByRole(3);
                    break;
                default:
                    // Default: no help sections
                    helpSections = new ArrayList<>();
                    break;
            }
            
            if (helpSections != null && !helpSections.isEmpty()) {
                // Create email service instance
                EmailService emailService = new EmailService();
                
                // Build email content with help sections
                String subject = "Welcome to Pahana BookStore - " + roleName + " Help & Guidelines";
                String emailContent = buildUserHelpEmailContent(user, helpSections, roleName);
                
                // Send email
                emailService.sendEmail(user.getEmail(), subject, emailContent);
                
                // Log successful email
                eventManager.logEvent("Help sections email sent to new " + roleName + " user: " + user.getEmail(), "INFO");
            } else {
                // Log that no help sections found
                eventManager.logEvent("No " + roleName + " help sections found for email to: " + user.getEmail(), "INFO");
            }
            
        } catch (Exception e) {
            // Log email error
            eventManager.logEvent("Error sending help sections email to user: " + user.getEmail() + " - " + e.getMessage(), "ERROR");
            throw e; // Re-throw to be caught by caller
        }
    }
    
    /**
     * Build email content with user help sections
     */
    private String buildUserHelpEmailContent(User user, List<HelpSection> helpSections, String roleName) {
        StringBuilder content = new StringBuilder();
        
        content.append("<html><body>");
        content.append("<h2>Welcome to Pahana BookStore!</h2>");
        content.append("<p>Dear ").append(user.getUsername()).append(",</p>");
        content.append("<p>Welcome to Pahana BookStore! Your ").append(roleName).append(" account has been successfully created.</p>");
        content.append("<p><strong>Account Details:</strong></p>");
        content.append("<ul>");
        content.append("<li><strong>Username:</strong> ").append(user.getUsername()).append("</li>");
        content.append("<li><strong>Email:</strong> ").append(user.getEmail()).append("</li>");
        content.append("<li><strong>Role:</strong> ").append(roleName).append("</li>");
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
    
    /**
     * Get role name by role ID
     */
    private String getRoleNameById(int roleId) {
        switch (roleId) {
            case 1: return "ADMIN";
            case 2: return "MANAGER";
            case 3: return "CASHIER";
            case 4: return "CUSTOMER";
            default: return "UNKNOWN";
        }
    }
} 