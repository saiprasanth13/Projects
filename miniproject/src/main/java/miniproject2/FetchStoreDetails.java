package miniproject2;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/fetchstoredetails")
public class FetchStoreDetails extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String storeName = request.getParameter("storeName");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "system", "3564");

            String sql = "SELECT STORE_NAME, EMAIL, PHONE, CITY, ADDRESS, IMAGE_URL " +
                         "FROM store_registration WHERE STORE_NAME = ?";

            ps = con.prepareStatement(sql);
            ps.setString(1, storeName);
            rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("storeName", rs.getString("STORE_NAME"));
                request.setAttribute("email", rs.getString("EMAIL"));
                request.setAttribute("phone", rs.getString("PHONE"));
                request.setAttribute("city", rs.getString("CITY"));
                request.setAttribute("address", rs.getString("ADDRESS"));
                request.setAttribute("imageUrl", rs.getString("IMAGE_URL"));

                request.getRequestDispatcher("updatestore.jsp").forward(request, response);
            } else {
                response.sendRedirect("updatestore.jsp?status=notfound");
            }

        } catch (Exception e) {
            response.sendRedirect("updatestore.jsp?status=error");
        }
    }
}
