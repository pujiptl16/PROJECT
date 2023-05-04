<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat, java.util.Date"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>

<%

	Statement stmt = null;
	ResultSet rs = null;
    stmt = con.createStatement();
    session=request.getSession();

    int id = 0;
    String fname = "";
    String lname = "";
    String EnNo = "";
    String email = "";
    String department = "";
    String phone = "";
    String role = "";
    int user = 0;
    String username="";
    String pass = "";
    boolean update = false;
    
    
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Expires","0");
	response.setDateHeader("Expires",-1);
	
    // Check if session exists
    if(session.getAttribute("username")==null) 
	{
	    response.sendRedirect("../../../../form/login.jsp");
	} else {
		
		if(request.getParameter("RoleAdd") != null){
			role = request.getParameter("RoleName");
			
			PreparedStatement pstmt = null;
			String message = null;

		    pstmt = con.prepareStatement("INSERT INTO `tblrole`(`Role_Type`) VALUES (?)");
		    pstmt.setString(1, role);
		    
		    int rowsInserted = pstmt.executeUpdate();
		    
		    if(rowsInserted > 0){
		        message = "Role Stored Successfully.";
		    }
		    session.setAttribute("message1", message);
			response.sendRedirect("starter-kit.jsp");
		}
		
		if(request.getParameter("RoleCancel") != null){
			response.sendRedirect("starter-kit.jsp");
		}

		if (request.getParameter("r-edit") != null) {
			id = Integer.parseInt(request.getParameter("r-edit"));
			update = true;
			ResultSet record = con.createStatement().executeQuery("SELECT * FROM tblrole WHERE Role_id=" + id);


			if (record.next()) {
			    role = record.getString("Role_Type");
			}
		}
		
		if (request.getParameter("RoleUpdate") != null) {
			id = Integer.parseInt(request.getParameter("id"));
			role = request.getParameter("RoleName");

			
			con.createStatement().executeUpdate("UPDATE tblrole SET Role_Type='" + role + "' WHERE Role_id=" + id);
			session.setAttribute("message1", "Role Updated Successfully."); 
			response.sendRedirect("starter-kit.jsp");
		}

		if (request.getParameter("r-del") != null) {
			id = Integer.parseInt(request.getParameter("r-del"));
			String query = "DELETE FROM tblrole WHERE Role_id='" + id + "'";
			con.createStatement().executeUpdate(query);
			session.setAttribute("message1", "Role Deleted Successfully.");
			response.sendRedirect("starter-kit.jsp");
		}
		
		if(request.getParameter("AssignDesignation")!=null){
		    user=Integer.parseInt(request.getParameter("StaffUser"));
		    role=request.getParameter("StaffUserDesignation");
		    int hostel=Integer.parseInt(request.getParameter("StaffUserDesignationHostel"));
		    
		    String query = "SELECT * FROM tblstaff WHERE user_id="+user;
		    ResultSet record = stmt.executeQuery(query);
		    
		    String db_role="";
		    
		    while(record.next())
		        db_role = db_role+record.getInt("Role_id")+",";

		    String[] arr_role = db_role.split(",");

		    if(!Arrays.asList(arr_role).contains(role)){
		        if(!record.next()){
		            String insertQuery = "INSERT INTO tblstaff(user_id, Role_id, Hostel_id) VALUES ('"+user+"','"+role+"', '"+hostel+"')";
		            stmt.executeUpdate(insertQuery);
		            session.setAttribute("message2","Designation Assigned Successfully.");
		        }else{
		            String updateQuery = "UPDATE tblstaff SET Role_id='"+role+"', Hostel_id='"+hostel+"' WHERE user_id='"+user+"'";
		            stmt.executeUpdate(updateQuery);
		            session.setAttribute("message2","Designation Updated Successfully.");
		        }
		        response.sendRedirect("starter-kit.jsp");
		    }else{
		        session.setAttribute("message2","Designation Already Assigned.");
		        response.sendRedirect("starter-kit.jsp");   
		    }
		}

		if(request.getParameter("del")!=null){
		    id = Integer.parseInt(request.getParameter("del"));
		    String query = "DELETE FROM tblregister WHERE user_id='"+id+"'";
		    stmt.executeUpdate(query);
		    session.setAttribute("message","Staff Member record Deleted Successfully."); 
		    response.sendRedirect("starter-kit.jsp");
		}

		if(request.getParameter("edit")!=null){
		    id = Integer.parseInt(request.getParameter("edit"));
		    update = true;
		    String query = "SELECT * FROM tblregister WHERE user_id='"+id+"'";
		    ResultSet record = stmt.executeQuery(query);

		    if(record.next()){
		        fname = record.getString("FirstName");
		        lname = record.getString("LastName");
		        EnNo = record.getString("EnrollmentNo");
		        email = record.getString("Email");
		        department = record.getString("DepartmentName");
		        phone = record.getString("PhoneNo");
		    }
		}

		if(request.getParameter("StudUpdate")!=null) {
			id = Integer.parseInt(request.getParameter("id"));
			fname = request.getParameter("Fname");
			lname = request.getParameter("Lname");
			EnNo = request.getParameter("EnNo");
			email = request.getParameter("Email");
			department = request.getParameter("Department");
			//phone = request.getParameter("Phone");

			PreparedStatement pstmt = null;
			String query = "UPDATE tblregister SET FirstName=?, LastName=?, EnrollmentNo=?, Email=?, DepartmentName=? WHERE user_id=?";
		    pstmt = con.prepareStatement(query);

		    pstmt.setString(1, fname);
		    pstmt.setString(2, lname);
		    pstmt.setString(3, EnNo);
		    pstmt.setString(4, email);
		    pstmt.setString(5, department);
		    pstmt.setInt(6, id);

		    int rowsAffected = pstmt.executeUpdate();

		    if (rowsAffected > 0) {
		        session.setAttribute("message", "Staff Member record Updated Successfully.");
		        response.sendRedirect("starter-kit.jsp");
		    } else {
		        out.println("<script>alert('Unknown Error Occured.')</script>");
		    }
			
		}

		if(request.getParameter("StaffAdd")!=null) {
			username = request.getParameter("username");
			fname = request.getParameter("Fname");
			lname = request.getParameter("Lname");
			EnNo = request.getParameter("EnNo");
			department = request.getParameter("Department");
			pass = request.getParameter("password");
			email = request.getParameter("Email");
			
			PreparedStatement pstmt = null;
			rs = null;

			
		    String query = "SELECT * FROM tblregister WHERE Username=?";
		    pstmt = con.prepareStatement(query);

		    pstmt.setString(1, username);

		    rs = pstmt.executeQuery();

		    if(!rs.next()) {
		        
		        email = email.replaceAll("\\s", "");

		        if (email.matches("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@" + "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$")) {
		            
		            String hash_pass = HBSHashing.HashPaswword(pass);
					String Salt = HBSHashing.getSalt();
					
		            query = "INSERT INTO `tblregister`(`EnrollmentNo`, `DepartmentName`, `Username`, `Password`, `Salt`, `FirstName`, `LastName`, `Email`) VALUES (?,?,?,?,?,?,?,?)";
		            pstmt = con.prepareStatement(query);

		            pstmt.setString(1, EnNo);
		            pstmt.setString(2, department);
		            pstmt.setString(3, username);
		            pstmt.setString(4, hash_pass);
		            pstmt.setString(5, Salt);
		            pstmt.setString(6, fname);
		            pstmt.setString(7, lname);
		            pstmt.setString(8, email);

		            int rowsAffected = pstmt.executeUpdate();

		            if (rowsAffected > 0) {
		                session.setAttribute("message", "Staff Member record Added Successfully.");
		                response.sendRedirect("starter-kit.jsp");
		            } else {
		                out.println("<script>alert('Unknown Error Occured.')</script>");
		            }
		        } else {
		            out.println("<script>alert('Invalid Email Address.')</script>");
		        }
		    } else {
		    	out.println("<script>alert('Username is not Available.')</script>");
	        }
		}
		
		if (request.getParameter("StudAdd") != null) {
			id = Integer.parseInt(request.getParameter("id"));
			fname = request.getParameter("Fname");
			lname = request.getParameter("Lname");
			EnNo = request.getParameter("EnNo");
			email = request.getParameter("Email");
			department = request.getParameter("Department");
			phone = request.getParameter("Phone");

			String query = "INSERT INTO tblregister (`FirstName`, `LastName`, `EnrollmentNo`, `Email`, `DepartmentName`, `PhoneNo`) VALUES ('" + fname + "','" + lname + "','" + EnNo + "','" + email + "','" + department + "','" + phone + "')";
			int result = stmt.executeUpdate(query);
			if (result > 0) {
			    session.setAttribute("message", "User Added Successfully.");
			    response.sendRedirect("starter-kit.jsp");
			}
		}
	}
    
