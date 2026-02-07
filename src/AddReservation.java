import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.Scanner;

public class AddReservation {

    public static void addReservation() {
        Scanner sc = new Scanner(System.in);

        try {
            Connection con = DBConnection.getConnection();
            if (con == null) return;

            System.out.print("Guest Name: ");
            String guestName = sc.nextLine();

            System.out.print("Address: ");
            String address = sc.nextLine();

            System.out.print("Contact Number: ");
            String contact = sc.nextLine();

            // Fetch room types from database
            String fetchRooms = "SELECT room_type_id, room_type_name, price FROM room_types";
            PreparedStatement psFetch = con.prepareStatement(fetchRooms);
            ResultSet rs = psFetch.executeQuery();

            System.out.println("\nAvailable Room Types:");
            while (rs.next()) {
                int id = rs.getInt("room_type_id");
                String typeName = rs.getString("room_type_name");
                double price = rs.getDouble("price");
                System.out.println(id + ". " + typeName + " - Rs. " + price + " per night");
            }

            System.out.print("Select Room Type (Enter ID): ");
            int roomTypeId = Integer.parseInt(sc.nextLine());

            // Verify selected room exists
            String roomSql = "SELECT room_type_name FROM room_types WHERE room_type_id = ?";
            PreparedStatement psRoom = con.prepareStatement(roomSql);
            psRoom.setInt(1, roomTypeId);
            ResultSet rsRoom = psRoom.executeQuery();

            if (!rsRoom.next()) {
                System.out.println("Invalid room selection.");
                return;
            }

            System.out.print("Check-in Date (YYYY-MM-DD): ");
            LocalDate checkIn = LocalDate.parse(sc.nextLine());

            System.out.print("Check-out Date (YYYY-MM-DD): ");
            LocalDate checkOut = LocalDate.parse(sc.nextLine());

            // Insert reservation into database
            String insertSql = """
                INSERT INTO reservations 
                (guest_name, address, contact_number, room_type_id, check_in_date, check_out_date)
                VALUES (?, ?, ?, ?, ?, ?)
            """;

            PreparedStatement psInsert = con.prepareStatement(insertSql);
            psInsert.setString(1, guestName);
            psInsert.setString(2, address);
            psInsert.setString(3, contact);
            psInsert.setInt(4, roomTypeId);
            psInsert.setString(5, checkIn.toString());
            psInsert.setString(6, checkOut.toString());

            int rows = psInsert.executeUpdate();
            if (rows > 0) {
                System.out.println("\nReservation added successfully!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
