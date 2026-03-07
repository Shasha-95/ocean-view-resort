<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Staff | Ocean View Resort</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(rgba(244, 247, 246, 0.85), rgba(244, 247, 246, 0.85)), url('images/oceanviewr.jpg');
            background-size: cover; font-family: 'Segoe UI', sans-serif;
            margin: 0;
        }
        .form-container {
            background: rgba(255, 255, 255, 0.98); padding: 40px; border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2); width: 90%; max-width: 700px;
            margin: 40px auto; text-align: center;
        }
        /* Grid layout for 8 fields */
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            text-align: left;
        }
        .full-width { grid-column: span 2; }

        label { font-weight: 600; color: #003366; font-size: 0.85rem; margin-top: 10px; display: block; }
        input, select, textarea {
            width: 100%; padding: 12px; margin-top: 5px; border-radius: 8px;
            border: 1px solid #ddd; box-sizing: border-box; font-size: 0.95rem;
        }
        textarea { height: 80px; resize: none; }

        .save-btn {
            background: #003366; color: white; font-weight: bold;
            cursor: pointer; border: none; transition: 0.3s; margin-top: 25px;
            padding: 15px; font-size: 1rem;
        }
        .save-btn:hover { background: #c5a059; transform: translateY(-2px); }

        .error-msg { color: #e74c3c; font-weight: bold; margin-top: 15px; font-size: 0.9rem; }
        .navbar {
            background: #003366; padding: 15px 30px; color: white;
            display: flex; justify-content: space-between; align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>

<div class="navbar">
    <h1 style="margin: 0; font-size: 1.5rem;">Ocean View Resort - Admin</h1>
    <a href="admin_dash.jsp" style="color: white; text-decoration: none; font-weight: bold;">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<div class="form-container">
    <h2><i class="fas fa-user-plus"></i> Register New Staff Member</h2>

    <form action="StaffServlet" method="post">
        <input type="hidden" name="action" value="add_staff">

        <div class="form-grid">
            <div>
                <label>Staff ID</label>
                <input type="text" name="staffId" placeholder="e.g., STF001" required>
            </div>

            <div>
                <label>Full Name</label>
                <input type="text" name="full_name" placeholder="John Doe" required>
            </div>

            <div class="full-width">
                <label>Address</label>
                <textarea name="address" placeholder="Residential Address" required></textarea>
            </div>

            <div>
                <label>Email Address</label>
                <input type="email" name="email_address" placeholder="john@example.com" required>
            </div>

            <div>
                <label>Mobile Number</label>
                <input type="text" name="mobile_number" placeholder="07XXXXXXXX" required>
            </div>

            <div>
                <label>Login Username</label>
                <input type="text" name="username" placeholder="Choose username" required>
            </div>

            <div>
                <label>Login Password</label>
                <input type="password" name="password" placeholder="Choose password" required>
            </div>

            <div class="full-width">
                <label>System Role</label>
                <select name="role" required>
                    <option value="" disabled selected>Select Role</option>
                    <option value="Staff">Hotel Staff</option>
                    <option value="Admin">System Administrator</option>
                </select>
            </div>
        </div>

        <button type="submit" class="save-btn full-width">Register Staff Member</button>
    </form>

    <% if(request.getParameter("error") != null) { %>
    <div class="error-msg">
        <i class="fas fa-exclamation-triangle"></i>
        Error: <%= java.net.URLDecoder.decode(request.getParameter("error"), "UTF-8") %>
    </div>
    <% } %>
</div>
</body>
</html>