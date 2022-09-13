<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Dormzz - Register</title>
    <link rel="stylesheet" href="css/register.css">
	<link rel="shortcut icon" type="image/x-icon" href="images/favicon.png" >
    <!---we had linked our css file----->
	
</head>
<body>
	<div class="full-page">
	<div class="form-box">
		<h2><strong>Dormzz</strong></h2>
		<h1>Register</h1>
		<br><br>
        <form id='register' class='input-group-register'>
			<input type='text' name='fname' id='fname' class='input-field'placeholder='First Name' required>
			<input type='text'name='lname' id='lname' class='input-field'placeholder='Last Name ' required>
			<input type='email'name='emailid' id='emailid' class='input-field'placeholder='Institute Email Id' required>
			<input type='password' name='password' id='password' class='input-field'placeholder='Enter Password' required>
			<input type='password' name='confirm_password' id='confirm_password' class='input-field'placeholder='Confirm Password'  oninput="check(this)" required>
			<script language='javascript' type='text/javascript'>
				function check(input) {
					if (input.value != document.getElementById('password').value) {
						input.setCustomValidity('Password Must be Matching.');
					} else {
						// input is valid -- reset the error message
						input.setCustomValidity('');
					}
				}
			</script>
			<input type='checkbox'class='check-box'><span>I agree to the terms and conditions</span>
            <button type='submit'class='submit-btn'>REGISTER</button><br>
			<a href="index.php" class='home-btn'><h4>Home</h4></a>
			
			<p><br><br><br>Already have account ?<br><a href='login.php'>Login</a></p>
		</form>
		
	</div>
	</div>
</body>
</html>