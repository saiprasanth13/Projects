<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Update Store</title>

<!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
body {
    margin: 0;
    font-family: 'Inter', sans-serif;
    background: url("https://res.cloudinary.com/dpxrmf3vc/image/upload/v1762508718/Gemini_Generated_Image_7khd547khd547khd_szscf4.png") no-repeat center center fixed;
    background-size: cover;
}

/* Logo Header */
.header {
    display: flex;
    justify-content: center;
    padding: 15px;
    background: rgba(255,255,255,0.65);
    backdrop-filter: blur(7px);
}

.header img {
    height: 75px;
}

/* Glass effect form */
.form-container {
    width: 420px;
    margin: 40px auto;
    padding: 25px;
    background: rgba(255,255,255,0.22);
    backdrop-filter: blur(8px);
    border-radius: 12px;
    box-shadow: 0 6px 25px rgba(0,0,0,0.30);
}

h2 {
    text-align: center;
    color: white;
    font-size: 28px;
    font-weight: 600;
}

label { font-weight: 600; color: #ffffff; }

input, button {
    width: 100%;
    padding: 10px;
    margin-top: 10px;
    border-radius: 6px;
    border: none;
}

input {
    background: rgba(255,255,255,0.85);
    font-size: 15px;
}

button {
    background: #1e5631;
    color: white;
    cursor: pointer;
    font-size: 16px;
}

button:hover {
    background: #2e7d47;
}
</style>
</head>

<body>

<!-- ✅ Logo -->
<div class="header">
    <img src="https://res.cloudinary.com/dpxrmf3vc/image/upload/v1761909191/Screenshot__71__copy-removebg-preview_1_ufupio.png">
</div>

<h2>Update Store Details</h2>

<!-- ✅ SEARCH FORM -->
<div class="form-container">
<form method="post">
    <label>Enter Store Name:</label>
    <input type="text" name="search_store"
           value="<%= request.getParameter("search_store") != null ? request.getParameter("search_store") : "" %>"
           required>
    <button type="submit">Search</button>
</form>
</div>

<%
String storeName = request.getParameter("search_store");

if (storeName != null) {
    try {
        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
        Connection con = ds.getConnection();

        PreparedStatement ps = con.prepareStatement(
        "SELECT STORE_ID, FULL_NAME, STORE_NAME, EMAIL, PHONE, CITY, ADDRESS, IMAGE_URL FROM store_registration WHERE STORE_NAME=?"
        );
        ps.setString(1, storeName);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
%>

<!-- ✅ UPDATE FORM -->
<div class="form-container">
<form id="updateForm" action="UpdateStore" method="post">

    <input type="hidden" name="store_id" value="<%= rs.getInt("STORE_ID") %>">

    <label>Full Name:</label>
    <input type="text" name="fullname" value="<%= rs.getString("FULL_NAME") %>" required>

    <label>Store Name:</label>
    <input type="text" name="storename" value="<%= rs.getString("STORE_NAME") %>" required>

    <label>Email:</label>
    <input type="email" name="email" value="<%= rs.getString("EMAIL") %>" required>

    <label>Phone:</label>
    <input type="text" name="phone" value="<%= rs.getString("PHONE") %>" required>

    <label>City:</label>
    <input type="text" name="city" value="<%= rs.getString("CITY") %>">

    <label>Address:</label>
    <input type="text" name="address" value="<%= rs.getString("ADDRESS") %>">

    <label>Image URL (optional):</label>
    <input type="text" name="image" value="<%= rs.getString("IMAGE_URL") %>">

    <button type="submit">Update Store</button>
</form>
</div>

<%
        } else {
            out.println("<p style='color:red; text-align:center;'>Store Not Found</p>");
        }
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
}
%>

<!-- ✅ CONFIRMATION BEFORE UPDATE -->
<script>
document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("updateForm");
    if (form) {
        form.addEventListener("submit", function (e) {
            e.preventDefault();

            Swal.fire({
                title: "Confirm Update",
                text: "Are you sure you want to update this store?",
                icon: "question",
                showCancelButton: true,
                confirmButtonColor: "#1e5631",
                cancelButtonColor: "#d33",
                confirmButtonText: "Yes, Update"
            }).then((result) => {
                if (result.isConfirmed) {
                    form.submit();
                }
            });
        });
    }
});
</script>

<!-- ✅ STATUS POPUP MESSAGES -->
<script>
<% if ("success".equals(request.getParameter("status"))) { %>
Swal.fire({
    title: "Updated Successfully!",
    text: "Store details updated in the database.",
    icon: "success",
    confirmButtonColor: "#1e5631"
}).then(() => { window.location.href = "admindashboard.html"; });
<% } %>

<% if ("error".equals(request.getParameter("status"))) { %>
Swal.fire({ title: "Update Failed!", text: "Something went wrong.", icon: "error" });
<% } %>

<% if ("duplicate".equals(request.getParameter("status"))) { %>
Swal.fire({ title: "Duplicate Store Name!", text: "Try another name.", icon: "warning" });
<% } %>
</script>

</body>
</html>
