package com.oceanview.controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Destroy the session
        request.getSession().invalidate();

        // 2. Set response type to HTML to show the alert
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // 3. JavaScript alert as per your requirement
        out.println("<script type='text/javascript'>");
        out.println("alert('You’re logged out of the Ocean View Resort Reservation System');");
        out.println("window.location.href='index.jsp';");
        out.println("</script>");

        out.close();
    }
}