<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "com.HBS.*" %>

<%
/*int otp = (int)(Math.random() * ((999999 - 100000) + 1)) + 100000;
String email = "20bscit001@gmail.com";
String MailSubject = "Dormzz : Sign In Verification";
String MailBody = "Your OTP to Login is :" + otp + "<br><br>Thank You.<br>Team Dormzz";
String result="";
out.println(email);
out.println(MailSubject);
out.println(MailBody);
try{
	
result="Success, Mail Sent";
} catch (Exception e){
	result="Error, Mail Not Sent";
}*/
%>

<html>
<head>
   	<title>Send Email using JSP</title>
   	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.min.css" rel="stylesheet">
   	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js" rel="stylesheet">
   	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   	<script>
	   	function showSwal(message){
	   		
	   		var title, data, icon, confirmButtonText, redirectURL;
	   		
	   		if(message == 'Success'){
	   			title = 'Success';
	   			data = 'Your Account has been Created.<br>Thank you for joining us. ❤️';
	   			icon = 'success';
	   			confirmButtonText = 'Login';
	   			redirectURL = './form/login.jsp';
	   		} else if(message == 'Error' ) {
	   			title = 'Error';
	   			data = 'Please fill all fields Properly !!';
	   			icon = 'error';
	   			confirmButtonText = 'Try Again.';
	   			redirectURL = './form/register.jsp';
	   		}
	   		
	   		
	   		return Swal.fire({
			   		  	title: title,
			   		 	html: data,
			   		  	confirmButtonText: confirmButtonText,
			   		 	cancelButtonText: 'Ok',
			   		 	icon: icon,
			   		 	showCancelButton: true
			   		}).then((result) => {
			   		  if (result.isConfirmed)
			   		  {
			   		    location.href = redirectURL;
			   		  } else if (result.isDismissed) {
			   			location.href = "index.jsp";
			   		  }
			   		});
	   	}
	   	$(document).ready(function() {
	   	  
	   	  const changeText = function (el, text, color) {
	   	    el.text(text).css('color', color);
	   	  };
	   	  
	   		const passwordInput = document.getElementById("password");
		   	const usernameInput = document.getElementById("username");
		   	const passwordStrengthBar = document.getElementById("progress-bar_text");


	   	  $('#password').keyup(function(){
	   	    let len = this.value.length;
	   	  	let strength = 0;
	   	    
	   	  	const pbText = $('.form-3 .progress-bar_text');
	   	  	const password = passwordInput.value;
	   	  	const username = usernameInput.value;
	   	    
	   	 	if (len >= 8) {
		   		strength+=2;
		   	}
	
		   	  // Check if password contains a digit
		    if (/\d/.test(password)) {
		   	    strength++;
		    }
	
	   	  	// Check if password contains an uppercase letter
	   	  	if (/[A-Z]/.test(password)) {
	   	   		strength++;
	   	  	}

	   	  	// Check if password contains a lowercase letter
	   	  	if (/[a-z]/.test(password)) {
	   	    	strength++;
	   	  	}
	   	  	
	   		if (/[@#$%^&+!]/.test(password)) {
	   	    	strength++;
	   	  	}

	   	  	
		   	  
	   	  	if (strength === 0) {
	   	      $(this).css('border-bottom-color', '#2F96EF');
	   	      changeText(pbText, 'Password is blank', '#aaa');
	   	    } else if (strength > 0 && strength < 4) {
	   	      $(this).css('border-bottom-color', '#FF4B47');
	   	      changeText(pbText, 'Too weak', '#FF4B47');
	   	    } else if (strength >= 4 && strength < 6) {
	   	      $(this).css('border-bottom-color', '#F9AE35');
	   	      changeText(pbText, 'Could be stronger', '#aaa');
	   	    } else {
	   	      $(this).css('border-bottom-color', '#2DAF7D');
	   	      changeText(pbText, 'Strong password');
	   	    } 
	   	  	alert(strength+this.value);
	   	  });
	   	  
	   	});
   	
	   	function forgotPassword() {
			  return Swal.fire({
			    title: 'Forgot Password',
			    //html: '<input id="username" placeholder="Enter your username" class="swal2-input">',
			    input: 'text',
			    inputAttributes: {
			    	id:"username",
			      	autocapitalize: 'off',
			      	placeholder:"Enter your username",
			    },
			    showCancelButton: true,
			    confirmButtonText: 'Verify',
			    showLoaderOnConfirm: true,
			    focusConfirm: false,
			    preConfirm: function() {
			      return $('#username').val();
			    }
			  }).then(function(result) {
				  var username = result.value;
				  alert(result.value);
			    if (username == ""){
			    	Swal.fire({
			    	      icon: 'error',
			    	      title: 'Error',
			    	      text: 'Please enter your username'
			    	    });
			    }
			    else {
			    	
			    	 $.ajax({
			                type: 'post',
			                url: 'verify-username.jsp',
			                data: { username: username },
			                success: function(response) 
			                {
			                	alert(response);
			                  if (response === 'success') 
			                  {
			                    // Show a message indicating that the OTP was validated
			                    Swal.fire({
			                      icon: 'success',
			                      title: 'Verification Successful',
			                      text: 'A verification code has been sent to your email. Please enter the code below to reset your password.'
			                    });
			                  }
			                }
			    	 });
			    	
			    	
			    	
			    	
			    }
			  });
			}
	   	
	</script>
	
	<style>
		body {
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  text-align: center;
}

.form-container {
  display: block;
  width: 500px;
  margin: 60px auto;
  text-align: left;
}

lable {
  display: block;
  position: relative;
  text-transform: uppercase;
  color: #aaa;
}

input[type='password'] {
  width: 100%;
  box-sizing: border-box;
  height: 55px;
  display: inline-block;
  border: 3px solid #2F96EF;
  border-radius: 5px;
  padding: 0 15px;
  margin: 10px 0;
  transition: .2s;
}

input[type='password']:focus {
  outline: none;
   -moz-outline: none;
   -webkit-outline: none;
}

lable:before {
  content: "\f070";
  color: #aaa;
  font-size: 22px;
  font-family: FontAwesome;
  position: absolute;
  right: 25px;
  top: 44px;
}

.progress-bar_wrap {
  width: 300px;
  height: 5px;
  background: #F6F6FA;
  display: inline-block;
  vertical-align: middle;
  overflow: hidden;
  border-radius: 5px;
}



.form-1 .progress-bar_item {
  display: inline-block;
  height: 100%;
  width: 33.33%;
  float: left;
  visibility: hidden;
  transition: background-color .2s, visisility .1s;
}

.form-1 .active {
  visibility: visible;
}

.progress-bar_item-1 {
  
}

.progress-bar_item-2 {

}

.progress-bar_item-3 {

}

.progress-bar_text {
  display: inline-block;
  color: #aaa;
  margin-left: 5px;
  transition: .2s;
}



.form-2 .progress-bar_item {
  display: inline-block;
  height: 100%;
  width: 32.5%;
  margin-right: .8%;
  border-radius: 5px;
  float: left;
  
  transition: background-color .2s, visisility .1s;
}

.form-2 .progress-bar_item-1.active {
  background-color: #FF4B47;
}

.form-2 .progress-bar_item-2.active {
  background-color: #F9AE35;
}

.form-2 .progress-bar_item-3.active {
  background-color: #2DAF7D;
}
	</style>

</head>
   
   <body>
      <div class="card-body">
   	  		<div class="wrapper text-center">
       			<h4 class="card-title">Alerts Popups</h4>
       			<p class="card-description">A success message!</p>
       			<button class="btn btn-outline-success" onclick="showSwal('Error');">Click here!</button>
        	</div>
        	
        	<button type='button' class="btn btn-outline-success" onclick="forgotPassword();">Test Password</button>
      </div>
      
      <div class="form-container">
  		<form class="form-3" action="">
    		<lable>Enter Username
      		<input class="input-3" type="text" id ="username" placeholder="username">
      		</lable>
      
      		<lable>Enter password
      		<input class="input-3" type="password" id ="password" placeholder="&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;">
      		</lable>
    		<span class="progress-bar_text" id="progress-bar_text">Password is blank</span>
  		</form>
	</div>
      
   </body>
</html>