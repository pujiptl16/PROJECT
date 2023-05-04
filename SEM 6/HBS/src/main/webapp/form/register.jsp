<%@ page language="java" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../DBConnection.jsp" %>
<%
	String Username = "";
	String Email = "";
	String PhoneNo = "";
	String password = "";
	String cpassword = "";
	String CourseName = "";
	String DepartmentName = "";
	String Fname = "";
	String Lname = "";
	String gender = "";
	String EnNo = "";

%>
<!DOCTYPE html>
<html lang="en">

<head>

<%@include file="../HBSScripts.jsp" %>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
  <link rel="icon" type="image/png" href="../images/favicon.png">
  <title>
    DORMZZ - Registration
  </title>
  <!--     Fonts and icons     -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
  <!-- Nucleo Icons -->
  <link href="assets/css/nucleo-icons.css" rel="stylesheet" />
  <link href="assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- Font Awesome Icons -->
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <link href="assets/css/nucleo-svg.css" rel="stylesheet" />
  <!-- CSS Files -->
  <link id="pagestyle" href="assets/css/soft-ui-dashboard.css?v=1.0.7" rel="stylesheet" />
  
  	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js"></script>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js" rel="stylesheet">
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
</head>

<body class="">
<%
	if (request.getParameter("signup") != null) 
	{
		EnNo = request.getParameter("EnNo");
		Username = request.getParameter("username");
		Email = request.getParameter("Email");
		PhoneNo = request.getParameter("PhonoNo");
		CourseName = request.getParameter("CourseName");
		DepartmentName = request.getParameter("DepartmentName");
		Fname = request.getParameter("Fname");
		Lname = request.getParameter("Lname");
		gender = request.getParameter("gender");
		
		ResultSet record = DatabaseConnection.SelectQuery("SELECT * FROM tblregister WHERE EnrollmentNo='" + EnNo + "';", con);
		
		if (record.next()) {
			out.println("<script>showSwal('AlreadyExists');</script>");
		}
		else{
			password = request.getParameter("password");
			cpassword = request.getParameter("cpassword");
			
			record = DatabaseConnection.SelectQuery("SELECT * FROM tblregister WHERE Username='" + Username + "';", con);

			if (!record.next()) {
				
				if (HBSRegEx.validateEmail(Email) &&
					request.getParameter("gender") != null &&
					HBSRegEx.validatePhoneNumber(PhoneNo) &&
					password.equals(cpassword))
				{
								
								
					String hash_pass = HBSHashing.HashPaswword(password);
					String Salt = HBSHashing.getSalt();
					
					
					String query = "INSERT INTO tblregister(EnrollmentNo, CourseName, DepartmentName, Username, Password, Salt, FirstName, LastName, Gender, Email, PhoneNo) VALUES ('" + EnNo + "','" + CourseName + "','" + DepartmentName + "','" +Username + "','" + hash_pass + "','" + Salt + "','" + Fname + "','" + Lname + "','" + gender + "','" + Email + "','" + PhoneNo + "')";
					int result = DatabaseConnection.InsertQuery(query,con);
					
					if(result > 0) {
						out.println("<script>showSwal('RSuccess');</script>");
						//response.sendRedirect("login.jsp");
					}
					else {
						out.println("<script>showSwal('UE');</script>");
					}
				} else 
				{
					out.println("<script>showSwal('Error');</script>");
				}
			}else 
			{
				out.println("<script>showSwal('UsernameTaken');</script>");
			}
		}		
	}
