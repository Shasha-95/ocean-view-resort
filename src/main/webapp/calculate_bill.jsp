<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Calculate Bill | Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="navbar">
    <h1>Ocean View Resort - Billing</h1>
    <a href="staff_dash.jsp">Back to Dashboard</a>
</div>

<div class="form-container">
    <h2>Calculate Guest Bill</h2>
    <form action="BillingServlet" method="get">
        <input type="text" name="resNumber" placeholder="Enter Reservation Number" required>
        <button type="submit" class="save-btn">Search & Calculate</button>
    </form>

    <% if(request.getAttribute("billData") != null) { %>
    <div class="bill-result">
        <h3>Invoice Summary</h3>
        <p>Guest Name: ${billData.guestName}</p>
        <p>Room Type: ${billData.roomType}</p>
        <p>Nights Stayed: ${billData.nights}</p>
        <p>Rate per Night: LKR ${billData.rate}</p>
        <hr>
        <h4 style="color: #0056b3;">Total Bill: LKR ${billData.total}</h4>

        <form action="ReportServlet" method="get">
            <input type="hidden" name="content" value="Guest: ${billData.guestName} | Total: ${billData.total}">
            <button type="submit" class="save-btn" style="background: #0056b3;">Print Invoice (PDF)</button>
        </form>
    </div>
    <% } %>
</div>
</body>
</html>