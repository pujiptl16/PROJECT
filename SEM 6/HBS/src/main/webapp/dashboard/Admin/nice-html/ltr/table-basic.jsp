<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>

<%
	session=request.getSession();
	boolean update = false;
	String Hname="";
	String category="";
	String address="";
	String Type="";
	String Status="";
	int id = 0;
    String distance = "";
    int capacity = 0;
    int availRooms = 0;
    int rector = 0;
    int mess = 0;
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
		
	    if (request.getParameter("del") != null) {
	        id = Integer.parseInt(request.getParameter("del"));
	        String query = "DELETE FROM tblhostel WHERE Hostel_id='" + id + "'";
	        
	        Statement statement = null;
        
            statement = con.createStatement();
            statement.executeUpdate(query);
            session.setAttribute("message", "Hostel Deleted Successfully.");
            response.sendRedirect("table-basic.jsp");

	    }
	    
	    if (request.getParameter("AddHostel") != null) {
	    	Hname = request.getParameter("Name");
	    	category = request.getParameter("category");
	    	capacity = Integer.parseInt(request.getParameter("Capacity"));
	        availRooms = Integer.parseInt(request.getParameter("Available_Rooms"));
	        rector = Integer.parseInt(request.getParameter("user_id"));
	        mess = Integer.parseInt(request.getParameter("Mess_id"));
	        distance = request.getParameter("Hostel_Distance");
	    	address = request.getParameter("Address");
	    	Type= request.getParameter("Type");
	    	Status= request.getParameter("Status");
	    	
	    	String query = "INSERT INTO `tblhostel`(`Capacity`, `Hostel_Name`, `Hostel_Category`, `Hostel_Status`, `Hostel_Distance`, `Hostel_Type`, `Available_Rooms`, `user_id`, `Mess_id`, `Address`) VALUES ('"+ capacity +"','"+ Hname +"', '"+ category +"', '"+ Status +"','"+ distance +"','"+ Type +"','"+ availRooms +"','"+ rector +"','"+ mess +"','"+ address +"')";
	    	Statement statement = null;
			int result = statement.executeUpdate(query);
			if (result > 0) {
			    session.setAttribute("message", "Hostel Stored Successfully.");
			    response.sendRedirect("table-basic.jsp");
			}
		}

	    if (request.getParameter("edit") != null) 
	    {
	        id = Integer.parseInt(request.getParameter("edit"));
	        update = true;
	        ResultSet record = null;
	        
	            record = con.createStatement().executeQuery("SELECT * FROM tblhostel WHERE Hostel_id=" + id);
	            if (record.next()) 
	            {
	            	Hname = record.getString("Hostel_Name");
	                category = record.getString("Hostel_Category");
	                capacity = record.getInt("Capacity");
	                availRooms = record.getInt("Available_Rooms");
	                rector = record.getInt("user_id");
	                mess = record.getInt("Mess_id");
	                address = record.getString("Address");
	                distance = record.getString("Hostel_Distance");
	                Type = record.getString("Hostel_Type");
	                Status = record.getString("Hostel_Status");
	            }
	    }
	    
	    if(request.getParameter("HostelUpdate") != null) {
	    	//id = request.getParameter("id");
	    	id = Integer.parseInt(request.getParameter("id"));
	    	Hname = request.getParameter("Name");
	    	category = request.getParameter("category");
	    	capacity = Integer.parseInt(request.getParameter("Capacity"));
	    	availRooms = Integer.parseInt(request.getParameter("AvailRooms"));
	    	rector = Integer.parseInt(request.getParameter("Rector"));
	    	mess = Integer.parseInt(request.getParameter("Messchief"));
	    	address = request.getParameter("Address");
	    	distance = request.getParameter("Distance");
	    	Type = request.getParameter("Type");
	    	Status = request.getParameter("Status");
	    	
	    	String query = "UPDATE tblhostel SET Capacity=" + capacity + ", Hostel_Name='" + Hname + "', Hostel_Category='" + category + "', Hostel_Status='" + Status + "', Hostel_Distance='" + distance + "', Hostel_Type='" + Type + "', Available_Rooms=" + availRooms + ", user_id=" + rector + ", Mess_id=" + mess + ", Address='" + address + "' WHERE Hostel_id=" + id;
	        Statement stmt = null;
	        stmt = con.createStatement();
            stmt.executeUpdate(query);
            session.setAttribute("message", "Hostel Updated Successfully.");
            response.sendRedirect("table-basic.jsp");
    
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
    <title>Dormzz - Mess Corner</title>
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
                        <h4 class="page-title">Hostels Panel</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Hostels Panel</li>
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
                                <h4 class="card-title">Hostels</h4>
                                <h6 class="card-subtitle">Manage Hostels</h6>
                                <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-1-box-multiple-outline"></i><a href="table-basic.php?add">Add Hostel</a></h6>
                                
                                <% if (request.getParameter("add") != null) { %>
                                    
                                    <form action="" method="post" class="form-horizontal mt-4">
                                        <input type="hidden" name="id" value="<%= id %>">
                                        <div class="form-group">
                                            <label>Hostel Name</label>
                                            <input type="text" name="Name" class="form-control" value="<%= Hname %>" placeholder="Hostel Name">
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Category</label>
                                            <select name="category" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="Girls" selected>Girls</option>
                                                <option value="Boys">Boys</option>
                                                <option value="Both">Both</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Capacity</label>
                                            <input type="text" name="Capacity" class="form-control" value="<%= capacity %>" placeholder="Capacity">
                                        </div>
                                        <div class="form-group">
                                            <label>Available Rooms</label>
                                            <input type="text" name="AvailRooms" class="form-control" value="<%= availRooms %>" placeholder="Available Rooms">
                                        </div>
                                        <div class="form-group">
                                            <label>Rector</label>
                                            <input type="text" name="Rector" id="example-email" value="<%= rector %>" class="form-control" placeholder="Rector">
                                        </div>
                                        <div class="form-group">
                                            <label>Mess Chief</label>
                                            <input type="text" name="Messchief" class="form-control" value="<%= mess %>" placeholder="Mess Chief">
                                        </div>
                                        <div class="form-group">
                                            <label>Address</label>
                                            <input type="text" name="Address" class="form-control" value="<%= address %>" placeholder="Address">
                                        </div>
                                        <div class="form-group">
                                            <label>Distance</label>
                                            <input type="text" name="Distance" class="form-control" value="<%= distance %>" placeholder="Hostel Distance">
                                        </div>
                                        <div class="form-group">
                                            <label>Location Type</label>
                                            <select name="Type" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="In Campus" selected>In Campus</option>
                                                <option value="Off Campus">Off Campus</option>
                                                <option value="PG">PG</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Status</label>
                                            <select name="Status" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="Available" selected>Available</option>
                                                <option value="Fast Filling">Fast Filling</option>
                                                <option value="Full">Full</option>
                                                <option value="Not Available">Not Available</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                                <div class="col-sm-12">
                                                    <button type="submit" name="AddHostel" class="btn btn-success text-white">Add</button>
                                                </div>
                                            </div>
                                    </form>

                                   <%
									request.removeAttribute("add"); 
                                   	}
									%>
                                
                                    <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-2-box-multiple-outline"></i> Available Hostels</h6>
                                
                                	 <% if (request.getParameter("edit") != null) { %>

                                    
                                        <form action="" method="post" class="form-horizontal mt-4">
                                        <input type="hidden" name="id" value="<%= id %>">
                                        <div class="form-group">
                                            <label>Hostel Name</label>
                                            <input type="text" name="Name" class="form-control" value="<%= Hname %>" placeholder="Hostel Name">
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Category</label>
                                            <select name="category" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="Girls" <% if (category.equals("Girls")) { %> selected <% } %> >Girls</option>
                                                <option value="Boys" <% if (category.equals("Boys")) { %> selected <% } %>  >Boys</option>
                                                <option value="Both" <% if (category.equals("Both")) { %> selected <% } %> >Both</option>
                                                <option value="Other" <% if (category.equals("Other")) { %> selected <% } %> >Other</option>
                                            </select>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Capacity</label>
                                            <input type="text" name="Capacity" class="form-control" value="<%= capacity %>" placeholder="Capacity">
                                        </div>
                                        <div class="form-group">
                                            <label>Available Rooms</label>
                                            <input type="text" name="AvailRooms" class="form-control" value="<%= availRooms %>" placeholder="Available Rooms">
                                        </div>
                                        <div class="form-group">
                                            <label>Rector</label>
                                            <input type="text" name="Rector" id="example-email" value="<%= rector %>" class="form-control" placeholder="Rector">
                                        </div>
                                        <div class="form-group">
                                            <label>Mess Chief</label>
                                            <input type="text" name="Messchief" class="form-control" value="<%= mess %>" placeholder="Mess Chief">
                                        </div>
                                        <div class="form-group">
                                            <label>Address</label>
                                            <input type="text" name="Address" class="form-control" value="<%= address %>" placeholder="Address">
                                        </div>
                                        <div class="form-group">
                                            <label>Distance</label>
                                            <input type="text" name="Distance" class="form-control" value="<%= distance %>" placeholder="Hostel Distance">
                                        </div>
                                        <div class="form-group">
                                            <label>Location Type</label>
                                            <select name="Type" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="In Campus" <% if (Type.equals("In Campus")) { %> selected <% } %>  >In Campus</option>
                                                <option value="Off Campus" <% if (Type.equals("Off Campus")) { %> selected <% } %> >Off Campus</option>
                                                <option value="PG" <% if (Type.equals("PG")) { %> selected <% } %> >PG</option>
                                                <option value="Other" <% if (Type.equals("Other")) { %> selected <% } %> >Other</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Status</label>
                                            <select name="Status" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="Available" <% if (Status.equals("Available")) { %> selected <% } %>  >Available</option>
                                                <option value="Fast Filling" <% if (Status.equals("Fast Filling")) { %> selected <% } %> >Fast Filling</option>
                                                <option value="Full" <% if (Status.equals("Full")) { %> selected <% } %>  >Full</option>
                                                <option value="Not Available" <% if (Status.equals("Not Available")) { %> selected <% } %> >Not Available</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                                <div class="col-sm-12">
                                                    <button type="submit" name="HostelUpdate" class="btn btn-success text-white">Update</button>
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
                                                        <th scope="col">Capacity</th>
                                                        <th scope="col">Available Rooms</th>
                                                        <th scope="col">Rector</th>
                                                        <th scope="col">Mess Chief</th>
                                                        <th scope="col">Address</th>
                                                        <th scope="col">Distance</th>
                                                        <th scope="col">Type</th>
                                                        <th scope="col">Status</th>
                                                        <th scope="col" colspan=2>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                <%
												    Statement stmt = null;
												    ResultSet rs = null;
												
												   		stmt = con.createStatement();
												        String query = "SELECT * FROM tblhostel";
												        rs = stmt.executeQuery(query);
												
												        int num = 1;
												        while (rs.next()) {
												%>
												            <tr>
												                <th scope="row"><%= num %></th>
												                <td><%= rs.getString("Hostel_Name") %></td>
												                <td><%= rs.getString("Capacity") %></td>
												                <td><%= rs.getString("Available_Rooms") %></td>
												                <td><%= rs.getString("user_id") %></td>
												                <td><%= rs.getString("Mess_id") %></td>
												                <td><%= rs.getString("Address") %></td>
												                <td><%= rs.getString("Hostel_Distance") %></td>
												                <td><%= rs.getString("Hostel_Type") %></td>
												                <td><%= rs.getString("Hostel_Status") %></td>
												                <td><a href="table-basic.jsp?edit=<%= rs.getString("Hostel_id") %>">Edit</a></td>
												                <td><a href="table-basic.jsp?del=<%= rs.getString("Hostel_id") %>" onclick="return checkDelete()">Delete</a></td>
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
                <a href="http://www.utu.ac.in/bmiit" target="_blank">BMIITIANS</a>..
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