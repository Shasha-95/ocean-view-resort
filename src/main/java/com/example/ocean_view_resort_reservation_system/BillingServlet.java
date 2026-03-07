package com.oceanview.controller;

import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/BillingServlet")
public class BillingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resNo = request.getParameter("resNumber");

        try (Connection conn = DBConnection.getConnection()) {
            // Join reservations with room_types to get the price per night
            String sql = "SELECT r.guest_name, rt.room_type_name, rt.price, " +
                    "DATEDIFF(r.check_out_date, r.check_in_date) AS nights " +
                    "FROM reservations r JOIN room_types rt ON r.room_type_id = rt.room_type_id " +
                    "WHERE r.reservation_number = ?";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, resNo);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                double rate = rs.getDouble("price");
                int nights = rs.getInt("nights");

                // If they check in and out on the same day, charge for 1 night
                if (nights <= 0) nights = 1;

                Map<String, Object> billData = new HashMap<>();
                billData.put("guestName", rs.getString("guest_name"));
                billData.put("roomType", rs.getString("room_type_name"));
                billData.put("rate", rate);
                billData.put("nights", nights);
                billData.put("total", rate * nights);

                request.setAttribute("billData", billData);
            } else {
                request.setAttribute("error", "Reservation number not found.");
            }

            // Forward back to the JSP in the root directory
            request.getRequestDispatcher("calculate_bill.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}