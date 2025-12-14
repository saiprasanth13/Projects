package miniproject2;

import java.io.IOException;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteStore")
public class DeleteStore extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response); // Allow GET requests also
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
			Connection con = ds.getConnection();

			PreparedStatement ps = con.prepareStatement(
				"DELETE FROM store_registration WHERE STORE_ID=?"
			);
			ps.setInt(1, Integer.parseInt(request.getParameter("store_id")));

			int result = ps.executeUpdate();
			con.close();

			if (result > 0) {
				response.sendRedirect("deletestore.jsp?status=success");
			} else {
				response.sendRedirect("deletestore.jsp?status=error");
			}

		} catch (Exception e) {
			System.out.println("Delete Error: " + e.getMessage());
			response.sendRedirect("deletestore.jsp?status=error");
		}
	}
}
