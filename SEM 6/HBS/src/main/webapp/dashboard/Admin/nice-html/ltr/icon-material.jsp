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

    String id = "";
    String Pname = "";
    String Description = "";
    String Pprice = "";
    String ValidFrom = "";
    String ValidTo = "";
    
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Expires","0");
	response.setDateHeader("Expires",-1);
	
    // Check if session exists
    if(session.getAttribute("username")==null) 
	{
	    response.sendRedirect("../../../../form/login.jsp");
	} else {

        // Check if AddPackage button is clicked
        if (request.getParameter("AddPackage") != null) {
            rs = stmt.executeQuery("SELECT * FROM tblpackage");
            int count = 0;
            while (rs.next()) {
                count++;
            }
            if (count < 4) {
            	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            	Date fromDate = dateFormat.parse(request.getParameter("ValidFrom"));
            	Date toDate = dateFormat.parse(request.getParameter("ValidTo"));

            	if (toDate.before(fromDate)) {
            	    // "to" date is before "from" date, add error message
            	    String errorMessage = "Expiration date cannot be before Creation date.";
            	    session.setAttribute("message", errorMessage);
                	
            	} else {
            	            	
	                Pname = request.getParameter("Name");
	                Description = request.getParameter("Description");
	                ValidFrom = request.getParameter("ValidFrom");
	                Pprice = request.getParameter("Pprice");
	                ValidTo = request.getParameter("ValidTo");
	
	                String query = "INSERT INTO tblpackage (Package_Name, Package_Description, Package_Price, Package_Valid_from, Package_Valid_to) VALUES ('" + Pname + "','" + Description + "','" + Pprice + "','" + ValidFrom + "','" + ValidTo + "')";
	                stmt.executeUpdate(query);
	                session.setAttribute("message", "Package Stored Successfully.");
            	
            	}
            } else {
                session.setAttribute("message", "Maximum 4 Packages can be Stored.");
            }
            response.sendRedirect("icon-material.jsp");
        }

        // Check if Edit button is clicked
        if (request.getParameter("edit") != null) {
            id = request.getParameter("edit");
            rs = stmt.executeQuery("SELECT * FROM tblpackage WHERE Package_id=" + id);
            if (rs.next()) {
                Pname = rs.getString("Package_Name");
                Description = rs.getString("Package_Description");
                Pprice = rs.getString("Package_Price");
                ValidFrom = rs.getString("Package_Valid_from");
                ValidTo = rs.getString("Package_Valid_to");
            }
        }

        // Check if PackageUpdate button is clicked
        if (request.getParameter("PackageUpdate") != null) {
            
        	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        	Date fromDate = dateFormat.parse(request.getParameter("ValidFrom"));
        	Date toDate = dateFormat.parse(request.getParameter("ValidTo"));

        	if (toDate.before(fromDate)) {
        	    // "to" date is before "from" date, add error message
        	    String errorMessage = "To date cannot be before From date.";
        	    session.setAttribute("message", errorMessage);
            	
        	} else {  
        		id = request.getParameter("id");
	            Pname = request.getParameter("Name");
	            Pprice = request.getParameter("Pprice");
	            Description = request.getParameter("Description");
	            ValidFrom = request.getParameter("ValidFrom");
	            ValidTo = request.getParameter("ValidTo");
	
	            String query = "UPDATE tblpackage SET Package_Name='" + Pname + "', Package_Description='" + Description + "', Package_Price='" + Pprice + "', Package_Valid_from='" + ValidFrom + "', Package_Valid_to='" + ValidTo + "' WHERE Package_id=" + id;
	            stmt.executeUpdate(query);
	            session.setAttribute("message", "Package Updated Successfully.");
	            
        	}
        	response.sendRedirect("icon-material.jsp");
        }

        // Check if del button is clicked
        if (request.getParameter("del") != null) {
            id = request.getParameter("del");
            String query = "DELETE FROM tblpackage WHERE Package_id='" + id + "'";
            stmt.executeUpdate(query);
            session.setAttribute("message", "Package Deleted Successfully.");
            response.sendRedirect("icon-material.jsp");
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
    <title>Dormzz - Payment</title>
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
                        <h4 class="page-title">Package Panel</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Package Panel</li>
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
                                <h4 class="card-title">Package</h4>
                                <h6 class="card-subtitle">Manage Packages</h6>                    
                                
                                <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-1-box-multiple-outline"></i><a href="icon-material.jsp?add">Add Package</a></h6>
                                
                                <% if (request.getParameter("add") != null) { %>
                                    
                                    <form action="" method="post" class="form-horizontal mt-4">
                                        <input type="hidden" name="id" value="<%= id %>">
                                        <div class="form-group">
                                            <label>Package Name</label>
                                            <input type="text" name="Name" class="form-control" value="<%= Pname %>" placeholder="Package Name" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Description</label>
                                            <input type="text" name="Description" class="form-control" value="<%= Description %>" placeholder="Description" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Price</label>
                                            <input type="text" name="Pprice" class="form-control" value="<%= Pprice %>" placeholder="Price" onkeypress="return isNumber(event)" required> 
                                        </div>
                                        <div class="form-group">
                                            <label>Valid From</label>
                                            <input type="date" name="ValidFrom" class="form-control" value="<%= ValidFrom %>" placeholder="Valid From" required>
                                        </div>
                                        <div class="form-group">
                                            <label>Valid To</label>
                                            <input type="date" name="ValidTo" value="<%= ValidTo %>" class="form-control" placeholder="Valid To" required>
                                        </div>
                                        <div class="form-group">
                                                <div class="col-sm-12">
                                                    <button type="submit" name="AddPackage" class="btn btn-success text-white">Add</button>
                                                </div>
                                            </div>
                                    </form>

                                   <%
									request.removeAttribute("add"); 
                                   	}
									%>
                                
                                    <h6 class="card-title mt-5"><i
                                        class="me-1 font-18 mdi mdi-numeric-2-box-multiple-outline"></i> Available Packages</h6>
                                
                                    <% if (request.getParameter("edit") != null) { %>
                                        <form action="" method="post" class="form-horizontal mt-4">
                                                <input type="hidden" name="id" value="<%= id %>">
                                                <div class="form-group">
                                                        <label>Package Name</label>
                                                        <input type="text" name="Name" class="form-control" value="<%= Pname %>" placeholder="Package Name" required>
                                                </div>
                                                <div class="form-group">
                                                        <label>Description</label>
                                                        <input type="text" name="Description" class="form-control" value="<%= Description %>" placeholder="Description" required>
                                                </div>
                                                <div class="form-group">
                                                        <label>Price</label>
                                                        <input type="text" name="Pprice" class="form-control" value="<%= Pprice %>" placeholder="Price" onkeypress="return isNumber(event)" required>
                                                </div>
                                                <div class="form-group">
                                                        <label>Valid From</label>
                                                        <input type="date" name="ValidFrom" class="form-control" value="<%= ValidFrom %>" placeholder="Valid From" required>
                                                        </div>
                                                <div class="form-group">
                                                        <label>Valid To</label>
                                                        <input type="date" name="ValidTo" value="<%= ValidTo %>" class="form-control" placeholder="Valid To" required>
                                                </div>
                                                <div class="form-group">
                                                        <div class="col-sm-12">
                                                        <button type="submit" name="PackageUpdate" class="btn btn-success text-white">Update</button>
                                                        </div>
                                                </div>
                                        </form>

                                   <%
									request.removeAttribute("edit"); 
                                   	}
									%>
                                    
                                    <div class="table-responsive">
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
												<%
												}
												%>
                                                <thead>
                                                    <tr>
                                                        <th scope="col">No.</th>
                                                        <th scope="col">Name</th>
                                                        <th scope="col">Description</th>
                                                        <th scope="col">Price</th>
                                                        <th scope="col">Created</th>
                                                        <th scope="col">Expiration</th>
                                                        <th scope="col" colspan=2>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                <%
												   
												   stmt = null;
												   rs = null;
												   int num = 1;
												   
												   
											       stmt = con.createStatement();
											       rs = stmt.executeQuery("SELECT * FROM tblpackage");
												       
												       while(rs.next()) {
												%>
												       <tr>
												           <th scope="row"><%= num %></th>
												           <td><%= rs.getString("Package_Name") %></td>
												           <td><%= rs.getString("Package_Description") %></td>
												           <td><%= rs.getString("Package_Price") %></td>
												           <td><%= rs.getString("Package_Valid_from") %></td>
												           <td><%= rs.getString("Package_Valid_to") %></td>
												           <td><a href="icon-material.jsp?edit=<%= rs.getInt("Package_id") %>">Edit</a></td>
												           <td><a href="icon-material.jsp?del=<%= rs.getInt("Package_id") %>" onclick="return checkDelete()">Delete</a></td>
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
