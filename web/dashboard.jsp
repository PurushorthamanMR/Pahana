<%-- 
    Document   : dashboard
    Created on : Aug 3, 2025, 9:08:48 AM
    Author     : pruso
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.booking.patterns.FacadeDP"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pahana - Dashboard</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }

            .dashboard-container {
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar Styles */
            .sidebar {
                width: 280px;
                background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
                color: white;
                padding: 0;
                position: fixed;
                height: 100vh;
                overflow-y: auto;
                z-index: 1000;
            }

            .sidebar-header {
                padding: 2rem 1.5rem;
                border-bottom: 1px solid rgba(255,255,255,0.1);
                text-align: center;
            }

            .logo {
                font-size: 1.8rem;
                font-weight: 700;
                color: white;
                text-decoration: none;
            }

            .logo:hover {
                color: #ffd700;
                text-decoration: none;
            }

            .nav-menu {
                padding: 1rem 0;
                flex-grow: 1;
            }

            .nav-item {
                margin: 0.5rem 1rem;
            }

            .nav-link {
                display: flex;
                align-items: center;
                padding: 0.75rem 1rem;
                color: rgba(255,255,255,0.8);
                text-decoration: none;
                border-radius: 8px;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .nav-link:hover {
                background: rgba(255,255,255,0.1);
                color: white;
                text-decoration: none;
            }

            .nav-link.active {
                background: rgba(255,255,255,0.2);
                color: white;
                border-left: 4px solid #ffd700;
            }



            .nav-link i {
                margin-right: 0.75rem;
                font-size: 1.1rem;
                width: 20px;
            }

            .sidebar-footer {
                padding: 1rem 1.5rem;
                border-top: 1px solid rgba(255,255,255,0.1);
                margin-top: auto;
            }

            .logout-btn {
                width: 100%;
                background: rgba(255,255,255,0.1);
                border: 1px solid rgba(255,255,255,0.2);
                color: white;
                padding: 0.75rem 1rem;
                border-radius: 8px;
                text-decoration: none;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
            }

            .logout-btn:hover {
                background: rgba(255,255,255,0.2);
                color: white;
                text-decoration: none;
            }

            /* Main Content Styles */
            .main-content {
                flex: 1;
                margin-left: 280px;
                padding: 2rem;
            }

            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 2rem;
                padding: 1rem 0;
            }

            .header-left {
                display: flex;
                align-items: center;
            }

            .menu-toggle {
                background: none;
                border: none;
                font-size: 1.5rem;
                color: #333;
                margin-right: 1rem;
                cursor: pointer;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-weight: 600;
            }

            /* Dashboard Cards */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .stat-card {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                border-left: 4px solid #667eea;
            }

            .stat-card.success {
                border-left-color: #28a745;
            }

            .stat-card.warning {
                border-left-color: #ffc107;
            }

            .stat-card.danger {
                border-left-color: #dc3545;
            }

            .stat-card.info {
                border-left-color: #17a2b8;
            }

            .stat-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 1rem;
            }

            .stat-title {
                font-size: 0.9rem;
                color: #6c757d;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .stat-icon {
                width: 40px;
                height: 40px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
                color: white;
            }

            .stat-value {
                font-size: 2rem;
                font-weight: 700;
                color: #333;
                margin-bottom: 0.5rem;
            }

            .stat-change {
                display: flex;
                align-items: center;
                font-size: 0.9rem;
                font-weight: 600;
            }

            .stat-change.positive {
                color: #28a745;
            }

            .stat-change.negative {
                color: #dc3545;
            }

            /* Charts Section */
            .charts-section {
                display: grid;
                grid-template-columns: 1fr;
                gap: 1.5rem;
                margin-bottom: 2rem;
            }

            .chart-card {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            .chart-title {
                font-size: 1.2rem;
                font-weight: 600;
                color: #333;
                margin-bottom: 1rem;
            }

            /* Chart Styles */
            .chart-container {
                position: relative;
                margin: 1rem 0;
            }
            
            .chart-card {
                background: white;
                border-radius: 12px;
                padding: 1.5rem;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                margin-bottom: 2rem;
            }

            /* Responsive Design */
            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                }

                .sidebar.show {
                    transform: translateX(0);
                }

                .main-content {
                    margin-left: 0;
                }

                .charts-section {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <%
            // Get user role from session
            String role = (String) session.getAttribute("role");
            String username = (String) session.getAttribute("username");
            
            if (role == null || username == null) {
                response.sendRedirect("login.jsp?error=Please login first.");
                return;
            }
            
            // Load dashboard statistics if not already loaded
            if (request.getAttribute("dashboardStats") == null) {
                try {
                    // Try to load data directly if servlet fails
                    FacadeDP facade = new FacadeDP();
                    FacadeDP.DashboardStats stats = facade.getDashboardStats();
                    request.setAttribute("dashboardStats", stats);
                } catch (Exception e) {
                    // If direct loading fails, redirect to servlet
                    response.sendRedirect("DashboardServlet");
                    return;
                }
            }
            
            // Set current page for sidebar highlighting
            request.setAttribute("currentPage", "dashboard");
        %>

        <div class="dashboard-container">
            <!-- Sidebar -->
            <jsp:include page="includes/sidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <!-- Header -->
                <div class="header">
                    <div class="header-left">
                        <button class="menu-toggle" onclick="toggleSidebar()">
                            <i class="bi bi-list"></i>
                        </button>
                        <h1 class="h3 mb-0">Dashboard</h1>
                    </div>
                    <div class="user-info">
                        <span>Welcome, <%= username %> (<%= role %>)</span>
                        <div class="user-avatar">
                            <i class="bi bi-person"></i>
                        </div>
                    </div>
                </div>

                <!-- Stats Cards -->
                <div class="stats-grid">
                    <%
                        FacadeDP.DashboardStats stats = (FacadeDP.DashboardStats) request.getAttribute("dashboardStats");
                        if (stats == null) {
                            stats = new FacadeDP.DashboardStats();
                        }
                    %>
                    <div class="stat-card success">
                        <div class="stat-header">
                            <span class="stat-title">Total Books</span>
                            <div class="stat-icon" style="background: #28a745;">
                                <i class="bi bi-book"></i>
                            </div>
                        </div>
                        <div class="stat-value"><%= stats.getTotalBooks() %></div>
                        <div class="stat-change positive">
                            <i class="bi bi-arrow-up me-1"></i>
                            Books in stock
                        </div>
                    </div>

                    <div class="stat-card info">
                        <div class="stat-header">
                            <span class="stat-title">Total Sales</span>
                            <div class="stat-icon" style="background: #17a2b8;">
                                <i class="bi bi-currency-dollar"></i>
                            </div>
                        </div>
                        <div class="stat-value"><%= stats.getTotalTransactions() %></div>
                        <div class="stat-change positive">
                            <i class="bi bi-arrow-up me-1"></i>
                            Transactions completed
                        </div>
                    </div>

                    <div class="stat-card warning">
                        <div class="stat-header">
                            <span class="stat-title">Total Customers</span>
                            <div class="stat-icon" style="background: #ffc107;">
                                <i class="bi bi-people"></i>
                            </div>
                        </div>
                        <div class="stat-value"><%= stats.getTotalCustomers() %></div>
                        <div class="stat-change positive">
                            <i class="bi bi-arrow-up me-1"></i>
                            Registered customers
                        </div>
                    </div>

                    <div class="stat-card danger">
                        <div class="stat-header">
                            <span class="stat-title">Total Users</span>
                            <div class="stat-icon" style="background: #dc3545;">
                                <i class="bi bi-person-gear"></i>
                            </div>
                        </div>
                        <div class="stat-value"><%= stats.getTotalUsers() %></div>
                        <div class="stat-change positive">
                            <i class="bi bi-arrow-up me-1"></i>
                            System users
                        </div>
                    </div>
                </div>

                <!-- Charts Section -->
                <div class="charts-section">
                    <div class="chart-card">
                        <h3 class="chart-title">
                            <i class="bi bi-graph-up me-2"></i>Transaction Sales (Last 30 Days)
                        </h3>
                        <div class="chart-container" style="position: relative; height: 300px;">
                            <canvas id="salesChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Toggle sidebar on mobile
            function toggleSidebar() {
                const sidebar = document.getElementById('sidebar');
                sidebar.classList.toggle('show');
            }

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(event) {
                const sidebar = document.getElementById('sidebar');
                const menuToggle = document.querySelector('.menu-toggle');
                
                if (window.innerWidth <= 768) {
                    if (!sidebar.contains(event.target) && !menuToggle.contains(event.target)) {
                        sidebar.classList.remove('show');
                    }
                }
            });

            // Load and display sales chart
            let salesChart;
            
            function loadSalesChart() {
                fetch('ChartServlet?action=transactionSales')
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            createSalesChart(data.labels, data.data);
                        } else {
                            console.error('Error loading chart data:', data.error);
                            // Show fallback chart with sample data
                            createSalesChart(['No Data'], [0]);
                        }
                    })
                    .catch(error => {
                        console.error('Error fetching chart data:', error);
                        // Show fallback chart with sample data
                        createSalesChart(['No Data'], [0]);
                    });
            }
            
            function createSalesChart(labels, data) {
                const ctx = document.getElementById('salesChart').getContext('2d');
                
                if (salesChart) {
                    salesChart.destroy();
                }
                
                salesChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Daily Sales',
                            data: data,
                            borderColor: 'rgb(102, 126, 234)',
                            backgroundColor: 'rgba(102, 126, 234, 0.1)',
                            borderWidth: 3,
                            fill: true,
                            tension: 0.4,
                            pointBackgroundColor: 'rgb(102, 126, 234)',
                            pointBorderColor: '#fff',
                            pointBorderWidth: 2,
                            pointRadius: 6,
                            pointHoverRadius: 8
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top'
                            },
                            tooltip: {
                                mode: 'index',
                                intersect: false,
                                callbacks: {
                                    label: function(context) {
                                        return 'Sales: ' + context.parsed.y.toLocaleString();
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) {
                                        return value.toLocaleString();
                                    }
                                }
                            }
                        },
                        interaction: {
                            mode: 'nearest',
                            axis: 'x',
                            intersect: false
                        }
                    }
                });
            }
            
            // Load chart when page loads
            document.addEventListener('DOMContentLoaded', function() {
                loadSalesChart();
                
                // Refresh chart every 5 minutes for real-time updates
                setInterval(loadSalesChart, 300000);
            });
        </script>
    </body>
</html> 
