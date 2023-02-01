<?php
session_start();
$db = mysqli_connect('localhost', 'root', '', 'dormz');

$Type = $_POST['RecType'];

$record = mysqli_query($db, "SELECT * FROM `tblcomplain_type` WHERE `ReC_Type`='$Type';");

?>

<option value="" disabled selected>Select SubType</option>

<?php
while($row = mysqli_fetch_array($record)){
?>    
  <option value="<?php echo $row['Cmp_Type_id']; ?>"><?php echo $row['Cmp_Type']; ?></option>
<?php } 
?>