%>

  <div class="container position-sticky z-index-sticky top-0">
    <div class="row">
      <div class="col-12">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg blur blur-rounded top-0 z-index-3 shadow position-absolute my-3 py-2 start-0 end-0 mx-4">
          <div class="container-fluid pe-0">
            <a class="navbar-brand fs-4 font-weight-bolder ms-lg-0 ms-3 " href="../index.jsp">
              Dormzz - Registration
            </a>
            <button class="navbar-toggler shadow-none ms-2" type="button" data-bs-toggle="collapse" data-bs-target="#navigation" aria-controls="navigation" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon mt-2">
                <span class="navbar-toggler-bar bar1"></span>
                <span class="navbar-toggler-bar bar2"></span>
                <span class="navbar-toggler-bar bar3"></span>
              </span>
            </button>
            <div class="collapse navbar-collapse" id="navigation">
              <ul class="navbar-nav mx-auto ms-xl-auto me-xl-7">
                <li class="nav-item">
                  
                </li>
                <li class="nav-item">
                  
                </li>
                <li class="nav-item">
                  
                </li>
                <li class="nav-item">
                  
                </li>
              </ul>
              <li class="nav-item d-flex align-items-center">
                <a class="btn btn-round btn-sm mb-0 btn-outline-primary me-2" target="_blank" href="../index.jsp">Home</a>
              </li>
              <ul class="navbar-nav d-lg-block d-none">
                <li class="nav-item">
                  <a href="login.jsp" class="btn btn-sm btn-round mb-0 me-1 bg-gradient-primary">Sign In</a>
                </li>
              </ul>
            </div>
          </div>
        </nav>
        <!-- End Navbar -->
      </div>
    </div>
  </div>
  <main class="main-content  mt-0">
    <section>
      <div class="page-header min-vh-75">
        <div class="container">
          <div class="row">
            <div class="col-xl-5 col-lg-6 col-md-7 d-flex flex-column mx-auto">
              <div class="card card-plain mt-8">
                <div class="card-header pb-0 text-left bg-transparent">
                  <h3 class="font-weight-bolder text-info text-gradient">Registration Panel</h3>
                  <p class="mb-0">Fill your details properly</p>
                </div>
                <div class="card-body">
                  <form action="" method="post" class="signin-form" >
							<div class="form-group">
								<select id="DepartmentName" name="DepartmentName" class="form-control" required>
                                      <%
                                      	PreparedStatement stmt = null;
										ResultSet rs = null;
										
										stmt = null;
										rs = null;
										
										stmt = con.prepareStatement("SELECT * FROM tbldepartment");
										rs = stmt.executeQuery();
										%>
										
										<option value="" disabled selected >Select department</option>
										<%
										while (rs.next()) {
										%>
										<option value="<%= rs.getString("d_id") %>" style="color:#6c757d" <% if(DepartmentName.equals(String.valueOf(rs.getInt("d_id")))){ %> selected <% } %> ><%= rs.getString("d_name") %></option>
										<%
										}
										%>
									</select>		
							</div>
							<div class="list-group list-group-horizontal" style="justify-content:space-between;">
								<div class="form-group" style="width:50%;">
									<input type="text" id="EnNo" name="EnNo" maxlength="15" class="form-control" value='<%=  EnNo %>' placeholder="Enrollment Number" required>
								</div>
								<div class="form-group" style="width:50%; margin-left:2%">
									<!--  <input type="text" id="CourseName" name="CourseName" class="form-control" value='' placeholder="Course Name" required>
									 -->
									 <input type="hidden" id="Course" name="Course" value="<%= CourseName %>"/>
									 <select id="CourseName" name="CourseName" class="form-control" required>
                                      <option value="" disabled selected >Select Department first</option>
									</select>      
								</div>
							</div>
							<div class="list-group list-group-horizontal" style="justify-content:space-between;">
								<span class="progress-bar_text" id="Enrollment-bar_text" ></span>
								<span class="progress-bar_text" id="Course-bar_text" ></span>
							</div>
							
							<div class="list-group list-group-horizontal" style="justify-content:space-between;">
								<div class="form-group" style="width:50%;">
									<input type="text" id="Fname" name="Fname" class="form-control" value='<%=  Fname %>' placeholder="First Name" required>
								</div>
								<div class="form-group" style="width:50%; margin-left:2%">
									<input type="text" id="Lname" name="Lname" class="form-control" value='<%=  Lname %>' placeholder="Last Name" required>
								</div>
							</div>
							<div class="list-group list-group-horizontal" style="justify-content:space-between;">
								<span class="progress-bar_text" id="Fname-bar_text" ></span>
								<span class="progress-bar_text" id="Lname-bar_text" ></span>
							</div>	
							<div class="form-group">
								<label class="form-control">Gender :
								<input type="radio" name="gender" value="Boys" placeholder="Male" <% if(gender.equals("Boys")){ %> checked <% } %> required> Male   
								<input style="margin-left:4%;" type="radio" name="gender" value="Girls" placeholder="Female" <% if(gender.equals("Girls")){ %> checked <% } %>> Female
								</label>
							</div>
							<div class="list-group list-group-horizontal" style="justify-content:space-between;">
								<div class="form-group" style="width:50%;">
									<input type="email" id="Email" name="Email" class="form-control" value='<%=  Email %>' placeholder="Email ID" required>
								</div>
								<div class="form-group" style="width:50%; margin-left:2%">
									<input type="text" id="PhonoNo" maxlength="10" name="PhonoNo" class="form-control" value='<%=  PhoneNo %>' placeholder="Phono No." required>
								</div>
							</div>
							<div class="list-group list-group-horizontal" style="justify-content:space-between;">
								<span class="progress-bar_text" id="Email-bar_text" ></span>
								<span class="progress-bar_text" id="Phone-bar_text" ></span>
							</div>	
							<div class="form-group">
								<input id="username-field" type="text" name="username" class="form-control" value='<%=  Username %>' placeholder="Username" required>
							</div>
							<div class="form-group">
								<input id="password-field" name="password" type="password" class="form-control" value='<%=  password %>' placeholder="Password"  style="border-bottom-color:#2F96EF;" required>
								<!--  <span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>  -->
							</div>
							<span class="progress-bar_text" id="progress-bar_text" ></span>
							
							<div class="form-group">
								<input id="cpassword-field" name="cpassword" type="password" class="form-control" value='<%=  cpassword %>' placeholder="Confirm Password" required>
								<!-- <span toggle="#cpassword-field" class="fa fa-fw fa-eye field-icon toggle-password"></span> -->
							</div>
							<span class="progress-bar_text" id="cprogress-bar_text" ></span>
							
							<div class="form-group">
								<button type="submit" id="signup" name="signup" class="form-control btn btn-primary submit px-3" disabled>Sign Up</button>
							</div>
							<!-- <div class="form-group d-md-flex">
								<div class="w-50">
									<label class="checkbox-wrap checkbox-primary">Remember Me
										<input type="checkbox" checked>
										<span class="checkmark"></span>
									</label>
								</div>
								<div class="w-50 text-md-right">
									<a href="#" style="color: #fff">Forgot Password</a>
								</div>
							</div> -->
