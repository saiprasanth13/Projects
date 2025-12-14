package p1;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/verifyotp")
public class VerifyOTP extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String enteredotp=request.getParameter("enteredotp");
		HttpSession session=request.getSession();
		String otp=(String)session.getAttribute("otp");
		
		try {
			if(otp.equals(enteredotp)) {
				RequestDispatcher rd=request.getRequestDispatcher("NewPassword.jsp");
				rd.forward(request, response);
			}else{
				request.setAttribute("msg2", "You entered wrong otp");
		    		RequestDispatcher rd=request.getRequestDispatcher("EnterOtp.jsp");
		    		rd.forward(request, response);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
