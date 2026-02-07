import java.util.Scanner;

public class MainApp {

    public static void main(String[] args) {

        boolean loggedIn = false;
        while (!loggedIn) {
            loggedIn = Login.authenticate();
            if (!loggedIn) {
                System.out.println("Please try again.\n");
            }
        }

        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.println("\n--- Ocean View Resort System ---");
            System.out.println("1. Add Reservation");
            System.out.println("2. View Reservation");
            System.out.println("3. Calculate Bill");
            System.out.println("4. Help");
            System.out.println("5. Exit");
            System.out.print("Choose option: ");

            int choice;
            try {
                choice = Integer.parseInt(sc.nextLine());
            } catch (Exception e) {
                System.out.println("Invalid input.");
                continue;
            }

            switch (choice) {
                case 1:
                    AddReservation.addReservation();
                    break;

                case 2:
                    ViewReservation.viewReservation();
                    break;

                case 3:
                    CalculateBill.calculateBill();
                    break;

                case 4:
                    HelpSection.showHelp();
                    break;

                case 5:
                    System.out.println("Thank you for using Ocean View Resort System!");
                    System.exit(0);

                default:
                    System.out.println("Invalid option.");
            }
        }
    }
}
