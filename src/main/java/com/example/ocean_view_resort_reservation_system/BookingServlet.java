package com.oceanview.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// Servlet and Web Imports
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Your Database Utility
import com.oceanview.util.DBConnection;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try (Connection conn = DBConnection.getConnection()) {
            if ("register".equals(action)) {
                // Logic for "Register Guest"
                String sql = "INSERT INTO reservations (guest_name, address, country, contact_number, room_type_id, check_in_date, check_out_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                // ps.setString(1, ...); // and so on
                ps.executeUpdate();
                response.sendRedirect("views/staff_dash.jsp?msg=success");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}