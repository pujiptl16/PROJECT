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
   		} else if(message == 'MailNotSent'){
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

   	$(document).ready(function() { 	  
	   	  const changeText = function (el, text, color) {
	   	    el.text(text).css('color', color);
	   	  };
	   	  
	   		const passwordInput = document.getElementById("password-field");
		   	const usernameInput = document.getElementById("username-field");
		   	const passwordStrengthBar = document.getElementById("progress-bar_text");


	   	  $('#password-field').keyup(function(){
	   	    let len = this.value.length;
	   	  	let strength = 0;
	   	    
	   	  	const pbText = $('.signin-form .progress-bar_text');
	   	  	const password = passwordInput.value;
	   	  	const username = usernameInput.value;
	   	    
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
					    	//alert("verification of username success");
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
														  	alert(newpass);
										  					
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
															                      text: 'your account password has been updated successfully.',
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
								    	      text: 'invalid Username, Try Again !!'
								    	    });
					                  }
					              }
					    	 });
		
					    }
		   	   		  }
				  });
				}
 	