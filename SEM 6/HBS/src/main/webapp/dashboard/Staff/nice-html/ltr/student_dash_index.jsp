<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	
	if(session.getId() == null || session.getAttribute("username") == null){
		//session.setAttribute("username", username);
		out.println("<script>location.href='../../../../form/login.jsp'</script>");
	}else{
		session.setAttribute("flag",0);
		String user = session.getAttribute("userid").toString();		
	    String query = "SELECT * FROM tblstaff WHERE user_id=?";
	    PreparedStatement pstmt = con.prepareStatement(query);
	    pstmt.setString(1, user);
	    ResultSet rs = pstmt.executeQuery();

	    if (rs.next()) {
	        session.setAttribute("Hostel_id", rs.getString("Hostel_id"));
	        session.setAttribute("Role_id", rs.getString("Role_id"));
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
    <title>Dormzz - Admin Dashboard</title>
    <link rel="shortcut icon" type="image/x-icon" href="../../../../images/favicon.png" />
    <link rel="canonical" href="https://www.wrappixel.com/templates/niceadmin-lite/" />
    <!-- Favicon icon -->
    <!-- <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    Custom CSS -->
    <link href="../../assets/libs/chartist/dist/chartist.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../dist/css/style.min.css" rel="stylesheet">
    <link href="../../dist/css/hostel.css" rel="stylesheet">
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
        <%@include file="StaffMenuFile.jsp" %>
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
                        <h4 class="page-title"><%= session.getAttribute("userid") + "" + session.getAttribute("FirstName")+"'s" %> Dashboard</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
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
                                <h4 class="card-title">User Acitivity</h4>
                                <div class="sales ct-charts mt-3"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title mb-1">Payments</h5>
                                <h3 class="font-light">â¹ 1,18,072.08</h3>
                                <div class="mt-3 text-center">
                                    <div id="earnings"></div>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title mb-0">Users</h4>
                                <h2 class="font-light">15,990 <span class="font-16 text-success font-medium">+9%</span>
                                </h2>
                                <div class="mt-4">
                                    <div class="row text-center">
                                        <div class="col-6 border-right">
                                            <h4 class="mb-0">15%</h4>
                                            <span class="font-14 text-muted">New Users</span>
                                        </div>
                                        <div class="col-6">
                                            <h4 class="mb-0">85%</h4>
                                            <span class="font-14 text-muted">Old Users</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Your Hostels</h4>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">Capacity</th>
                                                <th scope="col">Address</th>
                                                <th scope="col">Distance</th>
                                                <th scope="col">Type</th>
                                                <th scope="col">Status</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%
											
											PreparedStatement stmt = null;
											ResultSet rs = null;
											stmt = con.prepareStatement("SELECT HS.* from tblstaff SF LEFT JOIN tblhostel HS on SF.Hostel_id=HS.Hostel_id where SF.user_id=?");
											stmt.setString(1, (String)session.getAttribute("userid"));
											rs = stmt.executeQuery();
										    int num = 1;
										    if(!rs.next()){
										    	%>
										        <tr>
										            <th scope="row" colspan="7"><center>Hostel / Designation is not assigned yet.</center></th>
										        </tr>
											<%
										    } else {
										    	rs = stmt.executeQuery();
										    	while (rs.next()) {
											%>
											
											        <tr>
											            <th scope="row"><%= num++ %></th>
											            <td><%= rs.getString("Hostel_Name") %></td>
											            <td><%= rs.getString("Capacity") %></td>
											            <td><%= rs.getString("Address") %></td>
											            <td><%= rs.getString("Hostel_Distance") %></td>
											            <td><%= rs.getString("Hostel_Type") %></td>
											            <td>
											                <span class="label label-<%
											                    String hostelStatus = rs.getString("Hostel_Status");
											                    if (hostelStatus.equals("Available")) {
											                        out.print("success");
											                    } else if (hostelStatus.equals("Fast Filling")) {
											                        out.print("info");
											                    } else if (hostelStatus.equals("Full")) {
											                        out.print("danger");
											                    }
											                %> label-rounded">
											                <%= hostelStatus %></span>
											            </td>
											        </tr>
											<%
											    } }
											%>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>               
                <!-- ============================================================== -->
                <!-- Recent comment and chats -->
                <!-- ============================================================== -->
            
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
    <!--This page JavaScript -->
    <!--chartis chart-->
    <script src="../../assets/libs/chartist/dist/chartist.min.js"></script>
    <script src="../../assets/libs/chartist-plugin-tooltips/dist/chartist-plugin-tooltip.min.js"></script>
    <script src="../../dist/js/pages/dashboards/dashboard1.js"></script>
</body>

</html>