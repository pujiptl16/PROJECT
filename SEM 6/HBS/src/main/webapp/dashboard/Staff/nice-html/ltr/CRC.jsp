<%@ page language="java" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>
<%
	session=request.getSession();
	
	String fdate="";
	String tdate="";
	String status = "";
    String remark = "";
	String reason="";
	String id="";
	String aid="";
	String hid="";
	String uid="";
		
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Expires","0");
	response.setDateHeader("Expires",-1);
	
	if(session.getAttribute("username")==null) 
	{
	    response.sendRedirect("../../../../form/login.jsp");
	}
	else
	{
	    if(request.getParameter("AddReC") != null){
	        String Type = request.getParameter("RecType");
	        String SubType = request.getParameter("RecSubType");
	        String brief = request.getParameter("ReC");
	        uid = (String) session.getAttribute("userid");
	        //out.println("<script>alert('"+Type+"');</script>");

	        if(Type.equals("Request")){
	            PreparedStatement stmt = null;
	            String query = "INSERT INTO tblrequest (user_id, Req_Brief, Req_Type_id) VALUES (?, ?, ?)";
                stmt = con.prepareStatement(query);
                stmt.setString(1, uid);
                stmt.setString(2, brief);
                stmt.setString(3, SubType);
                stmt.executeUpdate();
            
	        } else if(Type.equals("Complain")){
	            PreparedStatement stmt = null;
	            String query = "INSERT INTO tblcomplain (user_id, Cmp_Brief, Cmp_Type_id) VALUES (?, ?, ?)";
                stmt = con.prepareStatement(query);
                stmt.setString(1, uid);
                stmt.setString(2, brief);
                stmt.setString(3, SubType);
                stmt.executeUpdate();
            
	        }
	        session.setAttribute("message", "ReC added Successfully.");
	        response.sendRedirect("CRC.jsp");
	    }

	    if(request.getParameter("edit") != null){
	        id = request.getParameter("edit");
	        String ReCType = request.getParameter("ReCType");
	        PreparedStatement stmt = null;

	        if(ReCType.equals("Request")){
            	String query = "SELECT * FROM tblrequest WHERE Req_id=?";
                stmt = con.prepareStatement(query);
                stmt.setString(1, id);
                ResultSet rs = stmt.executeQuery();
                if(rs.next()){
                    status = rs.getString("Req_Status");
                    remark = rs.getString("Req_Remarks");
                }
	        } else {
            	String query = "SELECT * FROM tblcomplain WHERE Cmp_id=?";
                stmt = con.prepareStatement(query);
                stmt.setString(1, id);
                ResultSet rs = stmt.executeQuery();
                if(rs.next()){
                    status = rs.getString("Cmp_Status");
                    remark = rs.getString("Cmp_Remarks");
                }
	        }
	    }

	    if (request.getParameter("UpdateRec") != null) {
	        id = request.getParameter("id");
	        status = request.getParameter("Status");
	        remark = request.getParameter("Remark");
	        reason = request.getParameter("Reason");
	        aid = (String) session.getAttribute("userid");
	        String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());

	        if("Complain".equalsIgnoreCase(request.getParameter("ReCType"))) {
	            String query = "UPDATE tblcomplain SET Cmp_Remarks=?, Cmp_Status=?, Cmp_ClosedBy=?, Cmp_UpdatedTS=? WHERE Cmp_id=?";
	            PreparedStatement stmt = con.prepareStatement(query);
	            stmt.setString(1, remark);
	            stmt.setString(2, status);
	            stmt.setString(3, aid);
	            stmt.setString(4, currentDate);
	            stmt.setString(5, id);
	            stmt.executeUpdate();
	        } else {
	            String query = "UPDATE tblrequest SET Req_Remarks=?, Req_Status=?, Req_UpdatedBy=?, Req_UpdatedTS=? WHERE Req_id=?";
	            PreparedStatement stmt = con.prepareStatement(query);
	            stmt.setString(1, remark);
	            stmt.setString(2, status);
	            stmt.setString(3, aid);
	            stmt.setString(4, currentDate);
	            stmt.setString(5, id);
	            stmt.executeUpdate();
	        }
	        session.setAttribute("message", "ReC updated Successfully.");
	        response.sendRedirect("CRC.jsp");
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
    <title>Dormzz - ReC Panel</title>
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
</head>
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
                        <h4 class="page-title">ReC Panel</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Rec Panel</li>
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
                                <h4 class="card-title">Register Complains and Requestes</h4>
                                <h5 class="card-subtitle"> Manage ReCs</h5>
                                <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-1-box-multiple-outline"></i><a href="CRC.jsp?apply">Add ReC</a></h6>
                           <% if(request.getParameter("apply")!=null){ %>
                            
                                <form action="" method="POST" class="form-horizontal form-material mx-2">
                                    <div class="form-group">
                                        <label class="col-sm-12">Rec Type</label>
                                        <div class="col-sm-12">
                                            <select name="RecType" id="RecType" class="form-select shadow-none form-control-line" required>
                                                <option value="" disabled selected>Select Request/Complain</option>
                                                <option value="Request">Request</option>
                                                <option value="Complain">Complain</option>
                                                </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-12">Sub Type</label>
                                        <div class="col-sm-12">
                                            <select name="RecSubType" id="RecSubType" class="form-select shadow-none form-control-line" required>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label>Specify ReC</label>
                                        <input class="form-control" name="ReC" type="text" placeholder="How can we help ? Kindly Specify." required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="submit" name="AddReC" class="btn btn-success text-white">Add</button>
                                        </div>
                                    </div>
                                </form>

                            <% request.removeAttribute("apply"); } 
                               if(request.getParameter("edit")!=null){
                            %>
                            <form action="" method="post" class="form-horizontal mt-4">
                                <input type="hidden" name="id" value="<%= id %>">
                                <div class="form-group">
                                    <label>Status</label>
                                    <!-- <input type="text" name="Status" class="form-control" value="<?php echo $status; ?>" placeholder="" required> -->
                                    <select name="Status" class="form-control" required>
                                        <option value="Pending" <% if(status.equals("Pending")){ %> selected <% } %> >Pending</option>
                                        <option value="Acknowledged" <% if(status.equals("Acknowledged")){ %> selected <% } %> >Acknowleged</option>
                                        <option value="Closed" <% if(status.equals("Closed")){ %> selected <% } %> >Closed</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Remark</label>
                                    <input type="text" name="Remark" class="form-control" value="<%= remark %>" placeholder="Remarks if any in Maximum 75 character.">
                                </div>
                                <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="submit" name="UpdateRec" class="btn btn-success text-white">Update</button>
                                        </div>
                                    </div>
                            </form>

                            <% request.removeAttribute("edit"); } %>

                            <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-2-box-multiple-outline"></i>Applied ReCs</h6>
                            <div class="table-responsive">
                                <div class="comment-widgets" style="height:500px;">
                                    <table class="table">
                                    <%
                                    	if (session.getAttribute("message") != null) {
										%>
											<tr scope="col" class="<%= (session.getAttribute("message").equals("User Deleted Successfully.")) ? "table-danger" : "table-success" %>">
												<th colspan='12'>
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
										<% } %>
                                        <thead>
                                            <tr style=" position: -webkit-sticky; position: sticky;top: 0; z-index: 1; background: #fff;">
                                                <th scope="col">No.</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">Enrollment No</th>
                                                <th scope="col">Room No</th>
                                                <th scope="col">Floor</th>
                                                <th scope="col">Registered Date</th>
                                                <th scope="col">Updated Date</th>
                                                <th scope="col">ReC</th>
                                                <th scope="col">ReC Type</th>
                                                <th scope="col">Status</th>
                                                <th scope="col">Remark</th>
                                                <th scope="col" colspan=2>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <%
                                        	PreparedStatement pstmt = null;
											ResultSet rs = null;
											hid = (String) session.getAttribute("Hostel_id");
											
											String sql = "SELECT * FROM tblrequest a " +
											                 "LEFT JOIN tblhostel_record b on b.user_id=a.user_id " +
											                 "LEFT JOIN tblregister c on b.user_id=c.user_id " +
											                 "WHERE b.Hostel_id = ?";
											
										    pstmt = con.prepareStatement(sql);
										    pstmt.setString(1, hid);
										    rs = pstmt.executeQuery();
											
											    if (!rs.next()) {
											        // No records found
											        out.println("<tr>");
											        out.println("<td colspan='12'><center>No any ReCs added yet.</center></td>");
											        out.println("</tr>");
											    } else {
											        int num = 1;
											        do {
											            int recTypeid = rs.getInt("Req_Type_id");
											            String sql2 = "SELECT * FROM tblcomplain_type WHERE Cmp_Type_id = ?";
											            pstmt = con.prepareStatement(sql2);
											            pstmt.setInt(1, recTypeid);
											            ResultSet rs2 = pstmt.executeQuery();
											            rs2.next();
											            String floor = rs.getString("Room_id").substring(3, 5);
											            String room = rs.getString("Room_id").substring(rs.getString("Room_id").length() - 2);
											
											            %> <tr>
											            <th scope='row'><%= num %></th>
											            <td><%= rs.getString("FirstName") + " " + rs.getString("LastName") %></td>
											            <td><%= rs.getString("EnrollmentNo") %></td>
											            <td><%= room %></td>
											            <td><%= floor %></td>
											            <td><%= rs.getString("Req_Timestamp") %></td>
											            <td><%= rs.getString("Req_UpdatedTS") %></td>
											            <td><%= rs.getString("Req_Brief") %></td>
											            <td><%= rs2.getString("ReC_Type") + " / " + rs2.getString("Cmp_Type") %></td>
											            <td><%= rs.getString("Req_Status") %></td>
											            <td><%= rs.getString("Req_Remarks") %></td>
													<% 
											            if (rs.getString("Req_Status").equals("Closed")) {
											                out.println("<td colspan='2'></td>");
											            } else {
											                out.println("<td><a href='CRC.jsp?edit=" + rs.getString("Req_id") + "&ReCType=Request'>Edit</a></td>");
											            }
											            out.println("</tr>");
											
											            num++;
											        } while (rs.next());
											    } %>
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
    <script>
        $(document).ready(function() {
            $('#RecType').on('change', function() {
                var RecType = this.value;
                $.ajax({
                    url: "CRC-Fetcher.jsp",
                    type: "POST",
                    data: { RecType: RecType },
                    cache: false,
                    success: function(result){
                        $("#RecSubType").html(result);
                    }
                });
            }); 
        });
    </script>
</body>

</html>