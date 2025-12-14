package p1;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/verifyemail")
public class VerifyEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		
		HttpSession session=request.getSession();
		session.setAttribute("email", email);
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","123");
	    
			PreparedStatement pst = con.prepareStatement("select * from userdata where email=?");
			pst.setString(1, email);
	   
		    ResultSet rs=pst.executeQuery();
		    boolean exist=rs.next();
		    	
		    	if(exist) {
		    		RequestDispatcher rd=request.getRequestDispatcher("otpgenerator");
		    		rd.forward(request, response);
		    		
		    	}else {
		    		request.setAttribute("msg", "Email not found");
		    		RequestDispatcher rd=request.getRequestDispatcher("forgotpass.jsp");
		    		rd.forward(request, response);
		    	}
		    	
		    	
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	}


