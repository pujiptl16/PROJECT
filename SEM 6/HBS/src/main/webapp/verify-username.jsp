<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>

<%
//System.out.println("Hello");
//out.println("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js'></script>");

String dbDriver = "com.mysql.cj.jdbc.Driver";
String dbURL = "jdbc:mysql://localhost:3305/";
// Database name to access
String dbName = "dormzz";
String dbUsername = "root";
String dbPassword = "root";
Connection con = null;


try{
	Class.forName(dbDriver);
	con = DriverManager.getConnection(dbURL + dbName, dbUsername, dbPassword);
	
	if(con == null){
		out.print("1");
		return;
	} else {
		String username = request.getParameter("username");
		System.out.println(username);
		String query = "SELECT * FROM tblregister WHERE Username='" + username + "';";

		PreparedStatement ps=con.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet result = ps.executeQuery(query);
	
		if (result.next()) {
		    // Return success if the username was found
		    
		    int otp = (int)(Math.random() * ((999999 - 100000) + 1)) + 100000;
			String MailSubject = "Dormzz : Password Reset Request";
			String MailBody = "Your OTP to reset password is : " + String.valueOf(otp) + "\nThank You.\nTeam Dormzz";
			String email = result.getString("email");
			
			System.out.println(otp);
			
			if(HBSMailer.sendMail(email, MailSubject, MailBody))
				out.println(String.valueOf(otp));
			else
				out.println("1");
				
		    
		  } else {
		    // Return an error if the username was not found
		    out.println("1");
		  }
	}

	
} catch(Exception e){
	System.out.println(e.toString());
}
%>
