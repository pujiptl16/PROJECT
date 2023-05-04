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
		session.setAttribute("flag",0);
		// out.println("<script>student_dash_index.jsp'</script>");

		
        Statement stmt=con.createStatement();
        ResultSet record = stmt.executeQuery("SELECT * FROM tblregister WHERE Username='"+username+"'");
        
        if (record.next()) {
            fname = record.getString("FirstName");
            lname = record.getString("LastName");
            EnNo = record.getString("EnrollmentNo");
            email = record.getString("Email");
            phone = record.getString("PhoneNo");
            username = record.getString("Username");
        }
        
		if (request.getParameter("AdminUpdate") != null) {
	        id = request.getParameter("id");
	        fname = request.getParameter("Fname");
	        lname = request.getParameter("Lname");
	        
	        email = request.getParameter("Email");
	        phone = request.getParameter("Phone");
	        username = request.getParameter("Username");
	        password = request.getParameter("Password");
	        
	        String hash_pass = HBSHashing.HashPaswword(password);
			String Salt = HBSHashing.getSalt();
			
	       	PreparedStatement ps;
	       
	        

            if (email.matches("^\\S+@\\S+\\.\\S+$")) {
                String updateQuery = "UPDATE tblregister SET FirstName=?, LastName=?, `Password`=?, `Salt`=?, Email=?, PhoneNo=? WHERE Username=?";
                ps = con.prepareStatement(updateQuery);
                ps.setString(1, fname);
                ps.setString(2, lname);
                ps.setString(3, hash_pass);
                ps.setString(4, Salt);
                ps.setString(5, email);
                ps.setString(6, phone);
                ps.setString(7, id);
                ps.executeUpdate();
                session.setAttribute("message", "User Updated Successfully.");
                request.removeAttribute("AdminUpdate");
                response.sendRedirect("pages-profile.jsp");
            }
            else {
                out.println("<script>alert('Invalid Email Address.')</script>");
            }
	    }
		
		if(request.getMethod().equalsIgnoreCase("post")) {
		    if (request.getContentType() != null && request.getContentType().startsWith("multipart/form-data")) {
		        request.setAttribute("org.apache.catalina.multipartConfig", new MultipartConfigElement("/tmp"));
		    }
		    
		    String[] allowedExtensions = {"jpg", "jpeg", "png"};
		    String fileName = null;
		    String filePath = null;
		    String uploadFolder = "C:/Users/Parth/eclipse-workspace/HBS/src/main/webapp/dashboard/Admin/nice-html/ltr/Image/";
		    Part filePart = request.getPart("ProfilePic");

		    if (filePart != null) {
		        fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

		        String extension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

		        if(Arrays.asList(allowedExtensions).contains(extension)) {
		            String file = "./Image/" + session.getAttribute("FirstName") + "_" + session.getAttribute("username") + "." + extension;
		            filePart.write(file);
		            System.out.println("Image Updated");
		            String query = "UPDATE `tblstudent` SET Profile_img='" + file + "' WHERE user_id=" + session.getAttribute("userid") + ";";
		            con.createStatement().executeUpdate(query);
		            session.setAttribute("ProfilePic", file);
		        } else {
		            out.println("Choose valid image file with extensions of JPG, JPEG, or PNG.");
		            System.out.println("Image Updated 1");
		        }
		    } else {
		        out.println("No file chosen for upload.");
		        System.out.println("Image Updated 2");
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
    <title>Dormzz - Profile</title>
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
<![endif]--><link href="../../../SearchStyle.css" rel="stylesheet">
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
                        <h4 class="page-title">Profile</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Profile</li>
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
                <!-- Row -->
                <div class="row">
                    <!-- Column -->
                    <div class="col-lg-4 col-xlg-3">
                        <div class="card">
                            <div class="card-body">
                                <center class="mt-4"> <img src="<%= session.getAttribute("ProfilePic") %>" class="rounded-circle" width="150" height="150" />
                                    <h4 class="card-title mt-2"><%= session.getAttribute("FirstName") %> <%= session.getAttribute("LastName") %></h4>
                                    <h6 class="card-subtitle">Admin</h6>
                                    <div class="row text-center justify-content-md-center">
                                        <div class="col-4"><a href="javascript:void(0)" class="link"><i class="mdi mdi-calendar-today"></i>
                                                <font class="font-medium">01/06/2022</font>
                                            </a></div>
                                        <div class="col-4"><a href="javascript:void(0)" class="link"><i class="mdi mdi-calendar-check"></i>
                                                <font class="font-medium">31/12/2022</font>
                                            </a></div>
                                    </div>
                                    <br><br><br>
                                    
                                </center>

                                <form action="" method="post" enctype="multipart/form-data" class="form-horizontal form-material mx-2">
                                        <div class="form-group">
                                        <label>Upload Profile Image</label>
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">Upload</span>
                                            </div>
                                            <div class="custom-file">
                                                <input type="file" name="ProfilePic" class="custom-file-input" accept="image/jpeg, image/jpg, image/png" id="inputGroupFile01" required>
                                                <!-- <label class="custom-file-label" for="inputGroupFile01">Choose file</label> -->
                                            </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="submit" name="PPUpload" class="btn btn-success text-white">Update Profile Image</button>
                                        </div>
                                        </div>
                                    </form>
	                                   <%/*
										   if(request.getParameter("PPUpload") != null){
										       String[] type = {"image/jpg", "image/jpeg", "image/png"};
										
										       if(Arrays.asList(type).contains(request.getPart("ProfilePic").getContentType())){
										           String file = "./Image/"+ session.getAttribute("FirstName") + "_" + session.getAttribute("username") + ".jpg";
										           request.getPart("ProfilePic").write(file);
										           String query = "UPDATE `tblstudent` SET Profile_img='" + file + "' WHERE user_id=" + session.getAttribute("userid") + ";";
										           ((java.sql.Connection) request.getServletContext().getAttribute("db")).createStatement().executeUpdate(query);
										
										           ResultSet record2 = con.createStatement().executeQuery("SELECT * FROM `tblstudent` WHERE user_id=" + session.getAttribute("userid").toString() + ";");
										           record2.next();
										
										           session.setAttribute("ProfilePic", record2.getString("Profile_img"));
										
										       }
										       else{
										           out.println("Choose Valid Image.");
										       }
										   }
										*/%>

                            </div>
                            <div>
                                <hr>
                            </div>
                            <div class="card-body"> 
	                            <small class="text-muted">Email address </small>
									<h6><%= session.getAttribute("Email") %></h6>
								<small class="text-muted pt-4 db">Phone</small>
									<h6><%= session.getAttribute("Phone") %></h6>

                                <!-- <small class="text-muted pt-4 db">Address</small>
                                <h6>Katargram, Surat, 395004</h6>
                                 <div class="map-box">
                                    <iframe
                                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d470029.1604841957!2d72.29955005258641!3d23.019996818380896!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x395e848aba5bd449%3A0x4fcedd11614f6516!2sAhmedabad%2C+Gujarat!5e0!3m2!1sen!2sin!4v1493204785508"
                                        width="100%" height="150" frameborder="0" style="border:0"
                                        allowfullscreen></iframe>
                                </div>
                                <small class="text-muted pt-4 db">Social Profile</small>
                                <br />
                                <button class="btn btn-circle btn-secondary"><i class="mdi mdi-facebook"></i></button>
                                <button class="btn btn-circle btn-secondary"><i class="mdi mdi-twitter"></i></button>
                                <button class="btn btn-circle btn-secondary"><i class="mdi mdi-youtube-play"></i></button> -->
                            </div>
                        </div>
                    </div>
                    <!-- Column -->
                    <!-- Column -->
                    <div class="col-lg-8 col-xlg-9">
                        <div class="card">
                            <div class="card-body">
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
										</table>
                                <form class="form-horizontal form-material mx-2">
                                	<input type="hidden" name="id" value="<%= username %>">
                                	<input type="hidden" name="Fname" value="<%= fname %>">
                                	<input type="hidden" name="Lname" value="<%= lname %>">
                                    <div class="form-group">
                                        <label>Enrollment No</label>
                                        <input class="form-control" name="EnNo" value="<%= EnNo %>" type="text" placeholder="Enrollment No" readonly required>
                                    </div>
                                    <div class="form-group">
                                        <label>Username</label>
                                        <input class="form-control" name="Username" value="<%= username %>" type="text" placeholder="Username" readonly required>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-12">Full Name</label>
                                        <div class="col-md-12">
                                            <input type="text" name="Name" value="<%= fname %> <%= lname %>" placeholder="Full Name"
                                                class="form-control form-control-line" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="example-email" class="col-md-12">Email</label>
                                        <div class="col-md-12">
                                            <input type="email" name="Email" value="<%= email %>" placeholder="email-id"
                                                class="form-control form-control-line" name="example-email"
                                                id="example-email" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-12">Password</label>
                                        <div class="col-md-12">
                                            <input type="password" value="" name="Password" class="form-control form-control-line" Placeholder="Password" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-12">Phone No</label>
                                        <div class="col-md-12">
                                            <input type="text" name="Phone" value="<%= phone %>" placeholder="+91 9925940272"
                                                class="form-control form-control-line" required>
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="submit" name="AdminUpdate" class="btn btn-success text-white">Update Profile</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <!-- Column -->
                </div>
                <!-- Row -->
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