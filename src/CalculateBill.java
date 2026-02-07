import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.Scanner;

public class CalculateBill {

    // Method to calculate total bill for a reservation
    public static void calculateBill() {
        Scanner sc = new Scanner(System.in);

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("Database connection failed.");
                return;
            }

            System.out.print("Enter Reservation Number: ");
            int reservationNumber = Integer.parseInt(sc.nextLine());

            // Fetch reservation details
            String sql = """
                SELECT r.guest_name, r.check_in_date, r.check_out_date,
                       rt.room_type_name, rt.price
                FROM reservations r
                JOIN room_types rt ON r.room_type_id = rt.room_type_id
                WHERE r.reservation_number = ?
            """;

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, reservationNumber);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String guestName = rs.getString("guest_name");
                LocalDate checkIn = rs.getDate("check_in_date").toLocalDate();
                LocalDate checkOut = rs.getDate("check_out_date").toLocalDate();
                String roomType = rs.getString("room_type_name");
                double ratePerNight = rs.getDouble("price");

                long nights = ChronoUnit.DAYS.between(checkIn, checkOut);
                double totalBill = nights * ratePerNight;

                System.out.println("\n--- Bill Summary ---");
                System.out.println("Guest Name   : " + guestName);
                System.out.println("Room Type    : " + roomType);
                System.out.println("Check-in     : " + checkIn);
                System.out.println("Check-out    : " + checkOut);
                System.out.println("Number of Nights : " + nights);
                System.out.println("Rate per Night   : Rs. " + ratePerNight);
                System.out.println("Total Bill       : Rs. " + totalBill);

            } else {
                System.out.println("Reservation not found.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
