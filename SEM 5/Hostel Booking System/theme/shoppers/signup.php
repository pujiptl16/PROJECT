<?php  
    include 'conn.php';
    session_start();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <!-- <link rel="icon" href="https://img.freepik.com/free-photo/black-friday-elements-assortment_23-2149074076.jpg?size=626&ext=jpg&ga=GA1.2.542333197.1655871465"> -->
    <title>Sign Up</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Bootstrap  -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <!-- Main css -->
    <link rel="stylesheet" href="css/style.css">


</head>

<body>

    <!-- Sign Up php  -->

    <?php

    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\SMTP;
    use PHPMailer\PHPMailer\Exception;

    require('PHPMailer.php');
    require('Exception.php');
    require('SMTP.php');

    $showsuccess = false;
    $showerror = false;
   
        if(isset($_POST['signup'])){
            
            $name = $_POST['name'];
            $_SESSION['name'] = $name;

            $email = $_POST['email'];
            $_SESSION['email'] = $email;

            $number = $_POST['num'];
            $_SESSION['num'] = $number;

            $password = $_POST['pass'];
            $_SESSION['pass'] = $password;

            $re_password = $_POST['re_pass'];
            $_SESSION['re_pass'] = $re_password;

            $email = filter_var($email,FILTER_SANITIZE_EMAIL);

            $uppercase = preg_match('@[A-Z]@', $password);
            $lowercase = preg_match('@[a-z]@', $password);
            $numbers    = preg_match('@[0-9]@', $password);
            $specialChars = preg_match('@[^\w]@', $password);

            if (!ctype_alpha ($name)){   
                $showerror = " Invalid Your Name";
            }else{
                if(!filter_var($email,FILTER_VALIDATE_EMAIL)){
                    $showerror = " Invalid Email-Id";
                }else{
                    if (!ctype_digit($number)) {
                        $showerror = " Invalid Your Phone Number";
                    }else{
                        if(!$uppercase || !$lowercase || !$numbers || !$specialChars || strlen($password) < 8) {
                            $showerror = "Password should be at least 8 characters in length and should include at least one upper case letter, one number, and one special character";
                        }else{
                            if($password==$re_password){
                                
                                $emailSql = "SELECT * FROM signup where email = '$email' ";
                                $query = mysqli_query($conn,$emailSql);
                    
                                $emailcount = mysqli_num_rows($query);
    
                                if($emailcount > 0){
                                    $showerror = " Email alredy exists";
                                }else{

                                    
                    $email = $_POST['email'];

                    $otp = rand(100000, 999999);





                    $mail = new PHPMailer(true);


                    try {






                        //Server settings

                        $mail->isSMTP();
                        $mail->Host       = 'smtp.gmail.com';
                        $mail->SMTPAuth   = true;
                        $mail->Username   = 'shoppershoes102@gmail.com';
                        $mail->Password   = 'hgriysxkgmoiqbzd';
                        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
                        $mail->Port       = 465;



                        //Recipients
                        $mail->setFrom('shoppershoes102@gmail.com', 'Registration-shoes');
                        $mail->addAddress($email);     //Add a recipient
                     
                        $mail->isHTML(true);
                        //$msg=file_get_contents("beefree-wbrjvkqo22s.php");

                        $mail->Subject = 'Sign Up Verification';

                        $mail->Body    = "otp is ".$otp;

                        $mail->MsgHTML = ('h');



                        $mail->send();

                        $sql = "INSERT INTO otps(otp)VALUES ('$otp')";
                        $run = mysqli_query($conn, $sql);

                        header("location:otp.php");

                    } catch (Exception $e) {
                        echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
                    }

                                 } 
                                
                           }else{
                            $showerror =  " Password is not matching";
                            }                      
                        }
                    }
                }
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

        <!-- Sign up form -->

        <section class="signup">
            <div class="container">
                <div class="signup-content">
                    <div class="signup-form">
                        <h2 class="form-title">Sign Up</h2>
                        <form method="POST" class="register-form" id="register-form">
                            <div class="form-group">
                                <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                <input type="text" name="name" id="name" placeholder="Your Name" required />
                                
                            </div>
                            <div class="form-group">
                                <label for="email"><i class="zmdi zmdi-email"></i></label>
                                <input type="email" name="email" id="email" placeholder="Your Email"
                                    pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,63}$" required />
                            </div>
                            <div class="form-group">
                                <label for="num"><i class="zmdi zmdi-smartphone-android"></i></label>
                                <input type="tel" name="num" id="num" placeholder="Phone Number" pattern="^\d{10}$"
                                    maxlength="10" required />
                            </div>
                            <div class="form-group">
                                <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                <input type="password" name="pass" id="pass" placeholder="Password" required />
                            </div>
                            <div class="form-group">
                                <label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                <input type="password" name="re_pass" id="re_pass" placeholder="Repeat your password"
                                    required />
                            </div>
                            <!-- <div class="form-group">
                                <input type="checkbox" name="agreeterm" id="agree-term" class="agree-term" />
                                <label for="agree-term" class="label-agree-term"><span><span></span></span>I agree
                                    all statements in <a href="#" class="term-service">Terms of service</a></label>
                            </div> -->
                            <div class="form-group">
                                <input type="checkbox" onclick="myFunction()" name="show" id="agree-term"
                                    class="agree-term" />
                                <label for="agree-term" class="label-agree-term"><span><span></span></span>Show
                                    Password</label>
                            </div>
                            <div class="form-group form-button">
                                <input type="submit" name="signup" id="signup" class="form-submit" value="Register" />
                            </div>
                        </form>
                    </div>
                    <div class="signup-image">
                        <figure><img src="images/sign_login.webp" alt="sing up image"></figure>
                        <a href="signin.php" class="signup-image-link">I am already member</a>
                    </div>
                </div>
            </div>
        </section>
    </div>


    <!-- JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>
    <script>
    function myFunction() {
        var x = document.getElementById("pass");
        var y = document.getElementById("re_pass");
        if (x.type === "password" || y.type === "password") {
            x.type = "text";
            y.type = "text";
        } else {
            x.type = "password";
            y.type = "password";
        }
    }
    </script>

</body>

</html>