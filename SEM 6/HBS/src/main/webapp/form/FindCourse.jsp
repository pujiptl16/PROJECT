<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="../DBConnection.jsp" %>
<%
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String id = request.getParameter("department_id");
	String CourseName = request.getParameter("CourseN");
	stmt = con.prepareStatement("SELECT * FROM tblcourse where d_id=?");
	stmt.setString(1, id);
	rs = stmt.executeQuery();
	%>
	
	<option value="" disabled selected >Select Course</option>
	<%
	while (rs.next()) {
	%>
	<option value="<%= rs.getInt("cr_id") %>" style="color:#6c757d" ><%= rs.getString("cr_name") %></option>
	<%
	}
%>