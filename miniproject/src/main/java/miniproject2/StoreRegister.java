package miniproject2;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@MultipartConfig
@WebServlet("/StoreRegister")
public class StoreRegister extends HttpServlet {

    private String getFieldValue(Part part) throws IOException {
        return new String(part.getInputStream().readAllBytes(), StandardCharsets.UTF_8).trim();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // ✅ Read inputs
        
        String storeUsername = getFieldValue(request.getPart("store_username"));
        String fullName = getFieldValue(request.getPart("full_name"));
        String storeName = getFieldValue(request.getPart("store_name"));
        String email = getFieldValue(request.getPart("email"));
        String phone = getFieldValue(request.getPart("phone"));
        String password = getFieldValue(request.getPart("password"));
        String certificationUrl = getFieldValue(request.getPart("certification_url"));
        String city = getFieldValue(request.getPart("city"));
        String address = getFieldValue(request.getPart("address"));

        // ✅ Image upload to server
        Part imagePart = request.getPart("image_url");
        String fileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("/store_images");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        imagePart.write(uploadPath + "/" + fileName);
        String imageUrl = "store_images/" + fileName;

        try {
            // ✅ DB Connection
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "system", "3564"
            );

            // ✅ Duplicate Validation
            PreparedStatement checkDuplicate = conn.prepareStatement(
                "SELECT COUNT(*) FROM store_registration WHERE store_username=? OR email=? OR phone=? OR store_name=?"
            );
            checkDuplicate.setString(1, storeUsername);
            checkDuplicate.setString(2, email);
            checkDuplicate.setString(3, phone);
            checkDuplicate.setString(4, storeName);

            ResultSet duplicateResult = checkDuplicate.executeQuery();
            duplicateResult.next();

            if (duplicateResult.getInt(1) > 0) {
                conn.close();
                response.sendRedirect("storeregister.jsp?status=duplicate");
                return;
            }

            // ✅ Insert record
            String sql = """
              
    INSERT INTO store_registration
    (store_id, store_username, full_name, store_name, email, phone, password,
     certification_url, city, address, image_url)
    VALUES (store_reg_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
""";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, storeUsername);
            ps.setString(2, fullName);
            ps.setString(3, storeName);
            ps.setString(4, email);
            ps.setString(5, phone);
            ps.setString(6, password);
            ps.setString(7, certificationUrl);
            ps.setString(8, city);
            ps.setString(9, address);
            ps.setString(10, imageUrl);
            int rowsInserted = ps.executeUpdate();

            conn.close();

            response.sendRedirect("admindashboard.html?status=success");

        } catch (SQLException ex) {

            if (ex.getErrorCode() == 1) {
                response.sendRedirect("storeregister.jsp?status=duplicate");
            } else {
                response.getWriter().println("Database Error: " + ex.getMessage());
            }

        } catch (Exception e) {
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
