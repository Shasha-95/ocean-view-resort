import java.util.Scanner;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Login {

    public static boolean authenticate() {
        Scanner sc = new Scanner(System.in);
        System.out.println("=== Ocean View Resort System Login ===");

        System.out.print("Username: ");
        String username = sc.nextLine();

        System.out.print("Password: ");
        String password = sc.nextLine();

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("Cannot connect to database.");
                return false;
            }

            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("Login successful! Welcome, " + username + ".");
                return true;
            } else {
                System.out.println("Invalid username or password.");
                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
