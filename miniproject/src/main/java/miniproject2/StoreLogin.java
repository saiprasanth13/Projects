package miniproject2;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/storelogin")
public class StoreLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                "SELECT store_id, store_username, password_hash FROM store_registration WHERE email = ?"
            );
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("password_hash");

                if (password.equals(dbPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("store_id", rs.getInt("store_id"));
                    session.setAttribute("store_username", rs.getString("store_username"));

                    response.sendRedirect("storedashboard.jsp");
                } else {
                    response.sendRedirect("login.jsp?error=wrongpassword");
                }
            } else {
                response.sendRedirect("login.jsp?error=nouser");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=exception");
        }
	}

}
