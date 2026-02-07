import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    // Database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/ocean_view"; // database name
    private static final String USER = "root";  // your MySQL username
    private static final String PASSWORD = "1234";  // your MySQL password

    // Method to get connection
    public static Connection getConnection() {
        Connection con = null;
        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to database
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            System.out.println("Database connection failed.");
            e.printStackTrace();
        }
        return con;
    }
}
