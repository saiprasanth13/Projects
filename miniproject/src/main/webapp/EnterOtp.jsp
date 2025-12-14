<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="verifyotp" method="post">
<h3>OTP has sent to your email</h3>
<input type=text placeholder="Enter your otp" name="enteredotp">
<% String error=(String)request.getAttribute("msg2"); 
	
	if (error != null) { %>
	   <div style="color: red;"><%= error %></div>
	<% } 
%>
<input type="submit" value=submit>
</form>

</body>
</html>