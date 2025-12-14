package p1;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/otpgenerator")
public class OTPGenerator extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session=request.getSession();
		String email=(String) session.getAttribute("email");
		
		String otp = String.valueOf(new Random().nextInt(900000) + 100000); //otp
                
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");
		
		Session sessionmail = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("mytv6970@gmail.com", "jskfssdukjczjhxe");
			}
		});
		
		
		
		try {
			MimeMessage message = new MimeMessage(sessionmail);
			message.setFrom(new InternetAddress(email));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			message.setSubject(otp+" is your reset code");
			message.setText("One more step to change your password \n Hi,\n We received your request to change your password. Enter this code in Fresh Farn Organics:\n");
			
			Transport.send(message);
		}

		catch (MessagingException e) {
			throw new RuntimeException(e);
		}
		
		session.setAttribute("otp",otp);
		RequestDispatcher rd= request.getRequestDispatcher("EnterOtp.jsp");
		rd.forward(request, response);


	}

}
