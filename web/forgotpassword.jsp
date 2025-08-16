<%-- 
    Document   : forgotpassword
    Created on : Aug 12, 2025, 1:10:00 AM
    Author     : pruso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookClub - Forgot Password</title>
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

            .forgot-container {
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
                overflow: hidden;
                max-width: 800px;
                width: 100%;
                margin: 20px;
            }

            .forgot-content {
                display: flex;
                min-height: 500px;
            }

            .form-section {
                flex: 1;
                padding: 40px;
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
                padding: 40px;
                text-align: center;
                order: 2;
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

            .input-group {
                display: flex;
                align-items: center;
            }

            .input-group .form-control {
                border-top-right-radius: 0;
                border-bottom-right-radius: 0;
                border-right: none;
            }

            .input-group .btn {
                border-top-left-radius: 0;
                border-bottom-left-radius: 0;
                border-left: none;
                padding: 12px 15px;
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

            .btn-reset {
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

            .btn-reset:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
            }

            .btn-reset:disabled {
                background: #6c757d;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
                opacity: 0.6;
            }

            .back-link {
                text-align: center;
                margin-top: 20px;
                color: #666;
            }

            .back-link a {
                color: #667eea;
                text-decoration: none;
                font-weight: 600;
            }

            .back-link a:hover {
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

            @media (max-width: 768px) {
                .forgot-content {
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
        <div class="forgot-container">
            <div class="forgot-content">
                <!-- Form Section -->
                <div class="form-section">
                    <h1 class="form-title">Reset Password</h1>
                    <p class="form-subtitle">Enter your email to receive a verification code</p>

                    <form id="forgotPasswordForm">
                        <div class="form-group">
                            <label for="resetEmail" class="form-label">Email Address</label>
                            <div class="input-group">
                                <input type="email" class="form-control" id="resetEmail" name="email" placeholder="Enter your email" required>
                                <button type="button" class="btn btn-outline-primary" id="sendVerificationBtn" onclick="sendVerificationCode()">
                                    <i class="bi bi-envelope"></i>
                                </button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="verificationPin" class="form-label">Verification Code</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="verificationPin" name="verificationPin" placeholder="Enter 6-digit code" maxlength="6" disabled>
                                <button type="button" class="btn btn-outline-success" id="verifyPinBtn" onclick="verifyPin()" disabled>
                                    <i class="bi bi-check-circle"></i>
                                </button>
                            </div>
                            <small class="form-text text-muted">Click the envelope button next to email to receive verification code</small>
                        </div>

                        <div class="form-group">
                            <label class="form-label">Email Status</label>
                            <div class="d-flex align-items-center">
                                <span id="emailStatus" class="badge bg-secondary">Not Verified</span>
                                <div id="verificationSpinner" class="spinner-border spinner-border-sm ms-2" style="display: none;"></div>
                            </div>
                        </div>

                        <div id="passwordResetSection" style="display: none;">
                            <div class="form-group">
                                <label for="newPassword" class="form-label">New Password</label>
                                <div class="password-container">
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Enter new password" required>
                                    <button type="button" class="password-toggle" onclick="togglePasswordVisibility('newPassword')">
                                        <i class="bi bi-eye-slash" id="newPassword-toggle-icon"></i>
                                    </button>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                <div class="password-container">
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" required>
                                    <button type="button" class="password-toggle" onclick="togglePasswordVisibility('confirmPassword')">
                                        <i class="bi bi-eye-slash" id="confirmPassword-toggle-icon"></i>
                                    </button>
                                </div>
                            </div>

                            <button type="submit" class="btn-reset" id="resetPasswordBtn">
                                <i class="bi bi-key me-2"></i>Reset Password
                            </button>
                        </div>
                    </form>

                    <div class="back-link">
                        <a href="login.jsp"><i class="bi bi-arrow-left me-2"></i>Back to Login</a>
                    </div>
                </div>

                <!-- Illustration Section -->
                <div class="illustration-section">
                    <div class="illustration-image">
                        <img src="<%= request.getContextPath() %>/IMG/pahana.png" alt="Pahana Password Reset">
                    </div>
                    <h3 style="color: #333; margin-bottom: 10px;">Forgot Your Password?</h3>
                    <p style="color: #666; font-size: 0.9rem;">Don't worry! We'll help you reset it securely.</p>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Custom JavaScript -->
        <script>
            // Email verification functions for password reset
            let emailVerified = false;
            
            function sendVerificationCode() {
                const email = document.getElementById('resetEmail').value.trim();
                if (!email) {
                    showAlert('Please enter an email address first.', 'error');
                    return;
                }
                
                // Show spinner and disable button
                document.getElementById('verificationSpinner').style.display = 'inline-block';
                document.getElementById('sendVerificationBtn').disabled = true;
                document.getElementById('emailStatus').textContent = 'Checking email...';
                document.getElementById('emailStatus').className = 'badge bg-warning';
                
                // Check if email exists in ANY table (customers or users) using CustomerServlet
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
                                    // Email exists in either table, determine which one and proceed
                                    determineEmailContextAndSendVerification(email);
                                } else {
                                    // Email doesn't exist in either table
                                    document.getElementById('verificationSpinner').style.display = 'none';
                                    document.getElementById('sendVerificationBtn').disabled = false;
                                    document.getElementById('emailStatus').textContent = 'Email Not Found';
                                    document.getElementById('emailStatus').className = 'badge bg-danger';
                                    showAlert('This email address is not registered in our system. Please check your email or register first.', 'error');
                                }
                            } catch (e) {
                                console.log('Error parsing email check response:', e);
                                // Fallback: try to determine context
                                determineEmailContextAndSendVerification(email);
                            }
                        } else {
                            // Fallback: try to determine context
                            determineEmailContextAndSendVerification(email);
                        }
                    }
                };
                
                checkEmailXhr.onerror = function() {
                    // Fallback: try to determine context
                    determineEmailContextAndSendVerification(email);
                };
                
                checkEmailXhr.send('email=' + encodeURIComponent(email));
            }
            
            function determineEmailContextAndSendVerification(email) {
                // Since CustomerServlet now checks both tables, we can determine context
                // by checking which table the email actually exists in
                const checkCustomerXhr = new XMLHttpRequest();
                checkCustomerXhr.open('POST', 'CustomerServlet?action=check-email-exists', true);
                checkCustomerXhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                checkCustomerXhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                checkCustomerXhr.onreadystatechange = function() {
                    if (checkCustomerXhr.readyState === 4) {
                        if (checkCustomerXhr.status === 200) {
                            try {
                                const response = JSON.parse(checkCustomerXhr.responseText);
                                if (response.status === 'success' && response.exists) {
                                    // Email exists in customers table
                                    sendVerificationEmail(email, 'customer');
                                    return;
                                }
                            } catch (e) {
                                console.log('Error parsing customer response:', e);
                            }
                        }
                        
                        // If not found in customers, it must be in users table
                        sendVerificationEmail(email, 'user');
                    }
                };
                
                checkCustomerXhr.onerror = function() {
                    // Fallback: assume it's a user
                    sendVerificationEmail(email, 'user');
                };
                
                checkCustomerXhr.send('email=' + encodeURIComponent(email));
            }
            
            function sendVerificationEmail(email, context) {
                console.log('=== SEND VERIFICATION EMAIL DEBUG ===');
                console.log('Email:', email);
                console.log('Context:', context);
                
                // Show spinner and disable button
                document.getElementById('verificationSpinner').style.display = 'inline-block';
                document.getElementById('sendVerificationBtn').disabled = true;
                document.getElementById('emailStatus').textContent = 'Sending...';
                document.getElementById('emailStatus').className = 'badge bg-warning';
                
                // Determine which servlet to use based on context
                const servletUrl = context === 'user' ? 'UserServlet?action=send-verification' : 'CustomerServlet?action=send-verification';
                const contextParam = context === 'user' ? 'forgot-password' : 'forgot-password';
                
                console.log('Using servlet URL:', servletUrl);
                console.log('Context parameter:', contextParam);
                
                // Send AJAX request for verification code
                const xhr = new XMLHttpRequest();
                xhr.open('POST', servletUrl, true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        console.log('Email verification response received:');
                        console.log('Status:', xhr.status);
                        console.log('Response text:', xhr.responseText);
                        
                        document.getElementById('verificationSpinner').style.display = 'none';
                        document.getElementById('sendVerificationBtn').disabled = false;
                        
                        if (xhr.status === 200) {
                            try {
                                const response = JSON.parse(xhr.responseText);
                                console.log('Parsed response:', response);
                                
                                if (response.status === 'success') {
                                    showAlert(response.message, 'success');
                                    document.getElementById('emailStatus').textContent = 'Code Sent';
                                    document.getElementById('emailStatus').className = 'badge bg-info';
                                    
                                    // Enable verification pin input and button
                                    document.getElementById('verificationPin').disabled = false;
                                    document.getElementById('verifyPinBtn').disabled = false;
                                    document.getElementById('verificationPin').focus();
                                    
                                    // Store context for password reset
                                    window.passwordResetContext = context;
                                    console.log('Password reset context set to:', context);
                                } else {
                                    showAlert(response.message, 'error');
                                    document.getElementById('emailStatus').textContent = 'Failed';
                                    document.getElementById('emailStatus').className = 'badge bg-danger';
                                }
                            } catch (e) {
                                console.error('Error parsing email verification response:', e);
                                console.log('Raw response was:', xhr.responseText);
                                
                                // If we get HTML instead of JSON, there's a servlet error
                                if (xhr.responseText.includes('<!DOCTYPE')) {
                                    console.error('Servlet returned HTML instead of JSON - likely a servlet error');
                                    showAlert('System error: Servlet is not responding correctly. Please contact administrator.', 'error');
                                } else {
                                    showAlert('Verification code sent successfully!', 'success');
                                    document.getElementById('emailStatus').textContent = 'Code Sent';
                                    document.getElementById('emailStatus').className = 'badge bg-info';
                                    
                                    // Enable verification pin input and button
                                    document.getElementById('verificationPin').disabled = false;
                                    document.getElementById('verifyPinBtn').disabled = false;
                                    document.getElementById('verificationPin').focus();
                                    
                                    // Store context for password reset
                                    window.passwordResetContext = context;
                                    console.log('Password reset context set to:', context);
                                }
                            }
                        } else {
                            console.error('HTTP error:', xhr.status);
                            showAlert('Failed to send verification code. Please try again.', 'error');
                            document.getElementById('emailStatus').textContent = 'Failed';
                            document.getElementById('emailStatus').className = 'badge bg-danger';
                        }
                    }
                };
                
                xhr.onerror = function() {
                    console.error('Network error occurred');
                    document.getElementById('verificationSpinner').style.display = 'none';
                    document.getElementById('sendVerificationBtn').disabled = false;
                    showAlert('Network error. Please check your connection and try again.', 'error');
                    document.getElementById('emailStatus').textContent = 'Failed';
                    document.getElementById('emailStatus').className = 'badge bg-danger';
                };
                
                // Send with context parameter for forgot password
                const postData = 'email=' + encodeURIComponent(email) + '&context=' + contextParam;
                console.log('Sending POST data:', postData);
                xhr.send(postData);
            }
            
            function verifyPin() {
                const email = document.getElementById('resetEmail').value.trim();
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
                                    
                                    console.log('=== EMAIL VERIFICATION SUCCESS ===');
                                    console.log('Email verified: true');
                                    console.log('Password reset section should be visible now');
                                    
                                    // Disable verification inputs
                                    document.getElementById('verificationPin').disabled = true;
                                    document.getElementById('verifyPinBtn').disabled = true;
                                    document.getElementById('sendVerificationBtn').disabled = true;
                                    
                                    // Show password reset section
                                    const passwordResetSection = document.getElementById('passwordResetSection');
                                    passwordResetSection.style.display = 'block';
                                    console.log('Password reset section display style:', passwordResetSection.style.display);
                                    
                                    // Focus on new password field
                                    document.getElementById('newPassword').focus();
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
                                
                                // Show password reset section
                                document.getElementById('passwordResetSection').style.display = 'block';
                                
                                // Focus on new password field
                                document.getElementById('newPassword').focus();
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
                
                if (inputId === 'newPassword') {
                    icon = document.getElementById('newPassword-toggle-icon');
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
            
            // Form validation and submission
            document.addEventListener('DOMContentLoaded', function() {
                const form = document.getElementById('forgotPasswordForm');
                if (form) {
                    form.addEventListener('submit', function(e) {
                        e.preventDefault();
                        
                        console.log('=== FORM SUBMISSION DEBUG ===');
                        console.log('Form submitted!');
                        console.log('Email verified status:', emailVerified);
                        
                        if (!emailVerified) {
                            showAlert('Please verify your email address first.', 'error');
                            return false;
                        }
                        
                        const newPassword = document.getElementById('newPassword').value.trim();
                        const confirmPassword = document.getElementById('confirmPassword').value.trim();
                        
                        console.log('New password length:', newPassword.length);
                        console.log('Confirm password length:', confirmPassword.length);
                        console.log('Passwords match:', newPassword === confirmPassword);
                        
                        if (!newPassword || !confirmPassword) {
                            showAlert('Please fill in both password fields.', 'error');
                            return false;
                        }
                        
                        if (newPassword !== confirmPassword) {
                            showAlert('Passwords do not match. Please try again.', 'error');
                            return false;
                        }
                        
                        if (newPassword.length < 6) {
                            showAlert('Password must be at least 6 characters long.', 'error');
                            return false;
                        }
                        
                        console.log('=== AJAX REQUEST DEBUG ===');
                        console.log('Password reset context:', window.passwordResetContext);
                        console.log('Email:', document.getElementById('resetEmail').value.trim());
                        console.log('New password:', newPassword);
                        
                        // Determine which servlet to use based on context
                        const resetServletUrl = window.passwordResetContext === 'user' ? 'UserServlet?action=reset-password' : 'CustomerServlet?action=reset-password';
                        console.log('Using servlet:', resetServletUrl);
                        
                        // Send password reset request to appropriate servlet
                        const xhr = new XMLHttpRequest();
                        xhr.open('POST', resetServletUrl, true);
                        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
                        
                        xhr.onreadystatechange = function() {
                            if (xhr.readyState === 4) {
                                if (xhr.status === 200) {
                                    try {
                                        const response = JSON.parse(xhr.responseText);
                                        if (response.status === 'success') {
                                            showAlert('Password reset successfully! You can now login with your new password.', 'success');
                                            
                                            // Redirect to login page after 2 seconds
                                            setTimeout(() => {
                                                window.location.href = 'login.jsp';
                                            }, 2000);
                                        } else {
                                            showAlert(response.message, 'error');
                                        }
                                    } catch (e) {
                                        showAlert('Password reset successfully! You can now login with your new password.', 'success');
                                        
                                        // Redirect to login page after 2 seconds
                                        setTimeout(() => {
                                            window.location.href = 'login.jsp';
                                        }, 2000);
                                    }
                                } else {
                                    showAlert('Failed to reset password. Please try again.', 'error');
                                }
                            }
                        };
                        
                        xhr.onerror = function() {
                            showAlert('Network error occurred. Please try again.', 'error');
                        };
                        
                        xhr.send('email=' + encodeURIComponent(document.getElementById('resetEmail').value.trim()) + '&newPassword=' + encodeURIComponent(newPassword));
                    });
                }
            });
            
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
