package com.HBS;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TesterMailer
 */
@WebServlet("/TesterMailer")
public class TesterMailer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TesterMailer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		out.println("Mailer<BR>");
		try {
			if(HBSMailer.sendMail("20bscit001@gmail.com", "Test Email 288 From Anvi", "Mail from Anvi Email id Sent Successfully."))
				out.println("Mail Sent<BR>");
			else
				out.println("Mail not Sent.<BR>");
			
			String Password = "Parth";
			HBSHashing.HashPaswword("ParthDesai");
			out.println("<BR>Stored Password : " + HBSHashing.getPassword());
			out.println("<BR>Stored Salt : " + HBSHashing.getSalt());
			out.println("<BR>Hashed Password : " + HBSHashing.getHashedPassword());
			out.println("<BR>Entered Password : " + Password);
			out.println("<BR>Verify Password : " + HBSHashing.VerifyHash(Password, HBSHashing.getHashedPassword(), HBSHashing.getSalt()));
			//out.println("<BR>Verify Password : " + HBSHashing.VerifyHash(HBSHashing.getPassword(), HBSHashing.getHashedPassword(), HBSHashing.getSalt()));
		}catch(Exception e) {
			out.println(e);
		}
		
	}

}
