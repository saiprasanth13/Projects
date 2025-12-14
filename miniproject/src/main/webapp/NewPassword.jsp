<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="newpassword" method="post">
<label>new password</label><br>
<input type=password name="newpass"><br>
<label>confirm password</label><br>
<input type=password name="confirm"><br>
<% String error=(String)request.getAttribute("msg3"); 
	
	if (error != null) { %>
	   <div style="color: red;"><%= error %></div>
	<% } 
%>
<input type=submit value=reset>
</form>
</body>
</html>
