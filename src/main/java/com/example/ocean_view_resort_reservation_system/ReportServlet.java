package com.oceanview.util;

import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

    // This method handles the button click (GET request)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Static content for now - you can fetch this from DB later
            String reportContent = "Guest Reservation Detail Report\nGenerated on: " + new java.util.Date();
            generatePDF(response, reportContent);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating PDF");
        }
    }

    public void generatePDF(HttpServletResponse response, String content) throws Exception {
        // Set response headers
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=GuestReport.pdf");

        // Initialize iText components
        PdfWriter writer = new PdfWriter(response.getOutputStream());
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf);

        // Add content
        document.add(new Paragraph("OCEAN VIEW RESORT - GUEST REPORT"));
        document.add(new Paragraph("----------------------------------"));
        document.add(new Paragraph(content));

        // Close
        document.close();
    }
}