<?php
$conn= new mysqli('localhost', 'root', '', 'login');
if($conn->connect_errno){
    echo json_encode(['status' => $conn->connect_error]);
    exit();
}