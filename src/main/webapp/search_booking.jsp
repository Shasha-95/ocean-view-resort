<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.oceanview.util.DBConnection" %>
<html>
<head>
    <title>Search Booking | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0;
            background: linear-gradient(rgba(244, 247, 246, 0.85), rgba(244, 247, 246, 0.85)), url('images/oceanviewr.jpg');
            background-size: cover; background-position: center; background-attachment: fixed;
            font-family: 'Segoe UI', sans-serif;
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
            text-align: left; background: #fff; padding: 25px; border-radius: 10px; border-left: 5px solid #c5a059;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); animation: fadeIn 0.5s ease;
        }
        .result-item { margin-bottom: 12px; font-size: 0.95rem; color: #333; border-bottom: 1px solid #f0f0f0; padding-bottom: 5px; }
        .result-item strong { color: #003366; width: 160px; display: inline-block; }

        .msg { padding: 15px; border-radius: 8px; margin-top: 20px; font-weight: bold; }
        .error { background: #fff5f5; color: #e74c3c; border: 1px solid #fed7d7; }

        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>
<body>

<div class="search-container">
    <div style="text-align: left; margin-bottom: 20px;">
        <a href="staff_dash.jsp" style="text-decoration: none; color: #003366; font-weight: bold;">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <h2 style="color: #003366; margin-bottom: 25px;"><i class="fas fa-search"></i> Search Reservation</h2>

    <form action="search_booking.jsp" method="get" class="search-box">
        <input type="number" name="resId" placeholder="Enter Reservation Number (e.g., 101)" required>
        <button type="submit" class="btn-search">Search</button>
    </form>

    <hr style="border: 0; border-top: 1px solid #eee; margin: 25px 0;">

    <%
        String resId = request.getParameter("resId");
        if (resId != null && !resId.trim().isEmpty()) {
            try (Connection conn = DBConnection.getConnection()) {
                // Corrected SQL: using room_type_name and price to match your schema
                String sql = "SELECT r.*, rt.room_type_name, rt.price " +
                        "FROM reservations r " +
                        "JOIN room_types rt ON r.room_type_id = rt.room_type_id " +
                        "WHERE r.reservation_number = ?";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(resId));
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
    %>
    <div class="result-card">
        <h3 style="color: #c5a059; margin-top: 0;"><i class="fas fa-id-card"></i> Booking Details</h3>
        <div class="result-item"><strong>Reservation #:</strong> <%= rs.getInt("reservation_number") %></div>
        <div class="result-item"><strong>Guest Name:</strong> <%= rs.getString("guest_name") %></div>
        <div class="result-item"><strong>Contact:</strong> <%= rs.getString("contact_number") %></div>
        <div class="result-item"><strong>Room Type:</strong> <%= rs.getString("room_type_name") %></div>
        <div class="result-item"><strong>Price per Night:</strong> LKR <%= String.format("%.2f", rs.getDouble("price")) %></div>
        <div class="result-item"><strong>Check-In:</strong> <%= rs.getDate("check_in_date") %></div>
        <div class="result-item"><strong>Check-Out:</strong> <%= rs.getDate("check_out_date") %></div>
        <div class="result-item"><strong>Country:</strong> <%= rs.getString("country") %></div>
        <div class="result-item"><strong>Address:</strong> <%= rs.getString("address") %></div>
    </div>
    <%
    } else {
    %>
    <div class="msg error"><i class="fas fa-exclamation-circle"></i> No reservation found with ID: <%= resId %></div>
    <%
        }
    } catch (SQLException e) {
    %>
    <div class="msg error">Database Error: <%= e.getMessage() %></div>
    <%
        e.printStackTrace();
    } catch (NumberFormatException e) {
    %>
    <div class="msg error">Invalid format. Please enter a numeric ID.</div>
    <%
            }
        }
    %>
</div>

</body>
</html>