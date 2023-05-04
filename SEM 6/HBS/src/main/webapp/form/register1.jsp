<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../DBConnection.jsp" %>
<%@include file="../HBSScripts.jsp" %>
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

	if (request.getParameter("signup") != null) 
	{
		EnNo = request.getParameter("EnNo");
		
		ResultSet record = DatabaseConnection.SelectQuery("SELECT * FROM tblregister WHERE EnrollmentNo='" + EnNo + "';", con);
		
		if (record.next()) {
			out.println("<script>showSwal('AlreadyExists');</script>");
		}
		else{
			Username = request.getParameter("username");
			Email = request.getParameter("Email");
			PhoneNo = request.getParameter("PhonoNo");
			password = request.getParameter("password");
			cpassword = request.getParameter("cpassword");
			CourseName = request.getParameter("CourseName");
			DepartmentName = request.getParameter("DepartmentName");
			Fname = request.getParameter("Fname");
			Lname = request.getParameter("Lname");
			gender = request.getParameter("gender");
			
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

<!doctype html>
<html lang="en">
  <head>
  	<title>Dormzz - Register</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
	
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js"></script>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.min.css">
	
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="shortcut icon" type="image/x-icon" href="../images/favicon.png" />
	<link rel="stylesheet" href="css/style.css">
	
	</head>
	<body class="img js-fullheight" style="background-image: url(images/bg3.jpg); background-size: cover; background-repeat: no-repeat; background-attachment: fixed; background-position: center center; ">
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-1">
					<h1 class="heading-section" style="text-transform: uppercase; font-weight: bolder;">Register</h1>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-5">
					<div class="login-wrap p-0">
		      			<!-- <h3 class="mb-4 text-center">Have an account?</h3> -->
						<form action="" method="post" class="signin-form" >
							<div class="list-group list-group-horizontal" style="justify-content:space-between;">
								<div class="form-group">
									<input type="text" name="EnNo" class="form-control" value='<%=  EnNo %>' placeholder="Enrollment Number" required>
								</div>
								<div class="form-group" style="margin-left:2%">
									<input type="text" name="CourseName" class="form-control" value='<%=  DepartmentName %>' placeholder="Course Name" required>
								</div>
							</div>
							<div class="list-group list-group-horizontal" style="justify-content:space-between;">
								<div class="form-group">
									<input type="text" name="Fname" class="form-control" value='<%=  Fname %>' placeholder="First Name" required>
								</div>
								<div class="form-group" style="margin-left:2%">
									<input type="text" name="Lname" class="form-control" value='<%=  Lname %>' placeholder="Last Name" required>
								</div>
							</div>	
							<div class="form-group">
								<!-- <input type="text" name="DepartmentName" class="form-control" placeholder="Department Name" required> -->
								<select name="DepartmentName"  class="form-control" required>
									<option value="BMIIT" style="color:#6c757d;">Babu Madhav Institute of Information Technology</option>
									<option value="CGPIT" style="color:#6c757d;">Chhotubhai Gopalbhai Patel Institute of Technology</option>
									<option value="CGBIBT" style="color:#6c757d;">C. G Bhakta Institute of BioTechnology</option>
									<option value="SRIMCA" style="color:#6c757d;">Shrimad Rajchandra Institute of Management and Computer Applications</option>
								</select>
							</div>
							<div class="form-group">
								<label class="form-control">Gender  :
								<input type="radio" name="gender" value="Boys" placeholder="Gender"> Male   
								<input style="margin-left:4%;" type="radio" name="gender" value="Girls" placeholder="Gender"> Female
								</label>
							</div>
							<div class="list-group list-group-horizontal" style="justify-content:space-between;">
								<div class="form-group">
									<input type="email" name="Email" class="form-control" value='<%=  Email %>' placeholder="Email ID" required>
								</div>
								<div class="form-group" style="margin-left:2%">
									<input type="text" name="PhonoNo" class="form-control" value='<%=  PhoneNo %>' placeholder="Phono No." required>
								</div>
							</div>
							<div class="form-group">
								<input id="username-field" type="text" name="username" class="form-control" value='<%=  Username %>' placeholder="Username" required>
							</div>
							<div class="form-group">
								<input id="password-field" name="password" type="password" class="form-control" value='<%=  password %>' placeholder="Password"  style="border-bottom-color:#2F96EF;" required>
								<span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
							</div>
							<span class="progress-bar_text" id="progress-bar_text" ></span>
							
							<div class="form-group">
								<input id="cpassword-field" name="cpassword" type="password" class="form-control" value='<%=  cpassword %>' placeholder="Confirm Password" required>
							<span toggle="#cpassword-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
							</div>
							<div class="form-group">
								<button type="submit" name="signup" class="form-control btn btn-primary submit px-3">Sign In</button>
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
							<p class="w-100 text-center">&mdash; Already Have an Account ? &mdash;</p>
							<div class="social d-flex text-center">
								<a href="login.jsp" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-1"></span>Sign In</a>
								<a href="../index.jsp" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-1"></span>Home</a>
							</div>
						</form>
		      		</div>
				</div>
			</div>
		</div>
	</section>

	<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>

	</body>
</html>

