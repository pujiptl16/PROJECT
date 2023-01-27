<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

require('PHPMailer.php');
require('Exception.php');
require('SMTP.php');


$email=$_POST['email'];

echo"$email";



$otp = rand(100000, 999999);

$mail = new PHPMailer(true);

try {

    echo "Hello";
    //Server settings

    $mail->isSMTP();
    $mail->Host       = 'smtp.gmail.com';
    $mail->SMTPAuth   = true;
    $mail->Username   = 'dormzz16@gmail.com';
    $mail->Password   = 'pzwdkidxefixhquq';
    $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;
    $mail->Port       = 465;

    //Recipients
    $mail->setFrom('dormzz16@gmail.com', 'Dormzz Login');
    $mail->addAddress($email);     //Add a recipient
    
    $mail->isHTML(true);
    //$msg=file_get_contents("beefree-wbrjvkqo22s.php");

    $mail->Subject = 'Dormzz : Sign In Verification';

    $mail->Body    = "OTP is ".$otp;

    $mail->MsgHTML = ('h');



    $mail->send();

    // $sql = "INSERT INTO otps(otp)VALUES ('$otp')";
    // $run = mysqli_query($conn, $sql);

    // $_SESSION['email'] = $email;


} catch (Exception $e) {
    echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
}



?>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="" method="post">
        <input type="text" name="email">
        <button type="submit" name="sub">submit</button>
    </form>
</body>
</html>