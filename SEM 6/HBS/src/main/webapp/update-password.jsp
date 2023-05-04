<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		String newpass = request.getParameter("newpass");
		
		//out.println("<script>alert('Hash : "+ Hash +"<br>Salt : " + Salt + "');</script>");
        String hash_pass = HBSHashing.HashPaswword(newpass);
		String Salt = HBSHashing.getSalt();
		
		
		String query = "UPDATE tblregister SET Password='" + hash_pass + "', Salt='" + Salt + "' WHERE Username='" + username + "';";
		int result = DatabaseConnection.InsertQuery(query,con);
		
		if(result > 0) {
			out.println("updated");
			//response.sendRedirect("login.jsp");
		}
		else {
			out.println("1");
		}
		System.out.println(username);

	}

	
} catch(Exception e){
	System.out.println(e.toString());
}
%>
