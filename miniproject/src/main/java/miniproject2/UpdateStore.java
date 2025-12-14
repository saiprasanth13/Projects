package miniproject2;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet("/UpdateStore")
public class UpdateStore extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String storeId    = request.getParameter("store_id");
        String fullname   = request.getParameter("fullname");
        String storename  = request.getParameter("storename");
        String email      = request.getParameter("email");
        String phone      = request.getParameter("phone");
        String city       = request.getParameter("city");
        String address    = request.getParameter("address");
        String image      = request.getParameter("image");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
            con = ds.getConnection();

            String query = "UPDATE store_registration SET FULL_NAME=?, STORE_NAME=?, EMAIL=?, PHONE=?, CITY=?, ADDRESS=?, IMAGE_URL=? WHERE STORE_ID=?";

            ps = con.prepareStatement(query);

            ps.setString(1, fullname);
            ps.setString(2, storename);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, city);
            ps.setString(6, address);
            ps.setString(7, image);
            ps.setString(8, storeId);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("updatestore.jsp?status=success");
            } else {
                response.sendRedirect("updatestore.jsp?status=error");
            }

        } catch (SQLException e) {

            // ✅ CHECK DUPLICATE STORE NAME CONSTRAINT
            if (e.getErrorCode() == 1) {  // ORA-00001
                response.sendRedirect("updatestore.jsp?status=duplicate");
            } else {
                response.sendRedirect("updatestore.jsp?status=error");
            }

        } catch (NamingException e) {
            response.sendRedirect("updatestore.jsp?status=error");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}
