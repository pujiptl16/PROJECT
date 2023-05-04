package com.HBS;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PDFGenerator
 */
@WebServlet("/InvoiceDownloader")
public class PDFGenerator extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PDFGenerator() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// Set the content type and attachment header
		
		String Fname="", Lname="";
		
		Connection con = null;
		try {
		   	con = DatabaseConnection.InitializeDatabase("dormzz");
		    if(con != null) {
		    	//out.println("<script>alert('Database Connected Successfully.')</script>");
		    	String query = "SELECT RG.EnrollmentNo, RG.FirstName, RG.LastName, RG.Email, RG.PhoneNo, RG.Gender, PK.Package_Name, PK.Package_Price, TR.Trn_Timestamp, TR.Trn_Amount, TR.Trn_Mode, TR.Trn_refference_id FROM tbltransaction TR LEFT JOIN tblhostel_record HR ON TR.Record_id = HR.Record_id LEFT JOIN tblpackage PK ON HR.Package_id = PK.Package_id LEFT JOIN tblregister RG ON TR.user_id = RG.user_id WHERE TR.Trn_id = ?";
				
				String id = request.getParameter("invoice_id");
				PreparedStatement statement = con.prepareStatement(query);
			    statement.setString(1, id);
			    ResultSet rs = statement.executeQuery();
				
			    if (rs.next()) {
			    	Fname = rs.getString("FirstName");
			    	Lname = rs.getString("LastName");
			    }
		    } else {
		    	System.out.println("Database Not Connected.");
		    }
		}
		catch (Exception e) {
			System.out.println("Error Establishing Database Connection. "+e.toString());
		}
		
		String Name = "DormzzInvoice_"+Fname+Lname+".pdf";
		response.setContentType("application/pdf");
		response.setHeader("Content-disposition", "attachment; filename=" + Name);
		ServletOutputStream out = response.getOutputStream();
		InvoiceGenerator.GeneratePDF(Name, request, response);
		//System.out.println(request.getParameter("invoice_id"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
