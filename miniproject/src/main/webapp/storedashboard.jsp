<%
if (session.getAttribute("store_id") == null) {
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Dashboard</title>
</head>
<body>
<h1>Welcome, <%= session.getAttribute("store_username") %></h1>

<a href="logout.jsp">Logout</a>
</body>
</html>
