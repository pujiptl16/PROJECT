<?php
session_start();
$db = mysqli_connect('localhost', 'root', '', 'dormz');

$id = $_POST['hostel_id'];

$record = mysqli_query($db, "SELECT * FROM `tblhostel` where `Hostel_id`='$id';"); 
?>
<option value="" selected disabled>Select a Floor</option>
<?php
$num=0;
$row = mysqli_fetch_array($record);
while($num<$row['Hostel_Floor']){
    $num = $num + 1;
?>    
  <option value="<?php echo $num; ?>"><?php echo $num; ?></option>
<?php } 
?>