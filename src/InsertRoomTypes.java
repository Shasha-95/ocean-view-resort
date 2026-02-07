import java.sql.Connection;
import java.sql.PreparedStatement;

public class InsertRoomTypes {

    public static void main(String[] args) {

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("Database connection failed.");
                return;
            }

            String sql = """
                INSERT INTO room_types (room_type_name, price)
                VALUES (?, ?)
            """;

            PreparedStatement ps = con.prepareStatement(sql);

            // Room Type 1
            ps.setString(1, "Standard");
            ps.setDouble(2, 15000);
            ps.executeUpdate();

            // Room Type 2
            ps.setString(1, "Deluxe");
            ps.setDouble(2, 22000);
            ps.executeUpdate();

            // Room Type 3
            ps.setString(1, "Suite");
            ps.setDouble(2, 35000);
            ps.executeUpdate();

            // Room Type 4
            ps.setString(1, "Family");
            ps.setDouble(2, 28000);
            ps.executeUpdate();

            System.out.println("Room types inserted successfully!");

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
