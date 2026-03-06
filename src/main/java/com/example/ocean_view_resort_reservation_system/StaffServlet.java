package com.oceanview.controller;

import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {

    /**
     * SEARCH LOGIC (GET)
     * Handles finding a staff member to display in the edit form.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String staffId = request.getParameter("staffId");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM staff WHERE staff_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, staffId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Pack the database row into a Map
                Map<String, String> staffData = new HashMap<>();
                staffData.put("staffId", rs.getString("staff_id"));
                staffData.put("fullName", rs.getString("full_name"));
                staffData.put("email", rs.getString("email_address"));
                staffData.put("mobile", rs.getString("mobile_number"));

                // This name "staff" MUST match the variable name used in manage_staff.jsp
                request.setAttribute("staff", staffData);
            } else {
                request.setAttribute("error", "Staff ID " + staffId + " not found!");
            }

            // Forwarding ensures the data stays in the request scope for the JSP to read
            request.getRequestDispatcher("manage_staff.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * UPDATE & DELETE LOGIC (POST)
     * Handles the actual modification of the database.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("staffId");

        try (Connection conn = DBConnection.getConnection()) {
            if ("update".equals(action)) {
                String sql = "UPDATE staff SET full_name=?, email_address=?, mobile_number=? WHERE staff_id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, request.getParameter("fullName"));
                ps.setString(2, request.getParameter("email"));
                ps.setString(3, request.getParameter("mobile"));
                ps.setString(4, id);
                ps.executeUpdate();
                response.sendRedirect("manage_staff.jsp?msg=updated");
            }
            else if ("delete".equals(action)) {
                String sql = "DELETE FROM staff WHERE staff_id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, id);
                ps.executeUpdate();
                response.sendRedirect("manage_staff.jsp?msg=deleted");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_staff.jsp?msg=error");
        }
    }
}