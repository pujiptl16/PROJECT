<?php

if (isset($_POST['signup'])) {

	$EnNo = $_POST['EnNo'];
	$db = mysqli_connect('localhost', 'root', '', 'dormz');
	$record = mysqli_query($db, "SELECT * FROM tblregister WHERE EnrollmentNo='$EnNo';");

	if ($record->num_rows != 0 ) {
		echo"<script>alert('User Already Exists. Kindly Login.')</script>";
	}
	else{
		
		$Username = $_POST['username'];
		$Email = $_POST['Email'];
		
		$record = mysqli_query($db, "SELECT * FROM tblregister WHERE Username='$Username';");

		if($record->num_rows == 0 )
		{
			$Email = filter_var($Email, FILTER_SANITIZE_EMAIL);
			
			if (filter_var($Email, FILTER_VALIDATE_EMAIL)) {
				
				if(isset($_POST['gender']))
				{
					$PhonoNo = $_POST['PhonoNo'];

					if (preg_match ("/^[0-9]*$/", $PhonoNo) )
					{  
						if(strlen($PhonoNo)==10)  {
							$password = $_POST['password'];
							$cpassword = $_POST['cpassword'];
							
							if($password==$cpassword){
								$CourseName = $_POST['CourseName'];
								$DepartmentName = $_POST['DepartmentName'];
								$Fname = $_POST['Fname'];
								$Lname = $_POST['Lname'];
								$gender = $_POST['gender'];

								$hash_pass = password_hash($password, PASSWORD_DEFAULT);

								if(mysqli_query($db, "INSERT INTO `tblregister`(`EnrollmentNo`, `CourseName`, `DepartmentName`, `Username`, `Password`, `FirstName`, `LastName`, `Gender`, `Email`, `PhoneNo`) VALUES ('$EnNo','$CourseName','$DepartmentName','$Username','$hash_pass','$Fname','$Lname', '$gender', '$Email','$PhonoNo')"))
								{
									echo "<script>location.href='login.php'</script>";
								}
								else{
									echo "<script>alert('Unknown Error Occured.')</script>";
								}
							}
							else{
								echo "<script>alert('Password Doesn't Matched. Please Enter Again.')</script>"; 
							}
						}
						else{
							echo "<script>alert('Contact Number must be of 10 Digits only.')</script>"; 
						} 
					} else {
						echo "<script>alert('Invalid Contact Number.')</script>";
					}
				}else
				{
					echo "<script>alert('Gender not selected.')</script>";
				}

			}
			else{
				echo"<script>alert('Invalid Email Address.')</script>";
			}
		}else
		{
			echo"<script>alert('Username is not Available.')</script>";
		}
	}

}

session_start();

?>
<!doctype html>
<html lang="en">
  <head>
  	<title>Dormzz - Register</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="shortcut icon" type="image/x-icon" href="../images/favicon.png" />
	<link rel="stylesheet" href="css/style.css">

	</head>
	<body class="img js-fullheight" style="background-image: url(images/bg.jpg); background-size: cover; background-repeat: no-repeat; background-attachment: fixed; background-position: center center; ">
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-3">
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
									<input type="text" name="EnNo" class="form-control" placeholder="Enrollment Number" required>
								</div>
								<div class="form-group" style="margin-left:2%">
									<input type="text" name="CourseName" class="form-control" placeholder="Course Name" required>
								</div>
							</div>
							<div class="list-group list-group-horizontal" style="justify-content:space-between;">
								<div class="form-group">
									<input type="text" name="Fname" class="form-control" placeholder="First Name" required>
								</div>
								<div class="form-group" style="margin-left:2%">
									<input type="text" name="Lname" class="form-control" placeholder="Last Name" required>
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
									<input type="email" name="Email" class="form-control" placeholder="Email ID" required>
								</div>
								<div class="form-group" style="margin-left:2%">
									<input type="text" name="PhonoNo" class="form-control" placeholder="Phono No." required>
								</div>
							</div>
							<div class="form-group">
								<input type="text" name="username" class="form-control" placeholder="Username" required>
							</div>
							<div class="form-group">
								<input id="password-field" name="password" type="password" class="form-control" placeholder="Password" required>
							<span toggle="#password-field" class="fa fa-fw fa-eye field-icon toggle-password"></span>
							</div>
							<div class="form-group">
								<input id="cpassword-field" name="cpassword" type="password" class="form-control" placeholder="Confirm Password" required>
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
								<a href="login.php" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-2"></span>Sign In</a>
								<a href="../index.php" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-2"></span>Home</a>
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

