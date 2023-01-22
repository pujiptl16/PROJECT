<?php
session_start();
$db = mysqli_connect('localhost', 'root', '', 'dormz');

$package_id = $_POST['package_id'];

$record = mysqli_query($db, "SELECT * FROM `tblpackage` where Package_id='$package_id';"); 

$row = mysqli_fetch_array($record);

echo $row['Package_Price']; 

?>