<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.oceanview.util.DBConnection" %>
<html>
<head>
    <title>Search Booking | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0;
            background: linear-gradient(rgba(244, 247, 246, 0.85), rgba(244, 247, 246, 0.85)), url('images/oceanviewr.jpg');
            background-size: cover; background-position: center;
        }
        .search-container {
            background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(10px);
            padding: 35px; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 90%; max-width: 600px; text-align: center;
        }
        .search-box { display: flex; gap: 10px; margin-bottom: 30px; }
        input[type="number"] { flex: 1; padding: 12px; border: 1px solid #ddd; border-radius: 8px; font-size: 1rem; }
        .btn-search { background: #003366; color: white; border: none; padding: 12px 25px; border-radius: 8px; cursor: pointer; font-weight: bold; }

        .result-card {
            text-align: left; background: #f9f9f9; padding: 20px; border-radius: 10px; border-left: 5px solid #c5a059;
            animation: fadeIn 0.5s ease;
        }
        .result-item { margin-bottom: 10px; font-size: 0.95rem; color: #333; }
        .result-item strong { color: #003366; width: 150px; display: inline-block; }
        .no-result { color: #e74c3c; font-weight: bold; margin-top: 20px; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

<div class="search-container">
    <a href="staff_dash.jsp" style="text-decoration: none; color: #003366; float: left;"><i class="fas fa-arrow-left"></i> Back</a>
    <h2 style="color: #003366; margin-bottom: 25px;">Search Reservation</h2>

    <form action="search_booking.jsp" method="get" class="search-box">
        <input type="number" name="resId" placeholder="Enter Reservation Number (e.g., 101)" required>
        <button type="submit" class="btn-search"><i class="fas fa-search"></i> Search</button>
    </form>

    <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">

    <%
        String resId = request.getParameter("resId");
        if (resId != null && !resId.trim().isEmpty()) {
            try (Connection conn = DBConnection.getConnection()) {
                // SQL to join reservations with room_types to show the name instead of just the ID
                String sql = "SELECT r.*, rt.type_name FROM reservations r " +
                        "JOIN room_types rt ON r.room_type_id = rt.room_type_id " +
                        "WHERE r.reservation_number = ?";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(resId));
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
    %>
    <div class="result-card">
        <h3 style="color: #c5a059; margin-top: 0;"><i class="fas fa-id-card"></i> Reservation Details</h3>
        <div class="result-item"><strong>Guest Name:</strong> <%= rs.getString("guest_name") %></div>
        <div class="result-item"><strong>Contact:</strong> <%= rs.getString("contact_number") %></div>
        <div class="result-item"><strong>Country:</strong> <%= rs.getString("country") %></div>
        <div class="result-item"><strong>Room Type:</strong> <%= rs.getString("type_name") %></div>
        <div class="result-item"><strong>Check-In:</strong> <%= rs.getDate("check_in_date") %></div>
        <div class="result-item"><strong>Check-Out:</strong> <%= rs.getDate("check_out_date") %></div>
        <div class="result-item"><strong>Address:</strong> <%= rs.getString("address") %></div>
    </div>
    <%
    } else {
    %>
    <p class="no-result"><i class="fas fa-exclamation-circle"></i> No reservation found with ID: <%= resId %></p>
    <%
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error connecting to database: " + e.getMessage() + "</p>");
                e.printStackTrace();
            }
        }
    %>
</div>

</body>
</html>