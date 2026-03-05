<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Staff | Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="navbar">
    <h1>Ocean View Resort - Admin</h1>
    <a href="admin_dash.jsp" class="back-btn">Back to Dashboard</a>
</div>

<div class="form-container">
    <h2>Add New Staff Member</h2>
    <form action="StaffServlet" method="post">
        <input type="hidden" name="action" value="add">

        <input type="text" name="staffId" placeholder="Staff ID (e.g., STF001)" required>
        <input type="text" name="fullName" placeholder="Full Name" required>
        <textarea name="address" placeholder="Address" required></textarea>
        <input type="email" name="email" placeholder="Email Address" required>
        <input type="text" name="mobile" placeholder="Mobile Number" required>
        <input type="text" name="username" placeholder="Login Username" required>
        <input type="password" name="password" placeholder="Login Password" required>

        <button type="submit" class="save-btn">Save Staff Member</button>
    </form>

    <% if(request.getParameter("msg") != null) { %>
    <p class="success-msg">Staff member added successfully!</p>
    <% } %>
</div>
</body>
</html>