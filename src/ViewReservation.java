import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Scanner;

public class ViewReservation {

    public static void viewReservation() {
        Scanner sc = new Scanner(System.in);

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("Database connection failed.");
                return;
            }

            System.out.print("Enter Reservation Number: ");
            int resNo = sc.nextInt();

            String sql = """
                SELECT 
                    r.reservation_number,
                    r.guest_name,
                    r.address,
                    r.contact_number,
                    rt.room_type_name,
                    rt.price,
                    r.check_in_date,
                    r.check_out_date
                FROM reservations r
                JOIN room_types rt ON r.room_type_id = rt.room_type_id
                WHERE r.reservation_number = ?
            """;

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, resNo);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("\n===== RESERVATION DETAILS =====");
                System.out.println("Reservation No : " + rs.getInt("reservation_number"));
                System.out.println("Guest Name     : " + rs.getString("guest_name"));
                System.out.println("Address        : " + rs.getString("address"));
                System.out.println("Contact Number : " + rs.getString("contact_number"));
                System.out.println("Room Type      : " + rs.getString("room_type_name"));
                System.out.println("Price          : " + rs.getDouble("price"));
                System.out.println("Check-in Date  : " + rs.getDate("check_in_date"));
                System.out.println("Check-out Date : " + rs.getDate("check_out_date"));
                System.out.println("================================");
            } else {
                System.out.println("No reservation found for number: " + resNo);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
