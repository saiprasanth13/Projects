<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Store List</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
body {
    font-family: 'Inter', sans-serif;
    margin: 0;
    padding: 0;
    background: url("https://res.cloudinary.com/dpxrmf3vc/image/upload/v1762508718/Gemini_Generated_Image_7khd547khd547khd_szscf4.png") no-repeat center center fixed;
    background-size: cover;
}

/* Header with logo */
.header {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 15px;
    background: rgba(255,255,255,0.65);
    backdrop-filter: blur(7px);
}

.header img {
    height: 70px;
}

.container { width: 90%; margin: auto; padding-top: 40px; }

h2 {
    text-align: center;
    color: #ffffff;
    font-size: 32px;
    margin-bottom: 35px;
    font-weight: 600;
}

/* Store Cards Layout */
.store-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(270px, 1fr));
    gap: 30px;
}

/* Card Styling */
.store-card {
    position: relative;
    border-radius: 15px;
    overflow: hidden;
    height: 310px;
    cursor: pointer;
    background: rgba(255,255,255,0.35);
    backdrop-filter: blur(8px);
    box-shadow: 0px 4px 20px rgba(0,0,0,0.25);
    transition: transform .25s ease-in-out;
}

.store-card:hover {
    transform: translateY(-6px) scale(1.01);
}

/* Store Image */
.store-card img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* Hover Sliding Details */
.store-details {
    position: absolute;
    bottom: -100%;
    left: 0;
    width: 100%;
    padding: 18px;
    background: rgba(30, 86, 49, 0.93);
    color: white;
    transition: bottom .35s ease-in-out;
}

.store-card:hover .store-details {
    bottom: 0;
}

/* Buttons */
button {
    border: none;
    padding: 7px;
    width: 48%;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 600;
}

.update-btn { background: #fff; color: #1e5631; }
.delete-btn { background: #b81d13; color: white; }

.action-btns { display: flex; justify-content: space-between; margin-top: 12px; }

</style>
</head>

<body>

<div class="header">
    <img src="https://res.cloudinary.com/dpxrmf3vc/image/upload/v1761909191/Screenshot__71__copy-removebg-preview_1_ufupio.png">
</div>

<div class="container">
    <h2>All Registered Stores</h2>

    <div class="store-grid">
    <%
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
            Connection con = ds.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT STORE_ID, FULL_NAME, STORE_NAME, EMAIL, PHONE, CITY, IMAGE_URL FROM store_registration ORDER BY STORE_ID DESC"
            );
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String img = rs.getString("IMAGE_URL");
                if (img == null || img.trim().equals("")) {
                    img = "https://via.placeholder.com/400x300?text=No+Image";
                }
    %>

        <div class="store-card">
            <img src="<%= img %>" alt="Store Image">

            <div class="store-details">
                <h3><%= rs.getString("STORE_NAME") %></h3>
                <p><b>Owner:</b> <%= rs.getString("FULL_NAME") %></p>
                <p><b>Email:</b> <%= rs.getString("EMAIL") %></p>
                <p><b>Phone:</b> <%= rs.getString("PHONE") %></p>
                <p><b>City:</b> <%= rs.getString("CITY") %></p>

                <div class="action-btns">
                    <button class="update-btn"
                        onclick="window.location.href='updatestore.jsp?search_store=<%= rs.getString("STORE_NAME") %>'">
                        Update
                    </button>
                    <button class="delete-btn"
                        onclick="deleteStore(<%= rs.getInt("STORE_ID") %>)">
                        Delete
                    </button>
                </div>
            </div>
        </div>

    <%
            }
            con.close();
        } catch(Exception e){
            out.println("Error: " + e.getMessage());
        }
    %>
    </div>
</div>

<script>
function deleteStore(id) {
    Swal.fire({
        title: "Are you sure?",
        text: "This store will be deleted permanently!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#b81d13",
        cancelButtonColor: "#3085d6",
        confirmButtonText: "Yes, delete"
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = "DeleteStore?store_id=" + id;
        }
    });
}

<% if ("deleted".equals(request.getParameter("status"))) { %>
Swal.fire("Deleted!", "Store deleted successfully.", "success");
<% } %>

<% if ("error".equals(request.getParameter("status"))) { %>
Swal.fire("Error!", "Something went wrong.", "error");
<% } %>
</script>

</body>
</html>
