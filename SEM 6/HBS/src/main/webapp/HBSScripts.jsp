<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- <body>
<head> -->
   	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<!--  <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.min.css" rel="stylesheet">
   	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js" rel="stylesheet">
   	<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
   	 -->
   	<script>
   	function showSwal(message){
   		
   		var title, data, icon, confirmButtonText, redirectURL;
   		
   		title = 'Error';
   		icon = 'error';
		confirmButtonText = 'Try Again.';
		redirectURL = 'register.jsp';
		callBackURL = '../index.jsp';
			
   		if(message == 'RSuccess'){
   			title = 'Success';
   			data = 'Your Account has been Created.<br>Thank you for joining us. ❤️';
   			icon = 'success';
   			confirmButtonText = 'Login';
   			redirectURL = 'login.jsp';
   		} else if(message == 'ULSuccess'){
   			title = 'Success';
   			data = 'Verification Successfull.<br>Welcome to Dormzz ❤️';
   			icon = 'success';
   			redirectURL = '../dashboard/Student/nice-html/ltr/student_dash_index.jsp';
   			
   			return Swal.fire({
   	   		  	title: title,
   	   		 	html: data,
   	   		  	icon: icon,
   	   		  	timerProgressBar: true,
   	   			showConfirmButton: false,
   		  		timer: 2500
   	   		}).then((result) => {
     	   		  if (result.isDismissed)
       	   		  {
         	   		    location.href = redirectURL;
         	   	  }
       	   		});
   			
   		} else if(message == 'SLSuccess'){
   			title = 'Success';
   			data = 'Verification Successfull.<br>Welcome to Dormzz ❤️';
   			icon = 'success';
   			redirectURL = '../dashboard/Staff/nice-html/ltr/student_dash_index.jsp';
   			
   			return Swal.fire({
   	   		  	title: title,
   	   		 	html: data,
   	   		  	icon: icon,
   	   		  	timerProgressBar: true,
   	   			showConfirmButton: false,
   		  		timer: 2500
   	   		});
   			
   		} else if(message == 'ALSuccess'){
   			title = 'Success';
   			data = 'Verification Successfull.<br>Welcome to Dormzz ❤️';
   			icon = 'success';
   			redirectURL = '../dashboard/Admin/nice-html/ltr/student_dash_index.jsp';
   			
   			return Swal.fire({
   	   		  	title: title,
   	   		 	html: data,
   	   		  	icon: icon,
   	   		  	timerProgressBar: true,
   	   			showConfirmButton: false,
   		  		timer: 2500
   	   		}).then((result) => {
     	   		  if (result.isDismissed)
       	   		  {
         	   		    location.href = redirectURL;
         	   	  }
       	   		});
   			
   		} else if(message == 'Error' ) {
   			redirectURL = '../index.jsp';
   			confirmButtonText = 'Home';
   			callBackURL = '';
   			data = 'Please fill all fields Properly !! 😒🥲';
   			
   		} else if(message == 'AlreadyExists'){
   			redirectURL = 'login.jsp';
   			confirmButtonText = 'Login';
   			callBackURL = '';
   			data = 'Can not create Account.<br>User Already Exists with given Enrollment Number.<br>Kindly Login !! 😕🤦‍♂️';
   			
   		} else if(message == 'UE'){
   			redirectURL = 'register.jsp';
   			confirmButtonText = 'Try Again.';
   			callBackURL = '../index.jsp';
   			data = 'Can not create Account.<br>Unknown Error Occured !! 😵‍💫🥺';
   		} else if(message == 'UsernameTaken'){
   			redirectURL = 'login.jsp';
   			confirmButtonText = 'Login';
   			callBackURL = '';
   			data = 'Can not create Account.<br>Username is taken.<br>Kindly choose a unique username or Login !! 😶‍🌫️🫣';
   		} else if(message == 'NotExists'){
   			redirectURL = 'register.jsp';
   			confirmButtonText = 'Register';
   			callBackURL = 'login.jsp';
   			data = 'User does not Exists.<br>Kindly Register !! 😭🤕';
   			
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
   	   		  } else if (result.isDismissed)
   	   		  {
     	   		    location.href = callBackURL;
     	   	  }
   	   		});
   			
   		} else if(message == 'IUP'){
   			redirectURL = 'login.jsp';
   			confirmButtonText = 'Try Again';
   			callBackURL = '';
   			data = 'Invalid Username and Password.<br>Kindly Enter valid details !! 😭🤕';
   			
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
   	   		  } else if (result.isDismissed)
   	   		  {
     	   		    location.href = callBackURL;
     	   	  }
   	   		});
   		} else if(message == 'MailSent'){
   			title = 'Authentication';
   			data = 'OTP sent Successfully. 😊💕<BR>Kindly check your mail';
   			icon = 'success';
   			
   			return Swal.fire({
   	   		  	title: title,
   	   		 	html: data,
   	   		  	icon: icon,
   	   		  	timerProgressBar: true,
   	   			showConfirmButton: false,
   		  		timer: 5000
   	   		});
   		} else if(message == 'PaymentSuccess'){
   			title = 'Success';
   			data = 'Payment Successful.<BR>Thank You for choosing Dormzz.😊💕';
   			icon = 'success';
   			
   			return Swal.fire({
   	   		  	title: title,
   	   		 	html: data,
   	   		  	icon: icon,
   	   		  	timerProgressBar: true,
   		  		timer: 5000
   	   		}).then((result) => {
		 		  if (result.isConfirmed)
		 		  {
		 		    location.href = "payout.jsp";
		 		  } else if(result.isDismissed){
		 			 location.href = "payout.jsp";
		 		  } else {
		 			 location.href = "payout.jsp";
		 		  }
		 		});
   		} 
   		else if(message == 'MailNotSent'){
   			title = 'Authentication Error';
   			data = 'OTP could not be sent.<BR>Kindly Try again.😭🥺';
   			icon = 'warning';
   			redirectURL = 'login.jsp';
   			
   			return Swal.fire({
   	   		  	title: title,
   	   		 	html: data,
   	   		  	icon: icon,
   	   		  	timerProgressBar: true,
   	   			showConfirmButton: false,
   		  		timer: 7500
   	   		}).then((result) => {
   	   		  if (result.isDismissed)
   	   		  {
     	   		    location.href = redirectURL;
     	   	  }
   	   		});
   			
   		} else if(message == 'VF'){
   			title = 'Authentication Failed';
   			data = 'Wrong OTP<BR>Kindly Try again.😭🥺';
   			icon = 'warning';
   			
   			return Swal.fire({
   	   		  	title: title,
   	   		 	html: data,
   	   		  	icon: icon,
   	   		  	timerProgressBar: true,
   	   			showConfirmButton: false,
   		  		timer: 3500
   	   		});
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
		 		  }
		 		});
   	}
