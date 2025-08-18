/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.booking;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.Random;

/**
 * Email service for sending verification emails using Gmail SMTP.
 * This uses the jakarta.mail API, which is implemented by Angus Mail (angus-mail-2.x).
 */
public class EmailService {

    private static final String FROM_EMAIL = "pahanabookstore@gmail.com";
    private static final String FROM_PASSWORD = "tsnh erce gbxn ztlh";
    private static final String FROM_NAME = "Pahana Book Store";
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;

    private Session session;

    public EmailService() {
        try {
            initializeSession();
            System.out.println("EmailService initialized (jakarta.mail via Angus Mail)");
        } catch (Exception e) {
            System.err.println("Failed to initialize real email session: " + e.getMessage());
            e.printStackTrace();
            session = null;
        }
    }

    private void initializeSession() {
        Properties props = new Properties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", String.valueOf(SMTP_PORT));
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2 TLSv1.3");
        props.put("mail.smtp.ssl.trust", SMTP_HOST);

        this.session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, FROM_PASSWORD);
            }
        });
    }

    /**
     * Generate a random 6-digit verification code
     */
    public String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

    /**
     * Send verification email to the specified email address.
     * Falls back to mock (console print) if jakarta.mail/SMTP fails.
     */
    public boolean sendVerificationEmail(String toEmail, String verificationCode) throws MessagingException, UnsupportedEncodingException {
        return sendVerificationEmail(toEmail, verificationCode, "Pahana Email Verification");
    }
    
    /**
     * Send verification email to the specified email address with custom heading.
     * Falls back to mock (console print) if jakarta.mail/SMTP fails.
     */
    public boolean sendVerificationEmail(String toEmail, String verificationCode, String heading) {
        if (session == null) {
            System.out.println("⚠ Real email session not available. Using mock service.");
            return sendMockEmail(toEmail, verificationCode);
        }

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Verification Code - Pahana");

            String emailContent = buildEmailContent(verificationCode, heading);
            message.setContent(emailContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("✓ Verification email sent to: " + toEmail + " (jakarta.mail/Angus)");
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            System.err.println("✗ SMTP send failed: " + e.getMessage());
            e.printStackTrace();
            System.out.println("↻ Falling back to mock email service");
            return sendMockEmail(toEmail, verificationCode);
        }
    }
    
    /**
     * Send forgot password verification email to the specified email address.
     * Falls back to mock (console print) if jakarta.mail/SMTP fails.
     */
    public boolean sendForgotPasswordVerificationEmail(String toEmail, String verificationCode) {
        return sendVerificationEmail(toEmail, verificationCode, "Pahana Password Reset");
    }
    
    /**
     * Send email change verification email to the specified email address.
     * Falls back to mock (console print) if jakarta.mail/SMTP fails.
     */
    public boolean sendEmailChangeVerificationEmail(String toEmail, String verificationCode) {
        return sendVerificationEmail(toEmail, verificationCode, "Pahana Email Changed");
    }
    
    /**
     * Send a generic email with custom subject and HTML content.
     * Falls back to mock (console print) if jakarta.mail/SMTP fails.
     */
    public boolean sendEmail(String toEmail, String subject, String htmlContent) {
        if (session == null) {
            System.out.println("⚠ Real email session not available. Using mock service.");
            return sendMockGenericEmail(toEmail, subject, htmlContent);
        }

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("✓ Generic email sent to: " + toEmail + " (jakarta.mail/Angus)");
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            System.err.println("✗ SMTP send failed: " + e.getMessage());
            e.printStackTrace();
            System.out.println("↻ Falling back to mock email service");
            return sendMockGenericEmail(toEmail, subject, htmlContent);
        }
    }
    
    /**
     * Send mock generic email (prints to console)
     */
    private boolean sendMockGenericEmail(String toEmail, String subject, String htmlContent) {
        System.out.println("=== MOCK GENERIC EMAIL ===");
        System.out.println("To: " + toEmail);
        System.out.println("Subject: " + subject);
        System.out.println("Content: " + htmlContent);
        System.out.println("================================");
        System.out.println("Note: This is a mock email. To send real emails, ensure angus-mail and jakarta.activation are in WEB-INF/lib and rebuild.");
        System.out.println("================================================");
        return true;
    }

    /**
     * Send mock email (prints to console)
     */
    private boolean sendMockEmail(String toEmail, String verificationCode) {
        System.out.println("=== MOCK EMAIL VERIFICATION ===");
        System.out.println("To: " + toEmail);
        System.out.println("Verification Code: " + verificationCode);
        System.out.println("================================");
        System.out.println("Note: This is a mock email. To send real emails, ensure angus-mail and jakarta.activation are in WEB-INF/lib and rebuild.");
        System.out.println("================================================");
        return true;
    }

    private String buildEmailContent(String verificationCode) {
        return buildEmailContent(verificationCode, "Pahana Email Verification");
    }

    private String buildEmailContent(String verificationCode, String heading) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<title>" + heading + "</title>" +
                "<style>" +
                "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                ".header { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0; }" +
                ".content { background: #f8f9fa; padding: 30px; border-radius: 0 0 8px 8px; }" +
                ".verification-code { background: #e9ecef; padding: 15px; text-align: center; font-size: 24px; font-weight: bold; color: #1e3c72; border-radius: 5px; margin: 20px 0; }" +
                ".footer { text-align: center; margin-top: 20px; color: #6c757d; font-size: 14px; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<div class='header'>" +
                "<h1>" + heading + "</h1>" +
                "</div>" +
                "<div class='content'>" +
                "<p>Hello!</p>" +
                "<p>Use the following verification code to continue:</p>" +
                "<div class='verification-code'>" + verificationCode + "</div>" +
                "<p>If you didn't request this verification, please ignore this email.</p>" +
                "<p>Best regards,<br>The Pahana Team</p>" +
                "</div>" +
                "<div class='footer'>" +
                "<p>This is an automated message, please do not reply.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
    }

    public String getEmailConfig() {
        StringBuilder config = new StringBuilder();
        config.append("Email Service Configuration:\n");
        config.append("From Name: ").append(FROM_NAME).append("\n");
        config.append("From Email: ").append(FROM_EMAIL).append("\n");
        config.append("SMTP: ").append(SMTP_HOST).append(":").append(SMTP_PORT).append("\n");
        config.append("API: jakarta.mail (implementation: Angus Mail)\n");
        config.append("TLS: STARTTLS, protocols TLSv1.2+\n");
        config.append("Mode: ").append(session == null ? "Mock" : "Real").append('\n');
        return config.toString();
    }
    
    /**
     * Send password email to the specified email address.
     * Falls back to mock (console print) if jakarta.mail/SMTP fails.
     */
    public boolean sendPasswordEmail(String toEmail, String password) {
        if (session == null) {
            System.out.println("⚠ Real email session not available. Using mock service.");
            return sendMockPasswordEmail(toEmail, password);
        }

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("New Password - Pahana");

            String emailContent = buildPasswordEmailContent(password);
            message.setContent(emailContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("✓ Password email sent to: " + toEmail + " (jakarta.mail/Angus)");
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            System.err.println("✗ SMTP send failed: " + e.getMessage());
            e.printStackTrace();
            System.out.println("↻ Falling back to mock email service");
            return sendMockPasswordEmail(toEmail, password);
        }
    }
    
    /**
     * Send mock password email (prints to console)
     */
    private boolean sendMockPasswordEmail(String toEmail, String password) {
        System.out.println("=== MOCK PASSWORD EMAIL ===");
        System.out.println("To: " + toEmail);
        System.out.println("New Password: " + password);
        System.out.println("==========================");
        System.out.println("Note: This is a mock email. To send real emails, ensure angus-mail and jakarta.activation are in WEB-INF/lib and rebuild.");
        System.out.println("================================================");
        return true;
    }
    
    private String buildPasswordEmailContent(String password) {
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<title>New Password</title>" +
                "<style>" +
                "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                ".header { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0; }" +
                ".content { background: #f8f9fa; padding: 30px; border-radius: 0 0 8px 8px; }" +
                ".password { background: #e9ecef; padding: 15px; text-align: center; font-size: 18px; font-weight: bold; color: #1e3c72; border-radius: 5px; margin: 20px 0; }" +
                ".footer { text-align: center; margin-top: 20px; color: #6c757d; font-size: 14px; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<h1>Pahana New Password</h1>" +
                "</div>" +
                "<div class='content'>" +
                "<p>Hello!</p>" +
                "<p>Your password has been updated. Here is your new password:</p>" +
                "<div class='password'>" + password + "</div>" +
                "<p><strong>Important:</strong> Please change this password after your next login for security reasons.</p>" +
                "<p>If you didn't request this password change, please contact the administrator immediately.</p>" +
                "<p>Best regards,<br>The Pahana Team</p>" +
                "</div>" +
                "<div class='footer'>" +
                "<p>This is an automated message, please do not reply.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
    
    /**
     * Send bill email to the specified email address.
     * Falls back to mock (console print) if jakarta.mail/SMTP fails.
     */
    public boolean sendBillEmail(String toEmail, Object transactionObj, Object customerObj) {
        if (session == null) {
            System.out.println("⚠ Real email session not available. Using mock service.");
            return sendMockBillEmail(toEmail, transactionObj, customerObj);
        }

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Transaction Receipt - Pahana");

            String emailContent = buildBillEmailContent(transactionObj, customerObj);
            message.setContent(emailContent, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println("✓ Bill email sent to: " + toEmail + " (jakarta.mail/Angus)");
            return true;
        } catch (MessagingException | UnsupportedEncodingException e) {
            System.err.println("✗ SMTP send failed: " + e.getMessage());
            e.printStackTrace();
            System.out.println("↻ Falling back to mock email service");
            return sendMockBillEmail(toEmail, transactionObj, customerObj);
        }
    }
    
    /**
     * Send mock bill email (prints to console)
     */
    private boolean sendMockBillEmail(String toEmail, Object transactionObj, Object customerObj) {
        System.out.println("=== MOCK BILL EMAIL ===");
        System.out.println("To: " + toEmail);
        
        if (transactionObj != null) {
            try {
                java.lang.reflect.Method getIdMethod = transactionObj.getClass().getMethod("getTransactionId");
                java.lang.reflect.Method getDateMethod = transactionObj.getClass().getMethod("getCreatedAt");
                java.lang.reflect.Method getAmountMethod = transactionObj.getClass().getMethod("getTotalAmount");
                java.lang.reflect.Method getItemsMethod = transactionObj.getClass().getMethod("getItems");
                
                Object idResult = getIdMethod.invoke(transactionObj);
                Object dateResult = getDateMethod.invoke(transactionObj);
                Object amountResult = getAmountMethod.invoke(transactionObj);
                Object itemsResult = getItemsMethod.invoke(transactionObj);
                
                System.out.println("Transaction ID: " + (idResult != null ? idResult : "N/A"));
                System.out.println("Transaction Date: " + (dateResult != null ? dateResult : "N/A"));
                System.out.println("Total Amount: " + (amountResult != null ? "$" + amountResult : "$N/A"));
                
                if (itemsResult != null && itemsResult instanceof java.util.List) {
                    java.util.List<?> items = (java.util.List<?>) itemsResult;
                    if (!items.isEmpty()) {
                        System.out.println("Items Purchased:");
                        System.out.println("----------------------------------------");
                        System.out.printf("%-30s %-8s %-10s%n", "Book Title", "Qty", "Price");
                        System.out.println("----------------------------------------");
                        
                        for (Object item : items) {
                            try {
                                java.lang.reflect.Method getBookMethod = item.getClass().getMethod("getBook");
                                java.lang.reflect.Method getQuantityMethod = item.getClass().getMethod("getQuantity");
                                java.lang.reflect.Method getPriceMethod = item.getClass().getMethod("getPrice");
                                
                                Object bookObj = getBookMethod.invoke(item);
                                Object quantityResult = getQuantityMethod.invoke(item);
                                Object priceResult = getPriceMethod.invoke(item);
                                
                                if (bookObj != null) {
                                    java.lang.reflect.Method getTitleMethod = bookObj.getClass().getMethod("getTitle");
                                    Object titleResult = getTitleMethod.invoke(bookObj);
                                    
                                    String title = titleResult != null ? titleResult.toString() : "Unknown Book";
                                    String quantity = quantityResult != null ? quantityResult.toString() : "0";
                                    String price = priceResult != null ? priceResult.toString() : "0.00";
                                    
                                    if (title.length() > 28) {
                                        title = title.substring(0, 25) + "...";
                                    }
                                    
                                    System.out.printf("%-30s %-8s %-10s%n", title, quantity, price);
                                }
                            } catch (Exception e) {
                                System.out.println("Warning: Could not extract item details: " + e.getMessage());
                            }
                        }
                        System.out.println("----------------------------------------");
                    } else {
                        System.out.println("Items: No items found");
                    }
                } else {
                    System.out.println("Items: Unable to retrieve items");
                }
                
            } catch (Exception e) {
                System.out.println("Transaction: " + transactionObj.getClass().getSimpleName() + " (details unavailable)");
            }
        } else {
            System.out.println("Transaction: null");
        }
        
        if (customerObj != null) {
            try {
                java.lang.reflect.Method getNameMethod = customerObj.getClass().getMethod("getName");
                java.lang.reflect.Method getEmailMethod = customerObj.getClass().getMethod("getEmail");
                Object nameResult = getNameMethod.invoke(customerObj);
                Object emailResult = getEmailMethod.invoke(customerObj);
                System.out.println("Customer Name: " + (nameResult != null ? nameResult : "N/A"));
                System.out.println("Customer Email: " + (emailResult != null ? emailResult : "N/A"));
            } catch (Exception e) {
                System.out.println("Customer: " + customerObj.getClass().getSimpleName() + " (details unavailable)");
            }
        } else {
            System.out.println("Customer: null");
        }
        
        System.out.println("==========================");
        System.out.println("Note: This is a mock email. To send real emails, ensure angus-mail and jakarta.activation are in WEB-INF/lib and rebuild.");
        System.out.println("================================================");
        return true;
    }
    
    private String buildBillEmailContent(Object transactionObj, Object customerObj) {
        String transactionId = "N/A";
        String transactionDate = "N/A";
        String totalAmount = "N/A";
        String itemsHtml = "";
        
        if (transactionObj != null) {
            try {
                java.lang.reflect.Method getIdMethod = transactionObj.getClass().getMethod("getTransactionId");
                java.lang.reflect.Method getDateMethod = transactionObj.getClass().getMethod("getCreatedAt");
                java.lang.reflect.Method getAmountMethod = transactionObj.getClass().getMethod("getTotalAmount");
                java.lang.reflect.Method getItemsMethod = transactionObj.getClass().getMethod("getItems");
                
                Object idResult = getIdMethod.invoke(transactionObj);
                Object dateResult = getDateMethod.invoke(transactionObj);
                Object amountResult = getAmountMethod.invoke(transactionObj);
                Object itemsResult = getItemsMethod.invoke(transactionObj);
                
                if (idResult != null) transactionId = idResult.toString();
                if (dateResult != null) transactionDate = dateResult.toString();
                if (amountResult != null) totalAmount = amountResult.toString();
                
                if (itemsResult != null && itemsResult instanceof java.util.List) {
                    java.util.List<?> items = (java.util.List<?>) itemsResult;
                    if (!items.isEmpty()) {
                        StringBuilder itemsBuilder = new StringBuilder();
                        itemsBuilder.append("<div style='margin: 15px 0; padding: 15px; background: #f8f9fa; border-radius: 5px;'>");
                        itemsBuilder.append("<h4 style='margin: 0 0 15px 0; color: #1e3c72;'>Items Purchased:</h4>");
                        itemsBuilder.append("<table style='width: 100%; border-collapse: collapse;'>");
                        itemsBuilder.append("<thead><tr style='background: #e9ecef;'>");
                        itemsBuilder.append("<th style='padding: 8px; text-align: left; border-bottom: 1px solid #dee2e6;'>Book Title</th>");
                        itemsBuilder.append("<th style='padding: 8px; text-align: center; border-bottom: 1px solid #dee2e6;'>Qty</th>");
                        itemsBuilder.append("<th style='padding: 8px; text-align: right; border-bottom: 1px solid #dee2e6;'>Price</th>");
                        itemsBuilder.append("</tr></thead><tbody>");
                        
                        for (Object item : items) {
                            try {
                                java.lang.reflect.Method getBookMethod = item.getClass().getMethod("getBook");
                                java.lang.reflect.Method getQuantityMethod = item.getClass().getMethod("getQuantity");
                                java.lang.reflect.Method getPriceMethod = item.getClass().getMethod("getPrice");
                                
                                Object bookObj = getBookMethod.invoke(item);
                                Object quantityResult = getQuantityMethod.invoke(item);
                                Object priceResult = getPriceMethod.invoke(item);
                                
                                if (bookObj != null) {
                                    java.lang.reflect.Method getTitleMethod = bookObj.getClass().getMethod("getTitle");
                                    Object titleResult = getTitleMethod.invoke(bookObj);
                                    
                                    String title = titleResult != null ? titleResult.toString() : "Unknown Book";
                                    String quantity = quantityResult != null ? quantityResult.toString() : "0";
                                    String price = priceResult != null ? priceResult.toString() : "0.00";
                                    
                                    itemsBuilder.append("<tr>");
                                    itemsBuilder.append("<td style='padding: 8px; border-bottom: 1px solid #dee2e6;'>").append(title).append("</td>");
                                    itemsBuilder.append("<td style='padding: 8px; text-align: center; border-bottom: 1px solid #dee2e6;'>").append(quantity).append("</td>");
                                    itemsBuilder.append("<td style='padding: 8px; text-align: right; border-bottom: 1px solid #dee2e6;'>").append(price).append("</td>");
                                    itemsBuilder.append("</tr>");
                                }
                            } catch (Exception e) {
                                System.out.println("Warning: Could not extract item details: " + e.getMessage());
                            }
                        }
                        
                        itemsBuilder.append("</tbody></table>");
                        itemsBuilder.append("</div>");
                        itemsHtml = itemsBuilder.toString();
                    }
                }
                
            } catch (Exception e) {
                System.out.println("Warning: Could not extract transaction details: " + e.getMessage());
            }
        }
        
        String customerName = "N/A";
        String customerEmail = "N/A";
        
        if (customerObj != null) {
            try {
                java.lang.reflect.Method getNameMethod = customerObj.getClass().getMethod("getName");
                java.lang.reflect.Method getEmailMethod = customerObj.getClass().getMethod("getEmail");
                
                Object nameResult = getNameMethod.invoke(customerObj);
                Object emailResult = getEmailMethod.invoke(customerObj);
                
                if (nameResult != null) customerName = nameResult.toString();
                if (emailResult != null) customerEmail = emailResult.toString();
            } catch (Exception e) {
                System.out.println("Warning: Could not extract customer details: " + e.getMessage());
            }
        }
        
        return "<!DOCTYPE html>" +
                "<html>" +
                "<head>" +
                "<meta charset='UTF-8'>" +
                "<title>Transaction Receipt</title>" +
                "<style>" +
                "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }" +
                ".container { max-width: 600px; margin: 0 auto; padding: 20px; }" +
                ".header { background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%); color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0; }" +
                ".content { background: #f8f9fa; padding: 30px; border-radius: 0 0 8px 8px; }" +
                ".receipt { background: #e9ecef; padding: 20px; border-radius: 5px; margin: 20px 0; }" +
                ".footer { text-align: center; margin-top: 20px; color: #6c757d; font-size: 14px; }" +
                "</style>" +
                "</head>" +
                "<body>" +
                "<div class='container'>" +
                "<div class='header'>" +
                "<h1>Pahana Transaction Receipt</h1>" +
                "</div>" +
                "<div class='content'>" +
                "<p>Hello " + customerName + "!</p>" +
                "<p>Thank you for your purchase. Here is your transaction receipt:</p>" +
                "<div class='receipt'>" +
                "<p><strong>Transaction Details:</strong></p>" +
                "<p><strong>Transaction ID:</strong> " + transactionId + "</p>" +
                "<p><strong>Customer Name:</strong> " + customerName + "</p>" +
                "<p><strong>Customer Email:</strong> " + customerEmail + "</p>" +
                "<p><strong>Transaction Date:</strong> " + transactionDate + "</p>" +
                "<p><strong>Total Amount:</strong> " + totalAmount + "</p>" +
                "</div>" +
                itemsHtml +
                "<p>If you have any questions about this transaction, please contact our customer service.</p>" +
                "<p>Best regards,<br>The Pahana Team</p>" +
                "</div>" +
                "<div class='footer'>" +
                "<p>This is an automated message, please do not reply.</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
    }
}
