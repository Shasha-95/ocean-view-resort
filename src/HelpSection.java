import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class HelpSection {

    public static void showHelp() {

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return;

            String sql = "SELECT title, description FROM help_section";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            System.out.println("\n=== Help Section ===");

            while (rs.next()) {
                System.out.println("\n🔹 " + rs.getString("title"));
                System.out.println(rs.getString("description"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
