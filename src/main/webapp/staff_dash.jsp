<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Security Check: Only allow logged-in Staff or Admin
    if (session.getAttribute("role") == null) {
        response.sendRedirect("index.jsp");
    }
%>
<html>
<head>
    <title>Staff Dashboard | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root {
            --ocean-blue: #003366;
            --accent-gold: #c5a059;
            --bg-light: #f4f7f6;
            --white: #ffffff;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-light);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            /* Using the same background image for a seamless transition */
            background: linear-gradient(rgba(244, 247, 246, 0.85), rgba(244, 247, 246, 0.85)),
            url('images/oceanviewr.jpg');
            background-size: cover;
            background-position: center;
        }

        .staff-container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 90%;
            max-width: 900px;
            text-align: center;
        }

        h2 {
            color: var(--ocean-blue);
            margin-bottom: 10px;
            font-size: 2rem;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .welcome-text {
            color: #555;
            margin-bottom: 35px;
            font-size: 1.1rem;
        }

        .welcome-text strong {
            color: var(--accent-gold);
        }

        .button-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .btn-card {
            background: var(--white);
            border: 1px solid #eee;
            padding: 30px 20px;
            border-radius: 12px;
            text-decoration: none;
            color: var(--ocean-blue);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }

        .btn-card i {
            font-size: 2.5rem;
            color: var(--accent-gold);
        }

        .btn-card span {
            font-weight: 600;
            font-size: 1rem;
        }

        .btn-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 20px rgba(0,51,102,0.15);
            background-color: var(--ocean-blue);
            color: white;
        }

        .btn-card:hover i {
            color: white;
        }

        .logout-section {
            margin-top: 35px;
            border-top: 1px solid #ddd;
            padding-top: 20px;
        }

        .logout-btn {
            color: #e74c3c;
            text-decoration: none;
            font-weight: bold;
            font-size: 0.9rem;
            transition: 0.3s;
        }

        .logout-btn:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="staff-container">
    <h2><i class="fas fa-concierge-bell"></i> Staff Portal</h2>
    <p class="welcome-text">Welcome back, <strong>${userFullName}</strong></p>

    <div class="button-grid">
        <a href="register_guest.jsp" class="btn-card">
            <i class="fas fa-user-check"></i>
            <span>Register Guest</span>
        </a>

        <a href="search_booking.jsp" class="btn-card">
            <i class="fas fa-search-location"></i>
            <span>Manage Bookings</span>
        </a>

        <a href="calculate_bill.jsp" class="btn-card">
            <i class="fas fa-file-invoice-dollar"></i>
            <span>Billing & Invoice</span>
        </a>

        <a href="help.jsp" class="btn-card">
            <i class="fas fa-info-circle"></i>
            <span>System Help</span>
        </a>
    </div>

    <div class="logout-section">
        <a href="LogoutServlet" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Exit System
        </a>
    </div>
</div>

</body>
</html>