<!-- 							<p class="w-100 text-center">&mdash; Already Have an Account ? &mdash;</p>
							<div class="social d-flex text-center">
								<a href="login.jsp" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-1"></span>Sign In</a>
								<a href="../index.jsp" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-1"></span>Home</a>
							</div> -->
						</form>
                </div>
                <div class="card-footer text-center pt-0 px-lg-2 px-1">
                  <p class="mb-4 text-sm mx-auto">
                    &mdash; Already Have an Account ? &mdash;<br>
                    <a href="login.jsp" class="text-info text-gradient font-weight-bold"><span class="ion-logo-facebook mr-1"></span>Sign In</a><br>
                    <a href="../index.jsp" class="text-info text-gradient font-weight-bold"><span class="ion-logo-facebook mr-1"></span>Home</a>
                    
                  </p>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="oblique position-absolute top-0 h-100 d-md-block d-none me-n8">
                <div class="oblique-image bg-cover position-absolute fixed-top ms-auto h-100 z-index-0 ms-n6" style="background-image:url('../images/banner/hero-area.JPG')/*url('assets/img/curved-images/curved6.jpg')*/"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>
  <!-- -------- START FOOTER 3 w/ COMPANY DESCRIPTION WITH LINKS & SOCIAL ICONS & COPYRIGHT ------- -->
  <footer class="footer py-5">
    <div class="container">
      <div class="row">
        <div class="col-8 mx-auto text-center mt-1">
          <p class="mb-0 text-secondary">
            Copyright © <script>
              document.write(new Date().getFullYear())
            </script> DORMZZ
          </p>
        </div>
      </div>
    </div>
  </footer>
  <!-- -------- END FOOTER 3 w/ COMPANY DESCRIPTION WITH LINKS & SOCIAL ICONS & COPYRIGHT ------- -->
  <!--   Core JS Files   -->
  <script src="../assets/js/core/popper.min.js"></script>
  <script src="../assets/js/core/bootstrap.min.js"></script>
  <script src="../assets/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="../assets/js/plugins/smooth-scrollbar.min.js"></script>
  <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>
  <!-- Github buttons -->
  <script async defer src="https://buttons.github.io/buttons.js"></script>
  <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="../assets/js/soft-ui-dashboard.min.js?v=1.0.7"></script>
  
  
</body>

</html>

