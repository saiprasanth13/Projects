<%@ page import="java.sql.*, javax.naming.*, javax.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Delete Store</title>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
body {
    margin: 0;
    font-family: 'Inter', sans-serif;
    background: url("https://res.cloudinary.com/dpxrmf3vc/image/upload/v1762508718/Gemini_Generated_Image_7khd547khd547khd_szscf4.png") no-repeat center center fixed;
    background-size: cover;
}

/* Header Logo */
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

/* Glass UI container */
.container {
    width: 420px;
    margin: 40px auto;
    padding: 25px;
    background: rgba(255,255,255,0.20);
    backdrop-filter: blur(8px);
    border-radius: 12px;
    box-shadow: 0 6px 25px rgba(0,0,0,0.25);
}

h2 {
    text-align: center;
    color: white;
    font-size: 28px;
    font-weight: 600;
}

label {
    color: white;
    font-weight: 600;
}

input, button {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    border-radius: 7px;
    border: none;
    font-size: 15px;
}

input {
    background: rgba(255,255,255,0.85);
}

button {
    background: #b00020;
    color: white;
    cursor: pointer;
    font-size: 16px;
}

button:hover {
    background: #e21b37;
}

img {
    width: 100%;
    border-radius: 10px;
    margin-top: 10px;
}
</style>
</head>

<body>

<!-- ✅ Logo -->
<div class="header">
    <img src="https://res.cloudinary.com/dpxrmf3vc/image/upload/v1761909191/Screenshot__71__copy-removebg-preview_1_ufupio.png">
</div>

<h2>Delete Store</h2>

<div class="container">

    <!-- STEP 1: Search store -->
    <form method="post">
        <label>Enter Store Name:</label>
        <input type="text" name="search_store" required>
        <button type="submit">Search</button>
    </form>

<%
String storeName = request.getParameter("search_store");

if (storeName != null) {
    try {
        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
        Connection con = ds.getConnection();

        PreparedStatement ps = con.prepareStatement(
            "SELECT STORE_ID, STORE_NAME, EMAIL, PHONE, CITY, IMAGE_URL FROM store_registration WHERE STORE_NAME=?"
        );
        ps.setString(1, storeName);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
%>

    <hr><br>
    <h3 style="color: white;">Store Found:</h3>

    <p style="color:white;"><b>Store Name:</b> <%= rs.getString("STORE_NAME") %></p>
    <p style="color:white;"><b>Email:</b> <%= rs.getString("EMAIL") %></p>
    <p style="color:white;"><b>Phone:</b> <%= rs.getString("PHONE") %></p>
    <p style="color:white;"><b>City:</b> <%= rs.getString("CITY") %></p>

    <% if (rs.getString("IMAGE_URL") != null) { %>
        <img src="<%= rs.getString("IMAGE_URL") %>" alt="Store Image">
    <% } %>

    <form id="deleteForm" action="DeleteStore" method="post">
        <input type="hidden" name="store_id" value="<%= rs.getInt("STORE_ID") %>">
        <button type="submit">Delete Store</button>
    </form>

<script>
document.getElementById("deleteForm").addEventListener("submit", function(e){
    e.preventDefault();
    Swal.fire({
        title: "Are you sure?",
        text: "This store will be permanently deleted.",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#b00020",
        cancelButtonColor: "#2962ff",
        confirmButtonText: "Yes, Delete"
    }).then((result) => {
        if (result.isConfirmed) {
            e.target.submit();
        }
    });
});
</script>

<%
        } else {
            out.println("<p style='color:white; text-align:center;'>Store Not Found</p>");
        }

        con.close();
    } catch (Exception ex) {
        out.println("<p style='color:white;'>Error: " + ex.getMessage() + "</p>");
    }
}
%>

</div>

<!-- ✅ SweetAlert result popup -->
<script>
<% if ("success".equals(request.getParameter("status"))) { %>
Swal.fire("Deleted!", "Store deleted successfully.", "success")
.then(() => window.location.href = "viewallstore.jsp");
<% } %>

<% if ("error".equals(request.getParameter("status"))) { %>
Swal.fire("Error", "Failed to delete the store. Try again.", "error");
<% } %>
</script>

</body>
</html>
