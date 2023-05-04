<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>

<%
    String id = request.getParameter("hostel_id");
    String floor = request.getParameter("HostelFloor");
    PreparedStatement stmt = null;
    ResultSet rs = null;
    
    String sql = "SELECT * FROM tblhostel where Hostel_id=?";
    
    stmt = con.prepareStatement(sql);
    stmt.setString(1, id);
    
    rs = stmt.executeQuery();
    
    if(rs.next()) {
        String data = rs.getString("Hostel_Map");
        String[] dataArray = data.split("]");
        
        String[][][] out1 = new String[dataArray.length][][];

      //out.println(dataArray.length + "<BR>");

      for(int i=0;i<dataArray.length;i++){
          String[] innerArray = dataArray[i].split(":");
          out1[i] = new String[innerArray.length][];
          for(int j=0;j<innerArray.length;j++){
              String[] valueArray = innerArray[j].split(",");
              out1[i][j] = new String[valueArray.length];
              for(int k=0;k<valueArray.length;k++){
                  out1[i][j][k] = valueArray[k];
                  //out.println(out1[i][j][k]);
              }//out.println("<BR>");
          }
      }
        
 %>
<div class="screen" style="color: black; text-align:center;">N</div>
<%
        String classValue = "seat";
        for(int i=0;i<=out1.length;i++)
        {
        	if((i+1) == Integer.parseInt(floor))
            {
        		%>
                <div class="movie-row">
                <% for(int j=0;j<out1[i].length;j++)
                   { %>
                   		<div class="seat-row">
                        <% for(int k=0;k<out1[i][j].length;k++)
                           { %>
                            <% if(out1[i][j][k].equals("seat")){ classValue="seat"; }
                               else if(out1[i][j][k].equals("staffuse")){ classValue="seat staffuse"; }
                               else if(out1[i][j][k].equals("occupied")){ classValue="seat occupied"; }
                               else if(out1[i][j][k].equals("whiteseat")){ classValue="seat whiteseat"; }
                            %>
                            <div class="<%=classValue%>"></div>
                        <% } %>
                    	</div>
                <% } %>
                </div>
                <%
        	}
    	}
    }
%>
