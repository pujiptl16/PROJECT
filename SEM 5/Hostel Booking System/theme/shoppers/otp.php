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
    <title>OTP</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

    <!-- Bootstrap  -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">

    <!-- Main css -->
    <link rel="stylesheet" href="css/otp.css">

</head>

<body>

    <?php

$showerror = false;
$showwarning = false;



if(isset($_POST['otpv'])){


    $name = $_SESSION['name'];
    $email = $_SESSION['email'];
    $number = $_SESSION['num'];
    $password = $_SESSION['pass'];
    $re_password = $_SESSION['repass'];

    $txtotp=$_POST['txtotp'];

    $pass = md5($password);
   
    $result = mysqli_query($conn, "SELECT * FROM otps WHERE otp = '$txtotp' AND exp!=1 AND NOW()<=DATE_ADD(date_dt,INTERVAL 1 MINUTE)");

    $matchedotp = mysqli_query($conn,"SELECT * FROM otps WHERE otp ='$txtotp' AND exp!=1");


    if(empty($_POST['txtotp'])){

        $showerror = "Please enter OTP ";

    }elseif(mysqli_num_rows($matchedotp) && mysqli_num_rows($result)){

        $insertSql = "INSERT INTO `signup` (`name`, `email`,`num`, `pass`,`re_pass`) VALUES ('$name', '$email', '$number','$pass','$re_password')";

        $iquery = mysqli_query($conn,$insertSql);

        $news = mysqli_query($conn, "UPDATE otps SET exp=1 WHERE otp = '$txtotp' ");
        header("location:signin.php");

    }elseif(!mysqli_num_rows($matchedotp)){   

        $showerror = "OTP is Invalid "; 

    }elseif(!mysqli_num_rows($result)){

        $news = mysqli_query($conn, "UPDATE otps SET exp=1 WHERE otp = '$txtotp'");
        $showerror = "OTP is expire ";
    }

}

  if($showerror){

    echo '<div class="alert alert-danger alert-dismissible fade show" role="alert">
    <strong>Error!</strong> '.$showerror.'
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>';

    }
    
?>

    <form action="" method="post">

        <div class="container height-100 d-flex justify-content-center align-items-center">
            <div class="position-relative">
                <div class="card p-2 text-center">
                    <h6>To verify your account</h6>
                    <div class="vv"> <span>* * <?php echo $_SESSION['email'] ?></span> <small> * *</small> </div>
                    <div id="otp" class="inputs d-flex flex-row justify-content-center mt-2">
                        <input class="m-2 text-center form-control rounded" type="text" id="first" maxlength="6"
                            name="txtotp" placeholder="One Time Password" />
                    </div>
                    <div class="mt-4">
                        <button class="btn btn-danger px-4 validate" name="otpv">Validate</button>

                    </div>
                    <style>
                    .resend {
                        margin-top: 0.8rem;
                        font-size: 15px;
                        border: none;
                        background: none;
                        text-decoration: underline;
                        color: blue;}
                    .resend:hover{                       
                        font-size: 15px; 
                    color:#c90e28e0}
                    </style>
                    <form action="" method="post"><button class="resend" name="resend">Resend OTP</button>
                    </form>

                </div>
            </div>
        </div>
    </form>

    <?php

    
    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\SMTP;
    use PHPMailer\PHPMailer\Exception;

    require('PHPMailer.php');
    require('Exception.php');
    require('SMTP.php');

    if(isset($_POST['resend'])){
    
        $news = mysqli_query($conn, "UPDATE otp SET exp=1");

        $otp = rand(100000, 999999);

        $mail = new PHPMailer(true);

        try {

            //Server settings
            $mail->SMTPDebug = SMTP::DEBUG_SERVER;                      //Enable verbose debug output
            $mail->isSMTP();                                            //Send using SMTP
            $mail->Host       = 'smtp.gmail.com';                     //Set the SMTP server to send through
            $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
            $mail->Username   = 'rushilvaghasiya701@gmail.com'; 
        
            //SMTP username
            $mail->Password   = 'ngukrdmzuosopmiy';                               //SMTP password
            $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
            $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`
        
            //Recipients
            $mail->setFrom('rushilvaghasiya701@gmail.com', 'he.com');
            $mail->addAddress($_SESSION['email']); //Add a recipient
            $mail->Subject = 'e-commerce men\'s wear';
            $mail->Body    = "OTP : ".$otp;
            $mail->MsgHTML = ($otp);
        
            $mail->send();
            
            $sql="INSERT INTO otp(otp)VALUES ('$otp')";
            $run=mysqli_query($conn,$sql);    
            
            if($run)
            {
                header("location:otp.php");
            }
        
        }catch (Exception $e) {
            echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
        }
    }
    ?>

   


    <!-- JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/main.js"></script>

    <!-- <script>

  alert("OTP Valid For 60 second");

</script> -->

</body>