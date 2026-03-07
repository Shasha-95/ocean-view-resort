package com.oceanview.controller;

import com.oceanview.model.Role;
import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String staffId = request.getParameter("staffId");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM staff WHERE staff_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, staffId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Map<String, String> staffData = new HashMap<>();
                staffData.put("staffId", rs.getString("staff_id"));
                staffData.put("fullName", rs.getString("full_name"));
                staffData.put("address", rs.getString("address"));
                staffData.put("email", rs.getString("email_address"));
                staffData.put("mobile", rs.getString("mobile_number"));
                staffData.put("username", rs.getString("username"));
                staffData.put("role", rs.getString("role"));

                request.setAttribute("staff", staffData);
            } else {
                request.setAttribute("error", "Staff ID " + staffId + " not found!");
            }
            request.getRequestDispatcher("manage_staff.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("staffId");

        System.out.println("DEBUG: Processing Action -> " + action);

        try (Connection conn = DBConnection.getConnection()) {

            // --- FEATURE: ADD STAFF (8 FIELDS + ENUM) ---
            if ("add_staff".equals(action)) {
                // Convert input string to Enum safely
                String roleInput = request.getParameter("role");
                Role roleEnum = Role.fromString(roleInput);

                String sql = "INSERT INTO staff (staff_id, full_name, address, email_address, mobile_number, username, password, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, request.getParameter("staffId"));
                    ps.setString(2, request.getParameter("full_name"));
                    ps.setString(3, request.getParameter("address"));
                    ps.setString(4, request.getParameter("email_address"));
                    ps.setString(5, request.getParameter("mobile_number"));
                    ps.setString(6, request.getParameter("username"));
                    ps.setString(7, request.getParameter("password"));
                    ps.setString(8, roleEnum.getDisplayName()); // Using Enum value

                    int rows = ps.executeUpdate();
                    System.out.println("DEBUG: Rows inserted -> " + rows);

                    response.sendRedirect("admin_dash.jsp?msg=staff_added");
                    return;
                }
            }

            // --- FEATURE: UPDATE ---
            else if ("update".equals(action)) {
                String sql = "UPDATE staff SET full_name=?, address=?, email_address=?, mobile_number=? WHERE staff_id=?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, request.getParameter("fullName"));
                    ps.setString(2, request.getParameter("address"));
                    ps.setString(3, request.getParameter("email"));
                    ps.setString(4, request.getParameter("mobile"));
                    ps.setString(5, id);

                    ps.executeUpdate();
                    response.sendRedirect("manage_staff.jsp?msg=updated");
                    return;
                }
            }

            // --- FEATURE: DELETE ---
            else if ("delete".equals(action)) {
                String sql = "DELETE FROM staff WHERE staff_id=?";
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, id);
                    ps.executeUpdate();
                    response.sendRedirect("manage_staff.jsp?msg=deleted");
                    return;
                }
            }

        } catch (Exception e) {
            System.err.println("CRITICAL ERROR in StaffServlet:");
            e.printStackTrace();
            String errorMsg = URLEncoder.encode(e.getMessage(), "UTF-8");
            response.sendRedirect("add_staff.jsp?error=" + errorMsg);
        }
    }
}