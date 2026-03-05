package com.oceanview.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.oceanview.util.DBConnection;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {
            if ("register".equals(action)) {
                String sql = "INSERT INTO reservations (guest_name, address, country, contact_number, room_type_id, check_in_date, check_out_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);

                ps.setString(1, request.getParameter("guest_name"));
                ps.setString(2, request.getParameter("address"));
                ps.setString(3, request.getParameter("country"));
                ps.setString(4, request.getParameter("contact"));
                ps.setInt(5, Integer.parseInt(request.getParameter("room_type_id")));
                ps.setString(6, request.getParameter("check_in"));
                ps.setString(7, request.getParameter("check_out"));

                ps.executeUpdate();
                // Success redirect to root dashboard
                response.sendRedirect("staff_dash.jsp?msg=success");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("staff_dash.jsp?msg=error");
        }
    }
}