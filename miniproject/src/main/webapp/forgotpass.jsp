<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Farm Fresh Organics.com</title>
</head>
<body>
<form action="verifyemail" method="post">
<label>Enter Your Registered Email</label><br>
<input type=text placeholder="email" name=email><br>

<% String error=(String)request.getAttribute("msg"); 
	
	if (error != null) { %>
	   <div style="color: red;"><%= error %></div>
	<% } 
%>

<input type=submit value=search>
</form>
</body>
</html>