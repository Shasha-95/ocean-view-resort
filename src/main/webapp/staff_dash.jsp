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
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="navbar">
    <h1>Ocean View Resort - Staff Portal</h1>
    <div class="user-info">
        <span>Welcome, ${username}</span>
        <a href="LogoutServlet" class="logout-btn">Exit</a>
    </div>
</div>

<div class="container">
    <h2>Reservation Management</h2>
    <div class="action-grid">
        <a href="register_guest.jsp" class="card">Register New Guest</a>
        <a href="search_booking.jsp" class="card">Search / Update Booking</a>
        <a href="calculate_bill.jsp" class="card">Calculate Bill & Invoice</a>
        <a href="help.jsp" class="card">Help Section</a>
    </div>
</div>
</body>
</html>