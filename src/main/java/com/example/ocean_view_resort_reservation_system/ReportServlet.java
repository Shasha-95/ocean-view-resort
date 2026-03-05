package com.oceanview.util;

import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import jakarta.servlet.http.HttpServletResponse;

public class ReportServlet {

    public static void generatePDF(HttpServletResponse response, String content) throws Exception {
        // Set response headers so the browser knows it's a PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Invoice.pdf");

        // Initialize iText components
        PdfWriter writer = new PdfWriter(response.getOutputStream());
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf);

        // Add content to the document
        document.add(new Paragraph("OCEAN VIEW RESORT - INVOICE"));
        document.add(new Paragraph("----------------------------"));
        document.add(new Paragraph(content));

        // Close the document
        document.close();
    }
}