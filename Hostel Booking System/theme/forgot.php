<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="author" content="Yinka Enoch Adedokun">
	<meta name="description" content="Simple Forgot Password Page Using HTML and CSS">
	<meta name="keywords" content="forgot password page, basic html and css">
	<title>Dormzz - Forgot Password</title>
    <link rel="shortcut icon" type="image/x-icon" href="images/favicon.png" />
    <link rel="stylesheet" href="css/forgot.css">
</head>
<body>
	<div class="row">
		<h1>Forgot Password</h1><br>
		<h6 class="information-text">Enter your registered email to reset your password.</h6>
		<div class="form-group">
            <br>
			<label for="username">Email</label>
            <input type="email" name="user_email" id="user_email">
			
			<button type="submit" onclick="showSpinner()">Reset Password</button>
		</div>
		<div class="footer">
			<h6>Already have an account? <a href="login.php">LOGIN.</a></h6>
			<h5 class="information-text"></span><a href="index.php" target="_blank">DORMZZ</a></h5>
		</div>
	</div>
</body>
</html>
