<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Staff Accounts | Ocean View</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root { --ocean: #003366; --gold: #c5a059; --light: #f4f7f6; }
        body { font-family: 'Segoe UI', sans-serif; background: var(--light); margin: 0; padding: 40px; }
        .container { max-width: 1100px; margin: auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
        h2 { color: var(--ocean); border-bottom: 2px solid var(--gold); padding-bottom: 10px; }

        .search-box { display: flex; gap: 10px; margin-bottom: 30px; background: #eef2f3; padding: 20px; border-radius: 8px; }
        input[type="text"], input[type="email"], input[type="password"], textarea, select {
            width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; font-size: 0.95rem;
        }

        .btn-search { background: var(--ocean); color: white; border: none; padding: 0 25px; border-radius: 5px; cursor: pointer; transition: 0.3s; }

        /* Layout for View and Edit */
        .action-container { display: grid; grid-template-columns: 1fr 2fr; gap: 20px; margin-top: 20px; align-items: start; }
        .card { border: 1px solid #eee; padding: 25px; border-radius: 10px; background: #fff; }
        .view-card { background: #fafafa; border-left: 5px solid var(--gold); }
        .view-card p { margin: 12px 0; border-bottom: 1px solid #eee; padding-bottom: 5px; font-size: 0.9rem; }

        /* Grid for Edit Form */
        .edit-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; text-align: left; }
        .full-width { grid-column: span 2; }
        label { display: block; margin-top: 10px; font-weight: 600; font-size: 0.85rem; color: var(--ocean); }

        .btn-update { background: #27ae60; color: white; border: none; padding: 14px; width: 100%; border-radius: 5px; margin-top: 20px; cursor: pointer; font-weight: bold; }
        .btn-delete { background: #c0392b; color: white; border: none; padding: 10px; width: 100%; border-radius: 5px; cursor: pointer; font-weight: bold; font-size: 0.8rem; }
        .back-link { display: inline-block; margin-bottom: 20px; color: var(--ocean); text-decoration: none; font-weight: bold; }

        .msg { text-align: center; padding: 10px; border-radius: 5px; margin-bottom: 20px; }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>

<div class="container">
    <a href="admin_dash.jsp" class="back-link"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    <h2><i class="fas fa-users-cog"></i> Staff Management Portal</h2>

    <%-- Success/Error Messages --%>
    <% if(request.getParameter("msg") != null) { %>
    <div class="msg success">Staff record updated successfully!</div>
    <% } %>
    <% if(request.getAttribute("error") != null) { %>
    <div class="msg error">${error}</div>
    <% } %>

    <div class="search-box">
        <form action="StaffServlet" method="get" style="display:flex; width:100%; gap:10px;">
            <input type="text" name="staffId" placeholder="Search by Staff ID (e.g., STF101)" required>
            <button type="submit" class="btn-search"><i class="fas fa-search"></i> Find Staff</button>
        </form>
    </div>

    <% if(request.getAttribute("staff") != null) { %>
    <div class="action-container">

        <%-- LEFT COLUMN: CURRENT DETAILS --%>
        <div class="card view-card">
            <h3><i class="fas fa-id-badge"></i> Profile Summary</h3>
            <p><strong>ID:</strong> ${staff.staffId}</p>
            <p><strong>Name:</strong> ${staff.fullName}</p>
            <p><strong>Username:</strong> ${staff.username}</p>
            <p><strong>Role:</strong> <span class="badge">${staff.role}</span></p>
            <p><strong>Email:</strong> ${staff.email}</p>
            <p><strong>Mobile:</strong> ${staff.mobile}</p>

            <hr style="margin: 20px 0; border: 0; border-top: 1px solid #eee;">

            <form action="StaffServlet" method="post" onsubmit="return confirm('Delete this account? This cannot be undone.')">
                <input type="hidden" name="staffId" value="${staff.staffId}">
                <input type="hidden" name="action" value="delete">
                <button type="submit" class="btn-delete"><i class="fas fa-trash"></i> Permanent Delete</button>
            </form>
        </div>

        <%-- RIGHT COLUMN: EDIT FORM --%>
        <div class="card">
            <h3><i class="fas fa-user-edit"></i> Edit Account Details</h3>
            <form action="StaffServlet" method="post">
                <input type="hidden" name="staffId" value="${staff.staffId}">
                <input type="hidden" name="action" value="update">

                <div class="edit-grid">
                    <div class="full-width">
                        <label>Full Name</label>
                        <input type="text" name="fullName" value="${staff.fullName}" required>
                    </div>

                    <div class="full-width">
                        <label>Home Address</label>
                        <textarea name="address" required>${staff.address}</textarea>
                    </div>

                    <div>
                        <label>Email Address</label>
                        <input type="email" name="email" value="${staff.email}" required>
                    </div>

                    <div>
                        <label>Mobile Number</label>
                        <input type="text" name="mobile" value="${staff.mobile}" required>
                    </div>

                    <div>
                        <label>Username (System Access)</label>
                        <input type="text" name="username" value="${staff.username}" required>
                    </div>

                    <div>
                        <label>Update Password</label>
                        <input type="password" name="password" placeholder="Leave blank to keep current">
                    </div>

                    <div class="full-width">
                        <label>Assigned Role</label>
                        <select name="role">
                            <option value="Staff" ${staff.role == 'Staff' ? 'selected' : ''}>Hotel Staff</option>
                            <option value="Admin" ${staff.role == 'Admin' ? 'selected' : ''}>System Administrator</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn-update"><i class="fas fa-save"></i> Update Records</button>
            </form>
        </div>
    </div>
    <% } %>
</div>

</body>
</html>