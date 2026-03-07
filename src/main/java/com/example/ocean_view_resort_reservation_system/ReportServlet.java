package com.oceanview.controller;

import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.UnitValue;
import com.oceanview.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set response headers for PDF download
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=OceanView_Reservations.pdf");

        try (Connection conn = DBConnection.getConnection()) {
            // FIXED SQL: Joined with room_types to get the specific room name
            String sql = "SELECT r.reservation_number, r.guest_name, rt.room_type_name, r.check_in_date, r.check_out_date " +
                    "FROM reservations r " +
                    "JOIN room_types rt ON r.room_type_id = rt.room_type_id " +
                    "ORDER BY r.check_in_date ASC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            // Initialize iText components directly using the response output stream
            PdfWriter writer = new PdfWriter(response.getOutputStream());
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf);

            // --- PDF HEADER ---
            document.add(new Paragraph("OCEAN VIEW RESORT - OFFICIAL RESERVATION REPORT")
                    .setBold().setFontSize(18));
            document.add(new Paragraph("Generated on: " + new java.util.Date()));
            document.add(new Paragraph("----------------------------------------------------------------------------------"));

            // --- DATA TABLE ---
            // Creating a table with 5 columns
            Table table = new Table(UnitValue.createPercentArray(new float[]{1, 3, 2, 2, 2}))
                    .useAllAvailableWidth();

            table.addHeaderCell("ID");
            table.addHeaderCell("Guest Name");
            table.addHeaderCell("Room Type");
            table.addHeaderCell("Check-In");
            table.addHeaderCell("Check-Out");

            while (rs.next()) {
                table.addCell(String.valueOf(rs.getInt("reservation_number")));
                table.addCell(rs.getString("guest_name"));
                table.addCell(rs.getString("room_type_name"));
                table.addCell(rs.getDate("check_in_date").toString());
                table.addCell(rs.getDate("check_out_date").toString());
            }

            document.add(table);

            // --- FOOTER ---
            document.add(new Paragraph("\nEnd of Report - Ocean View Resort Management System"));

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            // If PDF fails, we shouldn't send HTML error because the content type is already set to PDF
            System.err.println("PDF Generation Error: " + e.getMessage());
        }
    }
}