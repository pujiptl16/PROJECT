<%@ page language="java" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../DBConnection.jsp" %>
<%
//DatabaseConnection db = new DatabaseConnection();
//HBSMailer Mail = new HBSMailer();
response.setHeader("Pragma","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Expires","0");
response.setDateHeader("Expires",-1);

session = request.getSession();
//Connection con = null;

Cookie cookies[] = request.getCookies();

String user = "";
String pass = "";
String OTP = "";

String checked_val = "";


if(cookies != null) {
	checked_val = "checked";
	//out.println("Cookie Set.");
	for(int i=0;i<cookies.length;i++){  
		if(cookies[i].getName() == "username") {
			user = cookies[i].getValue();
    	}
		
		if(cookies[i].getName() == "password") {
			pass = cookies[i].getValue();
    	}
		 //out.print("<br>"+cookies[i].getName()+" "+cookies[i].getValue());
	}	
	//enrollment = cookies[1].getValue();
	//Name = cookies[2].getValue();
} else {
	user = "";
	pass = "";
	checked_val = "";
}

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
    DORMZZ - Login
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
if(request.getParameter("username") != null && request.getParameter("password") != null)
{
    
	
    /*
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
    */
    user = request.getParameter("username");
    pass = request.getParameter("password");
    
	String remember = request.getParameter("remember");
	

	if(remember!=null) {
		Cookie cookie = new Cookie("username",user);
		response.addCookie(cookie);
		cookie = new Cookie("password",pass);
		response.addCookie(cookie);
	} else {
		Cookie cookie = new Cookie("username","");
		cookie.setMaxAge(0);
		response.addCookie(cookie);
		
		cookie = new Cookie("pass","");
		cookie.setMaxAge(0);
		response.addCookie(cookie);
	}
	
    //Statement st = con.createStatement();
    String query = "SELECT * FROM tblregister WHERE Username='" + user + "';";
    ResultSet rs = DatabaseConnection.SelectQuery(query, con);
    
    if (!rs.next())
	{
    	out.println("<script>showSwal('NotExists');</script>");
        request.setAttribute("SendOTP", "");
        //out.println("<script>location.href='login.jsp'</script>");
    } 
    else
	{
    	//rs.last();
    	int numRows = rs.getRow();
    	//out.println("<script>alert('Entered Else Block, Contacines " + numRows + " Rows');</script>");
    	rs.beforeFirst();
        while (rs.next())
		{
            String EnNo = rs.getString("EnrollmentNo");
            String email = rs.getString("Email");
            //out.println("<script>alert('Entered While Block');</script>");
            
           	String Hash = rs.getString("Password");
            String Salt = rs.getString("Salt");
            //out.println("<script>alert('Hash : "+ Hash +"<br>Salt : " + Salt + "');</script>");
            if (HBSHashing.VerifyHash(pass, Hash, Salt))
			{	
            	session.setAttribute("username", user);
            	session.setAttribute("EnNo", rs.getString("EnrollmentNo"));
           		session.setAttribute("FirstName", rs.getString("FirstName"));
           		session.setAttribute("LastName", rs.getString("LastName"));
           		session.setAttribute("Email", email);
           		session.setAttribute("Phone", rs.getString("PhoneNo"));
           		session.setAttribute("userid", rs.getString("user_id"));
           		session.setAttribute("gender", rs.getString("Gender"));

           		String uid = rs.getString("user_id");
           		
           		query = "SELECT * FROM `tblstudent` WHERE user_id='" + uid + "';";
				ResultSet record2 = DatabaseConnection.SelectQuery(query, con);
				record2.next();
				session.setAttribute("ProfilePic", record2.getString("Profile_img"));
		
				try
				{
				
					if(request.getParameter("SendOTP") != null)
					{
						
						int otp = (int)(Math.random() * ((999999 - 100000) + 1)) + 100000;
						String MailSubject = "Dormzz : Sign In Verification";
						String MailBody = "Your OTP to Login is :" + String.valueOf(otp) + "\nThank You.\nTeam Dormzz";
						
						
						if(HBSMailer.sendMail(email, MailSubject, MailBody))
							out.println("<script>showSwal('MailSent');</script>");
						else{
							out.println("<script>showSwal('MailNotSent')</script>");
							request.removeAttribute("SendOTP");
							request.removeAttribute("SignIn");
							session.setAttribute("OTP", null);
					        //out.println("<script>location.href='login.jsp'</script>");
						}
						
						session.setAttribute("OTP", otp);
						OTP = String.valueOf(otp);
					}
	
					if(request.getParameter("SignIn") != null)
					{
				       //out.println("<script>alert('form OTP : " + request.getParameter("OTP") + "<BR>Session OTP : " + session.getAttribute("OTP") + "')</script>");
				        String Fp = request.getParameter("OTP");
				        String Sp = session.getAttribute("OTP").toString();
				        
				        request.removeAttribute("SendOTP");
						request.removeAttribute("SignIn");
						request.removeAttribute("username");
						request.removeAttribute("password");
						
						if(request.getParameter("OTP").equals(session.getAttribute("OTP").toString())) {
							if(EnNo.length() == 15)
							{
								out.println("<script>showSwal('ULSuccess');</script>");
								out.println("<script>location.href='../dashboard/Student/nice-html/ltr/student_dash_index.jsp'</script>");
								//response.sendRedirect("../dashboard/Student/nice-html/ltr/student_dash_index.jsp");
							}
							else if(EnNo.length() == 7)
							{
								out.println("<script>showSwal('ALSuccess');</script>");
								out.println("<script>location.href='../dashboard/Admin/nice-html/ltr/student_dash_index.jsp'</script>");
								//response.sendRedirect("../dashboard/Admin/nice-html/ltr/student_dash_index.jsp");
							}
							else if(EnNo.length() == 10)
							{
								out.println("<script>showSwal('SLSuccess');</script>");
								out.println("<script>location.href='../dashboard/Staff/nice-html/ltr/student_dash_index.jsp'</script>");
								//response.sendRedirect("../dashboard/Staff/nice-html/ltr/student_dash_index.jsp");
							}
							
							session.setAttribute("submitted", "true");
						}
						else
						{
							out.println("<script>showSwal('VF');</script>");
							
							
						}
					}
			
				} catch (Exception e)
				{
					out.println("Message could not be sent. Mailer Error" + e.toString());
					
				} 
        	}
			else
			{
				out.println("<script>showSwal('IUP');</script>");
				request.removeAttribute("SendOTP");
				request.removeAttribute("SignIn");
				session.setAttribute("OTP", null);
		        //out.println("<script>location.href='login.jsp'</script>");
			}
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
              Dormzz - Login
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
                  <a href="register.jsp" class="btn btn-sm btn-round mb-0 me-1 bg-gradient-primary">Sign Up</a>
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
            <div class="col-xl-4 col-lg-5 col-md-6 d-flex flex-column mx-auto">
              <div class="card card-plain mt-8">
                <div class="card-header pb-0 text-left bg-transparent">
                  <h3 class="font-weight-bolder text-info text-gradient">Welcome back</h3>
                  <p class="mb-0">Enter your email and password to sign in</p>
                </div>
                <div class="card-body">
                  <form action="" method="post" role="form">
                    <label>Username</label>
                    <div class="mb-3">
                    	 <input type="text" name="username" class="form-control" placeholder="Username" value="<%= user %>" required>
                    </div>
                    <label>Password</label>
                    <div class="mb-3">
                    	 <input id="password-field" name="password" type="password" class="form-control" placeholder="Password" value="<%= pass %>" required>
	              	</div>
	              	<div class="w-50 text-md-right">
						<button type='button' class="text-info text-gradient font-weight-bold" style="border: none;" id='forgotPasswordBtn' onclick='forgotPassword()'>Forgot Password</button>
					</div>
                    <div class="mb-3">
						<button type="submit" id="SendOtp" name="SendOTP" class="btn bg-gradient-primary w-100 mt-4 mb-0">Send OTP</button>
					</div>
                    <% if(request.getParameter("SendOTP") != null){ %>
					
					<div class="mb-3">
		      			<input type="text" id="OTP" name="OTP" value="" maxlength="6" oninput="AllowOTP(event)"  class="form-control" placeholder="6 Digit OTP" required>
		      		</div>
		      		
		      		<div class="form-check form-switch">
                      <input class="form-check-input" type="checkbox" id="rememberMe" <%= checked_val %>>
                      <label class="form-check-label" for="remember">Remember me</label>
                    </div>
	
					<div class="text-center">
                      <button type="submit" id="SignIn" name="SignIn" class="btn bg-gradient-info w-100 mt-4 mb-0">Sign In</button>
                    </div>

					<% } %>
					
					<!--
                    <div class="text-center">
                      <button type="button" class="btn bg-gradient-info w-100 mt-4 mb-0">Send OTP</button>
                    </div> -->
                  </form>
                </div>
                <div class="card-footer text-center pt-0 px-lg-2 px-1">
                  <p class="mb-4 text-sm mx-auto">
                    Don't have an account?
                    <a href="register.jsp" class="text-info text-gradient font-weight-bold">Sign up</a>
                  </p>
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <div class="oblique position-absolute top-0 h-100 d-md-block d-none me-n8">
                <div class="oblique-image bg-cover position-absolute fixed-top ms-auto h-100 z-index-0 ms-n6" style="background-image: url('../images/banner/hero-area.JPG')/*url('assets/img/curved-images/curved6.jpg')*/"></div>
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

