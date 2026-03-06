<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Staff Accounts | Ocean View</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --ocean: #003366; --gold: #c5a059; --light: #f4f7f6; }
        body { font-family: 'Segoe UI', sans-serif; background: var(--light); margin: 0; padding: 40px; }
        .container { max-width: 900px; margin: auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        h2 { color: var(--ocean); border-bottom: 2px solid var(--gold); padding-bottom: 10px; }

        /* Search Bar Styling */
        .search-box { display: flex; gap: 10px; margin-bottom: 30px; background: #eef2f3; padding: 20px; border-radius: 8px; }
        input[type="text"] { flex: 1; padding: 12px; border: 1px solid #ccc; border-radius: 5px; font-size: 1rem; }
        .btn-search { background: var(--ocean); color: white; border: none; padding: 0 25px; border-radius: 5px; cursor: pointer; transition: 0.3s; }
        .btn-search:hover { background: #002244; }

        /* Multi-Column Action Container */
        .action-container { display: grid; grid-template-columns: 1fr 1.2fr; gap: 20px; margin-top: 20px; }
        .card { border: 1px solid #eee; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.02); }
        .view-card { background: #fafafa; border-left: 5px solid var(--gold); }
        .view-card h3 { color: var(--ocean); margin-top: 0; }
        .view-card p { margin: 15px 0; border-bottom: 1px solid #eee; padding-bottom: 5px; }

        /* Form Styling */
        label { display: block; margin: 15px 0 5px; font-weight: 600; font-size: 0.9rem; color: #555; }
        input[type="email"], input[type="tel"] { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }

        .btn-update { background: #27ae60; color: white; border: none; padding: 14px; width: 100%; border-radius: 5px; margin-top: 20px; cursor: pointer; font-weight: bold; }
        .btn-delete { background: #c0392b; color: white; border: none; padding: 14px; width: 100%; border-radius: 5px; margin-top: 10px; cursor: pointer; font-weight: bold; }
        .back-link { display: inline-block; margin-bottom: 20px; color: var(--ocean); text-decoration: none; font-weight: bold; transition: 0.3s; }
        .back-link:hover { color: var(--gold); }

        .msg { text-align: center; padding: 10px; border-radius: 5px; margin-bottom: 20px; }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>

<div class="container">
    <a href="admin_dash.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    <h2>Manage Staff Accounts</h2>

    <% if(request.getParameter("msg") != null) { %>
    <div class="msg success">Operation successful!</div>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
    <div class="msg error">${error}</div>
    <% } %>

    <div class="search-box">
        <form action="StaffServlet" method="get" style="display:flex; width:100%; gap:10px;">
            <input type="text" name="staffId" placeholder="Enter User ID (e.g., 101)" required>
            <button type="submit" class="btn-search"><i class="fas fa-search"></i> Find Staff</button>
        </form>
    </div>

    <% if(request.getAttribute("staff") != null) { %>
    <div class="action-container">

        <div class="card view-card">
            <h3><i class="fas fa-eye"></i> View Details</h3>
            <p><strong>User ID:</strong> ${staff.staffId}</p>
            <p><strong>Full Name:</strong> ${staff.fullName}</p>
            <p><strong>Role:</strong> <span style="text-transform: capitalize;">${staff.role}</span></p>
            <p><strong>Current Email:</strong> ${staff.email}</p>
            <p><strong>Mobile:</strong> ${staff.mobile}</p>
        </div>

        <div class="card">
            <h3><i class="fas fa-edit"></i> Edit Staff</h3>
            <form action="StaffServlet" method="post">
                <input type="hidden" name="staffId" value="${staff.staffId}">
                <input type="hidden" name="action" value="update">

                <label>Update Email Address</label>
                <input type="email" name="email" value="${staff.email}" required>

                <label>Update Mobile Number</label>
                <input type="tel" name="mobile" value="${staff.mobile}" required>

                <button type="submit" class="btn-update">Save Changes</button>
            </form>

            <hr style="margin: 30px 0; border: 0; border-top: 2px dashed #eee;">

            <h3><i class="fas fa-trash-alt"></i> Danger Zone</h3>
            <p style="font-size: 0.8rem; color: #888;">Deleting this account is permanent and cannot be undone.</p>
            <form action="StaffServlet" method="post" onsubmit="return confirm('Are you absolutely sure you want to permanently delete this account?')">
                <input type="hidden" name="staffId" value="${staff.staffId}">
                <input type="hidden" name="action" value="delete">
                <button type="submit" class="btn-delete">Delete Account Permanently</button>
            </form>
        </div>
    </div>
    <% } %>
</div>

</body>
</html>