%>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords"
        content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, Nice lite admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, Nice admin lite design, Nice admin lite dashboard bootstrap 5 dashboard template">
    <meta name="description"
        content="Nice Admin Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
    <meta name="robots" content="noindex,nofollow">
    <title>Dormzz - Designation Management</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/niceadmin-lite/" />
    <link rel="shortcut icon" type="image/x-icon" href="../../../../images/favicon.png" />
    <!-- Favicon icon 
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    -->
    <!-- Custom CSS -->
    <link href="../../dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
<script>

		function letters(evt) {
		    var charCode = (evt.which) ? evt.which : event.keyCode
		    if ((charCode >= 65 && charCode <= 90) || (charCode >= 97 && charCode <= 122) || charCode == 32 || charCode == 46)
		        return true;
		    else {
		        //alert("Please Enter valid input");
		        return false;
		    }
		}

        function isNumber(evt) {
                evt = (evt) ? evt : window.event;
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                        return false;
                }
                return true;
        }

        function checkDelete(){
                return confirm('Are you sure?');
        }

        function AskPermission() {
            if (confirm("Are you sure?")) {
                return true;
            }
            return false;
        }
</script><link href="../../../SearchStyle.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
</head>

<body>
    <!-- ============================================================== -->
    <!-- Preloader - style you can find in spinners.css -->
    <!-- ============================================================== -->
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper" data-navbarbg="skin6" data-theme="light" data-layout="vertical" data-sidebartype="full"
        data-boxed-layout="full">
        <!-- ============================================================== -->
        <!-- Topbar header - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <%@include file="../../../HeaderFile.jsp" %>
        <!-- ============================================================== -->
        <!-- End Topbar header -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
                <%@include file="AdminMenuFile.jsp" %>
        <!-- ============================================================== -->
        <!-- End Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper  -->
        <!-- ============================================================== -->
        <div class="page-wrapper">
            <!-- ============================================================== -->
            <!-- Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-5 align-self-center">
                        <h4 class="page-title">Staff Panel</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Staff Panel</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid">
                <!-- ============================================================== -->
                <!-- Start Page Content -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Designation Management</h4>
                                <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-1-box-multiple-outline"></i> Manage Designation</h6>
                                
                                <table class="table">
                                    <% if (session.getAttribute("message2") != null) { %>
									
									<tr scope="col" 
									    <% if (session.getAttribute("message2").equals("Designation Already Assigned.")) { %> 
									        class="table-danger" 
									    <% } else { %> 
									        class="table-success" 
									    <% } %>
									>
									    <th colspan='12'>
									        <center>
									            <%= session.getAttribute("message2") %>
									
									            <% 
									            int flag = (Integer) session.getAttribute("flag") + 1;
												
									            session.setAttribute("flag", flag);
									            if (flag > 1) {
									                session.removeAttribute("message2");
									                session.setAttribute("flag", 0);
									            }
									            %>
									        </center>
									    </th>
									</tr>
								<% } %>
                                </table>            
                                <form method="post" action="" class="form-horizontal form-material mx-2" style="width:50%">
                                    <div class="form-group">
                                        <label class="col-sm-12">Select Staff Member</label>
                                        <div class="col-sm-12">
                                            <select name="StaffUser" id="StaffUser" class="form-select shadow-none form-control-line">
                                            <%
											    stmt = null;
											    rs = null;
											    
											    
											        String query = "SELECT * FROM tblregister";
											        stmt = con.createStatement();
											        rs = stmt.executeQuery(query);
											        
											        while (rs.next()) {
											            if (rs.getString("EnrollmentNo").length() <= 10) {
											%>
											                <option value="<%= rs.getInt("user_id") %>"><%= rs.getString("EnrollmentNo") + " | " + rs.getString("FirstName") + " " + rs.getString("LastName") %></option>
											<%
											            }
											        }
											%>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-12">Select Designation</label>
                                        <div class="col-sm-12">
                                            <select name="StaffUserDesignation" id="StaffUserDesignation" class="form-select shadow-none form-control-line">
                                                <%
												    stmt = null;
												    rs = null;
											        
												    stmt = con.createStatement();
											        String sql = "SELECT * FROM tblrole";
											        rs = stmt.executeQuery(sql);
											        while(rs.next()){
												%>
												        <option value="<%= rs.getString("Role_id") %>"><%= rs.getString("Role_Type") %></option>
												<%
												    }
												%>

                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="col-sm-12">Select Hostel</label>
                                        <div class="col-sm-12">
                                            <select name="StaffUserDesignationHostel" id="StaffUserDesignationHostel" class="form-select shadow-none form-control-line">
                                                <%
													stmt = con.createStatement();
													rs = stmt.executeQuery("SELECT * FROM tblhostel");
													while (rs.next()) {
													%>
													    <option value="<%= rs.getInt("Hostel_id") %>"><%= rs.getString("Hostel_Name") %></option>
													<%
													}
													%>

                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="submit" name="AssignDesignation" class="btn btn-success text-white" onclick="return AskPermission()">Assign</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title mb-1">Role Management</h5>
                                <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-1-box-multiple-outline"></i><a href="starter-kit.jsp?r-add">Add Roles</a></h6>
                               	<%
									if(request.getParameter("r-add") != null) {
								%>
                            
                                <form action="" method="post" class="form-horizontal mt-4">
                                    <div class="form-group">
                                        <label>Role Name</label>
                                        <input type="text" name="RoleName" class="form-control" value="" placeholder="Role Name"/>
                                    </div>
                                    <div class="form-group" style="justify-content:center; text-align:center; display:flex;">
                                            <div class="col-sm-12" style="width:20%;">
                                                <button type="submit" name="RoleAdd" class="btn btn-success text-white" onclick="return AskPermission()">Add</button>
                                            </div>
                                           
                                    		<div class="col-sm-12" style="width:20%;">
                                                <button type="submit" name="RoleCancel" class="btn btn-success text-white" onclick="return AskPermission()">Cancel</button>
                                            </div>
                                    </div>
								</form>
								<% 
							    		request.removeAttribute("r-add");
									}
								%>
                                
                                <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-2-box-multiple-outline"></i> Available Roles</h6>
                                
                                <%
									if(request.getParameter("r-edit") != null) {
								%>
                                <form action="" method="post" class="form-horizontal mt-4">
                                    <input type="hidden" name="id" value="<%= id %>">
                                    <div class="form-group">
                                        <label>Role Name</label>
                                        <input type="text" name="RoleName" class="form-control" value="<%= role %>" placeholder="Role Name">
                                    </div>
                                    <div class="form-group"style="justify-content:center; text-align:center; display:flex;">
                                            <div class="col-sm-12" style="width:20%;">
                                                <button type="submit" name="RoleUpdate" class="btn btn-success text-white">Update</button>
                                            </div>
                                            
                                            <div class="col-sm-12" style="width:20%;">
                                                <button type="submit" name="RoleCancel" class="btn btn-success text-white" onclick="return AskPermission()">Cancel</button>
                                            </div>
                                        </div>
                                </form>

                                <% 
							    		request.removeAttribute("r-edit");
									}
								%>
								
                                <div class="table-responsive">
                                <div class="comment-widgets" style="height:220px;">
                                    <table class="table">
                                    <%
										if(session.getAttribute("message1") != null) {
										    %>
										    <tr scope="col" <% if(session.getAttribute("message1").equals("Role Deleted Successfully.")) { %>class="table-danger"<% } else { %>class="table-success"<% } %>>
										        <th colspan='4'>
										            <center>
										                <%= session.getAttribute("message1") %>
										                <% 
										                int flag = (Integer) session.getAttribute("flag") + 1;
														session.setAttribute("flag", flag);
										
										                if(flag > 1) {
										                    session.removeAttribute("message1");
										                    session.setAttribute("flag", 0);
										                }
										                %>
										            </center>
										        </th>
										    </tr>
										    <% 
										}
										%>

                                        <thead>
                                            <tr style=" position: -webkit-sticky; position: sticky;top: 0; z-index: 1; background: #fff;">
                                                <th scope="col">No.</th>
                                                <th scope="col">Role</th>
                                                <th scope="col" colspan=2>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%
										    stmt = con.createStatement();
										    rs = stmt.executeQuery("SELECT * FROM tblrole");
										    
										    if(!rs.isBeforeFirst()) {
										%>
										        <tr>
										            <td colspan="4">No Roles Stored.</td>
										        </tr>
										<%
										    } else {
										        int num = 1;
										        while(rs.next()) {
										%>
										            <tr>
										                <th scope="row"><%= num %></th>
										                <td><%= rs.getString("Role_Type") %></td>
										                <td><a href="starter-kit.jsp?r-edit=<%= rs.getInt("Role_id") %>">Edit</a></td>
										                <td><a href="starter-kit.jsp?r-del=<%= rs.getInt("Role_id") %>" onclick="return checkDelete()">Delete</a></td>
										            </tr>
										<%
										            num++;
										        }
										    }
										%>

                                        </tbody>
                                    </table>
                                   </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-12">
                        <div class="card card-body">
                            <h4 class="card-title">Staff Management</h4>
                            <h5 class="card-subtitle"> Manage Staff</h5>
                            <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-1-box-multiple-outline"></i><a href="starter-kit.jsp?addstaff">Add Staff</a></h6>
                            
                            <%
								if(request.getParameter("addstaff") != null) {
							%>
							
                            <form action="" method="post" class="form-horizontal mt-4">
                                <div class="form-group">
                                    <label>Username</label>
                                    <input type="text" name="username" class="form-control" value="<%= username %>" placeholder="UserName" required>
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input type="text" name="password" class="form-control" value="<%= pass %>" placeholder="Password" required>
                                </div>
                                <div class="form-group">
                                    <label>First Name</label>
                                    <input type="text" name="Fname" class="form-control" value="<%= fname %>" placeholder="First Name" onkeypress="return letters()" required>
                                </div>
                                <div class="form-group">
                                    <label>Last Name</label>
                                    <input type="text" name="Lname" class="form-control" value="<%= lname %>" placeholder="Last Name" onkeypress="return letters()" required>
                                </div>
                                <div class="form-group">
                                    <label>Staff ID</label>
                                    <input type="text" name="EnNo" class="form-control" value="<%= EnNo %>" placeholder="Staff ID" onkeypress="return isNumber()" required>
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" name="Email" id="staffAdd-email" value="<%= email %>" class="form-control" placeholder="Email" onblur="validateEmail(this)" required>
                                </div>
                                <div class="form-group">
                                    <label>Department</label>
                                    <!-- <input type="text" name="Department" class="form-control" value="" placeholder="Department" required> -->
                                    <select id="Department" name="Department" class="form-control" required>  
                                      	<option value="" disabled selected >Select department</option>
										<option value="Management" style="color:#6c757d">Management</option>
										<option value="IT" style="color:#6c757d">IT</option>
										<option value="Counselling" style="color:#6c757d">Counselling</option>
										<option value="Mess" style="color:#6c757d">Mess</option>
										<option value="Club" style="color:#6c757d">Club</option>
										
									</select>
									
                                </div>
                                <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="submit" id="StaffAdd" name="StaffAdd" class="btn btn-success text-white" disabled>Add</button>
                                        </div>
                                    </div>
                            </form>

                            	<% 
							    		request.removeAttribute("addstaff");
									}
								%>
                            
                            <%
								if(request.getParameter("edit") != null) {
							%>
                            
                            <form action="" method="post" class="form-horizontal mt-4">
                                <input type="hidden" name="id" value="<%= id %>">
                                <div class="form-group">
                                    <label>First Name</label>
                                    <input type="text" name="Fname" class="form-control" value="<%= fname %>" placeholder="First Name">
                                </div>
                                <div class="form-group">
                                    <label>Last Name</label>
                                    <input type="text" name="Lname" class="form-control" value="<%= lname %>" placeholder="Last Name">
                                </div>
                                <div class="form-group">
                                    <label>Staff ID</label>
                                    <input type="text" name="EnNo" class="form-control" value="<%= EnNo %>" placeholder="Staff ID">
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" name="Email" id="example-email" value="<%= email %>" class="form-control" placeholder="Email">
                                </div>
                                <div class="form-group">
                                    <label>Department</label>
                                    <input type="text" name="Department" class="form-control" value="<%= department %>" placeholder="Department">
                                </div>
                                <!--  <div class="form-group">
                                    <label>Phone No.</label>
                                    <input type="text" name="Phone" class="form-control" value="<% //phone %>" placeholder="Phone No.">
                                </div>  -->
                                <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="submit" name="StudUpdate" class="btn btn-success text-white">Update</button>
                                        </div>
                                    </div>
                            </form>

                            <% 
						    		request.removeAttribute("edit");
								}
							%>
							<h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-2-box-multiple-outline"></i> Available Staff</h6>
                            <div class="comment-widgets" style="height:450px;">
                            <div class="table-responsive">
                                    <table class="table">
                                   		<%
	                                    
											if (session.getAttribute("message") != null) {
											%>
												<tr scope="col" class="<%= (session.getAttribute("message").equals("User Deleted Successfully.")) ? "table-danger" : "table-success" %>">
													<th colspan='12'>
														<center>
															<%= session.getAttribute("message") %> <%= session.getAttribute("flag") %>
															<%
															int flag = (Integer) session.getAttribute("flag") + 1;
															out.println(flag);
															session.setAttribute("flag", flag);
															if (flag > 1) {
															session.removeAttribute("message");
															session.setAttribute("flag", 0);
															}
															%>
														</center>
													</th>
												</tr>
											<%
											}
											%>
                                        <thead>
                                            <tr style=" position: -webkit-sticky; position: sticky;top: 0; z-index: 1; background: #fff;">
                                                <th scope="col">No.</th>
                                                <th scope="col">Role</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">Staff ID</th>
                                                <th scope="col">Email</th>
                                                <th scope="col">Hostel</th>
                                                <th scope="col">Department</th>
                                                <th scope="col">Phone No.</th>
                                                <th scope="col" colspan=2>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%
                                        	
										    query = "SELECT user_id, EnrollmentNo FROM tblregister";
										    ResultSet record = con.createStatement().executeQuery(query);
										    int num = 1;
										    String roletype="";
										    
										    while(record.next()) {
										        if(record.getString("EnrollmentNo").length() < 15) {
										            user = Integer.parseInt(record.getString("user_id"));
										            //String roleQuery = "SELECT A.Role_Type FROM tblrole A JOIN tblstaff B ON B.Role_id=A.Role_id WHERE B.user_id='" + user + "'";
										            String MasterQuery = "SELECT HS.Hostel_Name, RL.Role_Type, RG.FirstName, RG.LastName, RG.EnrollmentNo, RG.Email, RG.DepartmentName, RG.PhoneNo, RG.user_id FROM tblregister RG LEFT JOIN tblstaff SF ON RG.user_id = SF.user_id LEFT JOIN tblrole RL ON SF.Role_id = RL.Role_id LEFT JOIN tblhostel HS ON SF.Hostel_id = HS.Hostel_id WHERE RG.user_id ='" + user + "'";
										            ResultSet role1 = con.createStatement().executeQuery(MasterQuery);
										            
										            role1.next();
										            
										            /*if(role1.next()){
										            	if(role1.getString("Role_Type")!=null)
										            		roletype = role1.getString("Role_Type");
										            	else
										            		roletype = "N.A";
										            } else {
										            	roletype = "N.A";
										            }*/
										%>
										<tr>
										    <th scope="row"><%= num %></th>
										    <td><%= (role1.getString("Role_Type")!=null) ? role1.getString("Role_Type") : "N.A" %></td>
										    <td><%= role1.getString("FirstName") + " " + role1.getString("LastName") %></td>
										    <td><%= role1.getString("EnrollmentNo") %></td>
										    <td><%= role1.getString("Email") %></td>
										    <td><%= (role1.getString("Hostel_Name")!=null) ? role1.getString("Hostel_Name") : "N.A" %></td>
										    <td><%= (role1.getString("DepartmentName")!=null) ? role1.getString("DepartmentName") : "N.A" %></td>
										    <td><%= (role1.getString("PhoneNo")!=null) ? role1.getString("PhoneNo") : "N.A" %></td>
										    <td><a href="starter-kit.jsp?edit=<%= record.getString("user_id") %>">Edit</a></td>
										    <td><a href="starter-kit.jsp?del=<%= record.getString("user_id") %>" onclick="return checkDelete()">Delete</a></td>
										</tr>
										<%
													num++;    
										        }
										        
										    }
										%>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- End PAge Content -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Right sidebar -->
                <!-- ============================================================== -->
                <!-- .right-sidebar -->
                <!-- ============================================================== -->
                <!-- End Right sidebar -->
                <!-- ============================================================== -->
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- footer -->
            <!-- ============================================================== -->
            <footer class="footer text-center">
            All Rights Reserved by DORMZZ. Designed and Developed by
                <a href="http://www.utu.ac.in/bmiit" target="_blank">BMIITIANS</a>.
            </footer>
            <!-- ============================================================== -->
            <!-- End footer -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="../../assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="../../assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script src="../../assets/extra-libs/sparkline/sparkline.js"></script>
    <!--Wave Effects -->
    <script src="../../dist/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="../../dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="../../dist/js/custom.min.js"></script>
    
            	<script>
  // Disable back button after form submission
  history.pushState(null, null, location.href);
  window.onpopstate = function () {
      history.go(1);
  };
  
	
	const staffAdd = document.getElementById("StaffAdd");
	
	function validateEmail(email) {
		  // regular expression for email validation
		  var re = /^([a-zA-Z0-9._-]+)@([a-zA-Z0-9_-]+)\.([a-zA-Z]{2,5})$/;
		  console.log(staffAdd.innerHTML);
		  if(re.test(email.value))
			return staffAdd.disabled = false; // returns true if email is valid, false otherwise
		  else
			return staffAdd.disabled = true;	
 	}
		  
</script>
</body>

</html>