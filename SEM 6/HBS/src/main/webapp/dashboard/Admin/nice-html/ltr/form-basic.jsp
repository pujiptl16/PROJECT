<%@ page language="java" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>

<%
	session=request.getSession();
	boolean update = false;
	String fname="";
	String lname="";
	String EnNo="";
	String email="";
	String department="";
	String phone="";
	String password="";
	String username="";
	String gender="";
	String id="";
	
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Expires","0");
	response.setDateHeader("Expires",-1);
	
	if(session.getAttribute("username")==null) 
	{
	    session.setAttribute("username", username);
	    response.sendRedirect("../../../../form/login.jsp");
	}
	else
	{
	    //out.println("<script>form-basic.jsp</script>");
	    if(request.getParameter("del")!=null) {
	        id = request.getParameter("del");
	        String query = "DELETE FROM tblregister WHERE user_id='"+id+"'";
	        Statement stmt=con.createStatement();
	        stmt.executeUpdate(query);
	        //con.close();
	        session.setAttribute("message", "User Deleted Successfully."); 
	        response.sendRedirect("form-basic.jsp");
	    }

	    if(request.getParameter("edit")!=null) {
	        id = request.getParameter("edit");
	        update = true;
	        Statement stmt=con.createStatement();
	        ResultSet record = stmt.executeQuery("SELECT * FROM tblregister WHERE user_id='"+id+"'");
	        if (record.next()) {
	            fname = record.getString("FirstName");
	            lname = record.getString("LastName");
	            EnNo = record.getString("EnrollmentNo");
	            email = record.getString("Email");
	            department = record.getString("DepartmentName");
	            phone = record.getString("PhoneNo");
	            username = record.getString("Username");
	            gender = record.getString("Gender");
	        }
	        //con.close();
	    }

	    if (request.getParameter("StudUpdate") != null) {
	        id = request.getParameter("id");
	        fname = request.getParameter("Fname");
	        lname = request.getParameter("Lname");
	        EnNo = request.getParameter("EnNo");
	        email = request.getParameter("Email");
	        department = request.getParameter("Department");
	        phone = request.getParameter("Phone");
	        username = request.getParameter("Username");
	        password = request.getParameter("Password");
	        gender = request.getParameter("Gender");
	        
	        String hash_pass = HBSHashing.HashPaswword(password);
			String Salt = HBSHashing.getSalt();
			
	        String query = "SELECT * FROM tblregister WHERE Username=?";
	        PreparedStatement ps = con.prepareStatement(query);
	        ps.setString(1, username);
	        ResultSet record = ps.executeQuery();
	        
	        int did = Integer.parseInt(id);
	        int rows = 0;
	        int user_id = 0;
	        
	        if(record.next()) 
	        {
	            rows++;
	            user_id = record.getInt("user_id");
	            if(user_id != did) {
	                did = user_id;
	            }
	        }

	        if(rows <= 1 && did == Integer.parseInt(id)) {
	            if (email.matches("^\\S+@\\S+\\.\\S+$")) {
	                String updateQuery = "UPDATE tblregister SET FirstName=?, LastName=?, Username=?, `Password`=?, `Salt`=?, EnrollmentNo=?, Email=?, DepartmentName=?, Gender=?, PhoneNo=? WHERE user_id=?";
	                ps = con.prepareStatement(updateQuery);
	                ps.setString(1, fname);
	                ps.setString(2, lname);
	                ps.setString(3, username);
	                ps.setString(4, hash_pass);
	                ps.setString(5, Salt);
	                ps.setString(6, EnNo);
	                ps.setString(7, email);
	                ps.setString(8, department);
	                ps.setString(9, gender);
	                ps.setString(10, phone);
	                ps.setInt(11, Integer.parseInt(id));
	                ps.executeUpdate();
	                session.setAttribute("message", "User Updated Successfully.");
	                response.sendRedirect("form-basic.jsp");
	            }
	            else {
	                out.println("<script>alert('Invalid Email Address.')</script>");
	            }
	        }
	        else {
	            out.println("<script>alert('Username is Taken. Please Use different username.')</script>");
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
    <title>Dormzz - User Panel</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/niceadmin-lite/" />
    <link rel="shortcut icon" type="image/x-icon" href="../../../../images/favicon.png" />
    <!-- Favicon icon 
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    -->
    <link href="../../dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<script>
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
</script>
<link href="../../../SearchStyle.css" rel="stylesheet">
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
                        <h4 class="page-title">User Panel</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">User Panel</li>
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
                    <div class="col-12">
                        <div class="card card-body">
                            <h4 class="card-title">User Analytics</h4>
                            <h5 class="card-subtitle"> Manage Users</h5>
                            
                            <% if (request.getParameter("edit") != null) { %>
                            
                            <form action="" method="post" class="form-horizontal mt-4">
                                <input type="hidden" name="id" value="<%= id %>">
                                <div class="form-group">
                                    <label>First Name</label>
                                    <input type="text" name="Fname" class="form-control" value="<%= fname %>" placeholder="First Name" required>
                                </div>
                                <div class="form-group">
                                    <label>Last Name</label>
                                    <input type="text" name="Lname" class="form-control" value="<%= lname %>" placeholder="Last Name" required>
                                </div>
                                <div class="form-group">
                                    <label>Enrollment Number</label>
                                    <input type="text" name="EnNo" class="form-control" value="<%= EnNo %>" placeholder="Enrollment No." required>
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" name="Email" id="example-email" value="<%= email %>" class="form-control" placeholder="Email" required>
                                </div>
                                <div class="form-group">
                                    <label>Username</label>
                                    <input type="text" name="Username" class="form-control" value="<%= username %>" placeholder="Username" required>
                                </div>
                                <div class="form-group">
                                    <label>Password</label>   
                                    <input type="password" name="Password" value="" class="form-control" Placeholder="Password" required>
                                </div>
                                <div class="form-group">
                                    <label>Department</label>
                                    <input type="text" name="Department" class="form-control" value="<%= department %>" placeholder="Department" required>
                                </div>
                                <div class="form-group">
                                    <label>Gender</label>
                                    <select name="Gender"  class="form-control" required>
                                        <option value="Boys" <% if (gender.equals("Boys")) { %> selected <% } %>>Male</option>
                                        <option value="Girls"  <% if (gender.equals("Girls")) { %> selected <% } %> >Female</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Phone No.</label>
                                    <input type="text" name="Phone" class="form-control" value="<%= phone %>" placeholder="Phone No." required>
                                </div>
                                <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="submit" name="StudUpdate" class="btn btn-success text-white">Update</button>
                                        </div>
                                    </div>
                            </form>

                            <% request.removeAttribute("edit"); %>

							<% } %>
							
                            <div class="table-responsive">
                                <div class="comment-widgets" style="height:650px;">
                                    <table class="table">
                                    <%= session.getAttribute("flag") %>
                                    <%
                                    
										if (session.getAttribute("message") != null) {
										%>
											<tr scope="col" class="<%= (session.getAttribute("message").equals("User Deleted Successfully.")) ? "table-danger" : "table-success" %>">
												<th colspan='9'>
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
                                                <th scope="col">Name</th>
                                                <th scope="col">Enrollment No.</th>
                                                <th scope="col">Email</th>
                                                <th scope="col">Department</th>
                                                <th scope="col">Hostel</th>
                                                <th scope="col">Phone No.</th>
                                                <th scope="col" colspan=2>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
	                                       <%
											    Statement stmt = null;
											    ResultSet rs = null;
											    
											    PreparedStatement stmt2 = null;
											    ResultSet rs2 = null;
											
											    String Department="";
											    String HostelName="";
											    stmt = con.createStatement();
											    String sql = "SELECT "+
											    	    "HS.Hostel_Name, "+
											    		"HR.User_Status, "+
											    		"DP.d_name, "+
											    	    "RG.FirstName, "+
											    	    "RG.LastName, "+
											    	    "RG.EnrollmentNo, "+
											    	    "RG.Email, "+
											    	    "RG.DepartmentName, "+
											    	    "RG.PhoneNo, "+
											    	    "RG.user_id "+
											    	"FROM "+
											    	    "tblregister RG "+
											    		"LEFT JOIN tbldepartment DP ON RG.DepartmentName = DP.d_id "+
											    	    "LEFT JOIN tblhostel_record HR ON RG.user_id = HR.user_id "+
											    	    "LEFT JOIN tblhostel HS ON HR.Hostel_id = HS.Hostel_id";
											    rs = stmt.executeQuery(sql);
											    int num = 1;
											    while (rs.next()) {
											    	String status = rs.getString("User_Status");
											    	if(status != null){
											    		if(status.equals("InActive")){
											    			continue;
											    		}
											    	}
											    	if(rs.getString("EnrollmentNo").length()<15){
											    		String sql2 = "SELECT "+
												    		    "HS.Hostel_Name, "+
												    		    "RL.Role_Type, "+
												    		    "RG.FirstName, "+
												    		    "RG.LastName, "+
												    		    "RG.EnrollmentNo, "+
												    		    "RG.Email, "+
												    		    "RG.DepartmentName, "+
												    		    "RG.PhoneNo, "+
												    		    "RG.user_id "+
												    		"FROM "+
												    		    "tblregister RG "+
												    		    "LEFT JOIN tblstaff SF ON RG.user_id = SF.user_id "+
												    		    "LEFT JOIN tblrole RL ON SF.Role_id = RL.Role_id "+
												    		    "LEFT JOIN tblhostel HS ON SF.Hostel_id = HS.Hostel_id "+
												    		"WHERE "+
												    		    "RG.user_id = ?; ";
												    	stmt2 = con.prepareStatement(sql2);
												    	stmt2.setString(1, rs.getString("user_id"));
												    	rs2 = stmt2.executeQuery();
												    	if(rs2.next()){
												    		Department = rs2.getString("DepartmentName");
												    		HostelName = rs2.getString("Hostel_Name");
												    	}
											    	} else {
											    		Department = rs.getString("d_name");
											    		HostelName = rs.getString("Hostel_Name");
											    	}
											%>
									            <tr>
									                <th scope="row"><%= num %></th>
									                <td><%= rs.getString("FirstName") %> <%= rs.getString("LastName") %></td>
									                <td><%= rs.getString("EnrollmentNo") %></td>
									                <td><%= rs.getString("Email") == null ? "N.A" : rs.getString("Email") %></td>
									                <td><%= Department == null ? "N.A" : Department %></td>
									                <td><%= HostelName == null ? "N.A" : HostelName %></td>
									                <td><%= rs.getString("PhoneNo") == null ? "N.A" : rs.getString("PhoneNo") %></td>
									                <td><a href="form-basic.jsp?edit=<%= rs.getString("user_id") %>">Edit</a></td>
									                <td><a href="form-basic.jsp?del=<%= rs.getString("user_id") %>" onclick="return checkDelete()">Delete</a></td>
									            </tr>
											<%
											        num++;
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
</body>

</html>