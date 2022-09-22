<?php

session_start();


if(isset($_POST['username']) && isset($_POST['password'])){
	
	$username = $_POST['username'];
	$db = mysqli_connect('localhost', 'root', '', 'dormz');
	$record = mysqli_query($db, "SELECT * FROM tblregister WHERE Username='$username';");

	if ($record->num_rows == 0 ){
		echo"<script>alert('User Does not Exists. Kingly Register.')</script>";
	}
	else{
		while($row = mysqli_fetch_array($record)) {
			$user = $_POST['username'];
			$pass = $_POST['password'];
			$username = $row['Username'];
			$password = $row['Password'];
			$hash_pass = password_hash($pass, PASSWORD_DEFAULT);
			
		if(password_verify($pass, $password)) 
		{
			$_SESSION['username'] = $username;
			echo "<script>location.href='../dashboard/Student/nice-html/ltr/student_dash_index.php';</script>";
		}
		else
		{
			//echo "<script>alert('Invalid Username and Password"."<br>Database : ".$password."<br>Form : ".$hash_pass."')</script>";
			echo "<script>alert('Invalid Username and Password')</script>";
			
		}
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
	
	<link rel="stylesheet" href="css/style.css">

	</head>
	<body class="img js-fullheight" style="background-image: url(images/bg.jpg);">
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h1 class="heading-section">Login</h1>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4">
					<div class="login-wrap p-0">
		      	<!-- <h3 class="mb-4 text-center">Have an account?</h3> -->
		      	<form action="" method="post" class="signin-form">
		      		<div class="form-group">
		      			<input type="text" name="username" class="form-control" placeholder="Username" required>
		      		</div>
	            	<div class="form-group">
	              		<input id="password-field" name="password" type="password" class="form-control" placeholder="Password" required>
	              		<span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
	            	</div>
					<div class="form-group">
						<button type="submit" name="SignIn" class="form-control btn btn-primary submit px-3">Sign In</button>
					</div>
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

	</body>
</html>

