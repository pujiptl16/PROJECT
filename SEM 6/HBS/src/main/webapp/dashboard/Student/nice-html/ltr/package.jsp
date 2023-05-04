<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>
<%
   String package_id = request.getParameter("package_id");
   PreparedStatement stmt = null;
   ResultSet rs = null;

      stmt = con.prepareStatement("SELECT * FROM tblpackage WHERE Package_id = ?");
      stmt.setString(1, package_id);
      rs = stmt.executeQuery();

      if(rs.next()) {
          out.print(rs.getString("Package_Price"));
      }
%>
