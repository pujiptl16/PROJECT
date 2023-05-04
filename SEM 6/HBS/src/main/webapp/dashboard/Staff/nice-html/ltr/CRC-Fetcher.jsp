<%@ page language="java" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>

<%
    String Type = request.getParameter("RecType");
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String query = "SELECT * FROM tblcomplain_type WHERE ReC_Type = ?";
    pstmt = con.prepareStatement(query);
    pstmt.setString(1, Type);
    rs = pstmt.executeQuery();
%>
        <option value="" disabled selected>Select SubType</option>
<%
        while(rs.next()){
%>
            <option value="<%=rs.getString("Cmp_Type_id")%>"><%=rs.getString("Cmp_Type")%></option>
<%
        }
%>
