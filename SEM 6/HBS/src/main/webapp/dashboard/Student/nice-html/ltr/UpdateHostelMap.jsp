<%@ page language="java" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>

<%@ page import="java.sql.*,java.util.*,java.text.*" %>

<%

		String uid = request.getParameter("UserId");
	    String RecordId = request.getParameter("RecordId");
	    String RoomId = request.getParameter("RoomId");
	    String HostelId = request.getParameter("HostelId");
	    
	    int floor = Integer.parseInt(RoomId.substring(3, 5));
        int roomIndex = Integer.parseInt(RoomId.substring(5));
	       
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	   	pstmt = con.prepareStatement("SELECT * FROM `tblhostel` where `Hostel_id`=?");
	        pstmt.setString(1, HostelId);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            int availableRooms = rs.getInt("Available_Rooms") + 1;
	            String data = rs.getString("Hostel_Map");
	            String[] dataArray = data.split("]");
	            
	            int roomCount = 0;
	            String[][][] out2 = new String[dataArray.length][][];
	            String mapdata = "";
	            int count1 = 0;
	            int count2 = 0;

	            for(int i=0;i<dataArray.length;i++){
	                String[] innerArray = dataArray[i].split(":");
	                out2[i] = new String[innerArray.length][];
	                count2 = 0;
	                for(int j=0;j<innerArray.length;j++){
	                    String[] valueArray = innerArray[j].split(",");
	                    out2[i][j] = new String[valueArray.length];
	                    count1 = 0;
	                    for(int k=0;k<valueArray.length;k++){
	                    	if (i + 1 == floor && roomCount == roomIndex) {
	                        	out2[i][j][k] = "seat";
	                        }else{
	                    		out2[i][j][k] = valueArray[k];
	                        }
	                    	
	                    	if (count1 == out2[i][j].length - 1) {
	                            if (count2 != out2[i].length - 1) {
	                                //out.print(value + ":");
	                                mapdata += out2[i][j][k] + ":";
	                            } else {
	                                //out.print(value);
	                                mapdata += out2[i][j][k];
	                            }
	                        } else {
	                            //out.print(value + ",");
	                            mapdata += out2[i][j][k] + ",";
	                        }
	                        count1++;
	                        
	                    	out.println(out2[i][j][k]);
	                        roomCount++;
	                    }
	                    if (count2 == out2[i].length - 1) {
	                        //out.print("]");
	                        mapdata += "]";
	                    }
	                    count2++;
	                }
	                roomCount = 0; 
	            }
	            
	            String updateHostelSql = "UPDATE tblhostel SET Available_Rooms = ?, Hostel_Map = ? WHERE Hostel_id = ?";
	            
	            // Create a PreparedStatement for each query
	            PreparedStatement updateHostelStmt = con.prepareStatement(updateHostelSql);
	            
	            // Set the parameters for each query
	            updateHostelStmt.setString(1, String.valueOf(availableRooms));
	            updateHostelStmt.setString(2, mapdata);
	            updateHostelStmt.setString(3, HostelId);
	            
	            // Execute the queries
	            updateHostelStmt.executeUpdate();
	        }
   
 %>
 
 
                