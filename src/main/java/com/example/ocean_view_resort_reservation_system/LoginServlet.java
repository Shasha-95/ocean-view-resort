package com.oceanview.controller;

// Group 1: Standard Java IO
import java.io.IOException;

// Group 2: Database (JDBC) - Fixes Connection, PreparedStatement, ResultSet
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// Group 3: Servlet API - Fixes HttpServlet, WebServlet, HttpServletRequest, etc.
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// Group 4: Your Custom Database Utility - Fixes DBConnection error
import com.oceanview.util.DBConnection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Try-with-resources ensures the connection closes automatically
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT role FROM staff WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");
                HttpSession session = request.getSession();
                session.setAttribute("username", user);
                session.setAttribute("role", role);

                if ("Admin".equals(role)) {
                    response.sendRedirect("views/admin_dash.jsp");
                } else {
                    response.sendRedirect("views/staff_dash.jsp");
                }
            } else {
                request.setAttribute("error", "Invalid Credentials!");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database Error: " + e.getMessage());
        }
    }
}