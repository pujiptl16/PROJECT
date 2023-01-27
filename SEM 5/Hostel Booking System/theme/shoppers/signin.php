<?php

    include 'conn.php';

    session_start(); 

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <link rel="icon" href="https://img.freepik.com/free-photo/black-friday-elements-assortment_23-2149074076.jpg?size=626&ext=jpg&ga=GA1.2.542333197.1655871465"> -->
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign In</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Bootstrap  -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous">
    </script>

    <!-- Main css -->
    <link rel="stylesheet" href="css/style.css">
</head>



<body>

    <!-- sign in php -->

    <?php

    $showsuccess = false;
    $showerror = false;

    if (isset($_POST['signin'])) {

        $email = $_POST['email'];
        $password = $_POST['pass'];

        $search_emailSql = "SELECT * FROM `signup` WHERE email = '$email'";
        $query = mysqli_query($conn,$search_emailSql);
        $email_count = mysqli_num_rows($query); 

            if($email_count > 0){

                $pass = md5($password);

                $search_pass = "SELECT * FROM `signup` WHERE pass = '$pass'";

                $conform = mysqli_query($conn,$search_pass);

                $pass_count = mysqli_num_rows($conform);

                if($pass_count > 0){
                 
                    header("location:index.php");

                }else{               
                    $showerror = " Password Incorrect" ;
                }
            }else{
                $showerror = " Email-Id Is Not Exists";
            }
        }    
    
     if($showerror){

        echo '<div class="alert alert-danger alert-dismissible fade show" role="alert">
        <strong>Error!</strong> '.$showerror.'
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>';
       
    }
    if($showsuccess){

        echo '<div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>Success!</strong> '.$showsuccess.'
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
      </div>';
       
    } 

?>


    <div class="main">
        <!-- Sing in  Form -->
       
        <section class="sign-in">
            <div class="container">
                <div class="signin-content">
                    <div class="signin-image">
                        <figure><img
                                src="images/online-registration-sign-up-with-man-sitting-near-smartphone_268404-95.webp"
                                alt="sing up image"></figure>
                        <a href="signup.php" class="signup-image-link">Create an account</a>
                    </div>

                    <div class="signin-form">
                        <h2 class="form-title">Sign In</h2>
                        <form method="POST" class="register-form" id="login-form">
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <input type="text" name="email" id="email" placeholder="Your Email-Id" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,63}$" required/>
                            </div>
                            <div class="form-group">
                                <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="pass" id="pass" placeholder="Password" required />
                            </div>
                            <div class="form-group linkk">
                                <a href="forgot.php">Forgot Password </a>
                            </div>
                            <div class="form-group form-button">
                                <input type="submit" name="signin" id="signin" class="form-submit" value="Log in" />
                            </div>
                        </form>
                        <div class="social-login">
                            <span class="social-label">Or login with</span>
                            <ul class="socials">
                                <li><a href="https://www.facebook.com/" target="_blank"><i
                                            class="display-flex-center zmdi zmdi-facebook"></i></a></li>
                                <li><a href="https://twitter.com/" target="_blank"><i
                                            class="display-flex-center zmdi zmdi-twitter"></i></a></li>
                                <li><a href="https://www.google.com/" target="_blank"><i
                                            class="display-flex-center zmdi zmdi-google"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- $insertSql = "INSERT INTO `signin` (`siid`, `email`, `password`, `datetime`) VALUES (NULL, '$email', '$pass', current_timestamp());";

$iquery = mysqli_query($conn,$insertSql); -->

    <!-- JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>
</body>

</html>