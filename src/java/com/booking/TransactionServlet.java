/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

import com.booking.models.Transaction;
import com.booking.models.TransactionItem;
import com.booking.models.Customer;
import com.booking.models.Book;
import com.booking.models.User;
import com.booking.dao.TransactionDAO;
import com.booking.dao.CustomerDAO;
import com.booking.dao.BookDAO;
import com.booking.dao.UserDAO;
import com.booking.patterns.FacadeDP;
import com.booking.patterns.ObserverDP;
import java.io.IOException;
import java.io.BufferedReader;
import java.math.BigDecimal;
import java.util.List;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author pruso
 */
public class TransactionServlet extends HttpServlet {

    private FacadeDP facade;
    private ObserverDP.SystemEventManager eventManager;
    private TransactionDAO transactionDAO;
    private CustomerDAO customerDAO;
    private BookDAO bookDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        facade = new FacadeDP();
        eventManager = ObserverDP.SystemEventManager.getInstance();
        transactionDAO = new TransactionDAO();
        customerDAO = new CustomerDAO();
        bookDAO = new BookDAO();
        userDAO = new UserDAO();
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
        
        // If no action specified, default to list
        if (action == null || action.isEmpty()) {
            action = "list";
        }
        
        // Check role-based access
        if (!hasAccess(currentUserRole, action)) {
            response.sendRedirect("transaction.jsp?error=Access denied.");
            return;
        }

