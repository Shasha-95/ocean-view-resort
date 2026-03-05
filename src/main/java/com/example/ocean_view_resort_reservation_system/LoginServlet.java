package com.oceanview.controller;

import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {
            // Updated query to fetch both role and username for the session
            String sql = "SELECT role, username FROM staff WHERE username = ? AND password = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");

                HttpSession session = request.getSession();
                session.setAttribute("username", rs.getString("username"));
                session.setAttribute("role", role);

                // Redirecting based on role to the root JSP files
                if ("Admin".equalsIgnoreCase(role)) {
                    response.sendRedirect("admin_dash.jsp");
                } else {
                    response.sendRedirect("staff_dash.jsp");
                }
            } else {
                // If login fails, go back to index.jsp (your login entry)
                response.sendRedirect("index.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Optional: Redirect to an error page or show message
            response.sendRedirect("index.jsp?error=database");
        }
    }
}