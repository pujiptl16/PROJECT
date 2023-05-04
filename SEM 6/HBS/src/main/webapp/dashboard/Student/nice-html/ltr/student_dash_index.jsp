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
	
	if(session.getId() == null || session.getAttribute("username") == null){
		//session.setAttribute("username", username);
		out.println("<script>location.href='../../../../form/login.jsp'</script>");
	}else{
		session.setAttribute("flag",0);
		// out.println("<script>student_dash_index.jsp'</script>");
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
    <title>Dormzz - Student Dashboard</title>
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
                        <h4 class="page-title"><%= session.getAttribute("FirstName") %>'s Dashboard</h4>
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
       		<%
                String id = (String)session.getAttribute("userid");
			    String query = "SELECT a.Room_id, a.Trn_id, a.Timestamp_Check_In, a.Timestamp_Check_Out, b.Package_Name, c.Trn_Amount, d.Hostel_Name FROM tblhostel_record a "
			            + "LEFT JOIN tblpackage b ON a.Package_id = b.Package_id "
			            + "LEFT JOIN tbltransaction c ON a.Trn_id = c.Trn_id "
			            + "LEFT JOIN tblhostel d ON a.Hostel_id = d.Hostel_id "
			            + "WHERE a.user_id = ? and a.User_Status='Active'";
			    PreparedStatement statement = con.prepareStatement(query);
			    statement.setString(1, id);
			    ResultSet record = statement.executeQuery();
				boolean purchased = false;
				
			    if (record.next()) {
			    	
			%>
			  <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Dash Panel</h4>
                                <h5 class="card-subtitle">Your Package Detaiils</h5>
                                
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">Package Name</th>
                                                <th scope="col">Hostel Name</th>
                                                <th scope="col">Room Number</th>
                                                <th scope="col">Floor</th>
                                                <th scope="col">Amount Paid</th>
                                                <th scope="col">Purchase Date</th>
                                                <th scope="col">Due Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                           <%
											        do {
											            String floor = record.getString("Room_id").substring(3, 5);
											            String room = record.getString("Room_id").substring(5);
											%>
												<tr>
											            <td><%= record.getString("Package_Name") %></td>
											            <td><%= record.getString("Hostel_Name") %></td>
											            <td><%= room %></td>
											            <td><%= floor %></td>
											            <td><%= record.getDouble("Trn_Amount") %></td>
											            <td><%= record.getString("Timestamp_Check_In") %></td>
											            <td><%= record.getString("Timestamp_Check_Out") %></td>
											   </tr>
											<%
											        } while (record.next());
											%>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>      
			<%
			    } else {
			    	
			%>
            	<div class="row">
                    <!-- column -->
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">List of Hostels</h4>
                            </div>
                            
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
                                            <th scope="col">Book</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%
										query = "SELECT * FROM tblhostel";
										ResultSet rs = null;
										int num = 1;
										    rs = con.createStatement().executeQuery(query);
										    String gender;
										    while(rs.next()){
										        gender = rs.getString("Hostel_Category");
										        if(gender.equals(session.getAttribute("gender"))){
										%>
										
										<tr>
										    <th scope="row"><%= num %></th>
										    <td><%= rs.getString("Hostel_Name") %></td>
										    <td><%= rs.getString("Capacity") %></td>
										    <td><%= rs.getString("Address") %></td>
										    <td><%= rs.getString("Hostel_Distance") %></td>
										    <td><%= rs.getString("Hostel_Type") %></td>
										    <td>
										        <% if(rs.getString("Hostel_Status").equals("Available")){ %>
										            <span class="label label-success label-rounded"><%= rs.getString("Hostel_Status") %></span>
										        <% } else if(rs.getString("Hostel_Status").equals("Fast Filling")){ %>
										            <span class="label label-info label-rounded"><%= rs.getString("Hostel_Status") %></span>
										        <% } else if(rs.getString("Hostel_Status").equals("Full")){ %>
										            <span class="label label-danger label-rounded"><%= rs.getString("Hostel_Status") %></span>
										        <% } %>
										    </td>
										    <td>
										        <a href="table-basic.jsp?edit=<%= rs.getString("Hostel_id") %>" class="label label-primary label-custom">SELECT</a>
										    </td>
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
			<% } %>
                <!-- ============================================================== -->
                <!-- Recent comment and chats -->
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
    <!--This page JavaScript -->
    <!--chartis chart-->
    <script src="../../assets/libs/chartist/dist/chartist.min.js"></script>
    <script src="../../assets/libs/chartist-plugin-tooltips/dist/chartist-plugin-tooltip.min.js"></script>
    <script src="../../dist/js/pages/dashboards/dashboard1.js"></script>
</body>

</html>