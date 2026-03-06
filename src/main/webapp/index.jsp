<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login | Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>

<body class="login-body">

<div class="login-container">
    <i class="fas fa-umbrella-beach" style="font-size: 3rem; color: var(--primary-blue); margin-bottom: 15px;"></i>
    <h2>Ocean View Resort</h2>
    <p style="color: #666; margin-bottom: 25px; font-size: 0.9rem;">Staff & Admin Reservation System</p>

    <form action="LoginServlet" method="post">
        <div style="text-align: left;">
            <label style="font-size: 0.8rem; font-weight: bold; color: var(--primary-blue); margin-left: 5px;">Username</label>
            <input type="text" name="username" placeholder="" required>

            <label style="font-size: 0.8rem; font-weight: bold; color: var(--primary-blue); margin-left: 5px;">Password</label>
            <input type="password" name="password" placeholder="••••••••" required>
        </div>

        <button type="submit">Sign In</button>
    </form>

    <%-- Error Message Display --%>
    <% if(request.getAttribute("error") != null) { %>
    <div style="margin-top: 15px; padding: 10px; background: rgba(217, 83, 79, 0.1); border-radius: 5px;">
        <p style="color: var(--danger); font-size: 0.85rem; margin: 0;">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
        </p>
    </div>
    <% } %>

    <div style="margin-top: 25px; font-size: 0.8rem; color: #888;">
        &copy; 2026 Ocean View Resort
    </div>
</div>

</body>
</html>