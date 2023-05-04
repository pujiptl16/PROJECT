<%@ page language="java" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>

<%@ page import="java.sql.*,java.util.*,java.text.*" %>
<%
	System.out.println("Hello from Event");
System.out.println(request.getAttribute("Hostel_id"));
System.out.println(request.getAttribute("Room_id"));


%>