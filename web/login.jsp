<%-- 
    Document   : login
    Created on : Aug 3, 2025, 9:09:52 AM
    Author     : pruso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookClub - Login</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                background: #667eea;
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .login-container {
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                overflow: hidden;
                max-width: 1000px;
                width: 100%;
                margin: 20px;
            }

            .login-content {
                display: flex;
                min-height: 450px;
            }

            .form-section {
                flex: 1;
                padding: 35px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                order: 1;
            }

            .illustration-section {
                flex: 1;
                background: #f8f9fa;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 35px;
                text-align: center;
                order: 2;
            }

            .form-title {
                font-size: 1.8rem;
                font-weight: 700;
                color: #333;
                margin-bottom: 8px;
                text-align: center;
            }

            .form-subtitle {
                color: #666;
                font-size: 0.95rem;
                margin-bottom: 25px;
                text-align: center;
            }

            .form-group {
                margin-bottom: 18px;
            }

            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 6px;
                display: block;
                font-size: 0.9rem;
            }

            .form-control {
                width: 100%;
                padding: 10px 14px;
                border: 2px solid #ddd;
                border-radius: 8px;
                font-size: 0.9rem;
                transition: border-color 0.3s ease;
                background: #f8f9fa;
            }

            .form-control:focus {
                outline: none;
                border-color: #667eea;
                background: white;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            .password-container {
                position: relative;
                display: flex;
                align-items: center;
            }

            .password-container .form-control {
                padding-right: 45px;
            }

            .password-toggle {
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: #666;
                cursor: pointer;
                font-size: 1rem;
                padding: 5px;
                border-radius: 4px;
                transition: color 0.3s ease;
            }

            .password-toggle:hover {
                color: #667eea;
            }

            .btn-login {
                width: 100%;
                background: linear-gradient(135deg, #667eea 0%, #5a4f8f 100%);
                color: white;
                border: none;
                padding: 10px 18px;
                border-radius: 8px;
                font-size: 0.9rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 8px;
            }

            .btn-login:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
            }

            .register-link {
                text-align: center;
                margin-top: 18px;
                color: #666;
                font-size: 0.9rem;
            }

            .register-link a {
                color: #667eea;
                text-decoration: none;
                font-weight: 600;
            }

            .register-link a:hover {
                color: #764ba2;
            }

            .illustration-image {
                max-width: 280px;
                margin-bottom: 18px;
            }

            .illustration-image img {
                width: 100%;
                height: auto;
                border-radius: 10px;
            }

            .alert {
                border-radius: 8px;
                border: none;
                padding: 10px 14px;
                margin-bottom: 18px;
                font-size: 0.9rem;
            }

            .alert-success {
                background: #d4edda;
                color: #155724;
            }

            .alert-danger {
                background: #f8d7da;
                color: #721c24;
            }

            /* Responsive Design for 1920x1200 and other resolutions */
            @media (max-width: 1200px) {
                .login-container {
                    max-width: 900px;
                }
                
                .form-title {
                    font-size: 1.7rem;
                }
                
                .form-subtitle {
                    font-size: 0.9rem;
                }
            }

            @media (max-width: 768px) {
                .login-content {
                    flex-direction: column;
                    min-height: auto;
                }
                
                .form-section {
                    order: 2;
                    padding: 30px 25px;
                }
                
                .illustration-section {
                    order: 1;
                    padding: 25px;
                }
                
                .form-title {
                    font-size: 1.6rem;
                }
                
                .form-subtitle {
                    font-size: 0.85rem;
                }
                
                .illustration-image {
                    max-width: 200px;
                }
            }

            @media (max-width: 480px) {
                .login-container {
                    margin: 10px;
                    border-radius: 10px;
                }
                
                .form-section,
                .illustration-section {
                    padding: 20px;
                }
                
                .form-title {
                    font-size: 1.5rem;
                }
                
                .form-control {
                    padding: 8px 12px;
                    font-size: 0.85rem;
                }
                
                .btn-login {
                    padding: 8px 16px;
                    font-size: 0.85rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="login-container">
            <div class="login-content">
                <!-- Form Section -->
                <div class="form-section">
                    <!-- Login Form -->
                    <div id="loginForm">
                        <!-- Message Display -->
                        <% if (request.getParameter("message") != null) {%>
                        <div class="alert alert-success" id="successMessage">
                            <i class="bi bi-check-circle me-2"></i><%= request.getParameter("message")%>
                            <button type="button" class="btn-close" onclick="closeMessage('successMessage')" style="float: right; background: none; border: none; font-size: 1.2rem; cursor: pointer;">&times;</button>
                        </div>
                        <% } %>
                        <% if (request.getParameter("error") != null) {%>
                        <div class="alert alert-danger" id="errorMessage">
                            <i class="bi bi-exclamation-triangle me-2"></i><%= request.getParameter("error")%>
                            <button type="button" class="btn-close" onclick="closeMessage('errorMessage')" style="float: right; background: none; border: none; font-size: 1.2rem; cursor: pointer;">&times;</button>
                        </div>
                        <% }%>

                        <h1 class="form-title">Log In</h1>
                        <p class="form-subtitle">Welcome back to Pahana</p>

                        <form action="LoginServlet" method="post">
                            <input type="hidden" name="action" value="login">
                            
                            <div class="form-group">
                                <label for="username" class="form-label">User Name</label>
                                <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
                            </div>

                            <div class="form-group">
                                <label for="password" class="form-label">User Password</label>
                                <div class="password-container">
                                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                                    <button type="button" class="password-toggle" onclick="togglePasswordVisibility('password')">
                                        <i class="bi bi-eye-slash" id="password-toggle-icon"></i>
                                    </button>
                                </div>
                                <div class="text-end mt-2">
                                    <a href="forgotpassword.jsp" class="text-decoration-none" style="color: #667eea; font-size: 0.9rem;">
                                        <i class="bi bi-question-circle me-1"></i>Forgot Password?
                                    </a>
                                </div>
                            </div>

                            <button type="submit" class="btn-login">Log In</button>
                        </form>

                        <div class="register-link">
                            Don't have an account? <a href="register.jsp">Register</a>
                        </div>
                    </div>
                </div>

                <!-- Illustration Section -->
                <div class="illustration-section">
                    <div class="illustration-image">
                        <img src="IMG/login.jpg" alt="Pahana Welcome">
                    </div>
                    <h3 style="color: #333; margin-bottom: 10px;">Welcome to Pahana</h3>
                    <p style="color: #666; font-size: 0.9rem;">Discover your next favorite book from our vast collection of titles.</p>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Custom JavaScript -->
        <script>
            function togglePasswordVisibility(inputId) {
                const input = document.getElementById(inputId);
                const icon = document.getElementById(inputId + '-toggle-icon');
                
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.remove('bi-eye-slash');
                    icon.classList.add('bi-eye');
                } else {
                    input.type = 'password';
                    icon.classList.remove('bi-eye');
                    icon.classList.add('bi-eye-slash');
                }
            }

            function closeMessage(messageId) {
                document.getElementById(messageId).style.display = 'none';
            }

            // Auto-close success message after 5 seconds
            document.addEventListener('DOMContentLoaded', function() {
                const successMessage = document.getElementById('successMessage');
                if (successMessage) {
                    setTimeout(function() {
                        successMessage.style.display = 'none';
                    }, 5000); // 5 seconds
                }
            });
        </script>
    </body>
</html>
