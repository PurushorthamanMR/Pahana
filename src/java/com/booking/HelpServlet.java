/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

import com.booking.models.HelpSection;
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
public class HelpServlet extends HttpServlet {

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
        
        if (session == null || session.getAttribute("username") == null) {
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
            response.sendRedirect("help.jsp?error=Access denied.");
            return;
        }

        switch (action) {
            case "create":
                // Redirect to create page for GET, process form for POST
                if ("GET".equals(request.getMethod())) {
                    response.sendRedirect("help_create.jsp");
                } else {
                    handleCreateHelpSection(request, response, session);
                }
                break;
            case "update":
                handleUpdateHelpSection(request, response, session);
                break;
            case "delete":
                handleDeleteHelpSection(request, response, session);
                break;
            case "view":
                handleViewHelpSection(request, response, session);
                break;
            case "list":
                handleListHelpSections(request, response, session);
                break;
            default:
                response.sendRedirect("help.jsp?error=Invalid action.");
        }
    }

    private boolean hasAccess(String currentUserRole, String action) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin has access to everything
        } else if ("MANAGER".equals(currentUserRole)) {
            // Manager can manage help content (create, update, delete, view, list)
            return "create".equals(action) || "update".equals(action) || 
                   "delete".equals(action) || "view".equals(action) || "list".equals(action);
        } else if ("CASHIER".equals(currentUserRole) || "CUSTOMER".equals(currentUserRole)) {
            // Cashier and Customer can only view help content
            return "view".equals(action) || "list".equals(action);
        }
        return false;
    }

    private void handleCreateHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            if (title == null || content == null || title.trim().isEmpty() || content.trim().isEmpty()) {
                response.sendRedirect("help.jsp?error=Title and content are required.");
                return;
            }

            HelpSection helpSection = new HelpSection();
            helpSection.setTitle(title.trim());
            helpSection.setContent(content.trim());

            boolean success = facade.createHelpSection(helpSection);

            if (success) {
                eventManager.logEvent("Help section created successfully: " + title, "INFO");
                response.sendRedirect("help.jsp?message=Help section created successfully.");
            } else {
                eventManager.logEvent("Help section creation failed: " + title, "ERROR");
                response.sendRedirect("help.jsp?error=Failed to create help section.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Help section creation error: " + e.getMessage(), "ERROR");
            response.sendRedirect("help.jsp?error=Error creating help section: " + e.getMessage());
        }
    }

    private void handleUpdateHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int helpId = Integer.parseInt(request.getParameter("help_id"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");

            if (title == null || content == null || title.trim().isEmpty() || content.trim().isEmpty()) {
                response.sendRedirect("help.jsp?error=Title and content are required.");
                return;
            }

            HelpSection helpSection = new HelpSection();
            helpSection.setHelpId(helpId);
            helpSection.setTitle(title.trim());
            helpSection.setContent(content.trim());

            boolean success = facade.updateHelpSection(helpSection);

            if (success) {
                eventManager.logEvent("Help section updated successfully: " + title, "INFO");
                response.sendRedirect("help.jsp?message=Help section updated successfully.");
            } else {
                eventManager.logEvent("Help section update failed: " + title, "ERROR");
                response.sendRedirect("help.jsp?error=Failed to update help section.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Help section update error: " + e.getMessage(), "ERROR");
            response.sendRedirect("help.jsp?error=Error updating help section: " + e.getMessage());
        }
    }

    private void handleDeleteHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int helpId = Integer.parseInt(request.getParameter("help_id"));

            boolean success = facade.deleteHelpSection(helpId);

            if (success) {
                eventManager.logEvent("Help section deleted successfully: ID " + helpId, "INFO");
                response.sendRedirect("help.jsp?message=Help section deleted successfully.");
            } else {
                eventManager.logEvent("Help section deletion failed: ID " + helpId, "ERROR");
                response.sendRedirect("help.jsp?error=Failed to delete help section.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Help section deletion error: " + e.getMessage(), "ERROR");
            response.sendRedirect("help.jsp?error=Error deleting help section: " + e.getMessage());
        }
    }

    private void handleViewHelpSection(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int helpId = Integer.parseInt(request.getParameter("help_id"));
            HelpSection helpSection = facade.getHelpSectionById(helpId);
            
            if (helpSection != null) {
                request.setAttribute("helpSection", helpSection);
                request.getRequestDispatcher("help_view.jsp").forward(request, response);
            } else {
                response.sendRedirect("help.jsp?error=Help section not found.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Help section view error: " + e.getMessage(), "ERROR");
            response.sendRedirect("help.jsp?error=Error viewing help section: " + e.getMessage());
        }
    }

    private void handleListHelpSections(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            List<HelpSection> helpSections = facade.getAllHelpSections();
            request.setAttribute("helpSections", helpSections);
            request.getRequestDispatcher("help.jsp").forward(request, response);

        } catch (Exception e) {
            eventManager.logEvent("Help section list error: " + e.getMessage(), "ERROR");
            response.sendRedirect("help.jsp?error=Error loading help sections: " + e.getMessage());
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
        return "Help Content Management Servlet";
    }
} 