package com.oceanview.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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

            // --- ACTION: REGISTER ---
            if ("register".equals(action)) {
                String sql = "INSERT INTO reservations (guest_name, address, country, contact_number, room_type_id, check_in_date, check_out_date) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, request.getParameter("guest_name"));
                    ps.setString(2, request.getParameter("address"));
                    ps.setString(3, request.getParameter("country"));
                    ps.setString(4, request.getParameter("contact"));
                    ps.setInt(5, Integer.parseInt(request.getParameter("room_type_id")));
                    ps.setString(6, request.getParameter("check_in"));
                    ps.setString(7, request.getParameter("check_out"));

                    if (ps.executeUpdate() > 0) {
                        response.sendRedirect("staff_dash.jsp?msg=success");
                    } else {
                        response.sendRedirect("register_guest.jsp?error=failed");
                    }
                }
            }

            // --- ACTION: UPDATE ---
            else if ("update".equals(action)) {
                String sql = "UPDATE reservations SET guest_name=?, address=?, country=?, contact_number=?, check_in_date=?, check_out_date=? WHERE reservation_number=?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, request.getParameter("guest_name"));
                    ps.setString(2, request.getParameter("address"));
                    ps.setString(3, request.getParameter("country"));
                    ps.setString(4, request.getParameter("contact"));
                    ps.setString(5, request.getParameter("check_in"));
                    ps.setString(6, request.getParameter("check_out"));
                    ps.setInt(7, Integer.parseInt(request.getParameter("reservation_number")));

                    ps.executeUpdate();
                    response.sendRedirect("staff_dash.jsp?msg=updated");
                }
            }

            // --- ACTION: DELETE ---
            else if ("delete".equals(action)) {
                String sql = "DELETE FROM reservations WHERE reservation_number = ?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    int resId = Integer.parseInt(request.getParameter("reservation_number"));
                    ps.setInt(1, resId);

                    int rowsAffected = ps.executeUpdate();
                    if (rowsAffected > 0) {
                        response.sendRedirect("staff_dash.jsp?msg=deleted");
                    } else {
                        response.sendRedirect("delete_booking.jsp?error=notfound");
                    }
                }
            }

        } catch (NumberFormatException e) {
            System.err.println("Input Error: " + e.getMessage());
            response.sendRedirect("staff_dash.jsp?msg=invalid_input");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("staff_dash.jsp?msg=db_error");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("staff_dash.jsp?msg=error");
        }
    }
}