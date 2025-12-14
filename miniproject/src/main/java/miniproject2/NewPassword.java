package p1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/newpassword")
public class NewPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String newpass=request.getParameter("newpass");
		String confirm=request.getParameter("confirm");
		
		if (newpass.equals(confirm)) {
			HttpSession session=request.getSession();
			String email=(String) session.getAttribute("email");
			try{
				Class.forName("oracle.jdbc.OracleDriver");
				Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","123");
		    
				PreparedStatement pst = con.prepareStatement("update userdata set password=? where email=?");
				pst.setString(1,newpass);
				pst.setString(2, email);
				
				pst.executeUpdate();
								
				request.setAttribute("msg4", "your password is updated");
				RequestDispatcher rd = request.getRequestDispatcher("result.jsp");//redirect to login page
				rd.forward(request, response);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
            
		}else {
				
				request.setAttribute("msg3", "Passwords do not match");
	            RequestDispatcher rd = request.getRequestDispatcher("NewPassword.jsp");
	            rd.forward(request, response);
				}
			
		
	}

}
