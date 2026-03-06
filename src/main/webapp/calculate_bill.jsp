<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.oceanview.util.DBConnection, java.time.*, java.time.temporal.ChronoUnit" %>
<html>
<head>
    <title>Guest Bill | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f4f7f6; padding: 20px; }
        .no-print { background: white; padding: 20px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); max-width: 500px; margin: 0 auto 30px; text-align: center; }
        .invoice-box {
            max-width: 800px; margin: auto; padding: 40px; border: 1px solid #eee;
            background: white; box-shadow: 0 0 20px rgba(0, 0, 0, 0.1); color: #333;
        }
        .header { display: flex; justify-content: space-between; border-bottom: 3px solid #003366; padding-bottom: 15px; margin-bottom: 30px; }
        .hotel-info h1 { color: #003366; margin: 0; letter-spacing: 2px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th { background: #003366; color: white; padding: 12px; text-align: left; }
        td { padding: 12px; border-bottom: 1px solid #eee; }
        .total-section { text-align: right; margin-top: 30px; font-size: 1.4rem; font-weight: bold; color: #003366; }
        .btn { background: #003366; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; font-weight: bold; }

        @media print {
            .no-print { display: none; }
            body { padding: 0; background: white; }
            .invoice-box { box-shadow: none; border: 1px solid #ccc; width: 100%; }
        }
    </style>
</head>
<body>

<div class="no-print">
    <a href="staff_dash.jsp" style="text-decoration: none; color: #003366; float: left;"><i class="fas fa-arrow-left"></i> Back</a>
    <h2>Billing System</h2>
    <form action="calculate_bill.jsp" method="get">
        <input type="number" name="resId" placeholder="Reservation Number" style="padding: 10px; width: 50%;" required>
        <button type="submit" class="btn">Calculate</button>
    </form>
</div>

<%
    String resId = request.getParameter("resId");
    if (resId != null) {
        try (Connection conn = DBConnection.getConnection()) {
            // Using your specific column names: room_type_name and price
            String sql = "SELECT r.*, rt.room_type_name, rt.price FROM reservations r " +
                    "JOIN room_types rt ON r.room_type_id = rt.room_type_id " +
                    "WHERE r.reservation_number = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(resId));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Calculation Logic
                LocalDate start = rs.getDate("check_in_date").toLocalDate();
                LocalDate end = rs.getDate("check_out_date").toLocalDate();
                long nights = ChronoUnit.DAYS.between(start, end);
                if (nights <= 0) nights = 1; // Stay must be at least 1 night

                double rate = rs.getDouble("price");
                double grandTotal = nights * rate;
%>
<div class="invoice-box">
    <div class="header">
        <div class="hotel-info">
            <h1>OCEAN VIEW RESORT</h1>
            <p>Luxury Stay & Spa<br>Galle, Sri Lanka</p>
        </div>
        <div style="text-align: right;">
            <h3>INVOICE</h3>
            <p>ID: #<%= rs.getInt("reservation_number") %><br>Date: <%= LocalDate.now() %></p>
        </div>
    </div>

    <table>
        <tr>
            <td><strong>Guest Name:</strong> <%= rs.getString("guest_name") %></td>
            <td><strong>Contact:</strong> <%= rs.getString("contact_number") %></td>
        </tr>
        <tr>
            <td><strong>Check-In:</strong> <%= start %></td>
            <td><strong>Check-Out:</strong> <%= end %></td>
        </tr>
    </table>

    <table>
        <thead>
        <tr>
            <th>Description</th>
            <th>Nights</th>
            <th>Rate (LKR)</th>
            <th>Subtotal</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>Accommodation (<%= rs.getString("room_type_name") %>)</td>
            <td><%= nights %></td>
            <td><%= String.format("%.2f", rate) %></td>
            <td><%= String.format("%.2f", grandTotal) %></td>
        </tr>
        </tbody>
    </table>

    <div class="total-section">
        Grand Total: LKR <%= String.format("%.2f", grandTotal) %>
    </div>

    <div style="margin-top: 40px; text-align: center;" class="no-print">
        <button class="btn" onclick="window.print()"><i class="fas fa-file-pdf"></i> Print to PDF</button>
    </div>
</div>
<%
            } else {
                out.println("<div class='no-print'><p style='color:red;'>Reservation #" + resId + " not found.</p></div>");
            }
        } catch (Exception e) { e.printStackTrace(); }
    }
%>

</body>
</html>