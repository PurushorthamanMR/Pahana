/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

/**
 * Servlet to handle contact form submissions
 */
@WebServlet(name = "ContactServlet", urlPatterns = {"/ContactServlet"})
public class ContactServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        try {
            // Get form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");
            
            // Validate required fields
            if (name == null || name.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                subject == null || subject.trim().isEmpty() ||
                message == null || message.trim().isEmpty()) {
                
                sendJsonResponse(response, false, "All fields are required.");
                return;
            }
            
            // Validate email format
            if (!isValidEmail(email)) {
                sendJsonResponse(response, false, "Please enter a valid email address.");
                return;
            }
            
            // Send email to admin (pahanabookstore@gmail.com)
            EmailService emailService = new EmailService();
            
            // Create admin notification email
            String adminSubject = "New Contact Form Message: " + subject;
            String adminHtmlContent = buildAdminEmailContent(name, email, subject, message);
            
            boolean adminEmailSent = emailService.sendEmail("pahanabookstore@gmail.com", adminSubject, adminHtmlContent);
            
            // Send auto-reply to customer
            String customerSubject = "Thank you for contacting Pahana BookStore";
            String customerHtmlContent = buildCustomerAutoReplyContent(name, subject);
            
            boolean customerEmailSent = emailService.sendEmail(email, customerSubject, customerHtmlContent);
            
