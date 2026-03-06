<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.oceanview.util.DBConnection" %>
<html>
<head>
    <title>Guest Registration | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0;
            background: linear-gradient(rgba(244, 247, 246, 0.85), rgba(244, 247, 246, 0.85)), url('images/oceanviewr.jpg');
            background-size: cover; background-position: center; background-attachment: fixed;
        }
        .registration-card {
            background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(12px);
            padding: 40px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            width: 95%; max-width: 750px; border: 1px solid rgba(255,255,255,0.3);
        }
        h2 { color: #003366; text-align: center; border-bottom: 2px solid #c5a059; padding-bottom: 10px; margin-bottom: 25px; }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; text-align: left; }
        .full-width { grid-column: span 2; }
        label { font-weight: 700; color: #003366; font-size: 0.85rem; display: block; margin-bottom: 5px; }
        input, select { padding: 12px; border: 1px solid #ccc; border-radius: 8px; width: 100%; font-size: 1rem; }
        .btn-register {
            background: #003366; color: white; border: none; padding: 15px; width: 100%;
            border-radius: 8px; margin-top: 30px; cursor: pointer; font-weight: bold; font-size: 1.1rem;
        }
        .btn-register:hover { background: #00509d; transform: translateY(-2px); transition: 0.3s; }
    </style>
</head>
<body>

<div class="registration-card">
    <a href="staff_dash.jsp" style="text-decoration: none; color: #003366; font-weight: bold;"><i class="fas fa-arrow-left"></i> Back</a>
    <h2><i class="fas fa-concierge-bell"></i> New Guest Registration</h2>

    <form action="BookingServlet" method="post">
        <input type="hidden" name="action" value="register">

        <div class="form-grid">
            <div class="full-width">
                <label>Guest Full Name</label>
                <input type="text" name="guest_name" placeholder="" required>
            </div>

            <div class="full-width">
                <label>Address</label>
                <input type="text" name="address" placeholder="" required>
            </div>

            <div>
                <label>Country</label>
                <input type="text" name="country" placeholder="" required>
            </div>

            <div>
                <label>Contact Number</label>
                <input type="tel" name="contact" placeholder="  " required>
            </div>

            <div class="full-width">
                <label>Room Category</label>
                <select name="room_type_id" required>
                    <option value="">-- Select Room Type --</option>
                    <%
                        try (Connection conn = DBConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT * FROM room_types")) {
                            while(rs.next()) {
                    %>
                    <option value="<%= rs.getInt("room_type_id") %>">
                        <%= rs.getString("type_name") %> (LKR <%= rs.getDouble("price_per_night") %>)
                    </option>
                    <%
                            }
                        } catch(Exception e) { e.printStackTrace(); }
                    %>
                </select>
            </div>

            <div>
                <label>Check-In Date</label>
                <input type="date" name="check_in" required>
            </div>

            <div>
                <label>Check-Out Date</label>
                <input type="date" name="check_out" required>
            </div>
        </div>

        <button type="submit" class="btn-register">Confirm Reservation</button>
    </form>
</div>

</body>
</html>