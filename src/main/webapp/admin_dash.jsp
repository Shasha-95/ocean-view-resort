<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Dashboard | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --ocean-blue: #003366;
            --accent-gold: #c5a059;
            --bg-light: #f4f7f6;
            --white: #ffffff;
            --success-green: #28a745;
            --success-bg: #d4edda;
            --success-text: #155724;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(rgba(244, 247, 246, 0.85), rgba(244, 247, 246, 0.85)),
            url('images/oceanviewr.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .admin-container {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            width: 95%;
            max-width: 850px;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        /* Success Alert Styles */
        .success-alert {
            background-color: var(--success-bg);
            color: var(--success-text);
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 8px;
            border-left: 5px solid var(--success-green);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 600;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        h2 {
            color: var(--ocean-blue);
            margin-bottom: 10px;
            font-size: 2.2rem;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .subtitle {
            color: #7f8c8d;
            margin-bottom: 40px;
            font-weight: 300;
            border-bottom: 2px solid var(--accent-gold);
            display: inline-block;
            padding-bottom: 5px;
        }

        .button-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            margin-top: 20px;
        }

        .btn-card {
            background: var(--white);
            border: 1px solid #eee;
            padding: 40px 20px;
            border-radius: 12px;
            text-decoration: none;
            color: var(--ocean-blue);
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }

        .btn-card i {
            font-size: 3rem;
            color: var(--accent-gold);
        }

        .btn-card span {
            font-weight: 600;
            font-size: 1.1rem;
        }

        .btn-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0,51,102,0.15);
            background-color: var(--ocean-blue);
            color: white;
            border-color: var(--ocean-blue);
        }

        .btn-card:hover i {
            color: white;
        }

        .logout-section {
            margin-top: 40px;
            border-top: 1px solid #ddd;
            padding-top: 20px;
        }

        .logout-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #e74c3c;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: 0.3s;
        }

        .logout-btn:hover {
            color: #c0392b;
            transform: scale(1.05);
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .button-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<div class="admin-container">
    <%-- Success Message Alert Detection --%>
    <%
        String msg = request.getParameter("msg");
        if ("staff_added".equals(msg)) {
    %>
    <div class="success-alert">
        <i class="fas fa-check-circle"></i>
        New staff member has been registered successfully!
    </div>
    <% } %>

    <h2><i class="fas fa-hotel"></i> Ocean View Resort</h2>
    <div class="subtitle">System Administrator Management Portal</div>

    <div class="button-grid">
        <a href="add_staff.jsp" class="btn-card">
            <i class="fas fa-user-plus"></i>
            <span>Add New Staff</span>
        </a>

        <a href="manage_staff.jsp" class="btn-card">
            <i class="fas fa-users-gear"></i>
            <span>Manage Staff Accounts</span>
        </a>

        <a href="ReportServlet" class="btn-card">
            <i class="fas fa-file-pdf"></i>
            <span>Reservation Report</span>
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