            if (adminEmailSent && customerEmailSent) {
                sendJsonResponse(response, true, "Thank you for your message! We have received it and will get back to you soon. Check your email for confirmation.");
            } else if (adminEmailSent) {
                sendJsonResponse(response, true, "Thank you for your message! We have received it and will get back to you soon. (Note: Auto-reply email could not be sent)");
            } else {
                sendJsonResponse(response, false, "Sorry, there was an error sending your message. Please try again later or contact us directly at pahanabookstore@gmail.com");
            }
            
        } catch (Exception e) {
            System.err.println("Error in ContactServlet: " + e.getMessage());
            e.printStackTrace();
            sendJsonResponse(response, false, "An unexpected error occurred. Please try again later.");
        }
    }
    
    private boolean isValidEmail(String email) {
        // Simple email validation
        return email != null && email.contains("@") && email.contains(".") && email.length() > 5;
    }
    
    private String buildAdminEmailContent(String name, String email, String subject, String message) {
        return "<!DOCTYPE html>" +
               "<html>" +
               "<head>" +
               "<meta charset='UTF-8'>" +
               "<title>New Contact Form Message</title>" +
               "<style>" +
               "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
               ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
               ".header { background: #667eea; color: white; padding: 20px; text-align: center; border-radius: 10px 10px 0 0; }" +
               ".content { background: #f8f9fa; padding: 20px; border-radius: 0 0 10px 10px; }" +
               ".field { margin-bottom: 15px; }" +
               ".label { font-weight: bold; color: #667eea; }" +
               ".value { background: white; padding: 10px; border-radius: 5px; border-left: 4px solid #667eea; }" +
               "</style>" +
               "</head>" +
               "<body>" +
               "<div class='container'>" +
               "<div class='header'>" +
               "<h2>📧 New Contact Form Message</h2>" +
               "<p>Someone has sent a message through your website contact form</p>" +
               "</div>" +
               "<div class='content'>" +
               "<div class='field'>" +
               "<div class='label'>👤 Name:</div>" +
               "<div class='value'>" + name + "</div>" +
               "</div>" +
               "<div class='field'>" +
               "<div class='label'>📧 Email:</div>" +
               "<div class='value'>" + email + "</div>" +
               "</div>" +
               "<div class='field'>" +
               "<div class='label'>📝 Subject:</div>" +
               "<div class='value'>" + subject + "</div>" +
               "</div>" +
               "<div class='field'>" +
               "<div class='label'>💬 Message:</div>" +
               "<div class='value'>" + message.replace("\n", "<br>") + "</div>" +
               "</div>" +
               "<div style='margin-top: 30px; padding: 15px; background: #e3f2fd; border-radius: 5px;'>" +
               "<strong>💡 Quick Actions:</strong><br>" +
               "• Reply directly to: <a href='mailto:" + email + "'>" + email + "</a><br>" +
               "• Mark as resolved in your system<br>" +
               "• Follow up within 24 hours" +
               "</div>" +
               "</div>" +
               "</div>" +
               "</body>" +
               "</html>";
    }
    
    private String buildCustomerAutoReplyContent(String name, String subject) {
        StringBuilder content = new StringBuilder();
        
        content.append("<!DOCTYPE html>")
               .append("<html>")
               .append("<head>")
               .append("<meta charset='UTF-8'>")
               .append("<title>Thank you for contacting us</title>")
               .append("<style>")
               .append("body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }")
               .append(".container { max-width: 600px; margin: 0 auto; padding: 20px; }")
               .append(".header { background: #667eea; color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }")
               .append(".content { background: #f8f9fa; padding: 30px; border-radius: 0 0 10px 10px; }")
               .append(".footer { text-align: center; margin-top: 20px; color: #666; font-size: 14px; }")
               .append("</style>")
               .append("</head>")
               .append("<body>")
               .append("<div class='container'>")
               .append("<div class='header'>")
               .append("<h1>📚 Pahana BookStore</h1>")
               .append("<p>Thank you for reaching out to us!</p>")
               .append("</div>")
               .append("<div class='content'>")
               .append("<h2>Dear ").append(name).append(",</h2>")
               .append("<p>Thank you for contacting Pahana BookStore. We have received your message regarding:</p>")
               .append("<div style='background: white; padding: 15px; border-radius: 5px; border-left: 4px solid #667eea; margin: 20px 0;'>")
               .append("<strong>Subject:</strong> ").append(subject)
               .append("</div>")
               .append("<p>Our team will review your message and get back to you within 24 hours. We appreciate your patience!</p>")
               .append("<div style='background: #e8f5e8; padding: 20px; border-radius: 10px; margin: 20px 0;'>")
               .append("<h3>📖 While you wait...</h3>")
               .append("<p>Explore our latest book collections and special offers on our website!</p>")
               .append("</div>")
               .append("<p>If you have any urgent inquiries, you can also reach us directly at:</p>")
               .append("<ul>")
               .append("<li>📧 Email: pahanabookstore@gmail.com</li>")
               .append("<li>📞 Phone: +94 76 59 473 3337</li>")
               .append("<li>📍 Address: 158, Saddnathar Road, Nallur, Jaffna</li>")
               .append("</ul>");
        
        // Add special message for Book Store Subscription
        if (subject.contains("Store Location Subscription")) {
            content.append("<div style='background: #fff3cd; padding: 20px; border-radius: 10px; margin: 20px 0; border-left: 4px solid #ffc107;'>")
                   .append("<h3>🚀 Book Store Trail Link</h3>")
                   .append("<p><strong>We will send you the trail link as soon as possible!</strong></p>")
                   .append("<p>Our development team is working hard to bring you the book store feature. You'll be among the first to know when it's ready!</p>")
                   .append("</div>");
        }
        
        content.append("<p>Best regards,<br><strong>The Pahana BookStore Team</strong></p>")
               .append("</div>")
               .append("<div class='footer'>")
               .append("<p>This is an automated response. Please do not reply to this email.</p>")
               .append("</div>")
               .append("</div>")
               .append("</body>")
               .append("</html>");
        
        return content.toString();
    }
    
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        PrintWriter out = response.getWriter();
        String jsonResponse = "{\"success\": " + success + ", \"message\": \"" + message + "\"}";
        out.print(jsonResponse);
        out.flush();
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
        return "Contact Form Servlet for Pahana BookStore";
    }
}
