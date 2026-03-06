<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Staff | Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="navbar">
    <h1>Ocean View Resort - Admin</h1>
    <a href="admin_dash.jsp">Back to Dashboard</a>
</div>

<div class="container">
    <h2>Manage Staff Accounts</h2>

    <div class="form-container">
        <form action="StaffServlet" method="get">
            <input type="text" name="staffId" placeholder="Enter Staff ID (e.g. STF001)" required>
            <button type="submit" class="save-btn" style="background:#003d80;">Find Staff</button>
        </form>
    </div>

    <% if(request.getAttribute("staff") != null) { %>
    <div class="form-container">
        <h3>Edit Details for ${staff.staffId}</h3>
        <form action="StaffServlet" method="post">
            <input type="hidden" name="staffId" value="${staff.staffId}">

            <label>Full Name</label>
            <input type="text" name="fullName" value="${staff.fullName}" required>

            <label>Email Address</label>
            <input type="email" name="email" value="${staff.email}" required>

            <label>Mobile Number</label>
            <input type="text" name="mobile" value="${staff.mobile}" required>

            <div style="display: flex; gap: 10px;">
                <button type="submit" name="action" value="update" class="save-btn">Update Account</button>
                <button type="submit" name="action" value="delete" class="save-btn"
                        style="background: #d9534f;" onclick="return confirm('Are you sure you want to delete this account?')">Delete Account</button>
            </div>
        </form>
    </div>
    <% } %>

    <% if(request.getParameter("msg") != null) { %>
    <p class="success-msg">Operation successful!</p>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
    <p style="color: #d9534f; text-align: center; font-weight: bold;">${error}</p>
    <% } %>
</div>
</body>
</html>