<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"
		import="com.HBS.DatabaseConnection"
%>
<% 
//DatabaseConnection db = new DatabaseConnection();
Connection con = null;
try {
   	con = DatabaseConnection.InitializeDatabase("dormzz");
    if(con != null) {
    	//out.println("<script>alert('Database Connected Successfully.')</script>");
    } else {
    	out.println("<script>alert('Database Not Connected.')</script>");
    }
}
catch (Exception e) {
	out.println("<script>alert('Error Establishing Database Connection.')</script>");
	e.printStackTrace();
}
%>