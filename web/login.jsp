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
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
                max-width: 900px;
                width: 100%;
                margin: 20px;
            }

            .login-content {
                display: flex;
                min-height: 500px;
            }

            .form-section {
                flex: 1;
                padding: 40px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .illustration-section {
                flex: 1;
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                padding: 40px;
                text-align: center;
            }

            .form-title {
                font-size: 2rem;
                font-weight: 700;
                color: #333;
                margin-bottom: 10px;
                text-align: center;
            }

            .form-subtitle {
                color: #666;
                font-size: 1rem;
                margin-bottom: 30px;
                text-align: center;
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-label {
                font-weight: 600;
                color: #333;
                margin-bottom: 8px;
                display: block;
            }

            .form-control {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #ddd;
                border-radius: 8px;
                font-size: 1rem;
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
                font-size: 1.1rem;
                padding: 5px;
                border-radius: 4px;
                transition: color 0.3s ease;
            }

            .password-toggle:hover {
                color: #667eea;
            }

            .btn-login {
                width: 100%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                padding: 12px 20px;
                border-radius: 8px;
                font-size: 1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                margin-top: 10px;
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
            }

            .register-link {
                text-align: center;
                margin-top: 20px;
                color: #666;
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
                max-width: 300px;
                margin-bottom: 20px;
            }

            .illustration-image img {
                width: 100%;
                height: auto;
                border-radius: 10px;
            }

            .alert {
                border-radius: 8px;
                border: none;
                padding: 12px 15px;
                margin-bottom: 20px;
            }

            .alert-success {
                background: #d4edda;
                color: #155724;
            }

            .alert-danger {
                background: #f8d7da;
                color: #721c24;
            }

            .form-toggle {
                text-align: center;
                margin-top: 20px;
            }

            .form-toggle a {
                color: #667eea;
                text-decoration: none;
                font-weight: 600;
                cursor: pointer;
            }

            .form-toggle a:hover {
                color: #764ba2;
            }

            .hidden {
                display: none;
            }

            @media (max-width: 768px) {
                .login-content {
                    flex-direction: column;
                }
                
                .illustration-section {
                    order: -1;
                    padding: 20px;
                }
                
                .form-section {
                    padding: 30px 20px;
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
                        <p class="form-subtitle">Welcome back to BookShop</p>

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
                            </div>

                            <button type="submit" class="btn-login">Log In</button>
                        </form>

                        <div class="register-link">
                            Don't have an account? <a href="#" onclick="showRegisterForm()">Register</a>
                        </div>
                    </div>

                    <!-- Registration Form -->
                    <div id="registerForm" class="hidden">
                        <h1 class="form-title">Create Account</h1>
                        <p class="form-subtitle">Join our community today</p>

                        <form action="CustomerServlet" method="post">
                            <input type="hidden" name="action" value="register">
                            
                            <div class="form-group">
                                <label for="regName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="regName" name="name" placeholder="Enter your full name" required>
                            </div>

                            <div class="form-group">
                                <label for="regPhone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="regPhone" name="phone" placeholder="Enter your phone number" required>
                            </div>

                            <div class="form-group">
                                <label for="regAddress" class="form-label">Address</label>
                                <textarea class="form-control" id="regAddress" name="address" rows="3" placeholder="Enter your address" required></textarea>
                            </div>

                            <div class="form-group">
                                <label for="regUsername" class="form-label">Username</label>
                                <input type="text" class="form-control" id="regUsername" name="username" placeholder="Enter your username" required>
                            </div>

                            <div class="form-group">
                                <label for="regEmail" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="regEmail" name="email" placeholder="Enter your email" required>
                            </div>

                            <div class="form-group">
                                <label for="regPassword" class="form-label">Password</label>
                                <div class="password-container">
                                    <input type="password" class="form-control" id="regPassword" name="password" placeholder="Create a password" required>
                                    <button type="button" class="password-toggle" onclick="togglePasswordVisibility('regPassword')">
                                        <i class="bi bi-eye-slash" id="reg-password-toggle-icon"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="alert alert-info" style="font-size: 0.9rem; margin-bottom: 20px;">
                                <i class="bi bi-info-circle me-2"></i>
                                <strong>Note:</strong> Account number will be automatically generated when you register.
                            </div>

                            <button type="submit" class="btn-login">Create Account</button>
                        </form>

                        <div class="form-toggle">
                            <a href="#" onclick="showLoginForm()">Already have an account? Log in</a>
                        </div>
                    </div>
                </div>

                <!-- Illustration Section -->
                <div class="illustration-section">
                    <div class="illustration-image">
                        <img src="IMG/login.jpg" alt="BookShop Welcome">
                    </div>
                    <h3 style="color: #333; margin-bottom: 10px;">Welcome to BookShop</h3>
                    <p style="color: #666; font-size: 0.9rem;">Discover your next favorite book from our vast collection of titles.</p>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Custom JavaScript -->
        <script>
            function showLoginForm() {
                document.getElementById('loginForm').classList.remove('hidden');
                document.getElementById('registerForm').classList.add('hidden');
            }

            function showRegisterForm() {
                document.getElementById('loginForm').classList.add('hidden');
                document.getElementById('registerForm').classList.remove('hidden');
            }

            function togglePasswordVisibility(inputId) {
                const input = document.getElementById(inputId);
                let icon;
                
                if (inputId === 'regPassword') {
                    icon = document.getElementById('reg-password-toggle-icon');
                } else {
                    icon = document.getElementById(inputId + '-toggle-icon');
                }
                
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
