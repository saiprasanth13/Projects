<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Store Registration - Farm Fresh Organics</title>
  <link href="https://fonts.googleapis.com/css2?family=Quicksand&display=swap" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      font-family: 'Quicksand', sans-serif;
      background: url('https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
      background-size: cover;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      overflow: hidden;
    }

    .form-container {
      background: rgba(255,255,255,0.92);
      padding: 30px;
      border-radius: 20px;
      width: 430px;
      box-shadow: 0 12px 24px rgba(0,0,0,0.2);
      animation: slideUp 1.2s ease-in-out;
      backdrop-filter: blur(8px);
      text-align: center;
      border: 2px solid #a3c9a8;
    }

    @keyframes slideUp {
      0% { transform: translateY(60px); opacity: 0; }
      100% { transform: translateY(0); opacity: 1; }
    }

    .logo { width: 120px; margin-bottom: 10px; }

    input, textarea {
      width: 100%; padding: 12px; margin-top: 10px; border-radius: 10px;
      border: 1px solid #b2d8b2; font-size: 15px; background-color: #f7fff7;
    }

    button {
      width: 100%; padding: 12px; margin-top: 15px; border-radius: 10px;
      border: none; background: #6bbf59; color: white; font-size: 17px;
      cursor: pointer; transition: 0.3s;
    }

    button:hover { background-color: #4a7c59; transform: scale(1.05); }
  </style>
</head>
<body>

<form class="form-container" action="StoreRegister" method="post" enctype="multipart/form-data">
  <img src="https://res.cloudinary.com/dpxrmf3vc/image/upload/v1761909191/Screenshot__71__copy-removebg-preview_1_ufupio.png" class="logo">

  <h2>Store Registration</h2>
  
  <input type="text" name="store_username" placeholder="Store Username" required>
  <input type="text" name="full_name" placeholder="Owner Full Name" required>
  <input type="text" name="store_name" placeholder="Store Name" required>
  <input type="email" name="email" placeholder="Email Address" required>
  <input type="text" name="phone" placeholder="Phone Number" required>
  <input type="password" name="password" placeholder="Password" required>
  <input type="text" name="certification_url" placeholder="Certification URL (optional)">
  <input type="text" name="city" placeholder="City (default Hyderabad)">
  <textarea name="address" placeholder="Full Store Address"></textarea>

  <label style="margin-top:8px; font-size:14px; color:#4a7c59;">Upload Store Image</label>
  <input type="file" name="image_url" accept="image/*" required>

  <button type="submit">Register Store</button>
</form>

<!-- ✅ SWEET ALERT POPUP -->
<script>
<% if ("duplicate".equals(request.getParameter("status"))) { %>
Swal.fire("Duplicate Entry ❌", "Username / Email / Phone / Store Name already exists.", "warning");
<% } %>

<% if ("success".equals(request.getParameter("status"))) { %>
Swal.fire("Registration Successful ✅", "Your store has been submitted for approval.", "success");
<% } %>
</script>

</body>
</html>