        switch (action) {
            case "view":
                handleViewTransaction(request, response, session);
                break;
            case "list":
                handleListTransactions(request, response, session);
                break;
            case "create":
                handleCreateTransaction(request, response, session);
                break;
            case "send-bill-email":
                handleSendBillEmail(request, response, session);
                break;
            default:
                response.sendRedirect("transaction.jsp?error=Invalid action.");
        }
    }

    private boolean hasAccess(String currentUserRole, String action) {
        if ("ADMIN".equals(currentUserRole)) {
            return true; // Admin has access to everything
        } else if ("MANAGER".equals(currentUserRole) || "CASHIER".equals(currentUserRole)) {
            // Manager and Cashier can view, create transactions, and send bill emails
            return "view".equals(action) || "list".equals(action) || "create".equals(action) || "send-bill-email".equals(action);
        } else if ("CUSTOMER".equals(currentUserRole)) {
            // Customer can only view their own transactions
            return "view".equals(action) || "list".equals(action);
        }
        return false;
    }

    private void handleCreateTransaction(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        response.setContentType("application/json");
        
        try {
            // Read JSON data from request body
            BufferedReader reader = request.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            
            String jsonData = sb.toString();
            
            // Debug: Log the received JSON
            System.out.println("Received JSON: " + jsonData);
            
            // Parse JSON data using simple regex patterns
            int customerId = extractIntValue(jsonData, "customerId");
            BigDecimal totalAmount = new BigDecimal(extractStringValue(jsonData, "totalAmount"));
            String itemsJson = extractArrayValue(jsonData, "items");
            
            // Get customer
            Customer customer = customerDAO.getCustomerById(customerId);
            if (customer == null) {
                sendErrorResponse(response, "Customer not found");
                return;
            }
            
            // Get current user
            String username = (String) session.getAttribute("username");
            User currentUser = userDAO.getUserByUsername(username);
            if (currentUser == null) {
                sendErrorResponse(response, "User not found");
                return;
            }
            
            // Create transaction
            Transaction transaction = new Transaction();
            transaction.setCustomer(customer);
            transaction.setTotalAmount(totalAmount);
            transaction.setCreatedBy(currentUser);
            
            // Parse items array
            List<TransactionItem> items = parseItemsArray(itemsJson);
            
            // Validate items
            for (TransactionItem item : items) {
                Book book = bookDAO.getBookById(item.getBook().getBookId());
                if (book == null) {
                    sendErrorResponse(response, "Book not found: " + item.getBook().getBookId());
                    return;
                }
                
                // Check stock availability
                if (book.getStockQuantity() < item.getQuantity()) {
                    sendErrorResponse(response, "Insufficient stock for book: " + book.getTitle());
                    return;
                }
                
                item.setBook(book);
            }
            
            transaction.setItems(items);
            
            // Save transaction
            boolean success = transactionDAO.createTransaction(transaction);
            
            if (success) {
                // Update book stock
                for (TransactionItem item : items) {
                    Book book = item.getBook();
                    book.setStockQuantity(book.getStockQuantity() - item.getQuantity());
                    bookDAO.updateBook(book);
                }
                
                // Prepare response data
                StringBuilder responseData = new StringBuilder();
                responseData.append("{\"success\":true,");
                responseData.append("\"transactionId\":").append(transaction.getTransactionId()).append(",");
                responseData.append("\"transaction\":{");
                responseData.append("\"transactionId\":").append(transaction.getTransactionId()).append(",");
                responseData.append("\"customerId\":").append(customer.getCustomerId()).append(",");
                responseData.append("\"customerName\":\"").append(customer.getName()).append("\",");
                responseData.append("\"items\":[");
                
                for (int i = 0; i < items.size(); i++) {
                    TransactionItem item = items.get(i);
                    responseData.append("{");
                    responseData.append("\"title\":\"").append(item.getBook().getTitle()).append("\",");
                    responseData.append("\"quantity\":").append(item.getQuantity()).append(",");
                    responseData.append("\"price\":").append(item.getPrice());
                    responseData.append("}");
                    if (i < items.size() - 1) {
                        responseData.append(",");
                    }
                }
                
                responseData.append("]}");
                responseData.append("}");
                
                String finalResponse = responseData.toString();
                System.out.println("Sending response: " + finalResponse);
                
                // Log successful transaction
                eventManager.logEvent("Transaction created successfully: " + transaction.getTransactionId(), "INFO");
                
                response.getWriter().write(finalResponse);
            } else {
                sendErrorResponse(response, "Failed to create transaction");
            }
            
        } catch (Exception e) {
            eventManager.logEvent("Transaction creation error: " + e.getMessage(), "ERROR");
            System.err.println("Transaction creation error: " + e.getMessage());
            e.printStackTrace();
            sendErrorResponse(response, "Error creating transaction: " + e.getMessage());
        }
    }

    private List<TransactionItem> parseItemsArray(String itemsJson) throws Exception {
        List<TransactionItem> items = new ArrayList<>();
        
        // Simple regex to extract items from JSON array
        Pattern itemPattern = Pattern.compile("\\{[^}]*\\}");
        Matcher matcher = itemPattern.matcher(itemsJson);
        
        while (matcher.find()) {
            String itemJson = matcher.group();
            int bookId = extractIntValue(itemJson, "bookId");
            int quantity = extractIntValue(itemJson, "quantity");
            BigDecimal price = new BigDecimal(extractStringValue(itemJson, "price"));
            
            Book book = new Book();
            book.setBookId(bookId);
            
            TransactionItem item = new TransactionItem();
            item.setBook(book);
            item.setQuantity(quantity);
            item.setPrice(price);
            items.add(item);
        }
        
        return items;
    }

    private int extractIntValue(String json, String key) {
        Pattern pattern = Pattern.compile("\"" + key + "\":\\s*(\\d+)");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return Integer.parseInt(matcher.group(1));
        }
        throw new RuntimeException("Could not find " + key + " in JSON");
    }

    private String extractStringValue(String json, String key) {
        // First try to find string value
        Pattern pattern = Pattern.compile("\"" + key + "\":\\s*\"([^\"]*)\"");
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return matcher.group(1);
        }
        
        // If not found as string, try to find as number
        Pattern numberPattern = Pattern.compile("\"" + key + "\":\\s*([0-9]+\\.?[0-9]*)");
        Matcher numberMatcher = numberPattern.matcher(json);
        if (numberMatcher.find()) {
            return numberMatcher.group(1);
        }
        
        throw new RuntimeException("Could not find " + key + " in JSON: " + json.substring(0, Math.min(200, json.length())));
    }

    private String extractArrayValue(String json, String key) {
        Pattern pattern = Pattern.compile("\"" + key + "\":\\s*\\[(.*?)\\]", Pattern.DOTALL);
        Matcher matcher = pattern.matcher(json);
        if (matcher.find()) {
            return matcher.group(1);
        }
        throw new RuntimeException("Could not find " + key + " array in JSON");
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        String errorData = "{\"success\":false,\"message\":\"" + message + "\"}";
        response.getWriter().write(errorData);
    }

    private void handleViewTransaction(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            int transactionId = Integer.parseInt(request.getParameter("transaction_id"));
            Transaction transaction = facade.getTransactionById(transactionId);
            
            if (transaction != null) {
                // Check if customer is viewing their own transaction
                String currentUserRole = (String) session.getAttribute("role");
                if ("CUSTOMER".equals(currentUserRole)) {
                    int customerId = (Integer) session.getAttribute("userId");
                    if (transaction.getCustomer().getCustomerId() != customerId) {
                        response.sendRedirect("transaction.jsp?error=Access denied. You can only view your own transactions.");
                        return;
                    }
                }
                
                request.setAttribute("transaction", transaction);
                request.getRequestDispatcher("transaction_view.jsp").forward(request, response);
            } else {
                response.sendRedirect("transaction.jsp?error=Transaction not found.");
            }

        } catch (Exception e) {
            eventManager.logEvent("Transaction view error: " + e.getMessage(), "ERROR");
            response.sendRedirect("transaction.jsp?error=Error viewing transaction: " + e.getMessage());
        }
    }

    private void handleListTransactions(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            String currentUserRole = (String) session.getAttribute("role");
            List<Transaction> transactions;
            
            if ("CUSTOMER".equals(currentUserRole)) {
                // Customer can only see their own transactions
                int customerId = (Integer) session.getAttribute("userId");
                transactions = facade.getTransactionsByCustomer(customerId);
            } else {
                // Admin, Manager, Cashier can see all transactions
                transactions = facade.getAllTransactions();
            }
            
            request.setAttribute("transactions", transactions);
            request.getRequestDispatcher("transaction.jsp").forward(request, response);

        } catch (Exception e) {
            eventManager.logEvent("Transaction list error: " + e.getMessage(), "ERROR");
            response.sendRedirect("transaction.jsp?error=Error loading transactions: " + e.getMessage());
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

    private void handleSendBillEmail(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws ServletException, IOException {
        try {
            // Read JSON data from request body
            BufferedReader reader = request.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            String jsonData = sb.toString();
            
            System.out.println("=== SEND BILL EMAIL DEBUG ===");
            System.out.println("Received JSON data: " + jsonData);
            
            // Parse JSON data - only need customerId and transactionId
            int customerId = extractIntValue(jsonData, "customerId");
            int transactionId = extractIntValue(jsonData, "transactionId");
            
            System.out.println("Parsed data:");
            System.out.println("Customer ID: " + customerId);
            System.out.println("Transaction ID: " + transactionId);
            
            // Get transaction details for the email using foreign key
            Transaction transaction = transactionDAO.getTransactionById(transactionId);
            if (transaction == null) {
                sendJsonResponse(response, false, "Transaction not found.");
                return;
            }
            
            System.out.println("Transaction found: " + transaction.getTransactionId());
            
            // Get customer details from database using foreign key relationship
            Customer customer = customerDAO.getCustomerById(customerId);
            if (customer == null) {
                sendJsonResponse(response, false, "Customer not found.");
                return;
            }
            
            System.out.println("Customer found: " + customer.getName() + " (Email: " + customer.getEmail() + ")");
            
            // Check if customer has email
            if (customer.getEmail() == null || customer.getEmail().trim().isEmpty()) {
                sendJsonResponse(response, false, "Customer does not have an email address.");
                return;
            }
            
            // Send bill email using EmailService
            EmailService emailService = new EmailService();
            boolean emailSent = emailService.sendBillEmail(customer.getEmail(), transaction, customer);
            
            if (emailSent) {
                System.out.println("✓ Bill email sent successfully to: " + customer.getEmail());
                eventManager.logEvent("Bill email sent successfully to: " + customer.getEmail(), "INFO");
                sendJsonResponse(response, true, "Bill has been sent to " + customer.getName() + "'s email address (" + customer.getEmail() + ").");
            } else {
                System.out.println("✗ Failed to send bill email to: " + customer.getEmail());
                eventManager.logEvent("Failed to send bill email to: " + customer.getEmail(), "ERROR");
                sendJsonResponse(response, false, "Failed to send bill email. Please try again.");
            }
            
        } catch (Exception e) {
            System.out.println("ERROR in handleSendBillEmail: " + e.getMessage());
            e.printStackTrace();
            eventManager.logEvent("Error sending bill email: " + e.getMessage(), "ERROR");
            sendJsonResponse(response, false, "Error sending bill email: " + e.getMessage());
        }
    }
    
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String jsonResponse = "{\"success\": " + success + ", \"message\": \"" + message + "\"}";
        response.getWriter().write(jsonResponse);
    }
    
    @Override
    public String getServletInfo() {
        return "Transaction Management Servlet";
    }
} 