<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Store Login</title>
<style>
body { font-family: Arial, sans-serif; background:#f6f6f6; display:flex; justify-content:center; align-items:center; height:100vh; }
.card { background:white; padding:25px; border-radius:10px; width:350px; box-shadow:0 0 10px rgba(0,0,0,0.2); }
input { width:100%; padding:10px; margin-top:10px; border-radius:5px; border:1px solid gray; }
button { width:100%; padding:10px; background:#007bff; color:white; border:none; margin-top:15px; border-radius:5px; }
.error { color:red; font-size:14px; }
</style>
</head>
<body>

<div class="card">
<h2>Store Login</h2>

<form action="storelogin" method="post">
  <input type="email" name="email" placeholder="Enter Email" required>
  <input type="password" name="password" placeholder="Enter Password" required>
  <button type="submit">Login</button>
</form>

<%
  String error = request.getParameter("error");
  if ("wrongpassword".equals(error)) { out.print("<p class='error'>Incorrect Password!</p>"); }
  if ("nouser".equals(error)) { out.print("<p class='error'>User not found!</p>"); }
  if ("exception".equals(error)) { out.print("<p class='error'>Something went wrong!</p>"); }
%>

<br>
<a href="storeregister.jsp">New Store? Register Here</a>

</div>

</body>
</html>
