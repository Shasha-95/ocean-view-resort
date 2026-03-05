package com.oceanview.controller;

import com.oceanview.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String id = request.getParameter("staffId");
            String name = request.getParameter("fullName");
            String addr = request.getParameter("address");
            String email = request.getParameter("email");
            String mob = request.getParameter("mobile");
            String user = request.getParameter("username");
            String pass = request.getParameter("password");

            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO staff (staff_id, full_name, address, email_address, mobile_number, username, password, role) VALUES (?, ?, ?, ?, ?, ?, ?, 'Staff')";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, id);
                ps.setString(2, name);
                ps.setString(3, addr);
                ps.setString(4, email);
                ps.setString(5, mob);
                ps.setString(6, user);
                ps.setString(7, pass);

                ps.executeUpdate();
                response.sendRedirect("add_staff.jsp?msg=success");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("add_staff.jsp?msg=error");
            }
        }
    }
}