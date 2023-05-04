<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>
<%
  PreparedStatement stmt = null;
  
  String hostel_id = request.getParameter("hostel_id");
  
  String sql = "SELECT * FROM tblhostel WHERE Hostel_id = ?";
  stmt = con.prepareStatement(sql);
  stmt.setString(1, hostel_id);
  
  // Execute the SQL statement
  ResultSet rs = stmt.executeQuery();
%>

<option value="" selected disabled>Select a Floor</option>

<%
  int num = 0;
  if (rs.next()) {
    int hostelFloor = rs.getInt("Hostel_Floor");
    while (num < hostelFloor) {
%>
  <option value="<%=num+1%>"><%=num+1%></option>
<%
      num++;
    }
  }
%>

