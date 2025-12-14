<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f2f2f2;
    }
    .container {
        width: 350px;
        margin: 100px auto;
        background-color: white;
        padding: 25px;
        border-radius: 8px;
        box-shadow: 0px 0px 8px rgba(0, 0, 0, 0.2);
    }
    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 10px;
        margin: 8px 0;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    input[type="submit"] {
        width: 100%;
        padding: 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>

<div class="container">
    <h2>Admin Login</h2>

    <!-- LOGIN FORM -->
    <form action="admindashboard.html" method="post">
        <label for="user">Admin Username:</label>
        <input type="text" name="user" required>

        <label for="pwd">Admin Password:</label>
        <input type="password" name="pwd" required>

        <input type="submit" value="Login">
    </form>
</div>

</body>
</html>
