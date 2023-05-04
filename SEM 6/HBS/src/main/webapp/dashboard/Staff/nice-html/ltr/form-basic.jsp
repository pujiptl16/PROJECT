<%@ page language="java" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*, java.nio.file.Paths"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="javax.servlet.http.Part" %>

<%
	session = request.getSession(true);
	String id="";
	String fname = "";
    String lname = "";
    String email = "";
    String phone = "";
    String username = session.getAttribute("username").toString();
    String password = "";
	String EnNo = "";
	
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Expires","0");
	response.setDateHeader("Expires",-1);
	
	if(session.getId() == null || session.getAttribute("username") == null){
		//session.setAttribute("username", username);
		out.println("<script>location.href='../../../../form/login.jsp'</script>");
	}else{
		
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
                            
                            <div class="table-responsive">
                                    <table class="table">
                                    <%
                                    
										if (session.getAttribute("message") != null) {
										%>
											<tr scope="col" class="<%= (session.getAttribute("message").equals("User Deleted Successfully.")) ? "table-danger" : "table-success" %>">
												<th colspan='7'>
													<center>
														<%= session.getAttribute("message") %>
														<%
														int flag = (Integer) session.getAttribute("flag") + 1;
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
                                            <tr>
                                                <th scope="col">No.</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">Enrollment No.</th>
                                                <th scope="col">Email</th>
                                                <th scope="col">Department</th>
                                                <th scope="col">Room No.</th>
                                                <th scope="col">Floor</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%
											String hid = (String) session.getAttribute("Hostel_id");
											String query = "SELECT a.FirstName, a.LastName, a.EnrollmentNo, a.Email, a.PhoneNo, b.Hostel_id, b.Room_id, c.Hostel_Name, d.d_name FROM tblregister a LEFT JOIN tblhostel_record b on b.user_id=a.user_id LEFT JOIN tblhostel c on b.Hostel_id=c.Hostel_id LEFT JOIN tbldepartment d ON a.DepartmentName = d.d_id WHERE b.Hostel_id=? AND b.User_Status != 'InActive'";
											PreparedStatement pstmt = con.prepareStatement(query);
											pstmt.setString(1, hid);
											ResultSet record = pstmt.executeQuery();
											int num = 1;
											if(!record.next()){
												%>
											    <tr>
											    <th scope="row" colspan="7"><center>No User Found.</center></th>
											    </tr>
											<%
											} else {
												record = pstmt.executeQuery();
													while (record.next()) {
												    String floor = record.getString("Room_id").substring(3, 5);
												    String room = record.getString("Room_id").substring(5);
												%>
												    <tr>
												        <th scope="row"><%= num %></th>
												        <td><%= record.getString("FirstName") %> <%= record.getString("LastName") %></td>
												        <td><%= record.getString("EnrollmentNo") %></td>
												        <td><%= record.getString("Email") %></td>
												        <td><%= record.getString("d_name") %></td>
												        <td><%= room %></td>
												        <td><%= floor %></td>
												    </tr>
												<%
											    num++;
											} }
											%>

                                        </tbody>
                                    </table>
                                </div>
                                


                                <!-- <form class="form-horizontal mt-4">
                                <div class="form-group">
                                    <label>Default Text <span class="help"> e.g. "George deo"</span></label>
                                    <input type="text" class="form-control" value="George deo...">
                                </div>
                                <div class="form-group">
                                    <label for="example-email">Email <span class="help"> e.g.
                                            "example@gmail.com"</span></label>
                                    <input type="email" id="example-email" name="example-email" class="form-control"
                                        placeholder="Email">
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input type="password" class="form-control" value="password">
                                </div>
                                <div class="form-group">
                                    <label>Placeholder</label>
                                    <input type="text" class="form-control" placeholder="placeholder">
                                </div>
                                <div class="form-group">
                                    <label>Text area</label>
                                    <textarea class="form-control" rows="5"></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Read only input</label>
                                    <input class="form-control" type="text" placeholder="Readonly input hereâ¦" readonly>
                                </div>
                                <div class="form-group">
                                    <fieldset disabled>
                                        <label for="disabledTextInput">Disabled input</label>
                                        <input type="text" id="disabledTextInput" class="form-control"
                                            placeholder="Disabled input">
                                    </fieldset>
                                </div>
                                <div class="form-group row pt-3">
                                    <div class="col-sm-4">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="customCheck1">
                                            <label class="form-check-label mb-0" for="customCheck1">Check this custom
                                                checkbox</label>
                                        </div>
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="customCheck2">
                                            <label class="form-check-label mb-0" for="customCheck2">Check this custom
                                                checkbox</label>
                                        </div>
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="customCheck3">
                                            <label class="form-check-label mb-0" for="customCheck3">Check this custom
                                                checkbox</label>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-check">
                                            <input type="radio" id="customRadio1" name="customRadio"
                                                class="form-check-input">
                                            <label class="form-check-label mb-0" for="customRadio1">Toggle this custom
                                                radio</label>
                                        </div>
                                        <div class="form-check">
                                            <input type="radio" id="customRadio2" name="customRadio"
                                                class="form-check-input">
                                            <label class="form-check-label mb-0" for="customRadio2">Toggle this custom
                                                radio</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Input Select</label>
                                    <select class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                        <option selected>Choose...</option>
                                        <option value="1">One</option>
                                        <option value="2">Two</option>
                                        <option value="3">Three</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Default file upload</label>
                                    <input type="file" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>Custom File upload</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Upload</span>
                                        </div>
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="inputGroupFile01">
                                            <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Helping text</label>
                                    <input type="text" class="form-control" placeholder="Helping text">
                                    <span class="help-block"><small>A block of help text that breaks onto a new line and
                                            may extend beyond one line.</small></span> </div>
                            </form> -->
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