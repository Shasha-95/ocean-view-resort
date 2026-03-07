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
            --danger-red: #e74c3c;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-light);
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(rgba(244, 247, 246, 0.85), rgba(244, 247, 246, 0.85)),
            url('images/oceanviewr.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .staff-container {
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(15px);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            width: 90%;
            max-width: 1000px;
            text-align: center;
            border: 1px solid rgba(255,255,255,0.3);
        }

        /* --- UNIFIED ALERT STYLES --- */
        .alert-box {
            padding: 20px;
            margin-bottom: 25px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            text-align: left;
            gap: 15px;
            animation: fadeInDown 0.6s ease-out;
        }

        /* Register Success (Green) */
        .success { background: #e6fffa; border: 1px solid #38b2ac; border-left: 6px solid #319795; color: #234e52; }
        .success .icon-circle { background: #319795; }

        /* Update (Blue) */
        .info { background: #ebf8ff; border: 1px solid #4299e1; border-left: 6px solid #2b6cb0; color: #2c5282; }
        .info .icon-circle { background: #2b6cb0; }

        /* Delete (Red) */
        .danger { background: #fff5f5; border: 1px solid #feb2b2; border-left: 6px solid #e53e3e; color: #742a2a; }
        .danger .icon-circle { background: #e53e3e; }

        .icon-circle {
            color: white;
            min-width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        .message-content {
            display: flex;
            flex-direction: column;
        }

        .message-content strong { font-size: 1.1rem; }
        .message-content span { font-size: 0.9rem; opacity: 0.9; }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h2 {
            color: var(--ocean-blue);
            margin-bottom: 10px;
            font-size: 2.2rem;
            text-transform: uppercase;
            letter-spacing: 3px;
        }

        .welcome-text {
            color: #444;
            margin-bottom: 35px;
            font-size: 1.2rem;
        }

        .welcome-text strong {
            color: var(--accent-gold);
            border-bottom: 1px solid var(--accent-gold);
        }

        .button-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .btn-card {
            background: var(--white);
            border: 1px solid rgba(0,0,0,0.05);
            padding: 25px 15px;
            border-radius: 15px;
            text-decoration: none;
            color: var(--ocean-blue);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 12px;
        }

        .btn-card i {
            font-size: 2.2rem;
            color: var(--accent-gold);
        }

        .btn-card span {
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: capitalize;
        }

        .btn-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 25px rgba(0,51,102,0.2);
            background-color: var(--ocean-blue);
            color: white;
        }

        .btn-card:hover i {
            color: var(--white);
            transform: scale(1.1);
        }

        .btn-card.delete-action:hover {
            background-color: var(--danger-red);
        }

        .logout-section {
            margin-top: 40px;
            padding-top: 25px;
            border-top: 1px solid rgba(0,0,0,0.1);
        }

        .logout-btn {
            color: var(--danger-red);
            text-decoration: none;
            font-weight: bold;
            font-size: 1rem;
            padding: 10px 20px;
            border-radius: 30px;
            transition: 0.3s;
            display: inline-block;
        }

        .logout-btn:hover {
            background: rgba(231, 76, 60, 0.1);
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="staff-container">

    <%-- DYNAMIC STATUS ALERTS --%>
    <%
        String msg = request.getParameter("msg");
        if ("success".equals(msg)) {
    %>
    <div class="alert-box success">
        <div class="icon-circle"><i class="fas fa-check"></i></div>
        <div class="message-content">
            <strong>Reservation Confirmed!</strong>
            <span>The guest has been successfully added to the Ocean View Resort database.</span>
        </div>
    </div>
    <% } else if ("updated".equals(msg)) { %>
    <div class="alert-box info">
        <div class="icon-circle"><i class="fas fa-sync-alt"></i></div>
        <div class="message-content">
            <strong>Update Complete!</strong>
            <span>The reservation details have been updated successfully in the system.</span>
        </div>
    </div>
    <% } else if ("deleted".equals(msg)) { %>
    <div class="alert-box danger">
        <div class="icon-circle"><i class="fas fa-trash-alt"></i></div>
        <div class="message-content">
            <strong>Booking Deleted!</strong>
            <span>The reservation has been permanently removed from the system.</span>
        </div>
    </div>
    <% } %>

    <h2><i class="fas fa-concierge-bell"></i> Staff Portal</h2>
    <p class="welcome-text">Logged in as: <strong>${userFullName}</strong></p>

    <div class="button-grid">
        <a href="register_guest.jsp" class="btn-card">
            <i class="fas fa-user-plus"></i>
            <span>Register Guest</span>
        </a>

        <a href="search_booking.jsp" class="btn-card">
            <i class="fas fa-search"></i>
            <span>Search Booking</span>
        </a>

        <a href="update_booking.jsp" class="btn-card">
            <i class="fas fa-edit"></i>
            <span>Update Booking</span>
        </a>

        <a href="delete_booking.jsp" class="btn-card delete-action">
            <i class="fas fa-trash-alt"></i>
            <span>Delete Booking</span>
        </a>

        <a href="calculate_bill.jsp" class="btn-card">
            <i class="fas fa-file-invoice-dollar"></i>
            <span>Billing & Invoice</span>
        </a>

        <a href="help.jsp" class="btn-card">
            <i class="fas fa-question-circle"></i>
            <span>System Help</span>
        </a>
    </div>

    <div class="logout-section">
        <a href="LogoutServlet" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Secure Logout
        </a>
    </div>
</div>

</body>
</html>