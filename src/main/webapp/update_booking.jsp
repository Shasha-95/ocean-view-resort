<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.oceanview.util.DBConnection" %>
<html>
<head>
    <title>Update Booking | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0;
            background: linear-gradient(rgba(244, 247, 246, 0.85), rgba(244, 247, 246, 0.85)), url('images/oceanviewr.jpg');
            background-size: cover; background-position: center;
        }
        .update-container {
            background: rgba(255, 255, 255, 0.95); padding: 35px; border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1); width: 95%; max-width: 700px;
        }
        .search-section { border-bottom: 1px solid #eee; margin-bottom: 25px; padding-bottom: 20px; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; text-align: left; }
        .full { grid-column: span 2; }
        label { font-weight: bold; color: #003366; font-size: 0.85rem; }
        input, select { padding: 10px; border: 1px solid #ddd; border-radius: 5px; width: 100%; margin-top: 5px; }
        .btn-update { background: #c5a059; color: white; border: none; padding: 15px; width: 100%; border-radius: 5px; margin-top: 20px; cursor: pointer; font-weight: bold; }
    </style>
</head>
<body>

<div class="update-container">
    <a href="staff_dash.jsp" style="text-decoration: none; color: #003366;"><i class="fas fa-arrow-left"></i> Back</a>
    <h2 style="color: #003366; text-align: center;"><i class="fas fa-edit"></i> Update Reservation</h2>

    <div class="search-section">
        <form action="update_booking.jsp" method="get" style="display: flex; gap: 10px;">
            <input type="number" name="resId" placeholder="Enter Reservation Number to Update" required>
            <button type="submit" style="background:#003366; color:white; border:none; padding:10px 20px; border-radius:5px; cursor:pointer;">Fetch Data</button>
        </form>
    </div>

    <%
        String resId = request.getParameter("resId");
        if (resId != null) {
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT * FROM reservations WHERE reservation_number = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(resId));
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
    %>
    <form action="BookingServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="reservation_number" value="<%= rs.getInt("reservation_number") %>">

        <div class="form-grid">
            <div class="full">
                <label>Guest Full Name</label>
                <input type="text" name="guest_name" value="<%= rs.getString("guest_name") %>" required>
            </div>
            <div class="full">
                <label>Address</label>
                <input type="text" name="address" value="<%= rs.getString("address") %>">
            </div>
            <div>
                <label>Country</label>
                <input type="text" name="country" value="<%= rs.getString("country") %>">
            </div>
            <div>
                <label>Contact Number</label>
                <input type="text" name="contact" value="<%= rs.getString("contact_number") %>">
            </div>
            <div>
                <label>Check-In Date</label>
                <input type="date" name="check_in" value="<%= rs.getDate("check_in_date") %>" required>
            </div>
            <div>
                <label>Check-Out Date</label>
                <input type="date" name="check_out" value="<%= rs.getDate("check_out_date") %>" required>
            </div>
        </div>
        <button type="submit" class="btn-update">Save Changes</button>
    </form>
    <%
                } else {
                    out.println("<p style='color:red; text-align:center;'>Reservation #" + resId + " not found.</p>");
                }
            } catch (Exception e) { e.printStackTrace(); }
        }
    %>
</div>

</body>
</html>