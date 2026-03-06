<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Booking | Ocean View Resort</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0;
            background: linear-gradient(rgba(244, 247, 246, 0.85), rgba(244, 247, 246, 0.85)), url('images/oceanviewr.jpg');
            background-size: cover; background-position: center;
        }
        .delete-card {
            background: rgba(255, 255, 255, 0.95); padding: 40px; border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1); width: 100%; max-width: 500px; text-align: center;
        }
        h2 { color: #e74c3c; margin-bottom: 20px; }
        p { color: #666; margin-bottom: 30px; }
        input[type="number"] { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px; margin-bottom: 20px; font-size: 1rem; }
        .btn-delete {
            background: #e74c3c; color: white; border: none; padding: 15px; width: 100%;
            border-radius: 8px; cursor: pointer; font-weight: bold; font-size: 1rem; transition: 0.3s;
        }
        .btn-delete:hover { background: #c0392b; }
    </style>
    <script>
        function confirmDelete() {
            var resId = document.getElementById("resId").value;
            if (resId === "") {
                alert("Please enter a Reservation Number first.");
                return false;
            }
            return confirm("Warning: Are you sure you want to permanently delete Reservation #" + resId + "? This action cannot be undone.");
        }
    </script>
</head>
<body>

<div class="delete-card">
    <a href="staff_dash.jsp" style="text-decoration: none; color: #003366; float: left;"><i class="fas fa-arrow-left"></i> Back</a>
    <br><br>
    <h2><i class="fas fa-trash-alt"></i> Delete Reservation</h2>
    <p>Please enter the Reservation Number below to remove it from the system.</p>

    <form action="BookingServlet" method="post" onsubmit="return confirmDelete()">
        <input type="hidden" name="action" value="delete">
        <input type="number" id="resId" name="reservation_number" placeholder="Enter Reservation Number (e.g. 105)" required>
        <button type="submit" class="btn-delete">Permanently Delete Booking</button>
    </form>
</div>

</body>
</html>