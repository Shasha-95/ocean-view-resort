<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.oceanview.util.DBConnection" %>
<html>
<head>
    <title>System Help | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(rgba(244, 247, 246, 0.9), rgba(244, 247, 246, 0.9)), url('images/oceanviewr.jpg');
            background-size: cover; background-attachment: fixed;
            display: flex; justify-content: center; align-items: flex-start; min-height: 100vh; margin: 0; padding-top: 50px;
        }
        .help-container {
            background: white; padding: 40px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 90%; max-width: 800px;
        }
        h2 { color: #003366; text-align: center; border-bottom: 2px solid #c5a059; padding-bottom: 15px; margin-bottom: 30px; }

        .help-item { margin-bottom: 15px; border: 1px solid #eee; border-radius: 8px; overflow: hidden; }
        .help-title {
            background: #f9f9f9; padding: 15px 20px; cursor: pointer; display: flex;
            justify-content: space-between; align-items: center; font-weight: bold; color: #003366;
            transition: 0.3s;
        }
        .help-title:hover { background: #003366; color: white; }
        .help-description {
            padding: 0 20px; max-height: 0; overflow: hidden; transition: max-height 0.3s ease-out;
            background: #fff; color: #555; line-height: 1.6;
        }
        .help-item.active .help-description { padding: 20px; max-height: 500px; }

        .back-btn { text-decoration: none; color: #003366; font-weight: bold; margin-bottom: 20px; display: inline-block; }
    </style>
</head>
<body>

<div class="help-container">
    <a href="staff_dash.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    <h2><i class="fas fa-question-circle"></i> System Support & FAQ</h2>

    <%
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM help_section")) {

            while(rs.next()) {
    %>
    <div class="help-item">
        <div class="help-title" onclick="this.parentElement.classList.toggle('active')">
            <span><%= rs.getString("title") %></span>
            <i class="fas fa-chevron-down"></i>
        </div>
        <div class="help-description">
            <%= rs.getString("description") %>
        </div>
    </div>
    <%
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error loading help content.</p>");
            e.printStackTrace();
        }
    %>
</div>

</body>
</html>