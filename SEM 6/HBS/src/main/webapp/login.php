<?php
$username = "parth020";
$password = "123";

session_start();

if(isset($_POST['username']) && isset($_POST['password'])){
	
	/*if(isset($_SESSION['username']))*/
	if($_POST['username'] == $username && $_POST['password'] == $password) 
	{
		$_SESSION['username'] = $username;
    	echo "<script>location.href='dashboard/Student/nice-html/ltr/student_dash_index.php'</script>";
		//header('location:dashboard/Student/nice-html/ltr/student_dash_index.php');
	}
	else
	{
        echo "<script>alert('Invalid Username and Password.')</script>";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dormzz - Login</title>
    <link rel="stylesheet" href="css/login.css">
	<link rel="shortcut icon" type="image/x-icon" href="images/favicon.png" />
    <!---we had linked our css file----->
</head>
<body>
	<div class="full-page">
	<div class="form-box">
		<h2><strong>Dormzz</strong></h2>
		<h1>Login</h1>
        <form id='login' class='input-group-login' method="POST">
            <input type='text' name='username' class='input-field'placeholder='Username' required />
			<input type='password'name='password' class='input-field'placeholder='Password' required />
			
			<br><br><br><h5><a href="forgot.php" target="_self">Forgot Password ?</a></h5><br><br>
			
			<button type='submit'name="login" class='submit-btn' value="login">LOGIN</button><br>
			<a href="index.php" class='home-btn'><h4>Home</h4></a>
			
			<p><br><br><br>Don't have Account ?<br>Create <a href='register.php'>Account</a></p>
		</form>
	</div>
	</div>
</body>
</html>