<%-- 
    Document   : index
    Created on : Aug 3, 2025, 9:07:20 AM
    Author     : pruso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pahana BookStore - Your Gateway to Knowledge</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #667eea;
                --secondary-color: #764ba2;
                --accent-color: #f093fb;
                --text-dark: #333;
                --text-light: #666;
                --white: #ffffff;
                --light-gray: #f8f9fa;
                --border-color: #e9ecef;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                line-height: 1.6;
                color: var(--text-dark);
            }



            .search-container {
                position: relative;
                max-width: 500px;
                margin: 0 auto;
            }

            .search-input {
                border: 2px solid var(--border-color);
                border-radius: 25px;
                padding: 12px 20px;
                width: 100%;
                font-size: 16px;
                transition: border-color 0.3s ease;
            }

            .search-input:focus {
                outline: none;
                border-color: var(--primary-color);
            }

            .main-header {
                background: white;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                padding: 15px 0;
            }

            .logo {
                font-size: 28px;
                font-weight: 700;
                color: var(--primary-color);
                text-decoration: none;
            }

            .logo:hover {
                color: var(--secondary-color);
            }

            .search-container {
                position: relative;
                max-width: 500px;
                margin: 0 auto;
            }

            .search-input {
                border: 2px solid var(--border-color);
                border-radius: 25px;
                padding: 12px 20px;
                width: 100%;
                font-size: 16px;
                transition: border-color 0.3s ease;
            }

            .search-input:focus {
                outline: none;
                border-color: var(--primary-color);
            }

            .search-btn {
                position: absolute;
                right: 5px;
                top: 50%;
                transform: translateY(-50%);
                background: var(--primary-color);
                color: white;
                border: none;
                border-radius: 20px;
                padding: 8px 20px;
                font-size: 14px;
                transition: background 0.3s ease;
            }

            .search-btn:hover {
                background: var(--secondary-color);
            }

            .nav-link {
                color: var(--text-dark) !important;
                font-weight: 500;
                margin: 0 15px;
                transition: color 0.3s ease;
                text-decoration: none;
            }

            .nav-link:hover {
                color: var(--primary-color) !important;
            }

                         .nav-link.active {
                 color: var(--primary-color) !important;
             }
             
             
             .login-nav-link {
                 background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                 color: white !important;
                 padding: 8px 20px !important;
                 border-radius: 25px !important;
                 margin: 0 10px !important;
                 transition: all 0.3s ease !important;
                 box-shadow: 0 2px 10px rgba(102, 126, 234, 0.3) !important;
             }
             
             .login-nav-link:hover {
                 background: linear-gradient(135deg, var(--secondary-color), var(--accent-color)) !important;
                 color: white !important;
                 transform: translateY(-2px) !important;
                 box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4) !important;
             }
             
             .login-nav-link i {
                 font-size: 0.9em;
                 margin-right: 5px;
             }

            
            .modern-navbar {
                background: #1a1a1a;
                padding: 0;
                position: sticky;
                top: 0;
                z-index: 1000;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
                width: 100%;
            }

            .nav-container {
                max-width: 100%;
                margin: 0 auto;
                padding: 0 2rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
                height: 60px;
            }

            .nav-brand {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .nav-brand .brand-logo {
                font-size: 1.6rem;
                font-weight: 700;
                color: #ffffff;
                text-decoration: none;
                letter-spacing: 0.5px;
                transition: color 0.3s ease;
                white-space: nowrap;
            }

            .nav-brand .brand-logo:hover {
                color: var(--primary-color);
            }

            .nav-brand .search-container {
                position: relative;
                display: flex;
                align-items: center;
                background: #333333;
                border-radius: 20px;
                padding: 3px;
                border: 1px solid #444444;
            }

            .nav-brand .search-input {
                background: transparent;
                border: none;
                color: #ffffff;
                padding: 8px 16px;
                font-size: 0.9rem;
                width: 280px;
                outline: none;
                transition: all 0.3s ease;
            }

            .nav-brand .search-input::placeholder {
                color: #aaaaaa;
                font-size: 0.85rem;
            }

            .nav-brand .search-input:focus {
                background: #444444;
                border-color: var(--primary-color);
            }

            .nav-brand .search-btn {
                background: var(--primary-color);
                color: white;
                border: none;
                border-radius: 18px;
                padding: 8px 16px;
                font-size: 0.85rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
            }

            .nav-brand .search-btn:hover {
                background: var(--secondary-color);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(118, 75, 162, 0.4);
                color: #ffffff;
            }

            .nav-brand .search-btn:active {
                transform: translateY(0);
                box-shadow: 0 2px 8px rgba(118, 75, 162, 0.3);
            }

            .nav-menu {
                display: flex;
                align-items: center;
                gap: 0;
                flex: 1;
                justify-content: center;
            }

            .nav-item {
                color: #cccccc;
                text-decoration: none;
                padding: 10px 20px;
                border-radius: 20px;
                font-weight: 500;
                font-size: 0.9rem;
                transition: all 0.3s ease;
                position: relative;
                margin: 0 4px;
                display: flex;
                align-items: center;
                gap: 6px;
            }

            .nav-item:hover {
                color: #ffffff;
                background: #333333;
                transform: translateY(-1px);
            }

            .nav-item.active {
                color: #ffffff;
                background: #4a4a4a;
                box-shadow: 0 3px 12px rgba(255, 255, 255, 0.1);
            }

            .nav-item.login-btn {
                background: #000000;
                color: #ffffff;
                padding: 10px 20px;
                border-radius: 20px;
                font-weight: 600;
                box-shadow: 0 3px 12px rgba(0, 0, 0, 0.3);
                transition: all 0.3s ease;
            }

            .nav-item.login-btn:hover {
                background: #333333;
                transform: translateY(-1px);
                box-shadow: 0 5px 18px rgba(0, 0, 0, 0.4);
            }

            .nav-item.login-btn i {
                font-size: 0.85em;
            }

            .nav-toggle {
                display: none;
                flex-direction: column;
                cursor: pointer;
                gap: 4px;
                z-index: 1002;
            }

            .nav-toggle span {
                width: 25px;
                height: 3px;
                background: #ffffff;
                border-radius: 2px;
                transition: all 0.3s ease;
            }

            
            .mobile-nav-backdrop {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.5);
                z-index: 1000;
            }

            .mobile-nav-backdrop.active {
                display: block;
            }

            
            @media (max-width: 1024px) {
                .nav-container {
                    padding: 0 1.5rem;
                }
                
                .nav-brand .search-input {
                    width: 250px;
                }
                
                .nav-menu {
                    gap: 0;
                }
                
                .nav-item {
                    padding: 9px 18px;
                    margin: 0 3px;
                    font-size: 0.85rem;
                }
            }

            @media (max-width: 768px) {
                .nav-menu {
                    display: none;
                    position: absolute;
                    top: 100%;
                    left: 0;
                    right: 0;
                    background: #1a1a1a;
                    flex-direction: column;
                    padding: 1rem 0;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
                    z-index: 1001;
                }

                .nav-menu.active {
                    display: flex;
                }

                .nav-item {
                    margin: 5px 0;
                    width: 100%;
                    text-align: center;
                    justify-content: center;
                    padding: 12px 20px;
                    font-size: 0.95rem;
                }

                .nav-toggle {
                    display: flex;
                }

                .nav-container {
                    padding: 0 1rem;
                    height: 70px;
                }

                .nav-brand {
                    flex-direction: column;
                    gap: 10px;
                    align-items: flex-start;
                    flex: 1;
                }

                .nav-brand .search-container {
                    width: 100%;
                    max-width: 350px;
                }

                .nav-brand .search-input {
                    width: 100%;
                    flex: 1;
                    font-size: 0.95rem;
                    padding: 10px 18px;
                }

                .nav-brand .search-btn {
                    font-size: 0.9rem;
                    padding: 10px 18px;
                }

                .nav-actions {
                    flex-direction: column;
                    gap: 10px;
                    align-items: stretch;
                    min-width: 120px;
                }

                .nav-item.find-store-btn,
                .nav-item.login-btn {
                    width: 100%;
                    text-align: center;
                    justify-content: center;
                    padding: 10px 16px;
                    font-size: 0.9rem;
                }
            }

            @media (max-width: 480px) {
                .nav-container {
                    padding: 0 0.5rem;
                    height: 80px;
                }
                
                .nav-item {
                    padding: 10px 16px;
                    font-size: 0.9rem;
                }
                
                .brand-logo {
                    font-size: 1.4rem;
                }

                .nav-brand .search-container {
                    max-width: 280px;
                }

                .nav-brand .search-input {
                    font-size: 0.9rem;
                    padding: 8px 16px;
                }

                .nav-brand .search-btn {
                    padding: 8px 16px;
                    font-size: 0.85rem;
                }

                .nav-actions {
                    min-width: 100px;
                }

                .nav-item.find-store-btn,
                .nav-item.login-btn {
                    font-size: 0.85rem;
                    padding: 8px 12px;
                }
            }

            @media (max-width: 360px) {
                .nav-container {
                    padding: 0 0.25rem;
                    height: 100px;
                }
                
                .brand-logo {
                    font-size: 1.3rem;
                }
                
                .nav-brand .search-container {
                    max-width: 240px;
                }
                
                .nav-brand .search-input {
                    font-size: 0.8rem;
                    padding: 6px 12px;
                }
                
                .nav-brand .search-btn {
                    font-size: 0.8rem;
                    padding: 6px 10px;
                }
                
                .nav-actions {
                    min-width: 80px;
                }
                
                .nav-item.find-store-btn,
                .nav-item.login-btn {
                    font-size: 0.8rem;
                    padding: 6px 8px;
                }
                
                .nav-item.find-store-btn span,
                .nav-item.login-btn span {
                    display: none;
                }
                
                .nav-item.find-store-btn i,
                .nav-item.login-btn i {
                    font-size: 1rem;
                }
            }

            .btn-primary-custom {
                background: var(--primary-color);
                border: none;
                color: white;
                padding: 10px 25px;
                border-radius: 25px;
                font-weight: 600;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-block;
            }

            .btn-primary-custom:hover {
                background: var(--secondary-color);
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            }

            
            .hero-section {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                padding: 80px 0;
                text-align: left;
            }

            
            .brand-logo-section {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-bottom: 2rem;
            }

            .brand-icon {
                width: 50px;
                height: 50px;
                background: #ff6b35;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                color: white;
            }

            .brand-name {
                font-size: 2rem;
                font-weight: 700;
                color: white;
                margin: 0;
            }

            
            .hero-headline {
                font-size: 3.5rem;
                font-weight: 700;
                line-height: 1.2;
                margin-bottom: 1.5rem;
                color: white;
            }

            .highlighted-text {
                position: relative;
                display: inline-block;
            }

            .highlighted-text::after {
                content: '';
                position: absolute;
                bottom: -5px;
                left: 0;
                width: 100%;
                height: 3px;
                background: #ff6b35;
                border-radius: 2px;
            }

            
            .hero-description {
                font-size: 1.2rem;
                line-height: 1.6;
                margin-bottom: 2rem;
                color: rgba(255, 255, 255, 0.9);
                max-width: 500px;
            }

            
            .search-container-hero {
                display: flex;
                max-width: 450px;
                background: white;
                border-radius: 25px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            }

            .search-input-wrapper {
                position: relative;
                flex: 1;
                display: flex;
                align-items: center;
            }

            .search-input-hero {
                width: 100%;
                padding: 15px 20px;
                border: none;
                outline: none;
                font-size: 1rem;
                color: #333;
            }

            .search-dropdown {
                position: absolute;
                right: 15px;
                color: #666;
                cursor: pointer;
                padding: 5px;
            }

            .search-btn-hero {
                background: #ff6b35;
                color: white;
                border: none;
                padding: 15px 25px;
                font-size: 1rem;
                cursor: pointer;
                transition: background 0.3s ease;
            }

            .search-btn-hero:hover {
                background: #e55a2b;
            }

            
            .quick-links {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-top: 2rem;
            }

            .quick-link {
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            .quick-link:hover {
                color: white;
            }

            .separator {
                color: rgba(255, 255, 255, 0.4);
                font-weight: 300;
            }

            
            .book-covers-section {
                position: relative;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 600px;
            }

            .book-cover {
                position: absolute;
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                overflow: hidden;
                transition: transform 0.3s ease;
            }

            .book-cover:hover {
                transform: translateY(-10px);
            }

            .book-1 {
                left: 5%;
                top: 10%;
                z-index: 6;
                transform: rotate(-15deg);
            }

            .book-2 {
                left: 30%;
                top: 15%;
                z-index: 5;
                transform: rotate(-5deg);
            }

            .book-3 {
                right: 10%;
                top: 10%;
                z-index: 4;
                transform: rotate(8deg);
            }

            .book-4 {
                left: 10%;
                bottom: 20%;
                z-index: 3;
                transform: rotate(-12deg);
            }

            .book-5 {
                left: 40%;
                bottom: 15%;
                z-index: 2;
                transform: rotate(3deg);
            }

            .book-6 {
                right: 20%;
                bottom: 25%;
                z-index: 1;
                transform: rotate(12deg);
            }

            .book-cover-img {
                width: 200px;
                height: 280px;
                object-fit: cover;
            }

            
            .book-1 .book-cover-img,
            .book-2 .book-cover-img,
            .book-3 .book-cover-img {
                width: 250px;
                height: 350px;
            }

            .book-info {
                padding: 15px;
                text-align: center;
                background: white;
            }

            .book-info h4 {
                font-size: 1rem;
                font-weight: 600;
                color: #333;
                margin: 0 0 5px 0;
            }

            .book-info p {
                font-size: 0.85rem;
                color: #666;
                margin: 0;
            }



            
            .categories-section {
                padding: 80px 0;
                background: var(--light-gray);
                width: 100%;
            }

            .categories-section .container-fluid {
                max-width: 100%;
                padding-left: 2rem;
                padding-right: 2rem;
            }

            
            .categories-section .row {
                margin-left: -0.5rem;
                margin-right: -0.5rem;
            }

            .categories-section .col-xl-2,
            .categories-section .col-lg-3,
            .categories-section .col-md-4,
            .categories-section .col-sm-6 {
                padding-left: 0.5rem;
                padding-right: 0.5rem;
            }

            
            .category-card {
                min-height: 200px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .section-title {
                text-align: center;
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 50px;
                color: var(--text-dark);
            }

            .category-card {
                background: white;
                border-radius: 15px;
                padding: 30px;
                text-align: center;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                height: 100%;
                position: relative;
                overflow: hidden;
            }

            .category-card::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
                transition: left 0.5s ease;
            }

            .category-card:hover::before {
                left: 100%;
            }

            .category-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 40px rgba(0,0,0,0.2);
            }

            .category-card .loading {
                opacity: 0.7;
                pointer-events: none;
            }

            .category-card .loading::after {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 20px;
                height: 20px;
                margin: -10px 0 0 -10px;
                border: 2px solid var(--primary-color);
                border-top: 2px solid transparent;
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }

            .category-icon {
                font-size: 3rem;
                color: var(--primary-color);
                margin-bottom: 20px;
            }

            .category-card h4 {
                font-weight: 600;
                margin-bottom: 15px;
                color: var(--text-dark);
            }

            .category-link {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s ease;
            }

            .category-link:hover {
                color: var(--secondary-color);
            }

            
            .deals-section {
                padding: 80px 0;
            }

            .book-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
                height: 100%;
            }

            .book-card:hover {
                transform: translateY(-5px);
            }

            .book-image {
                width: 100%;
                height: 250px;
                object-fit: cover;
            }

            .book-info {
                padding: 20px;
            }

            .book-title {
                font-weight: 600;
                margin-bottom: 10px;
                color: var(--text-dark);
            }

            .book-author {
                color: var(--text-light);
                margin-bottom: 10px;
            }

            .book-rating {
                color: #ffc107;
                margin-bottom: 15px;
            }

            .book-price {
                font-size: 1.2rem;
                font-weight: 700;
                color: var(--primary-color);
            }

            
            .promo-banners {
                padding: 60px 0;
                background: var(--light-gray);
            }

            .promo-card {
                background: white;
                border-radius: 15px;
                padding: 40px;
                text-align: center;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                height: 100%;
            }

            .promo-card h3 {
                font-weight: 700;
                margin-bottom: 15px;
                color: var(--text-dark);
            }

            .promo-card p {
                color: var(--text-light);
                margin-bottom: 25px;
            }

            
            .email-section {
                padding: 80px 0;
                background: linear-gradient(135deg, #28a745, #20c997);
                color: white;
            }

            .email-content h3 {
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 20px;
            }

            .email-content p {
                font-size: 1.1rem;
                margin-bottom: 30px;
                opacity: 0.9;
            }

            .email-form {
                display: flex;
                gap: 15px;
                max-width: 500px;
                margin: 0 auto;
            }

            .email-input {
                flex: 1;
                padding: 15px 20px;
                border: none;
                border-radius: 25px;
                font-size: 16px;
            }

            .email-input:focus {
                outline: none;
            }

            .subscribe-btn {
                background: #dc3545;
                color: white;
                border: none;
                padding: 15px 30px;
                border-radius: 25px;
                font-weight: 600;
                transition: background 0.3s ease;
            }

            .subscribe-btn:hover {
                background: #c82333;
            }

                         
             .service-card {
                 background: white;
                 border-radius: 15px;
                 box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                 transition: transform 0.3s ease, box-shadow 0.3s ease;
                 height: 100%;
                 border: 1px solid var(--border-color);
             }
             
             .service-card:hover {
                 transform: translateY(-10px);
                 box-shadow: 0 15px 40px rgba(0,0,0,0.2);
             }
             
             .service-icon {
                 color: var(--primary-color);
                 margin-bottom: 20px;
             }
             
             .service-card h4 {
                 color: var(--text-dark);
                 font-weight: 600;
                 margin-bottom: 15px;
             }
             
             .service-card p {
                 color: var(--text-light);
                 line-height: 1.6;
             }
             
             
             .blog-section {
                 padding: 80px 0;
                 background: var(--light-gray);
             }

            .blog-card {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                transition: transform 0.3s ease;
                height: 100%;
            }

            .blog-card:hover {
                transform: translateY(-5px);
            }

            .blog-image {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .blog-content {
                padding: 25px;
            }

            .blog-date {
                color: var(--text-light);
                font-size: 14px;
                margin-bottom: 10px;
            }

            .blog-title {
                font-weight: 600;
                margin-bottom: 10px;
                color: var(--text-dark);
            }

            .blog-category {
                color: var(--primary-color);
                font-size: 14px;
                margin-bottom: 15px;
            }

            .read-more {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 600;
                transition: color 0.3s ease;
            }

            .read-more:hover {
                color: var(--secondary-color);
            }

            
            .footer {
                background: var(--text-dark);
                color: white;
                padding: 60px 0 20px;
            }

            .footer h5 {
                color: var(--primary-color);
                margin-bottom: 20px;
                font-weight: 600;
            }

            .footer-links {
                list-style: none;
                padding: 0;
            }

            .footer-links li {
                margin-bottom: 10px;
            }

            .footer-links a {
                color: #ccc;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .footer-links a:hover {
                color: var(--primary-color);
            }

            .payment-methods {
                text-align: center;
                margin-top: 30px;
                padding-top: 30px;
                border-top: 1px solid #444;
            }

            .payment-methods img {
                height: 40px;
                margin: 0 10px;
                opacity: 0.7;
                transition: opacity 0.3s ease;
            }

            .payment-methods img:hover {
                opacity: 1;
            }

            .copyright {
                text-align: center;
                margin-top: 20px;
                padding-top: 20px;
                border-top: 1px solid #444;
                color: #ccc;
            }

            
            .alert {
                border-radius: 10px;
                border: none;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .alert-success {
                background: #d4edda;
                color: #155724;
                border-left: 4px solid #28a745;
            }

            .alert-danger {
                background: #f8d7da;
                color: #721c24;
                border-left: 4px solid #dc3545;
            }

            .alert-info {
                background: #d1ecf1;
                color: #0c5460;
                border-left: 4px solid #17a2b8;
            }

            #submitBtn:disabled {
                opacity: 0.7;
                cursor: not-allowed;
            }

            #submitSpinner {
                color: white;
            }

            
            @media (max-width: 768px) {
                .hero-content h1 {
                    font-size: 2.5rem;
                }
                
                .hero-headline {
                    font-size: 2.5rem;
                }
                
                .brand-name {
                    font-size: 1.5rem;
                }
                
                .brand-icon {
                    width: 40px;
                    height: 40px;
                    font-size: 1.2rem;
                }
                
                .search-container-hero {
                    max-width: 100%;
                }
                
                .book-covers-section {
                    height: 400px;
                }
                
                .book-cover-img {
                    width: 150px;
                    height: 210px;
                }

                
                .book-1 .book-cover-img,
                .book-2 .book-cover-img,
                .book-3 .book-cover-img {
                    width: 180px;
                    height: 252px;
                }
                
                .book-1 {
                    left: 2%;
                    top: 8%;
                }
                
                .book-2 {
                    left: 25%;
                    top: 12%;
                }
                
                .book-3 {
                    right: 15%;
                    top: 8%;
                }
                
                .book-4 {
                    left: 8%;
                    bottom: 18%;
                }
                
                .book-5 {
                    left: 35%;
                    bottom: 12%;
                }
                
                .book-6 {
                    right: 8%;
                    bottom: 22%;
                }
                

                
                .quick-links {
                    flex-wrap: wrap;
                    gap: 10px;
                }
                
                .section-title {
                    font-size: 2rem;
                }
                
                .email-form {
                    flex-direction: column;
                }
                
                .nav-link {
                    margin: 5px 0;
                }
            }
            
            
            #storeSubscriptionAlert {
                display: block !important;
                visibility: visible !important;
            }
            
            #storeSubscriptionAlert .alert {
                display: block !important;
                opacity: 1 !important;
                visibility: visible !important;
            }
            
            #storeSubmitSpinner {
                display: none;
            }
            
            #storeSubmitBtn:disabled {
                opacity: 0.7;
                cursor: not-allowed;
            }
            


            .nav-actions {
                display: flex;
                align-items: center;
                gap: 15px;
            }

            .nav-item.find-store-btn {
                background: #333333;
                color: #ffffff;
                padding: 8px 16px;
                border-radius: 20px;
                font-weight: 500;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
                transition: all 0.3s ease;
                font-size: 0.85rem;
            }

            .nav-item.find-store-btn:hover {
                background: #444444;
                transform: translateY(-1px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            }

            .nav-item.find-store-btn i {
                font-size: 0.8em;
                margin-right: 5px;
            }
        </style>
    </head>
    <body>


        
        <nav class="modern-navbar">
            <div class="nav-container">
                <div class="nav-brand">
                    <a href="#home" class="brand-logo">Pahana</a>
                </div>
                <div class="nav-menu">
                    <a href="#home" class="nav-item active">Home</a>
                    <a href="#categories" class="nav-item">Categories</a>
                    <a href="#about" class="nav-item">About</a>
                    <a href="#service" class="nav-item">Service</a>
                    <a href="#contact" class="nav-item">Contact</a>
                </div>
                <div class="nav-actions">
                    <a href="#" class="nav-item find-store-btn" onclick="showStoreSubscriptionForm(); return false;">
                        <i class="fas fa-store"></i>
                        <span>Find a Book Store</span>
                    </a>
                    <a href="login.jsp" class="nav-item login-btn">
                        <i class="fas fa-sign-in-alt"></i>
                        <span>Login</span>
                    </a>
                </div>
                <div class="nav-toggle" id="navToggle">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
            </div>
        </nav>

        
        <div class="mobile-nav-backdrop" id="mobileNavBackdrop"></div>

        
        <section id="home" class="hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <div class="hero-content">
                            
                            <div class="brand-logo-section mb-4">
                                <div class="brand-icon">
                                    <img src="<%= request.getContextPath() %>/IMG/pahana.png" alt="Pahana" style="width: 50px; height: 50px; border-radius: 12px; object-fit: contain; background: transparent;">
                                </div>
                                <h2 class="brand-name">Pahana</h2>
                            </div>
                            
                            
                            <h1 class="hero-headline mb-4">
                                Best Place to Find Your 
                                <span class="highlighted-text">Favorite</span> Books
                            </h1>
                            
                            
                            <p class="hero-description mb-4">
                                Discover millions of book titles with the best price offered here. 
                                Available for worldwide shipping and payment.
                            </p>
                            
                            
                            <div class="search-section mb-4">
                                <div class="search-container-hero">
                                    <div class="search-input-wrapper">
                                        <input type="text" class="search-input-hero" placeholder="Search">
                                    </div>
                                    <button class="search-btn-hero">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                            
                            
                            <div class="quick-links">
                                <a href="#" class="quick-link" onclick="shopNowComingSoon(); return false;">Best Seller</a>
                                <span class="separator">|</span>
                                <a href="#" class="quick-link" onclick="shopNowComingSoon(); return false;">Trending Items</a>
                                <span class="separator">|</span>
                                <a href="#" class="quick-link" onclick="shopNowComingSoon(); return false;">New Items</a>
                                <span class="separator">|</span>
                                <a href="#" class="quick-link" onclick="shopNowComingSoon(); return false;">Our Recommendation</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="book-covers-section">
                            
                            <div class="book-cover book-1">
                                <img src="https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                     alt="Love in Paris" class="book-cover-img">
                                <div class="book-info">
                                    <h4>Love in Paris.</h4>
                                    <p>Emily Stevenson</p>
                                </div>
                            </div>
                            
                            
                            <div class="book-cover book-2">
                                <img src="https://images.unsplash.com/photo-1589829085413-56de8ae18c73?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                     alt="THE JOURNEY" class="book-cover-img">
                                <div class="book-info">
                                    <h4>THE JOURNEY</h4>
                                    <p>ALEX TURNER</p>
                                </div>
                            </div>
                            
                            
                            <div class="book-cover book-3">
                                <img src="https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                     alt="Children Reading" class="book-cover-img">
                                <div class="book-info">
                                    <h4>Children's World</h4>
                                    <p>Sarah Johnson</p>
                                </div>
                            </div>
                            
                            
                            <div class="book-cover book-4">
                                <img src="https://images.unsplash.com/photo-1512820790803-83ca734da794?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                     alt="River of My Blood" class="book-cover-img">
                                <div class="book-info">
                                    <h4>River of My Blood</h4>
                                    <p>John Smith</p>
                                </div>
                            </div>
                            
                            
                            <div class="book-cover book-5">
                                <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                     alt="Bobi Puribar Age" class="book-cover-img">
                                <div class="book-info">
                                    <h4>Bobi Puribar Age</h4>
                                    <p>Humayun Ahmed</p>
                                </div>
                            </div>
                            
                            
                            <div class="book-cover book-6">
                                <img src="https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                     alt="The Great Adventure" class="book-cover-img">
                                <div class="book-info">
                                    <h4>The Great Adventure</h4>
                                    <p>Adventure Writer</p>
                                </div>
                            </div>
                            

                        </div>
                    </div>
                </div>
            </div>
        </section>

                 
         <section id="categories" class="py-5 bg-light">
            <div class="container-fluid px-4">
                <h2 class="section-title">Categories</h2>
                <div class="row g-4">
                    <%
                        // Import necessary classes and handle database connection
                        java.util.List<com.booking.models.BookCategory> categories = null;
                        try {
                            com.booking.dao.BookCategoryDAO bookCategoryDAO = new com.booking.dao.BookCategoryDAO();
                            categories = bookCategoryDAO.getAllBookCategories();
                        } catch (Exception e) {
                            // Log error but continue with fallback categories
                            System.err.println("Error loading book categories: " + e.getMessage());
                            // You could also add a user-friendly error message here
                        }
                        
                        // Define category icons mapping
                        java.util.Map<String, String> categoryIcons = new java.util.HashMap<>();
                        categoryIcons.put("arts", "fas fa-palette");
                        categoryIcons.put("photography", "fas fa-camera");
                        categoryIcons.put("food", "fas fa-utensils");
                        categoryIcons.put("drink", "fas fa-wine-glass");
                        categoryIcons.put("romance", "fas fa-heart");
                        categoryIcons.put("health", "fas fa-heartbeat");
                        categoryIcons.put("biography", "fas fa-user");
                        categoryIcons.put("fiction", "fas fa-book");
                        categoryIcons.put("science", "fas fa-flask");
                        categoryIcons.put("history", "fas fa-landmark");
                        categoryIcons.put("technology", "fas fa-laptop");
                        categoryIcons.put("business", "fas fa-briefcase");
                        categoryIcons.put("education", "fas fa-graduation-cap");
                        categoryIcons.put("children", "fas fa-child");
                        categoryIcons.put("mystery", "fas fa-search");
                        categoryIcons.put("thriller", "fas fa-exclamation-triangle");
                        categoryIcons.put("fantasy", "fas fa-magic");
                        categoryIcons.put("poetry", "fas fa-feather-alt");
                        categoryIcons.put("religion", "fas fa-pray");
                        categoryIcons.put("philosophy", "fas fa-brain");
                        categoryIcons.put("travel", "fas fa-plane");
                        categoryIcons.put("cooking", "fas fa-utensils");
                        categoryIcons.put("sports", "fas fa-futbol");
                        categoryIcons.put("music", "fas fa-music");
                        categoryIcons.put("art", "fas fa-palette");
                        categoryIcons.put("design", "fas fa-paint-brush");
                        categoryIcons.put("computer", "fas fa-desktop");
                        categoryIcons.put("programming", "fas fa-code");
                        categoryIcons.put("mathematics", "fas fa-calculator");
                        categoryIcons.put("physics", "fas fa-atom");
                        categoryIcons.put("chemistry", "fas fa-flask");
                        categoryIcons.put("biology", "fas fa-dna");
                        categoryIcons.put("medicine", "fas fa-stethoscope");
                        categoryIcons.put("psychology", "fas fa-brain");
                        categoryIcons.put("sociology", "fas fa-users");
                        categoryIcons.put("economics", "fas fa-chart-line");
                        categoryIcons.put("politics", "fas fa-balance-scale");
                        categoryIcons.put("law", "fas fa-gavel");
                        categoryIcons.put("architecture", "fas fa-building");
                        categoryIcons.put("engineering", "fas fa-cogs");
                        categoryIcons.put("automotive", "fas fa-car");
                        categoryIcons.put("aviation", "fas fa-plane");
                        categoryIcons.put("marine", "fas fa-ship");
                        categoryIcons.put("space", "fas fa-rocket");
                        categoryIcons.put("nature", "fas fa-leaf");
                        categoryIcons.put("animals", "fas fa-paw");
                        categoryIcons.put("gardening", "fas fa-seedling");
                        categoryIcons.put("crafts", "fas fa-hammer");
                        categoryIcons.put("hobbies", "fas fa-puzzle-piece");
                        
                        if (categories != null && !categories.isEmpty()) {
                            for (com.booking.models.BookCategory category : categories) {
                                String categoryName = category.getCategoryName().toLowerCase();
                                String iconClass = "fas fa-book"; // default icon
                                
                                // Find matching icon for category
                                for (java.util.Map.Entry<String, String> entry : categoryIcons.entrySet()) {
                                    if (categoryName.contains(entry.getKey())) {
                                        iconClass = entry.getValue();
                                        break;
                                    }
                                }
                    %>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="text-primary mb-3">
                                <i class="<%= iconClass %> fa-3x"></i>
                            </div>
                            <h4><%= category.getCategoryName() %></h4>
                            <small class="text-muted d-block mb-2">Browse Books</small>
                            <a href="#" class="text-primary text-decoration-none fw-bold" 
                               onclick="filterBooksByCategory('<%= category.getCategoryId() %>', '<%= category.getCategoryName() %>')">
                                Shop Now >
                            </a>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                            // Fallback to default categories if database is empty
                    %>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="text-primary mb-3">
                                <i class="fas fa-palette fa-3x"></i>
                            </div>
                            <h4>Arts & Photography</h4>
                            <a href="#" class="text-primary text-decoration-none fw-bold" onclick="shopNowComingSoon()">Shop Now ></a>
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="text-primary mb-3">
                                <i class="fas fa-utensils fa-3x"></i>
                            </div>
                            <h4>Food & Drink</h4>
                            <a href="#" class="text-primary text-decoration-none fw-bold" onclick="shopNowComingSoon()">Shop Now ></a>
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="text-primary mb-3">
                                <i class="fas fa-heart fa-3x"></i>
                            </div>
                            <h4>Romance</h4>
                            <a href="#" class="text-primary text-decoration-none fw-bold" onclick="shopNowComingSoon()">Shop Now ></a>
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="text-primary mb-3">
                                <i class="fas fa-heartbeat fa-3x"></i>
                            </div>
                            <h4>Health</h4>
                            <a href="#" class="text-primary text-decoration-none fw-bold" onclick="shopNowComingSoon()">Shop Now ></a>
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="text-primary mb-3">
                                <i class="fas fa-user fa-3x"></i>
                            </div>
                            <h4>Biography</h4>
                            <a href="#" class="text-primary text-decoration-none fw-bold" onclick="shopNowComingSoon()">Shop Now ></a>
                        </div>
                    </div>
                    <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6">
                        <div class="category-card">
                            <div class="text-primary mb-3">
                                <i class="fas fa-book fa-3x"></i>
                            </div>
                            <h4>Fiction</h4>
                            <a href="#" class="text-primary text-decoration-none fw-bold" onclick="shopNowComingSoon()">Shop Now ></a>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </section>

        
        <section class="py-5">
            <div class="container">
                <h2 class="section-title">Daily Deals</h2>
                <div class="row g-4">
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <div class="book-card">
                            <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                 alt="Book Cover" class="book-image">
                            <div class="book-info">
                                <h5 class="fw-bold">Bobi Puribar Age</h5>
                                <p class="text-muted">Humayun Ahmed</p>
                                <div class="text-warning mb-2">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                                                 <div class="fw-bold text-primary">LKR 1100</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <div class="book-card">
                            <img src="https://images.unsplash.com/photo-1543002588-bfa74002ed7e?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                 alt="Book Cover" class="book-image">
                            <div class="book-info">
                                <h5 class="fw-bold">Humayun Ahmed's Jibon O Sristi</h5>
                                <p class="text-muted">Humayun Ahmed</p>
                                <div class="text-warning mb-2">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                                                 <div class="fw-bold text-primary">LKR 1500</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <div class="book-card">
                            <img src="https://images.unsplash.com/photo-1589829085413-56de8ae18c73?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                 alt="Book Cover" class="book-image">
                            <div class="book-info">
                                <h5 class="fw-bold">Kazuo Ishiguro Never Let Me Go</h5>
                                <p class="text-muted">Kazuo Ishiguro</p>
                                <div class="text-warning mb-2">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                                                 <div class="fw-bold text-primary">LKR 2100</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <div class="book-card">
                            <img src="https://images.unsplash.com/photo-1512820790803-83ca734da794?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                 alt="Book Cover" class="book-image">
                            <div class="book-info">
                                <h5 class="fw-bold">River of My Blood</h5>
                                <p class="text-muted">John Smith</p>
                                <div class="text-warning mb-2">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                                                 <div class="fw-bold text-primary">LKR 1200</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <div class="book-card">
                            <img src="https://images.unsplash.com/photo-1481627834876-b7833e8f5570?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                 alt="Book Cover" class="book-image">
                            <div class="book-info">
                                <h5 class="fw-bold">Those Days</h5>
                                <p class="text-muted">Jane Doe</p>
                                <div class="text-warning mb-2">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                                                 <div class="fw-bold text-primary">LKR 2100</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4 col-sm-6">
                        <div class="book-card">
                            <img src="https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80" 
                                 alt="Book Cover" class="book-image">
                            <div class="book-info">
                                <h5 class="fw-bold">The Great Adventure</h5>
                                <p class="text-muted">Adventure Writer</p>
                                <div class="text-warning mb-2">
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                    <i class="fas fa-star"></i>
                                </div>
                                                                 <div class="fw-bold text-primary">LKR 3700</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

                 
         <section id="about" class="py-5 bg-light">
             <div class="container">
                 <div class="row align-items-center">
                     <div class="col-lg-6">
                         <h2 class="section-title text-start">About Pahana BookStore</h2>
                         <p class="lead">We are passionate about bringing the world's best literature to our readers. Since our establishment, we've been committed to providing quality books across all genres.</p>
                         <p>Our mission is to inspire, educate, and entertain through the power of books. We believe that every book has the potential to change a life, and we're here to help you discover your next favorite read.</p>
                         <a href="#service" class="btn-primary-custom" onclick="shopNowComingSoon(); return false;">Learn More</a>
                     </div>
                                          <div class="col-lg-6 text-center">
                          <img src="<%= request.getContextPath() %>/IMG/pahana.png" 
                               alt="Pahana" class="img-fluid rounded" style="max-width: 400px; height: auto;">
                      </div>
                 </div>
             </div>
         </section>

         
         <section id="service" class="py-5">
             <div class="container">
                 <h2 class="section-title">Our Services</h2>
                 <div class="row g-4">
                     <div class="col-lg-4 col-md-6">
                         <div class="service-card text-center p-4">
                             <div class="service-icon mb-3">
                                 <i class="fas fa-shipping-fast fa-3x text-primary"></i>
                             </div>
                             <h4>Fast Delivery</h4>
                             <p class="text-muted">Get your books delivered to your doorstep within 24-48 hours across Sri Lanka.</p>
                         </div>
                     </div>
                     <div class="col-lg-4 col-md-6">
                         <div class="service-card text-center p-4">
                             <div class="service-icon mb-3">
                                 <i class="fas fa-undo fa-3x text-primary"></i>
                             </div>
                             <h4>Easy Returns</h4>
                             <p class="text-muted">Not satisfied with your purchase? Return it within 7 days for a full refund.</p>
                         </div>
                     </div>
                     <div class="col-lg-4 col-md-6">
                         <div class="service-card text-center p-4">
                             <div class="service-icon mb-3">
                                 <i class="fas fa-headset fa-3x text-primary"></i>
                             </div>
                             <h4>24/7 Support</h4>
                             <p class="text-muted">Our customer support team is available round the clock to assist you.</p>
                         </div>
                     </div>
                     <div class="col-lg-4 col-md-6">
                         <div class="service-card text-center p-4">
                             <div class="service-icon mb-3">
                                 <i class="fas fa-gift fa-3x text-primary"></i>
                             </div>
                             <h4>Gift Wrapping</h4>
                             <p class="text-muted">Beautiful gift wrapping service available for all your book purchases.</p>
                         </div>
                     </div>
                     <div class="col-lg-4 col-md-6">
                         <div class="service-card text-center p-4">
                             <div class="service-icon mb-3">
                                 <i class="fas fa-bookmark fa-3x text-primary"></i>
                             </div>
                             <h4>Book Recommendations</h4>
                             <p class="text-muted">Personalized book recommendations based on your reading preferences.</p>
                         </div>
                     </div>
                     <div class="col-lg-4 col-md-6">
                         <div class="service-card text-center p-4">
                             <div class="service-icon mb-3">
                                 <i class="fas fa-users fa-3x text-primary"></i>
                             </div>
                             <h4>Book Clubs</h4>
                             <p class="text-muted">Join our online book clubs and discuss your favorite reads with fellow book lovers.</p>
                         </div>
                     </div>
                 </div>
             </div>
         </section>

        
        <section id="contact" class="py-5">
            <div class="container">
                <h2 class="section-title">Contact Us</h2>
                <div class="row">
                    <div class="col-lg-6">
                        <h4>Get in Touch</h4>
                        <p>Have questions? We'd love to hear from you. Send us a message and we'll respond as soon as possible.</p>
                        <div class="mt-4">
                            <h5><i class="fas fa-map-marker-alt text-primary me-2"></i>Address</h5>
                            <p>158, Saddnathar Road, Nallur, Jaffna</p>
                            
                            <h5><i class="fas fa-phone text-primary me-2"></i>Phone</h5>
                            <p>+94 76 594 7337 | 021 221 1270</p>
                            
                            <h5><i class="fas fa-envelope text-primary me-2"></i>Email</h5>
                            <p>pahanabookstore@gmail.com</p>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <form id="contactForm" onsubmit="submitContactForm(event)">
                            <div class="mb-3">
                                <input type="text" class="form-control" id="contactName" name="name" placeholder="Your Name" required>
                            </div>
                            <div class="mb-3">
                                <input type="email" class="form-control" id="contactEmail" name="email" placeholder="Your Email" required>
                            </div>
                            <div class="mb-3">
                                <input type="text" class="form-control" id="contactSubject" name="subject" placeholder="Subject" required>
                            </div>
                            <div class="mb-3">
                                <textarea class="form-control" id="contactMessage" name="message" rows="5" placeholder="Your Message" required></textarea>
                            </div>
                            <button type="submit" class="btn-primary-custom" id="submitBtn">
                                <span id="submitText">Send Message</span>
                                <span id="submitSpinner" style="display: none;">
                                    <i class="fas fa-spinner fa-spin me-2"></i>Sending...
                                </span>
                            </button>
                        </form>
                        <div id="contactAlert" class="mt-3" style="display: none;"></div>
                    </div>
                </div>
            </div>
        </section>

        
        <footer class="footer">
            <div class="container">
                <div class="row g-4">
                    <div class="col-lg-3 col-md-6">
                        <h5>Address</h5>
                        <p>158, Saddnathar Road, Nallur, Jaffna</p>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5>Important Links</h5>
                        <ul class="footer-links">
                            <li><a href="#">Cart</a></li>
                            <li><a href="login.jsp">Login</a></li>
                            <li><a href="#">My Account</a></li>
                            <li><a href="#">Order History</a></li>
                            <li><a href="#">Wishlist</a></li>
                            <li><a href="#">Track Order</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5>Support</h5>
                        <ul class="footer-links">
                            <li><a href="#">How to Pay</a></li>
                            <li><a href="#">How to PayPal</a></li>
                            <li><a href="#">FAQ</a></li>
                            <li><a href="#">Help Center</a></li>
                            <li><a href="#contact">Contact Us</a></li>
                            <li><a href="#">Live Chat</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5>Stay Connected</h5>
                        <p>Download our mobile app for the best shopping experience.</p>
                        <div class="mt-3">
                            <a href="#" class="btn btn-outline-light me-2">
                                <i class="fab fa-google-play me-1"></i>Google Play
                            </a>
                            <a href="#" class="btn btn-outline-light">
                                <i class="fab fa-apple me-1"></i>App Store
                            </a>
                        </div>
                    </div>
                </div>
                
                <div class="payment-methods">
                    <img src="https://cdn-icons-png.flaticon.com/512/349/349221.png" alt="Visa">
                    <img src="https://cdn-icons-png.flaticon.com/512/349/349228.png" alt="Mastercard">
                    <img src="https://cdn-icons-png.flaticon.com/512/2111/2111432.png" alt="PayPal">
                </div>
                
                <div class="copyright">
                    <p>&copy; Design by Purushorthaman MR. All rights reserved.</p>
                </div>
            </div>
        </footer>

        
        <div class="modal fade" id="storeSubscriptionModal" tabindex="-1" aria-labelledby="storeSubscriptionModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="storeSubscriptionModalLabel">Book Store Coming Soon!</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center mb-4">
                            <i class="fas fa-store fa-3x text-primary mb-3"></i>
                            <h4>Currently we are in process</h4>
                            <p class="text-muted">Subscribe to get updates when our book stores are available!</p>
                        </div>
                        <form id="storeSubscriptionForm">
                            <div class="mb-3">
                                <label for="storeEmail" class="form-label">Book Store Email Address</label>
                                <input type="email" class="form-control" id="storeEmail" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="storeName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="storeName" name="name" required>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary" id="storeSubmitBtn">
                                    <span id="storeSubmitText">Subscribe for Updates</span>
                                    <span id="storeSubmitSpinner" class="spinner-border spinner-border-sm ms-2" style="display: none;"></span>
                                </button>
                            </div>
                        </form>
                        <div id="storeSubscriptionAlert" class="mt-3"></div>
                    </div>
                </div>
            </div>
        </div>

        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
        
        
        <script>

            document.addEventListener('DOMContentLoaded', function() {
                const navToggle = document.getElementById('navToggle');
                const navMenu = document.querySelector('.nav-menu');
                const mobileBackdrop = document.getElementById('mobileNavBackdrop');
                
                if (navToggle && navMenu) {
                    navToggle.addEventListener('click', function() {
                        navMenu.classList.toggle('active');
                        if (mobileBackdrop) {
                            mobileBackdrop.classList.toggle('active');
                        }
                        

                        const spans = navToggle.querySelectorAll('span');
                        spans.forEach((span, index) => {
                            if (navMenu.classList.contains('active')) {
                                if (index === 0) span.style.transform = 'rotate(45deg) translate(5px, 5px)';
                                if (index === 1) span.style.opacity = '0';
                                if (index === 2) span.style.transform = 'rotate(-45deg) translate(7px, -6px)';
                            } else {
                                span.style.transform = 'none';
                                span.style.opacity = '1';
                            }
                        });
                    });
                    

                    if (mobileBackdrop) {
                        mobileBackdrop.addEventListener('click', function() {
                            navMenu.classList.remove('active');
                            mobileBackdrop.classList.remove('active');

                            const spans = navToggle.querySelectorAll('span');
                            spans.forEach(span => {
                                span.style.transform = 'none';
                                span.style.opacity = '1';
                            });
                        });
                    }
                    

                    const navItems = document.querySelectorAll('.nav-item');
                    navItems.forEach(item => {
                        item.addEventListener('click', function() {
                            if (window.innerWidth <= 768) {
                                navMenu.classList.remove('active');
                                if (mobileBackdrop) {
                                    mobileBackdrop.classList.remove('active');
                                }

                                const spans = navToggle.querySelectorAll('span');
                                spans.forEach(span => {
                                    span.style.transform = 'none';
                                    span.style.opacity = '1';
                                });
                            }
                        });
                    });
                    

                    document.addEventListener('click', function(e) {
                        if (!navToggle.contains(e.target) && !navMenu.contains(e.target)) {
                            navMenu.classList.remove('active');
                            if (mobileBackdrop) {
                                mobileBackdrop.classList.remove('active');
                            }
                            const spans = navToggle.querySelectorAll('span');
                            spans.forEach(span => {
                                span.style.transform = 'none';
                                span.style.opacity = '1';
                            });
                        }
                    });


                    window.addEventListener('resize', function() {
                        if (window.innerWidth > 768) {
                            navMenu.classList.remove('active');
                            if (mobileBackdrop) {
                                mobileBackdrop.classList.remove('active');
                            }
                            const spans = navToggle.querySelectorAll('span');
                            spans.forEach(span => {
                                span.style.transform = 'none';
                                span.style.opacity = '1';
                            });
                        }
                    });
                }
            });


            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });


            window.addEventListener('scroll', () => {
                let current = '';
                const sections = document.querySelectorAll('section[id]');
                
                sections.forEach(section => {
                    const sectionTop = section.offsetTop;
                    const sectionHeight = section.clientHeight;
                    if (scrollY >= (sectionTop - 200)) {
                        current = section.getAttribute('id');
                    }
                });

                document.querySelectorAll('.nav-item').forEach(link => {

                    if (link.classList.contains('login-btn')) return;
                    
                    link.classList.remove('active');
                    if (link.getAttribute('href') === `#${current}`) {
                        link.classList.add('active');
                    }
                });
            });


            function submitContactForm(event) {
                event.preventDefault();
                console.log('Contact form submitted!');
                

                

                const formData = new FormData(event.target);
                const name = formData.get('name');
                const email = formData.get('email');
                const subject = formData.get('subject');
                const message = formData.get('message');
                
                console.log('Form data:', { name, email, subject, message });
                

                if (!name || !email || !subject || !message) {
                    console.log('Validation failed: missing fields');
                    showContactAlert('Please fill in all fields.', 'danger');
                    return;
                }
                

                

                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    console.log('Validation failed: invalid email');
                    showContactAlert('Please enter a valid email address.', 'danger');
                    return;
                }
                

                
                console.log('Form validation passed, sending to server...');
                

                const submitBtn = document.getElementById('submitBtn');
                const submitText = document.getElementById('submitText');
                const submitSpinner = document.getElementById('submitSpinner');
                
                submitBtn.disabled = true;
                submitText.style.display = 'none';
                submitSpinner.style.display = 'inline';
                

                console.log('Sending request to ContactServlet...');
                fetch('ContactServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: new URLSearchParams(formData)
                })
                .then(response => {
                    console.log('Response received:', response);
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    console.log('Data received:', data);
                    if (data.success) {
                        showContactAlert(data.message, 'success');

                        document.getElementById('contactForm').reset();
                    } else {
                        showContactAlert(data.message, 'danger');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showContactAlert('An error occurred while sending your message. Please try again.', 'danger');
                })
                .finally(() => {

                    submitBtn.disabled = false;
                    submitText.style.display = 'inline';
                    submitSpinner.style.display = 'none';
                });
            }
            

            function showContactAlert(message, type) {
                console.log('Showing alert:', message, type);
                const alertDiv = document.getElementById('contactAlert');
                
                if (!alertDiv) {
                    console.error('Alert div not found!');
                    return;
                }
                
                alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
                alertDiv.innerHTML = `
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                `;
                alertDiv.style.display = 'block';
                
                console.log('Alert displayed:', alertDiv.style.display);
                

                setTimeout(() => {
                    if (alertDiv && alertDiv.parentElement) {
                        alertDiv.style.display = 'none';
                        console.log('Alert auto-hidden');
                    }
                }, 5000);
            }


            function filterBooksByCategory(categoryId, categoryName) {

                showComingSoonMessage('Category: ' + categoryName);
            }


            function shopNowComingSoon() {
                showComingSoonMessage('Shop Now');
            }


            function showComingSoonMessage(feature) {

                const overlay = document.createElement('div');
                overlay.style.cssText = `
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(0, 0, 0, 0.7);
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    z-index: 9999;
                    animation: fadeIn 0.3s ease;
                `;

                const messageBox = document.createElement('div');
                messageBox.style.cssText = `
                    background: white;
                    padding: 40px;
                    border-radius: 15px;
                    text-align: center;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                    max-width: 400px;
                    animation: slideIn 0.3s ease;
                `;

                messageBox.innerHTML = `
                    <div style="font-size: 4rem; color: #667eea; margin-bottom: 20px;">
                        <i class="fas fa-tools"></i>
                    </div>
                    <h3 style="color: #333; margin-bottom: 15px;">Coming Soon!</h3>
                    <p style="color: #666; margin-bottom: 25px;">The ${feature} feature is currently under development. We're working hard to bring you an amazing shopping experience!</p>
                    <button onclick="this.parentElement.parentElement.remove()" 
                            style="background: #667eea; color: white; border: none; padding: 12px 30px; border-radius: 25px; font-weight: 600; cursor: pointer; transition: background 0.3s ease;">
                        Got it!
                    </button>
                `;

                overlay.appendChild(messageBox);
                document.body.appendChild(overlay);


                const style = document.createElement('style');
                style.textContent = `
                    @keyframes fadeIn {
                        from { opacity: 0; }
                        to { opacity: 1; }
                    }
                    @keyframes slideIn {
                        from { transform: translateY(-50px); opacity: 0; }
                        to { transform: translateY(0); opacity: 1; }
                    }
                `;
                document.head.appendChild(style);


                overlay.addEventListener('click', function(e) {
                    if (e.target === overlay) {
                        overlay.remove();
                    }
                });


                setTimeout(() => {
                    if (overlay.parentElement) {
                        overlay.remove();
                    }
                }, 5000);
            }


            document.addEventListener('DOMContentLoaded', function() {
                

                const categoryCards = document.querySelectorAll('.category-card');
                categoryCards.forEach(card => {
                    card.addEventListener('mouseenter', function() {
                        this.style.transform = 'translateY(-10px) scale(1.02)';
                    });
                    
                    card.addEventListener('mouseleave', function() {
                        this.style.transform = 'translateY(0) scale(1)';
                    });
                });


                const footerLinks = document.querySelectorAll('.footer-links a, .footer .btn-outline-light');
                footerLinks.forEach(link => {
                    link.addEventListener('click', function(e) {
                        e.preventDefault();
                        const label = (this.textContent || 'This feature').trim();

                        showComingSoonMessage(label);
                    });
                });


                const visaLogo = document.querySelector('.footer img[src*="visa"]');
                const amexLogo = document.querySelector('.footer img[src*="amex"]');
                const githubLogo = document.querySelector('.footer img[src*="github"]');

                if (visaLogo) {
                    visaLogo.style.cursor = 'pointer';
                    visaLogo.addEventListener('click', function() {
                        showComingSoonMessage('Payment gateway not set');
                    });
                }

                if (amexLogo) {
                    amexLogo.style.cursor = 'pointer';
                    amexLogo.addEventListener('click', function() {
                        showComingSoonMessage('Payment gateway not set');
                    });
                }

                if (githubLogo) {
                    githubLogo.style.cursor = 'pointer';
                    githubLogo.addEventListener('click', function() {
                        window.open('https://github.com/PurushorthamanMR/Pahana.git', '_blank');
                    });
                }
            });


            function showStoreSubscriptionForm() {
                const modal = new bootstrap.Modal(document.getElementById('storeSubscriptionModal'));
                modal.show();
            }


            document.addEventListener('DOMContentLoaded', function() {
                const storeSubscriptionForm = document.getElementById('storeSubscriptionForm');
                if (storeSubscriptionForm) {
                    storeSubscriptionForm.addEventListener('submit', function(e) {
                        e.preventDefault();
                        console.log('Store subscription form submitted');
                        
                        const email = document.getElementById('storeEmail').value;
                        const name = document.getElementById('storeName').value;
                        
                        console.log('Form data:', { email, name });
                        
                        if (!email || !name) {
                            showStoreSubscriptionAlert('Please fill in all fields.', 'danger');
                            return;
                        }
                        

                        const submitBtn = document.getElementById('storeSubmitBtn');
                        const submitText = document.getElementById('storeSubmitText');
                        const submitSpinner = document.getElementById('storeSubmitSpinner');
                        
                        console.log('Button elements:', { submitBtn, submitText, submitSpinner });
                        
                        if (submitBtn && submitText && submitSpinner) {
                            submitBtn.disabled = true;
                            submitText.style.display = 'none';
                            submitSpinner.style.display = 'inline';
                            console.log('Loading state activated');
                        } else {
                            console.error('Button elements not found');
                        }
                        

                        console.log('Sending request to ContactServlet...');
                        fetch('ContactServlet', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: new URLSearchParams({
                                name: name,
                                email: email,
                                subject: 'Store Location Subscription',
                                message: 'I would like to be notified when book stores are available.'
                            })
                        })
                        .then(response => {
                            console.log('Response received:', response);
                            if (!response.ok) {
                                throw new Error(`HTTP error! status: ${response.status}`);
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log('Response data received:', data);
                            if (data.success) {
                                console.log('Success case - showing success alert');
                                showStoreSubscriptionAlert('Thank you for subscribing! We\'ll send you book store updates.', 'success');
                                storeSubscriptionForm.reset();
                            } else {
                                console.log('Error case - showing error alert');
                                showStoreSubscriptionAlert(data.message, 'danger');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            showStoreSubscriptionAlert('An error occurred while subscribing. Please try again.', 'danger');
                        })
                        .finally(() => {

                            if (submitBtn && submitText && submitSpinner) {
                                submitBtn.disabled = false;
                                submitText.style.display = 'inline';
                                submitSpinner.style.display = 'none';
                                console.log('Button state reset');
                            }
                        });
                    });
                } else {
                    console.error('Store subscription form not found');
                }
            });


             function showStoreSubscriptionAlert(message, type) {
                console.log('Showing store subscription alert:', message, type);
                const alertDiv = document.getElementById('storeSubscriptionAlert');
                
                if (!alertDiv) {
                    console.error('Alert div not found!');
                    return;
                }
                
                console.log('Alert div found, setting innerHTML');
                alertDiv.innerHTML = `
                    <div class="alert alert-${type} alert-dismissible fade show" role="alert" style="display: block !important;">
                        ${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                `;
                
                console.log('Alert HTML set, checking visibility');
                const alertElement = alertDiv.querySelector('.alert');
                if (alertElement) {
                    alertElement.style.display = 'block';
                    alertElement.style.opacity = '1';
                    console.log('Alert element display set to block and opacity to 1');
                }
                

                alertDiv.style.display = 'block';
                alertDiv.style.visibility = 'visible';
                

                setTimeout(() => {
                    if (alertDiv.firstChild) {
                        alertDiv.firstChild.remove();
                        console.log('Alert auto-hidden');
                    }
                }, 5000);
            }


            document.addEventListener('DOMContentLoaded', function() {

                const navLinks = document.querySelectorAll('.navbar-nav .nav-link[href^="#"]');
                const sections = document.querySelectorAll('section[id]');
                

                function updateActiveNavLink() {
                    const scrollPosition = window.scrollY + 100; 
                    
                    sections.forEach(section => {
                        const sectionTop = section.offsetTop;
                        const sectionHeight = section.offsetHeight;
                        const sectionId = section.getAttribute('id');
                        
                        if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {

                            navLinks.forEach(link => link.classList.remove('active'));
                            

                            const activeLink = document.querySelector(`.navbar-nav .nav-link[href="#${sectionId}"]`);
                            if (activeLink) {
                                activeLink.classList.add('active');
                            }
                        }
                    });
                }
                

                function handleNavLinkClick(e) {
                    const href = this.getAttribute('href');
                    
                    if (href.startsWith('#')) {
                        e.preventDefault();
                        const targetId = href.substring(1);
                        const targetSection = document.getElementById(targetId);
                        
                        if (targetSection) {

                            navLinks.forEach(link => link.classList.remove('active'));
                            

                            this.classList.add('active');
                            

                            targetSection.scrollIntoView({
                                behavior: 'smooth',
                                block: 'start'
                            });
                        }
                    }
                }
                

                navLinks.forEach(link => {
                    link.addEventListener('click', handleNavLinkClick);
                });
                

                window.addEventListener('scroll', updateActiveNavLink);
                

                updateActiveNavLink();
            });
        </script>
    </body>
</html>