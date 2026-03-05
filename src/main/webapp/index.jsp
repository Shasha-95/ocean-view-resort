<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login | Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="login-body">
<div class="login-container">
    <h2>Ocean View Resort Reservation System</h2>
    <form action="LoginServlet" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Login</button>
    </form>
    <% if(request.getAttribute("error") != null) { %>
    <p style="color:red;"><%= request.getAttribute("error") %></p>
    <% } %>
</div>
</body>
</html>