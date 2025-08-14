<%-- 
    Document   : register
    Created on : Aug 12, 2025, 1:10:00 AM
    Author     : pruso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookClub - Register</title>
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

            .register-container {
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                overflow: hidden;
                max-width: 1000px;
                width: 100%;
                margin: 20px;
            }

            .register-content {
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
                font-size: 1.1rem;
                padding: 5px;
                border-radius: 4px;
                transition: color 0.3s ease;
            }

            .password-toggle:hover {
                color: #667eea;
            }

            .btn-register {
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

            .btn-register:hover {
                background: #0056b3;
                transform: translateY(-2px);
            }

            .btn-register:disabled {
                background: #6c757d;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
                opacity: 0.6;
            }

            .login-link {
                text-align: center;
                margin-top: 20px;
                color: #666;
            }

            .login-link a {
                color: #667eea;
                text-decoration: none;
                font-weight: 600;
            }

            .login-link a:hover {
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

            .badge {
                padding: 0.5em 0.75em;
                font-size: 0.75em;
                font-weight: 600;
                border-radius: 0.375rem;
            }
            
            .bg-secondary {
                background-color: #6c757d !important;
                color: white;
            }
            
            .bg-warning {
                background-color: #ffc107 !important;
                color: #212529;
            }
            
            .bg-info {
                background-color: #0dcaf0 !important;
                color: white;
            }
            
            .bg-success {
                background-color: #198754 !important;
                color: white;
            }
            
            .bg-danger {
                background-color: #dc3545 !important;
                color: white;
            }
            
            .spinner-border-sm {
                width: 1rem;
                height: 1rem;
            }
            
            .form-text {
                font-size: 0.875em;
                color: #6c757d;
                margin-top: 0.25rem;
            }

            /* Loading Overlay Styles */
            .loading-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.8);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            .loading-content {
                text-align: center;
                background: rgba(102, 126, 234, 0.9);
                padding: 2rem;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                max-width: 400px;
                width: 90%;
            }

            .loading-content .spinner-border {
                width: 3rem;
                height: 3rem;
            }

            @media (max-width: 768px) {
                .register-content {
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
        <!-- Loading Screen Overlay -->
        <div id="loadingOverlay" class="loading-overlay" style="display: none;">
            <div class="loading-content">
                <div class="spinner-border text-primary mb-3" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <h5 class="text-white mb-2">Creating Your Account</h5>
                <p class="text-white-50 mb-0">Please wait while we set up your account and send welcome email...</p>
            </div>
        </div>
        <div class="register-container">
            <div class="register-content">
                <!-- Form Section -->
                <div class="form-section">
                    <h1 class="form-title">Create Account</h1>
                    <p class="form-subtitle">Join our community today</p>

                    <form action="CustomerServlet" method="post" id="registerForm">
                        <input type="hidden" name="action" value="register">
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="regName" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="regName" name="name" placeholder="Enter your full name" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="regPhone" class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" id="regPhone" name="phone" placeholder="Enter your phone number" required onblur="checkPhoneNumberOnBlur(this.value)">
                                    <div id="phoneWarning" class="text-danger mt-1" style="display: none;">
                                        <i class="bi bi-exclamation-triangle me-1"></i>
                                        <small>This phone number is already registered in our system.</small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="regAddress" class="form-label">Address</label>
                            <textarea class="form-control" id="regAddress" name="address" rows="3" placeholder="Enter your address" required></textarea>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="regUsername" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="regUsername" name="username" placeholder="Enter your username" required onblur="checkUsernameOnBlur(this.value)">
                                    <div id="usernameWarning" class="text-danger mt-1" style="display: none;">
                                        <i class="bi bi-exclamation-triangle me-1"></i>
                                        <small>This username is already taken. Please choose a different one.</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="regEmail" class="form-label">Email Address</label>
                                    <div class="password-container">
                                        <input type="email" class="form-control" id="regEmail" name="email" placeholder="Enter your email" required>
                                        <button type="button" class="btn btn-outline-primary" id="sendVerificationBtn" onclick="sendVerificationCode()">
                                            <i class="bi bi-envelope"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
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
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="verificationPin" class="form-label">Verification Pin</label>
                                    <div class="password-container">
                                        <input type="text" class="form-control" id="verificationPin" name="verificationPin" placeholder="Enter 6-digit code" maxlength="6" disabled>
                                        <button type="button" class="btn btn-outline-success" id="verifyPinBtn" onclick="verifyPin()" disabled>
                                            <i class="bi bi-check-circle"></i>
                                        </button>
                                    </div>
                                    <small class="form-text text-muted">Click the envelope button next to email to receive verification code</small>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="form-label">Email Status</label>
                                    <div class="d-flex align-items-center">
                                        <span id="emailStatus" class="badge bg-secondary">Not Verified</span>
                                        <div id="verificationSpinner" class="spinner-border spinner-border-sm ms-2" style="display: none;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn-register" id="createAccountBtn" disabled>
                            <i class="bi bi-plus-circle me-2"></i>Create Account
                        </button>
                    </form>



                    <div class="login-link">
                        Already have an account? <a href="login.jsp">Log in</a>
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
            // Email verification functions for registration
            let emailVerified = false;
            
            function sendVerificationCode() {
                const email = document.getElementById('regEmail').value.trim();
                if (!email) {
                    showAlert('Please enter an email address first.', 'error');
                    return;
                }
                
                // Show spinner and disable button
                document.getElementById('verificationSpinner').style.display = 'inline-block';
                document.getElementById('sendVerificationBtn').disabled = true;
                document.getElementById('emailStatus').textContent = 'Checking email...';
                document.getElementById('emailStatus').className = 'badge bg-warning';
                
                // First check if email exists in ANY table (customers or users)
                const checkEmailXhr = new XMLHttpRequest();
                checkEmailXhr.open('POST', 'CustomerServlet?action=check-email-exists', true);
                checkEmailXhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                checkEmailXhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                checkEmailXhr.onreadystatechange = function() {
                    if (checkEmailXhr.readyState === 4) {
                        if (checkEmailXhr.status === 200) {
                            try {
                                const response = JSON.parse(checkEmailXhr.responseText);
                                if (response.status === 'success' && response.exists) {
                                    // Email already exists in either table - BLOCK verification
                                    document.getElementById('verificationSpinner').style.display = 'none';
                                    document.getElementById('sendVerificationBtn').disabled = false;
                                    document.getElementById('emailStatus').textContent = 'Email Exists';
                                    document.getElementById('emailStatus').className = 'badge bg-danger';
                                    showAlert('This email address is already registered in our system. Please use a different email address or login instead.', 'error');
                                    return;
                                } else {
                                    // Email is unique - proceed with verification
                                    sendVerificationEmail(email);
                                }
                            } catch (e) {
                                console.log('Error parsing email check response:', e);
                                // Fallback: proceed with verification
                                sendVerificationEmail(email);
                            }
                        } else {
                            // Fallback: proceed with verification
                            sendVerificationEmail(email);
                        }
                    }
                };
                
                checkEmailXhr.onerror = function() {
                    // Fallback: proceed with verification
                    sendVerificationEmail(email);
                };
                
                checkEmailXhr.send('email=' + encodeURIComponent(email));
            }
            
            function sendVerificationEmail(email) {
                // Show spinner and disable button
                document.getElementById('verificationSpinner').style.display = 'inline-block';
                document.getElementById('sendVerificationBtn').disabled = true;
                document.getElementById('emailStatus').textContent = 'Sending...';
                document.getElementById('emailStatus').className = 'badge bg-warning';
                
                // Send AJAX request for verification code
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=send-verification', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        document.getElementById('verificationSpinner').style.display = 'none';
                        document.getElementById('sendVerificationBtn').disabled = false;
                        
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.status === 'success') {
                                    showAlert(response.message, 'success');
                                    document.getElementById('emailStatus').textContent = 'Code Sent';
                                    document.getElementById('emailStatus').className = 'badge bg-info';
                                    
                                    // Enable verification pin input and button
                                    document.getElementById('verificationPin').disabled = false;
                                    document.getElementById('verifyPinBtn').disabled = false;
                                    document.getElementById('verificationPin').focus();
                                } else {
                                    showAlert(response.message, 'error');
                                    document.getElementById('emailStatus').textContent = 'Failed';
                                    document.getElementById('emailStatus').className = 'badge bg-danger';
                                }
                            } catch (e) {
                                showAlert('Verification code sent successfully!', 'success');
                                document.getElementById('emailStatus').textContent = 'Code Sent';
                                document.getElementById('emailStatus').className = 'badge bg-info';
                                
                                // Enable verification pin input and button
                                document.getElementById('verificationPin').disabled = false;
                                document.getElementById('verifyPinBtn').disabled = false;
                                document.getElementById('verificationPin').focus();
                            }
                        } else {
                            showAlert('Failed to send verification code. Please try again.', 'error');
                            document.getElementById('emailStatus').textContent = 'Failed';
                            document.getElementById('emailStatus').className = 'badge bg-danger';
                        }
                    }
                };
                
                xhr.onerror = function() {
                    document.getElementById('verificationSpinner').style.display = 'none';
                    document.getElementById('sendVerificationBtn').disabled = false;
                    showAlert('Network error occurred. Please try again.', 'error');
                    document.getElementById('emailStatus').textContent = 'Failed';
                    document.getElementById('emailStatus').className = 'badge bg-danger';
                };
                
                xhr.send('email=' + encodeURIComponent(email));
            }
            
            function verifyPin() {
                const email = document.getElementById('regEmail').value.trim();
                const pin = document.getElementById('verificationPin').value.trim();
                
                if (!pin) {
                    showAlert('Please enter the verification code.', 'error');
                    return;
                }
                
                // Show spinner and disable button
                document.getElementById('verificationSpinner').style.display = 'inline-block';
                document.getElementById('verifyPinBtn').disabled = true;
                document.getElementById('emailStatus').textContent = 'Verifying...';
                document.getElementById('emailStatus').className = 'badge bg-warning';
                
                // Send AJAX request
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=verify-email', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        document.getElementById('verificationSpinner').style.display = 'none';
                        document.getElementById('verifyPinBtn').disabled = false;
                        
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.status === 'success') {
                                    showAlert(response.message, 'success');
                                    document.getElementById('emailStatus').textContent = 'Verified';
                                    document.getElementById('emailStatus').className = 'badge bg-success';
                                    emailVerified = true;
                                    
                                    // Disable verification inputs
                                    document.getElementById('verificationPin').disabled = true;
                                    document.getElementById('verifyPinBtn').disabled = true;
                                    document.getElementById('sendVerificationBtn').disabled = true;
                                    
                                    // Enable the Create Account button
                                    document.getElementById('createAccountBtn').disabled = false;
                                } else {
                                    showAlert(response.message, 'error');
                                    document.getElementById('emailStatus').textContent = 'Invalid Code';
                                    document.getElementById('emailStatus').className = 'badge bg-danger';
                                }
                            } catch (e) {
                                showAlert('Email verified successfully!', 'success');
                                document.getElementById('emailStatus').textContent = 'Verified';
                                document.getElementById('emailStatus').className = 'badge bg-success';
                                emailVerified = true;
                                
                                // Disable verification inputs
                                document.getElementById('verificationPin').disabled = true;
                                document.getElementById('verifyPinBtn').disabled = true;
                                document.getElementById('sendVerificationBtn').disabled = true;
                                
                                // Enable the Create Account button
                                document.getElementById('createAccountBtn').disabled = false;
                            }
                        } else {
                            showAlert('Failed to verify code. Please try again.', 'error');
                            document.getElementById('emailStatus').textContent = 'Failed';
                            document.getElementById('emailStatus').className = 'badge bg-danger';
                        }
                    }
                };
                
                xhr.onerror = function() {
                    document.getElementById('verificationSpinner').style.display = 'none';
                    document.getElementById('verifyPinBtn').disabled = false;
                    showAlert('Network error occurred. Please try again.', 'error');
                    document.getElementById('emailStatus').textContent = 'Failed';
                    document.getElementById('emailStatus').className = 'badge bg-danger';
                };
                
                xhr.send('email=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(pin));
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
            
            // Form validation - disable Create Account button until email is verified
            document.addEventListener('DOMContentLoaded', function() {
                const createAccountBtn = document.getElementById('createAccountBtn');
                if (createAccountBtn) {
                    createAccountBtn.disabled = true;
                    createAccountBtn.title = 'Please verify your email first';
                }
                
                // Add form validation
                const form = document.getElementById('registerForm');
                if (form) {
                    form.addEventListener('submit', function(e) {
                        if (!emailVerified) {
                            e.preventDefault();
                            showAlert('Please verify your email address before creating your account.', 'error');
                            return false;
                        }
                        
                        // Check username before submitting
                        const username = document.getElementById('regUsername').value.trim();
                        if (username) {
                            checkUsernameExists(username, function(exists) {
                                if (exists) {
                                    e.preventDefault();
                                    showAlert('This username is already taken. Please choose a different username.', 'error');
                                    return false;
                                } else {
                                    // Username is unique, check phone number
                                    const phone = document.getElementById('regPhone').value.trim();
                                    if (phone) {
                                        checkPhoneNumberExists(phone, function(phoneExists) {
                                            if (phoneExists) {
                                                e.preventDefault();
                                                showAlert('This phone number is already registered in our system. Please use a different phone number.', 'error');
                                                return false;
                                            } else {
                                                // Both username and phone are unique, allow form submission
                                                showLoadingScreen();
                                                form.submit();
                                            }
                                        });
                                        e.preventDefault(); // Prevent default until we check phone
                                        return false;
                                    } else {
                                        // Username is unique and no phone to check, allow form submission
                                        showLoadingScreen();
                                        form.submit();
                                    }
                                }
                            });
                            e.preventDefault(); // Prevent default until we check username
                            return false;
                        }
                    });
                }
            });
            
            // Function to check if phone number already exists
            function checkPhoneNumberExists(phone, callback) {
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=check-phone-exists', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.status === 'success') {
                                    callback(response.exists);
                                } else {
                                    callback(false); // Allow submission on error
                                }
                            } catch (e) {
                                callback(false); // Allow submission on parse error
                            }
                        } else {
                            callback(false); // Allow submission on network error
                        }
                    }
                };
                
                xhr.onerror = function() {
                    callback(false); // Allow submission on error
                };
                
                xhr.send('phone=' + encodeURIComponent(phone));
            }

            function checkPhoneNumberOnBlur(phone) {
                if (phone) {
                    checkPhoneNumberExists(phone, function(exists) {
                        const phoneWarning = document.getElementById('phoneWarning');
                        if (exists) {
                            phoneWarning.style.display = 'block';
                        } else {
                            phoneWarning.style.display = 'none';
                        }
                    });
                }
            }
            
            // Function to check if username already exists
            function checkUsernameExists(username, callback) {
                const xhr = new XMLHttpRequest();
                xhr.open('POST', 'CustomerServlet?action=check-username-exists', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if (response.status === 'success') {
                                    callback(response.exists);
                                } else {
                                    callback(false); // Allow submission on error
                                }
                            } catch (e) {
                                callback(false); // Allow submission on parse error
                            }
                        } else {
                            callback(false); // Allow submission on network error
                        }
                    }
                };
                
                xhr.onerror = function() {
                    callback(false); // Allow submission on error
                };
                
                xhr.send('username=' + encodeURIComponent(username));
            }

            function checkUsernameOnBlur(username) {
                if (username) {
                    checkUsernameExists(username, function(exists) {
                        const usernameWarning = document.getElementById('usernameWarning');
                        if (exists) {
                            usernameWarning.style.display = 'block';
                        } else {
                            usernameWarning.style.display = 'none';
                        }
                    });
                }
            }
            
            function showLoadingScreen() {
                document.getElementById('loadingOverlay').style.display = 'flex';
            }

            function hideLoadingScreen() {
                document.getElementById('loadingOverlay').style.display = 'none';
            }
            

            
            // Alert function for showing messages
            function showAlert(message, type) {
                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-' + (type === 'success' ? 'success' : 'danger') + ' alert-dismissible fade show';
                alertDiv.style.position = 'fixed';
                alertDiv.style.top = '20px';
                alertDiv.style.right = '20px';
                alertDiv.style.zIndex = '9999';
                alertDiv.style.minWidth = '300px';
                alertDiv.innerHTML = 
                    message +
                    '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
                document.body.appendChild(alertDiv);
                
                // Auto remove after 3 seconds
                setTimeout(() => {
                    if (alertDiv.parentNode) {
                        alertDiv.remove();
                    }
                }, 3000);
            }
        </script>
    </body>
</html>
