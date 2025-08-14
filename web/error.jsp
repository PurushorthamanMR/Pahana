<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Pahana BookStore</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .error-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            text-align: center;
            max-width: 500px;
            width: 90%;
        }
        .error-icon {
            font-size: 80px;
            color: #e74c3c;
            margin-bottom: 20px;
        }
        .error-title {
            color: #2c3e50;
            font-size: 24px;
            margin-bottom: 15px;
        }
        .error-message {
            color: #7f8c8d;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .error-details {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 30px;
            font-family: monospace;
            font-size: 12px;
            color: #495057;
            text-align: left;
        }
        .btn {
            background: #3498db;
            color: white;
            padding: 12px 24px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin: 0 10px;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #2980b9;
        }
        .btn-secondary {
            background: #95a5a6;
        }
        .btn-secondary:hover {
            background: #7f8c8d;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⚠️</div>
        
        <% 
        Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
        String errorMessage = (String) request.getAttribute("jakarta.servlet.error.message");
        String requestUri = (String) request.getAttribute("jakarta.servlet.error.request_uri");
        
        if (statusCode == null) {
            statusCode = 500;
        }
        
        String title, message;
        switch (statusCode) {
            case 404:
                title = "Page Not Found";
                message = "The page you're looking for doesn't exist.";
                break;
            case 408:
                title = "Request Timeout";
                message = "The request took too long to complete. Please try again.";
                break;
            case 500:
                title = "Internal Server Error";
                message = "Something went wrong on our end. Please try again later.";
                break;
            default:
                title = "Error " + statusCode;
                message = errorMessage != null ? errorMessage : "An unexpected error occurred.";
        }
        %>
        
        <h1 class="error-title"><%= title %></h1>
        <p class="error-message"><%= message %></p>
        
        <% if (requestUri != null) { %>
        <div class="error-details">
            <strong>Request URI:</strong> <%= requestUri %><br>
            <strong>Status Code:</strong> <%= statusCode %><br>
            <% if (exception != null) { %>
            <strong>Exception:</strong> <%= exception.getClass().getName() %><br>
            <strong>Message:</strong> <%= exception.getMessage() %>
            <% } %>
        </div>
        <% } %>
        
        <div>
            <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
            <a href="dashboard.jsp" class="btn">Go to Dashboard</a>
        </div>
    </div>
</body>
</html>
