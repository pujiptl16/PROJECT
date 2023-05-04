<%@ page language="java" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>

<%@ page import="java.sql.*,java.util.*,java.text.*" %>

<%
	if(request.getParameter("PaymentId") != null &&
	request.getParameter("UserId") != null &&
	request.getParameter("Amount") != null) {

		String uid = request.getParameter("UserId");
	    String amount = request.getParameter("Amount");
	    String mode = "Online";
	    String payId = request.getParameter("PaymentId");
	    String status = "Success";
	    String hostelId = request.getParameter("HostelId");
	    String packageId = request.getParameter("PackageId");
	    int roomIndex = Integer.parseInt(request.getParameter("RoomIndex"));
	    int floor = Integer.parseInt(request.getParameter("Floor"));
	    
	    java.util.Calendar cal = java.util.Calendar.getInstance();
	    cal.add(java.util.Calendar.DATE, 150);
	    java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
	    
	    String checkoutdate = dateFormat.format(cal.getTime()) + " 12:00:00";;
	    String stdstatus = "Active";

	    
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	   	pstmt = con.prepareStatement("SELECT * FROM `tblhostel` where `Hostel_id`=?");
	        pstmt.setString(1, hostelId);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            int availableRooms = rs.getInt("Available_Rooms") - 1;
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
	                        	out2[i][j][k] = "occupied";
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

	            /*List<List<List<String>>> out1 = new ArrayList<>();
	            int step = 0;
	            int last = dataArr.length;
	            String className = "seat";

	            for (int i = 0; i < last; i++) {
	                String[] items = dataArr[i].split(":");
	                List<List<String>> itemList = new ArrayList<>();
	                for (int j = 0; j < items.length; j++) {
	                    String[] values = items[j].split(",");
	                    List<String> valueList = new ArrayList<>();
	                    for (int k = 0; k < values.length; k++) {
	                        valueList.add(values[k]);
	                    }
	                    itemList.add(valueList);
	                }
	                out1.add(itemList);
	            }
	            
	            int roomCount = 0;
	            for (int i = 0; i < out1.size(); i++) {
	                for (int j = 0; j < out1.get(i).size(); j++) {
	                    for (int k = 0; k < out1.get(i).get(j).size(); k++) {
	                        if (i + 1 == floor && roomCount == roomIndex) {
	                            out1.get(i).get(j).set(k, "occupied");
	                        }
	                        roomCount++;
	                    }
	                }
	                roomCount = 0;
	            }

	            int count1 = 0;
	            int count2 = 0;
	            String mapdata = "";
	            
	            for (int i = 0; i < out1.size(); i++) {
	                count2 = 0;
	                for (int j = 0; j < out1.get(i).size(); j++) {
	                    count1 = 0;
	                    for (int k = 0; k < out1.get(i).get(j).size(); k++) {
	                        String value = out1.get(i).get(j).get(k);
	                        if (count1 == out1.get(i).get(j).size() - 1) {
	                            if (count2 != out1.get(i).size() - 1) {
	                                //out.print(value + ":");
	                                mapdata += value + ":";
	                            } else {
	                                //out.print(value);
	                                mapdata += value;
	                            }
	                        } else {
	                            //out.print(value + ",");
	                            mapdata += value + ",";
	                        }
	                        count1++;
	                    }
	                    if (count2 == out1.get(i).size() - 1) {
	                        //out.print("]");
	                        mapdata += "]";
	                    }
	                    count2++;
	                    //out.println("<br>");
	                }
	            }*/
	            
	            String roomid = "";
	            int HostelId = Integer.parseInt(request.getParameter("HostelId"));
	            int Floor = Integer.parseInt(request.getParameter("Floor"));
	            int RoomIndex = Integer.parseInt(request.getParameter("RoomIndex"));

	            if (HostelId < 10) {
	                if (Floor < 10) {
	                    roomid = HostelId + "00";
	                    roomid = roomid + "0" + Floor;
	                    if (RoomIndex < 10) {
	                        roomid = roomid + "0" + RoomIndex;
	                    } else if (RoomIndex >= 10 && RoomIndex < 100) {
	                        roomid = roomid + RoomIndex;
	                    }
	                } else if (Floor >= 10 && Floor < 99) {
	                    roomid = HostelId+"0";
	                    roomid = roomid + Floor;
	                    if (RoomIndex < 10) {
	                        roomid = roomid + "0" + RoomIndex;
	                    } else if (RoomIndex >= 10 && RoomIndex < 100) {
	                        roomid = roomid + RoomIndex;
	                    }
	                }
	            }
	            
	            String query = "INSERT INTO tblhostel_record(user_id, Hostel_id, Package_id, Room_id, Timestamp_Check_Out, User_Status) VALUES (?, ?, ?, ?, ?, ?)";
	            pstmt = con.prepareStatement(query);
	            pstmt.setString(1, uid);
	            pstmt.setString(2, String.valueOf(HostelId));
	            pstmt.setString(3, packageId);
	            pstmt.setString(4, roomid);
	            pstmt.setString(5, checkoutdate);
	            pstmt.setString(6, stdstatus);
	            int rows = pstmt.executeUpdate();
	            %>

	            <%
	            query = "SELECT * FROM tblhostel_record ORDER BY Record_id DESC LIMIT 1";
	            pstmt = con.prepareStatement(query);
	            rs = pstmt.executeQuery();
	            String rid1="";
	            
	            if(rs.next()){
	                rid1 = rs.getString("Record_id");
	            }
	            
	            String sqlInsert = "INSERT INTO `tbltransaction`(`user_id`, `Record_id`, `Trn_Amount`, `Trn_Mode`, `Trn_refference_id`, `Trn_Status`) VALUES (?, ?, ?, ?, ?, 'Success')";
	            pstmt = con.prepareStatement(sqlInsert);
	            pstmt.setString(1, uid);
	            pstmt.setString(2, rid1);
	            pstmt.setString(3, amount);
	            pstmt.setString(4, mode);
	            pstmt.setString(5, payId);
	            pstmt.executeUpdate();

	            // Select from tbltransaction
	            String sqlSelect = "SELECT * FROM `tbltransaction` ORDER BY `Trn_id` DESC LIMIT 1";
	            pstmt = con.prepareStatement(sqlSelect);
	            rs = pstmt.executeQuery();
	            int tid;
	            if (rs.next()) {
	                tid = rs.getInt("Trn_id");
	            } else {
	                tid = 1;
	            }
	            
	            String updateRecordSql = "UPDATE tblhostel_record SET Trn_id = ? WHERE Record_id = ?";
	            String updateHostelSql = "UPDATE tblhostel SET Available_Rooms = ?, Hostel_Map = ? WHERE Hostel_id = ?";
	            
	            // Create a PreparedStatement for each query
	            PreparedStatement updateRecordStmt = con.prepareStatement(updateRecordSql);
	            PreparedStatement updateHostelStmt = con.prepareStatement(updateHostelSql);
	            
	            // Set the parameters for each query
	            updateRecordStmt.setString(1, String.valueOf(tid));
	            updateRecordStmt.setString(2, String.valueOf(rid1));
	            updateHostelStmt.setString(1, String.valueOf(availableRooms));
	            updateHostelStmt.setString(2, mapdata);
	            updateHostelStmt.setString(3, hostelId);
	            
	            // Execute the queries
	            updateRecordStmt.executeUpdate();
	            updateHostelStmt.executeUpdate();
	        }

	
	}      
 %>
 
 
                