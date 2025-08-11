/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

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
        
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please login first.");
            return;
        }

        // Get current user's role
        String currentUserRole = (String) session.getAttribute("role");
        
        // If no action specified, default to list (load the page with data)
        if (action == null || action.isEmpty()) {
            action = "list";
        }
        
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

            UserRole role = new UserRole();
            role.setRoleId(roleId);
            
            User user = new User();
            user.setUsername(username);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            boolean success = facade.registerUser(user);

            if (success) {
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
            int userId = Integer.parseInt(request.getParameter("user_id"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            int roleId = Integer.parseInt(request.getParameter("role_id"));

            // Role-based validation
            String currentUserRole = (String) session.getAttribute("role");
            if (!canUpdateUser(currentUserRole, userId, roleId)) {
                response.sendRedirect("user.jsp?error=You don't have permission to update this user.");
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

            boolean success = facade.updateUser(user);

            if (success) {
                eventManager.logEvent("User updated successfully: " + username, "INFO");
                response.sendRedirect("user.jsp?message=User updated successfully.");
            } else {
                eventManager.logEvent("User update failed: " + username, "ERROR");
                response.sendRedirect("user.jsp?error=Failed to update user.");
            }

        } catch (Exception e) {
            eventManager.logEvent("User update error: " + e.getMessage(), "ERROR");
            response.sendRedirect("user.jsp?error=Error updating user: " + e.getMessage());
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

    @Override
    public String getServletInfo() {
        return "User Management Servlet";
    }
} 