/*
	const EnNo = document.getElementById("EnNo");
    const CourseName = document.getElementById("CourseName");
    const Fname = document.getElementById("Fname");
    const Lname = document.getElementById("Lname");
    const DepartmentName = document.getElementById("DepartmentName");
    const Email = document.getElementById("Email");
    const PhonoNo = document.getElementById("PhonoNo");
    const username = document.getElementById("username");
    const password = document.getElementById("password");
    const cpassword = document.getElementById("cpassword");
    const signup = document.getElementById("signup");
 
    // Add event listeners to form fields
    EnNo.addEventListener("input", checkFields);
    CourseName.addEventListener("input", checkFields);
    Fname.addEventListener("input", checkFields);
    Lname.addEventListener("input", checkFields);
    DepartmentName.addEventListener("input", checkFields);
    Email.addEventListener("input", checkFields);
    PhonoNo.addEventListener("input", checkFields);
    username.addEventListener("input", checkFields);
    password.addEventListener("input", checkFields);
    cpassword.addEventListener("input", checkFields);

    // Function to check if all required fields are filled in
    function checkFields() {
      if (EnNo.value.trim() !== "" && CourseName.value.trim() !== "" && Fname.value.trim() !== "" && Lname.value.trim() !== "" && DepartmentName.value.trim() !== "" && Email.value.trim() !== "" && PhonoNo.value.trim() !== "" && username.value.trim() !== "" && password.value.trim() !== "" && cpassword.value.trim() !== "") {
    	  signup.disabled = false;
      } else {
    	  signup.disabled = true;
      }
    }
    */
   	$(document).ready(function() { 	  
	   	  const changeText = function (el, text, color) {
	   	    el.text(text).css('color', color);
	   	  };
	   	  
	   		const cpasswordInput = document.getElementById("cpassword-field");
	   		const passwordInput = document.getElementById("password-field");
		   	const usernameInput = document.getElementById("username-field");
		   	const passwordStrengthBar = document.getElementById("progress-bar_text");
		   	const cpasswordStrengthBar = document.getElementById("cprogress-bar_text");
		    
		   	const EnNo = document.getElementById("EnNo");
		    const CourseName = document.getElementById("CourseName");
		    const Fname = document.getElementById("Fname");
		    const Lname = document.getElementById("Lname");
		    const DepartmentName = document.getElementById("DepartmentName");
		    const Email = document.getElementById("Email");
		    const PhonoNo = document.getElementById("PhonoNo");
		    const OTP = document.getElementById("OTP");
		    const signup = document.getElementById("signup");
		    const genderInputs = document.getElementsByName("gender");
		    let genderSelected = false;
	    	
		    
		 	// Function to check if all required fields are filled in
		    function checkFields() {
				/*		    	
			    for (let i = 0; i < genderInputs.length; i++) {
			      if (genderInputs[i].checked) {
			        genderSelected = true;
			        break;
			      }
			    }*/
				    
			      if (genderSelected == true && EnNo.value.trim() !== "" && CourseName.value.trim() !== "" && Fname.value.trim() !== "" && Lname.value.trim() !== "" && DepartmentName.value.trim() !== "" && Email.value.trim() !== "" && PhonoNo.value.trim() !== "" && username.value.trim() !== "" && password.value.trim() !== "" && cpassword.value.trim() !== "") {
			    	  signup.disabled = false;
			      } else {
			    	  signup.disabled = true;
			      }
		    }
		 
		 	// Add event listeners to form fields
			EnNo.addEventListener("keyup", checkFields);
			CourseName.addEventListener("keyup", checkFields);
			Fname.addEventListener("keyup", checkFields);
			Lname.addEventListener("keyup", checkFields);
			DepartmentName.addEventListener("keyup", checkFields);
			Email.addEventListener("keyup", checkFields);
			PhonoNo.addEventListener("keyup", checkFields);
			usernameInput.addEventListener("keyup", checkFields);
			passwordInput.addEventListener("keyup", checkFields);
			cpasswordInput.addEventListener("keyup", checkFields);
		    
			
		    $('#cpassword-field').keyup(function(){
		    	const pbText2 = $('.signin-form #cprogress-bar_text');
		   	  	const password = passwordInput.value;
		   	  	const cpassword = cpasswordInput.value;
		   	  	
			   	 pbText2.show();
		   	    if((password !== "" && cpassword !== "") && (password === cpassword)){
		   	    	signup.disabled = false;
		   	    	$(cpasswordInput).css('border-bottom-color', '#2DAF7D');
		   	    	pbText2.hide();
		        } else {
		      	  	signup.disabled = true;
		      		$(cpasswordInput).css('border-bottom-color', '#FF4B47');
		   	      	changeText(pbText2, 'Password doesn\'t match', '#FF4B47');		
		        }
		   	 	checkFields();
		    });
		    
	   	  $('#password-field').keyup(function(){
	   	    let len = this.value.length;
	   	  	let strength = 0;
	   	    
	   	  	const pbText = $('.signin-form #progress-bar_text');
	   	 	const pbText2 = $('.signin-form #cprogress-bar_text');
	   	  	const password = passwordInput.value;
	   	  	const username = usernameInput.value;
	   	  	const cpassword = cpasswordInput.value;
	   	  	
	   	 	pbText2.show();
	   	    if((password !== "" && cpassword !== "") && (password === cpassword)){
	   	    	signup.disabled = false;
	   	    	$(cpasswordInput).css('border-bottom-color', '#2DAF7D');
	   	    	pbText2.hide();
	        } else {
	      	  	signup.disabled = true;
	      		$(cpasswordInput).css('border-bottom-color', '#FF4B47');
	   	      	changeText(pbText2, 'Password doesn\'t match', '#FF4B47');
	   	   		
	        }
	   	 	checkFields();
	   	  	// Check if password does not contain the username
	   	  	//if (password.includes(username)) {
	   	    	//strength=1;
	   	  	//}
		   	  
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
	   		
	   		pbText.show();
	   		
	   		
	   	  	if (strength === 0) {
	   	      $(this).css('border-bottom-color', '#2F96EF');
	   	      changeText(pbText, 'Enter the Password', '#aaa');
	   	   		pbText.hide();
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
	   	 
	   	 	//alert(password+'\n'+strength+this.value);
	   	  });
	   	  
	   	const PhoneText = $('.signin-form #Phone-bar_text'); 
   	 	
		PhonoNo.addEventListener("keypress", function(evt) {
			const charCode = (evt.which) ? evt.which : evt.keyCode;
		   	  if (charCode > 31 && (charCode < 48 || charCode > 57)) {
		   	    // key is not a digit, prevent input
		   	    evt.preventDefault();
		   	  } else {
		   	  
		   		if (this.value.length === 10) {
		   			e.preventDefault();
		   		}
		   	  //alert(this.value);
			   	PhoneText.show();
			   	  if (this.value.length === 10-1) {
			   	    // input is valid, do nothing
			   		$(this).css('border-bottom-color', '#2DAF7D');
			   	    changeText(PhoneText, 'Enter the Phone No.', '#aaa');
			   	 PhoneText.hide();
			   	  } else {
			   		$(this).css('border-bottom-color', '#FF4B47');
			   	    changeText(PhoneText, 'Invalid Phone No.', '#FF4B47');
			   	  }
		   	  }
		   	checkFields();
		});
		
		function validatePhoneNo() {
		   	  if (PhonoNo.value.length === 10) {
		   	    // input is valid, do nothing
		   		$(PhonoNo).css('border-bottom-color', '#2DAF7D');
		   	    changeText(PhoneText, 'Enter the Phone No.', '#aaa');
		   	 	PhoneText.hide();
		   	  } else {
		   		PhoneText.show();
		   		$(PhonoNo).css('border-bottom-color', '#FF4B47');
		   	    changeText(PhoneText, 'Invalid Phone No.', '#FF4B47');
		   	  }
	   		checkFields();
	   	}

		PhonoNo.addEventListener("blur", function(evt) {
			  validatePhoneNo();
	   	});

	   	  
		   	
		   	const EnField = document.getElementById("EnNo");
			const EnText = $('.signin-form #Enrollment-bar_text');
	   	 	
		   	EnField.addEventListener("keypress", function(evt) {
		   	  const charCode = (evt.which) ? evt.which : evt.keyCode;
		   	  if (charCode > 31 && (charCode < 48 || charCode > 57)) {
		   	    // key is not a digit, prevent input
		   	    evt.preventDefault();
		   	  } else {
		   		if (this.value.length === 15) {
		   			e.preventDefault();
		   		}
		   	  //alert(this.value);
			   	EnText.show();
			   	  if (this.value.length === 15-1) {
			   	    // input is valid, do nothing
			   		$(this).css('border-bottom-color', '#2DAF7D');
			   	    changeText(EnText, 'Enter the Password', '#aaa');
			   	   	EnText.hide();
			   	  } else {
			   		$(this).css('border-bottom-color', '#FF4B47');
			   	    changeText(EnText, 'Invalid En. No.', '#FF4B47');
			   	  }
		   	  }
		   	checkFields();
		   	});
		   	
		   	function validateEnrollmentNo() {
		   		EnText.show();
		   	  if (EnField.value.length === 15) {
		   	    EnText.show();
		   	    $(EnField).css('border-bottom-color', '#2DAF7D');
		   	    changeText(EnText, 'Enter the Password', '#aaa');
		   	    EnText.hide();
		   	  } else {
		   	    EnText.show();
		   	    $(EnField).css('border-bottom-color', '#FF4B47');
		   	    changeText(EnText, 'Invalid En. No.', '#FF4B47');
		   	  }
		   	  checkFields();
		   	}

			  EnField.addEventListener("blur", function(evt) {
				  validateEnrollmentNo();
		   	});
		   	
			const CourseText = $('.signin-form #Course-bar_text');
	   	 	
			   	CourseName.addEventListener("keypress", function(evt) {
			   	  const charCode = (evt.which) ? evt.which : evt.keyCode;
			   	
			   	CourseText.show();
			   	
			   	if (charCode > 31 && (charCode < 65 || charCode > 90) && (charCode < 97 || charCode > 122) && charCode !== 32 && charCode !== 46 && charCode !== 40 && charCode !== 41) {
			   		$(this).css('border-bottom-color', '#FF4B47');
			   	    changeText(CourseText, 'Invalid Course', '#FF4B47');
				   	evt.preventDefault();
			   	    
			   	} else {
			   	  //alert(this.value);
				   	$(this).css('border-bottom-color', '#2DAF7D');
					changeText(CourseText, 'Enter the Course', '#aaa');
					CourseText.hide();
				   	
			    }
			   	checkFields();
		   	});
		   	
			   	
			const FnameText = $('.signin-form #Fname-bar_text');
		   	 	
			Fname.addEventListener("keypress", function(evt) {
			   	const charCode = (evt.which) ? evt.which : evt.keyCode;
			   	
			   	FnameText.show();
			   	
			   	if (charCode > 31 && (charCode < 65 || charCode > 90) && (charCode < 97 || charCode > 122) && charCode !== 32 && charCode !== 46 && charCode !== 40 && charCode !== 41) {
			   		$(this).css('border-bottom-color', '#FF4B47');
			   	    changeText(FnameText, 'Invalid First Name', '#FF4B47');
				   	evt.preventDefault();
			   	    
			   	} else {
			   	  //alert(this.value);
				   	$(this).css('border-bottom-color', '#2DAF7D');
					changeText(FnameText, 'Enter the FIrst Name', '#aaa');
					FnameText.hide();
				   	
			    }
			   	checkFields();
		   	});
			
			const LnameText = $('.signin-form #Lname-bar_text');
	   	 	
			Lname.addEventListener("keypress", function(evt) {
			   	const charCode = (evt.which) ? evt.which : evt.keyCode;
			   	
			   	LnameText.show();
			   	
			   	if (charCode > 31 && (charCode < 65 || charCode > 90) && (charCode < 97 || charCode > 122) && charCode !== 32 && charCode !== 46 && charCode !== 40 && charCode !== 41) {
			   		$(this).css('border-bottom-color', '#FF4B47');
			   	    changeText(LnameText, 'Invalid Last Name', '#FF4B47');
				   	evt.preventDefault();
			   	    
			   	} else {
			   	  //alert(this.value);
				   	$(this).css('border-bottom-color', '#2DAF7D');
					changeText(LnameText, 'Enter the Last Name', '#aaa');
					LnameText.hide();
				   	
			    }
			   	checkFields();
		   	});
			
			const EmailText = $('.signin-form #Email-bar_text');
	   	 	
			Email.addEventListener("blur", function(evt) {
			   	//const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{3,4}$/;
				const emailRegex = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$/;
  				const inputValue = this.value.trim();
			    
			   	EmailText.show();
			   	
			   	if (inputValue.match(emailRegex)) {

				   	$(this).css('border-bottom-color', '#2DAF7D');
					changeText(EmailText, 'Enter the Email', '#aaa');
					EmailText.hide();
			   	    
			   	} else {
			   	  //alert(this.value);
			   	  	$(this).css('border-bottom-color', '#FF4B47');
			   	    changeText(EmailText, 'Invalid Email', '#FF4B47');
			   	 
			    }
			   	checkFields();
		   	});
					   	
			const radioButtons = document.querySelectorAll('input[type=radio]');

			radioButtons.forEach(radioButton => {
				radioButton.addEventListener('change', () => {
					if (radioButton.checked) {
						genderSelected = true;
					} 
					checkFields();
				});
			});
		   	
	   	  
	   	});
   	   
		 /*
		 // Get the form element
		   	const form = document.querySelector('form');
		
		   	// Add a submit event listener to the form
		   	form.addEventListener('submit', (event) => {
		   	  event.preventDefault();
		
		   	  // Make the post request
		   	  fetch('http://localhost:3600/HBS/form/login.jsp', {
		   	    method: 'POST',
		   	    body: new FormData(form)
		   	  }).then(response => {
		   	      // Update the URL without adding a new history entry
		   	      window.history.replaceState(null, document.title, window.location.href);
		
		   	      // Handle the response
		   	      // ...
		   	    });
		   	});
		   	*/
		   	
		   	
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
					  
					  if (result.isConfirmed)
		   	   		  {
						  var username = $('#username').val();
						  //alert(username);
					    	if (username == ""){
					    		Swal.fire({
					    	      icon: 'error',
					    	      title: 'Error',
					    	      text: 'invalid username'
					    	    });
					    	}
					    	else {
					    	//alert("verification of username success"+username);
					    	 $.ajax({
					                type: 'post',
					                url: '../verify-username.jsp',
					                data: { username: username },
					                success: function(response) 
					                {
					                  var val_otp = response.trim();
					                  
					                  //alert(val_otp);
					                  if (val_otp.length == 6) 
					                  {
					                    // Show a message indicating that the OTP was validated
					                    Swal.fire({
					                      icon: 'success',
					                      title: 'Verification Successful',
					                      text: 'A verification code has been sent to your email. Please enter the code below to reset your password.',
					                      input: 'text',
					      				    inputAttributes: {
					      				    	id:"OTP",
					      				      autocapitalize: 'off',
					      				      placeholder:"Enter OTP",
					      				    },
					      				    showCancelButton: true,
					      				    confirmButtonText: 'Verify',
					      				    showLoaderOnConfirm: true,
					      				    focusConfirm: false,
					      				    preConfirm: function() {
					      				      return $('#OTP').val();
					      				    }
					                    }).then(function(result) {
					                    	
					                    	if (result.isConfirmed)
					  		   	   		  	{
							  				  var otp = $('#OTP').val();
											  
							  				  //alert(otp + " " + val_otp);
											  
											  if (otp == val_otp){
												  Swal.fire({
								                      icon: 'success',
								                      title: 'Authentication Successful',
								                      text: 'Please reset your password.',
								                      input: 'password',
								      				    inputAttributes: {
								      				    	id:"newPass",
								      				      autocapitalize: 'off',
								      				      placeholder:"Enter new password",
								      				    },
								      				  //html : "<button id='togglePassword' name='togglePassword' type='button' class='btn btn-primary'>View</button>",
								                      showCancelButton: true,
								      				  confirmButtonText: 'Update',
								      				  showLoaderOnConfirm: true,
								      				  focusConfirm: false,
								      				  preConfirm: function() {
								      				      return $('#newPass').val();
								      				  }
								                    }).then(function(result) {
								                    	
								                    	if (result.isConfirmed)
								  		   	   		  	{
										  				  var newpass = $('#newPass').val();
														  	//alert(newpass);
										  					
														  	if (newpass == "")
								  		   	   		  		{
										  				  
														  		Swal.fire({
														    	      icon: 'error',
														    	      title: 'Can\'t be Empty.',
														    	      text: 'Password can not be empty, Please Try Again !!'
														    	    });
														  		
							  		   	   		  			} else {
							  		   	   		  				
							  		   	   		  				  //alert(username + " " + newpass);
																  
																  $.ajax({
														                type: 'post',
														                url: '../update-password.jsp',
														                data: { username: username,
														                		newpass: newpass
														                	},
														                success: function(response) 
														                {
														                  var pass_status = response.trim();
														                  
														                  //alert(pass_status);
														                  
														                  if (pass_status == "updated")
														                  {
																			  Swal.fire({
															                      icon: 'success',
															                      title: 'Success',
															                      text: 'Your account password has been updated successfully.',
															                      showCancelButton: true,
															      				  confirmButtonText: 'Login',
															      				  cancelButtonText: 'Ok',
															      				  showLoaderOnConfirm: true,
															      				  focusConfirm: false,
															      				  
															                  }).then(function(result) {
															                    	
															                    	if (result.isConfirmed)
															  		   	   		  	{
															  		   	   		  		location.href='login.jsp';
															  		   	   		  	}
															  		   	   	  });
															                    
																	      } else 
																	      {
																	    	  Swal.fire({
																	    	      icon: 'error',
																	    	      title: 'Failed.',
																	    	      text: 'Can\'t Update Password, Please Try Again !!'
																	    	    });
																	      }
														                  
														                 } //end of success
																   	}); // end of Ajax - update password
									  		   	   		  		
							  		   	   		  				}
								  		   	   		  	  }
								                    	}); // end of OTP swalFire
								                    
											      } else {
											    	  //alert("Invalid");
											    	  Swal.fire({
											    	      icon: 'error',
											    	      title: 'Authentication Failed.',
											    	      text: 'Invalid OTP, Please Try Again !!'
											    	    });
											      }
												  
												  $("#togglePassword").on("click", function() {
													  var input = $("#newPass");
													  var attr = input.attr("type");
													  if (attr == "password") {
													    input.attr("type", "text");
													  } else {
													    input.attr("type", "password");
													  }
													});
						  		   	   		  	} // end of isConfirm
											  
					                    });
					                    
					                    $("#OTP").on("keypress", function(e) {
					                        var charCode = (e.which) ? e.which : e.keyCode;
					                        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
					                          return false;
					                        }
					                        if (this.value.length >= 6) {
					                          return false;
					                        }
					                        return true;
					                      });
					                  }
					                  else {
					                	  //alert(response.toString());
					                	  Swal.fire({
								    	      icon: 'error',
								    	      title: 'Error',
								    	      text: 'Invalid Username, Try Again !!'
								    	    });
					                  }
					              }
					    	 });
		
					    }
		   	   		  }
				  });
				}
 	
   	
		   	$(document).ready(function() {
	            $('#DepartmentName').on('change', function() {
	            	const Course = document.getElementById("Course");
	                var CourseN = Course.value;
	                var department_id = this.value;
	                $.ajax({
	                    url: "FindCourse.jsp",
	                    type: "POST",
	                    data: { department_id: department_id,
	                    	CourseN: CourseN },
	                    cache: false,
	                    success: function(result){
	                        $("#CourseName").html(result);
	                    }
	                });
	            }); 
	        });
		   	
		    // Disable back button after form submission
		    history.pushState(null, null, location.href);
		    window.onpopstate = function () {
		        history.go(1);
		    };
		    
	</script>
<!--  </head>
</body> -->