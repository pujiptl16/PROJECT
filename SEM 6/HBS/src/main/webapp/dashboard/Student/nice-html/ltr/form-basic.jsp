<%@ page language="java" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>

<%
	session = request.getSession(true);
	String username = (String)session.getAttribute("username");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Expires","0");
	response.setDateHeader("Expires",-1);
	
	String fdate="";
    String tdate="";
    String reason="";
    String aid="";
    String id = "";
    
	if(session.getId() == null || session.getAttribute("username") == null){
		//session.setAttribute("username", username);
		out.println("<script>location.href='../../../../form/login.jsp'</script>");
	}else{
		session.setAttribute("flag",0);
		// out.println("<script>student_dash_index.jsp'</script>");


	    if (request.getParameter("ApplyLeave") != null) {
	        fdate = request.getParameter("FDate");
	        tdate = request.getParameter("TDate");
	        reason = request.getParameter("Reason");
	        aid = (String) session.getAttribute("userid");
	        
	        
	        PreparedStatement stmt = null;
            stmt = con.prepareStatement("INSERT INTO tblleave(User_id, Leave_Reason, Leave_From, Leave_To) VALUES (?, ?, ?, ?)");
            stmt.setString(1, aid);
            stmt.setString(2, reason);
            stmt.setString(3, fdate);
            stmt.setString(4, tdate);
            stmt.executeUpdate();
            session.setAttribute("message", "Leave applied Successfully.");
            response.sendRedirect("starter-kit.jsp");
	    } 
	    
	    if (request.getParameter("edit") != null) {
	        id = request.getParameter("edit");
	        ResultSet record = null;
	       	String sql = "SELECT * FROM tblleave WHERE Leave_id=?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, id);
            record = statement.executeQuery();
	        
	        if (record.next()) {
	            fdate = record.getString("Leave_From");
	            tdate = record.getString("Leave_To");
	            reason = record.getString("Leave_Reason");
	            
	        }
	    }

	    if (request.getParameter("UpdateLeave") != null) {
	        id = request.getParameter("id");
	        fdate = request.getParameter("FDate");
	        tdate = request.getParameter("TDate");
	        reason = request.getParameter("Reason");
	        aid = (String) session.getAttribute("userid");
	        
	        String sql = "UPDATE `tblleave` SET `Leave_Reason`=?, `Leave_From`=?, `Leave_To`=? WHERE `Leave_id`=?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, reason);
            statement.setString(2, fdate);
            statement.setString(3, tdate);
            statement.setString(4, id);
            statement.executeUpdate();
            session.setAttribute("message", "Leave updated Successfully.");
            response.sendRedirect("starter-kit.jsp");
	        
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
    <title>Dormzz - My Clubs</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/niceadmin-lite/" />
    <link rel="shortcut icon" type="image/x-icon" href="../../../../images/favicon.png" />
    <link href="../../../SearchStyle.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
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
        
        <%@include file="StudentMenuFile.jsp" %>
        
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
                        <h4 class="page-title">Leave Panel</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Leave Panel</li>
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
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Apply Leave</h4>
                                <h5 class="card-subtitle"> Manage Leave</h5>
                                <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-1-box-multiple-outline"></i><a href="starter-kit.php?apply">Apply Leave</a></h6>
                            
                            <% if (request.getParameter("apply") != null) { %>
                            
                            <form action="" method="post" class="form-horizontal mt-4">
                                <input type="hidden" name="id" value="<%= id %>">
                                <div class="form-group">
                                    <label>From Date</label>
                                    <input type="datetime-local" name="FDate" class="form-control" value="<%= fdate %>" placeholder="From Date" required>
                                </div>
                                <div class="form-group">
                                    <label>To Date</label>
                                    <input type="datetime-local" name="TDate" class="form-control" value="<%= tdate %>" placeholder="To Date" required>
                                </div>
                                <div class="form-group">
                                    <label>Reason</label>
                                    <input type="text" name="Reason" class="form-control" value="<%= reason %>" placeholder="Please Specify Reason in Maximum 75 character." required>
                                </div>
                                <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="submit" name="ApplyLeave" class="btn btn-success text-white">Apply</button>
                                        </div>
                                    </div>
                            </form>

                            <%  request.removeAttribute("apply");
							    }
							%>
                            <h6 class="card-title mt-5"><i
                                        class="me-1 font-18 mdi mdi-numeric-2-box-multiple-outline"></i> Applied Leaves</h6>
                            
                            <% if (request.getParameter("edit") != null) { %>
                            
                            <form action="" method="post" class="form-horizontal mt-4">
                                <input type="hidden" name="id" value="<?php echo $id; ?>">
                                <div class="form-group">
                                    <label>From Date</label>
                                    <input type="datetime-local" name="FDate" class="form-control" value="<%= fdate %>" placeholder="From Date" required>
                                </div>
                                <div class="form-group">
                                    <label>To Date</label>
                                    <input type="datetime-local" name="TDate" class="form-control" value="<%= tdate %>" placeholder="To Date" required>
                                </div>
                                <div class="form-group">
                                    <label>Reason</label>
                                    <input type="text" name="Reason" class="form-control" value="<%= reason %>" placeholder="Please Specify Reason in Maximum 75 character." required>
                                </div>
                                <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="submit" name="UpdateLeave" class="btn btn-success text-white">Update</button>
                                        </div>
                                    </div>
                            </form>

                            <%  request.removeAttribute("edit");
							    }
							%>

                            <div class="table-responsive">
                                <div class="comment-widgets" style="height:500px;">
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
                                                <th scope="col">Start Date</th>
                                                <th scope="col">End Date</th>
                                                <th scope="col">Reason</th>
                                                <th scope="col">Status</th>
                                                <th scope="col">Remark</th>
                                                <th scope="col" colspan=2>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%
											id = (String) session.getAttribute("userid");
											ResultSet record = null;
											PreparedStatement stmt = con.prepareStatement("SELECT * FROM tblleave where User_id=?");
										    stmt.setString(1, id);
										    record = stmt.executeQuery();
											
											if (!record.next()) {
											%>
											<tr>
											    <td colspan="8"><center>You have not applied any leaves yet.</center></td>
											</tr>
											<%
											} else {
											    int num = 1;
											    do {
											%>
											<tr>
											    <th scope="row"><%= num %></th>
											    <td><%= record.getString("Leave_From") %></td>
											    <td><%= record.getString("Leave_To") %></td>
											    <td><%= record.getString("Leave_Reason") %></td>
											    <td><%= record.getString("Leave_Status") %></td>
											    <td><%= record.getString("Leave_Remarks")==null ? "-" : record.getString("Leave_Remarks") %></td>
											    <% if (!record.getString("Leave_Status").equals("Pending")) { %>
											        <td colspan="2"></td>
											    <% } else { %>
											        <td><a href="starter-kit.jsp?edit=<%= record.getString("Leave_id") %>">Edit</a></td>
											        <td><a href="starter-kit.jsp?del=<%= record.getString("Leave_id") %>" onclick="return checkDelete()">Delete</a></td>
											    <% } %>
											</tr>
											<%
											        num++;
											    } while (record.next());
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