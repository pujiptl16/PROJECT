<?php

session_start();
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

require('PHPMailer.php');
require('Exception.php');
require('SMTP.php');

$user="";
$pass="";

if(isset($_POST['username']) && isset($_POST['password'])){
	
	$user = $_POST['username'];
	$pass = $_POST['password'];
	$db = mysqli_connect('localhost', 'root', '', 'dormz');
	$record = mysqli_query($db, "SELECT * FROM tblregister WHERE Username='$user';");

	if ($record->num_rows == 0 ){
		echo"<script>alert('User Does not Exists. Kingly Register.')</script>";
	}
	else{
		
		
			$row = mysqli_fetch_array($record);

			$EnNo = $row['EnrollmentNo'];
			$username = $row['Username'];
			$password = $row['Password'];
			$email = $row['Email'];
			$hash_pass = password_hash($pass, PASSWORD_DEFAULT);
			
			if(password_verify($pass, $password)) 
			{
				$_SESSION['username'] = $username;
				$_SESSION['EnNo'] = $row['EnrollmentNo'];
				$_SESSION['FirstName'] = $row['FirstName'];
				$_SESSION['LastName'] = $row['LastName'];
				$_SESSION['Email'] = $email;
				$_SESSION['Phone'] = $row['PhoneNo'];
				$_SESSION['userid'] = $row['user_id'];
				$_SESSION['gender'] = $row['Gender'];

				$record2 = mysqli_query($db, "SELECT * FROM `tblstudent` WHERE user_id=".$_SESSION['userid'].";");
				$row2 = mysqli_fetch_array($record2);

				$_SESSION['ProfilePic'] = $row2['Profile_img'];

				try {

					if(isset($_POST['SendOTP'])){

						$otp = rand(100000, 999999);

						$mail = new PHPMailer(true);

						$mail->isSMTP();
						$mail->Host       = 'smtp.gmail.com';
						$mail->SMTPAuth   = true;
						$mail->Username   = 'dormzz16@gmail.com';
						$mail->Password   = 'xbnqfoqjarjqwgud';
						$mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
						$mail->Port       = 465;

						//Recipients
						$mail->setFrom('dormzz16@gmail.com', 'Dormzz Login');
						$mail->addAddress($email);     //Add a recipient
						
						$mail->isHTML(true);
						//$msg=file_get_contents("beefree-wbrjvkqo22s.php");

						$mail->Subject = 'Dormzz : Sign In Verification';

						$mail->Body    = "Your OTP to Login is :".$otp."<br><br>Thank You.<br>Team Dormzz";

						$mail->MsgHTML = ('h');



						$mail->send();

						$_SESSION['OTP']=$otp;
					}

					if(isset($_POST['SignIn'])){
						if($_POST['OTP'] == $_SESSION['OTP']){
							if(strlen($EnNo)==15)
								echo "<script>location.href='../dashboard/Student/nice-html/ltr/student_dash_index.php';</script>";
							elseif(strlen($EnNo)==10)
								echo "<script>location.href='../dashboard/Admin/nice-html/ltr/student_dash_index.php';</script>";
							elseif(strlen($EnNo)==7)
								echo "<script>location.href='../dashboard/Staff/nice-html/ltr/student_dash_index.php';</script>";
						}
						else{
							echo "<script>alert('Verification Failed.')</script>";
							
						}
					}
				} catch (Exception $e) {
					echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
				}
		}
		else
		{
			//echo "<script>alert('Invalid Username and Password"."<br>Database : ".$password."<br>Form : ".$hash_pass."')</script>";
			echo "<script>alert('Invalid Username and Password')</script>";
			unset($_POST['SendOTP']);
			unset($_POST['SignIn']);
			
		}
	}
}

?>
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
		      			<input type="text" name="username" class="form-control" placeholder="Username" value="<?php echo $user ?>" required>
		      		</div>
	            	<div class="form-group">
	              		<input id="password-field" name="password" type="password" class="form-control" placeholder="Password" value="<?php echo $pass ?>" required>
	              		<span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
	            	</div>
					<div class="form-group">
						<button type="submit" id="SendOtp" name="SendOTP" class="form-control btn btn-primary submit px-3">Send OTP</button>
					</div>

					<?php
						if(isset($_POST['SendOTP'])){
					?>
					<div class="form-group">
		      			<input type="text" name="OTP" class="form-control" placeholder="6 Digit OTP" required>
		      		</div>

					<div class="form-group">
						<button type="submit" id="SignIn" name="SignIn" class="form-control btn btn-primary submit px-3">Sign In</button>
					</div>

					<?php
						}
					?>
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

