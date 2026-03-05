<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Dashboard | Ocean View</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div class="navbar">
    <h1>Admin: Ocean View Resort</h1>
    <a href="../LogoutServlet" class="logout-btn">Exit</a>
</div>

<div class="container">
    <h3>Staff Management</h3>
    <div class="action-grid">
        <a href="add_staff.jsp" class="card">Add New Staff</a>
        <a href="manage_staff.jsp" class="card">Update/Delete Staff</a>
        <a href="../ReportServlet" class="card">Guest Reservation Report (PDF)</a>
    </div>
</div>
</body>
</html>