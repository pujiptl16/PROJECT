<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.mail.*" %>
<%@page import="javax.mail.internet.*" %>
<%@page import="org.mindrot.jbcrypt.*" %>
<%@page import="com.HBS.DatabaseConnection" %>
<%@page import="com.HBS.HBSMailer" %>
<%
//DatabaseConnection db = new DatabaseConnection();
//HBSMailer Mail = new HBSMailer();
session = request.getSession();
Connection con = null;

String user = "";
String pass = "";

if(request.getParameter("username") != null && request.getParameter("password") != null)
{
    user = request.getParameter("username");
    pass = request.getParameter("password");
    
    try
	{
       	con = DatabaseConnection.InitializeDatabase("dormzz");
        if(con != null) {
        	out.println("<script>alert('Database Connected Successfully.')</script>");
        } else {
        	out.println("<script>alert('Database Not Connected.')</script>");
        }
    }
    catch (Exception e)
	{
    	out.println("<script>alert('Error Establishing Database Connection.')</script>");
    }
    
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM tblregister WHERE Username='" + user + "';");
    
    if (rs.next() == false)
	{
        out.println("<script>alert('User Does not Exists. Kingly Register.')</script>");
    } 
    else
	{
    	//rs.beforeFirst();
        while (rs.next())
		{
            String EnNo = rs.getString("EnrollmentNo");
            String username = rs.getString("Username");
            String password = rs.getString("Password");
            String email = rs.getString("Email");
            String hash_pass = BCrypt.hashpw(pass, BCrypt.gensalt());
            
            if (BCrypt.checkpw(pass, password))
			{	
            	session.setAttribute("username", username);
            	session.setAttribute("EnNo", rs.getString("EnrollmentNo"));
           		session.setAttribute("FirstName", rs.getString("FirstName"));
           		session.setAttribute("LastName", rs.getString("LastName"));
           		session.setAttribute("Email", email);
           		session.setAttribute("Phone", rs.getString("PhoneNo"));
           		session.setAttribute("userid", rs.getString("user_id"));
           		session.setAttribute("gender", rs.getString("Gender"));

				ResultSet record2 = st.executeQuery("SELECT * FROM `tblstudent` WHERE user_id='" + rs.getString("user_id") + "';");
		
				session.setAttribute("ProfilePic", record2.getString("Profile_img"));
		
				try
				{
				
					if(request.getParameter("SendOTP") != null)
					{
						
						int otp = (int)(Math.random() * ((999999 - 100000) + 1)) + 100000;
						String MailSubject = "Dormzz : Sign In Verification";
						String MailBody = "Your OTP to Login is :" + otp + "<br><br>Thank You.<br>Team Dormzz";
						
						HBSMailer.sendMail(email, MailSubject, MailBody);
						
						session.setAttribute("OTP", otp);
					}
	
					if(request.getParameter("SignIn") != null)
					{
						//if(request.getParameter("OTP").equals(session.getAttribute("OTP"))) {
							if(EnNo.length() == 15)
							{
								response.sendRedirect("../dashboard/Student/nice-html/ltr/student_dash_index.jsp");
							}
							else if(EnNo.length() == 10)
							{
								response.sendRedirect("../dashboard/Admin/nice-html/ltr/student_dash_index.jsp");
							}
							else if(EnNo.length() == 7)
							{
								response.sendRedirect("../dashboard/Staff/nice-html/ltr/student_dash_index.jsp");
							}
						//}
						//else
						//{
							//out.println("<script>alert('Verification Failed.')</script>");
						//}
					}
			
				} catch (Exception e)
				{
					out.println("Message could not be sent. Mailer Error");
				} 
        	}
			else
			{
				out.println("<script>alert('Invalid Username and Password')</script>");
				request.removeAttribute("SendOTP");
				request.removeAttribute("SignIn");
			}
		}
	}
}
%>
<!doctype html>
<html lang="en">
  <head>
  	<title>Dormzz - Login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="shortcut icon" type="image/x-icon" href="../images/favicon.png" />
	<link rel="stylesheet" href="css/style.css">

	</head>
	<body class="img js-fullheight" style="background-image: url(images/bg.jpg);">
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-3">
					<h1 class="heading-section" style="text-transform: uppercase; font-weight: bolder;">Login</h1>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4">
					<div class="login-wrap p-0">
		      	<!-- <h3 class="mb-4 text-center">Have an account?</h3> -->
		      	<form action="" method="post" class="signin-form">
		      		<div class="form-group">
		      			<input type="text" name="username" class="form-control" placeholder="Username" value="<%= user %>" required>
		      		</div>
	            	<div class="form-group">
	              		<input id="password-field" name="password" type="password" class="form-control" placeholder="Password" value="<%= pass %>" required>
	              		<span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
	            	</div>
					<div class="form-group">
						<button type="submit" id="SendOtp" name="SendOTP" class="form-control btn btn-primary submit px-3">Send OTP</button>
					</div>
	
					<% if(request.getParameter("SendOTP") != null){ %>
					
					<div class="form-group">
		      			<input type="text" name="OTP" class="form-control" placeholder="6 Digit OTP" required>
		      		</div>

					<div class="form-group">
						<button type="submit" id="SignIn" name="SignIn" class="form-control btn btn-primary submit px-3">Sign In</button>
					</div>

					<% } %>
					<div class="form-group d-md-flex">
						<div class="w-50">
							<label class="checkbox-wrap checkbox-primary">Remember Me
										<input type="checkbox" checked>
										<span class="checkmark"></span>
										</label>
									</div>
									<div class="w-50 text-md-right">
										<a href="#" style="color: #fff">Forgot Password</a>
									</div>
					</div>
				</form>
	          <p class="w-100 text-center">&mdash; Or Sign Up With &mdash;</p>
	          <div class="social d-flex text-center">
	          	<a href="register.php" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-2"></span>Sign Up</a>
	          	<a href="../index.php" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-2"></span>Home</a>
	          	<!-- <a href="#" class="px-2 py-2 ml-md-1 rounded"><span class="ion-logo-twitter mr-2"></span> Twitter</a> -->
	          </div>
		      </div>
				</div>
			</div>
		</div>
	</section>

	<script src="js/jquery.min.js"></script>
  <script src="js/popper.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/main.js"></script>
  <script>
	$("#SendOtp").on("click", function () {
    	document.getElementById("SignIn").focus();
 	});
  </script>

	</body>
</html>

