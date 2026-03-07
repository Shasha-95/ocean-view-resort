# Ocean View Resort - Hotel Management System

A robust **Java EE** web application designed for managing hotel operations, including staff management, guest registration, and automated reporting.

## 🚀 Features
* **Admin Dashboard:** Manage staff accounts (CRUD), generate PDF reservation reports.
* **Staff Portal:** Register new guests, search/update/delete bookings.
* **Security:** Role-based access control (Admin vs. Staff) with session management.
* **Reporting:** Dynamic PDF generation using iText 7.
* **UI/UX:** Responsive CSS with specialized alerts for user feedback.

## 🛠️ Tech Stack
* **Backend:** Java (Jakarta EE), Servlets, JSP
* **Database:** MySQL 8.0
* **Server:** Apache Tomcat 10.x
* **Libraries:** iText 7 (PDF Generation), FontAwesome, JDBC

## 📂 Database Setup
1. Create a database named `ocean_view_db` in MySQL Workbench.
2. Import the schema and sample data using the script located in:
   `db_scripts/database_backup.sql`

## ⚙️ Configuration
1. Open the project in **IntelliJ IDEA**.
2. Configure **Tomcat 10.1** in the Run/Debug configurations.
3. Update database credentials in `com.oceanview.util.DBConnection.java`:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/ocean_view_db";
   private static final String USER = "your_username";
   private static final String PASS = "your_password";