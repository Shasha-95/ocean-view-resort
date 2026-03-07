package com.oceanview.controller;

import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Use the connection utility to talk to MySQL
        try (Connection conn = DBConnection.getConnection()) {

            // Fixed: Now targets 'staff' table and pulls correct column names
            String sql = "SELECT role, full_name, staff_id FROM staff WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Success: Get user details from the database
                String role = rs.getString("role");
                String fullName = rs.getString("full_name");
                String staffId = rs.getString("staff_id");

                // Create a secure session to keep the user logged in
                HttpSession session = request.getSession();
                session.setAttribute("username", user);
                session.setAttribute("userFullName", fullName);
                session.setAttribute("staffId", staffId);
                session.setAttribute("role", role);

                // Auto-logout after 30 minutes of inactivity
                session.setMaxInactiveInterval(30 * 60);

                // Role-based Redirection (Case-insensitive check)
                if ("admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("admin_dash.jsp");
                } else {
                    response.sendRedirect("staff_dash.jsp");
                }

            } else {
                // Failure: No matching user found
                request.setAttribute("error", "Invalid Staff Username or Password");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Logs the real error to the IntelliJ console for you to see
            e.printStackTrace();
            request.setAttribute("error", "System Error: " + e.getMessage());
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}