package com.oceanview.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Database URL, Username, and Password
    private static final String URL = "jdbc:mysql://localhost:3306/ocean_view?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASS = "1234"; // Replace with your MySQL password

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        // Load MySQL Driver for Jakarta/Tomcat
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}