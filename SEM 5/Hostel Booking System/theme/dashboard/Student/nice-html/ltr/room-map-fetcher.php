<?php
session_start();
$db = mysqli_connect('localhost', 'root', '', 'dormz');

$id = $_POST['hostel_id'];
$floor = $_POST['HostelFloor'];
//echo "<script>alert('$id, $floor')</script>";
$record = mysqli_query($db, "SELECT * FROM `tblhostel` where `Hostel_id`='$id';"); 
$row = mysqli_fetch_array($record);

$data = $row['Hostel_Map'];
$data = explode("]", $data);

$out = array();
$step = 0;
$last = count($data);
$last--;
$class="seat";

foreach($data as $key1=>$item){
    if ($key1!=$last){
        foreach(explode(':',$item) as $key2=>$value1){
            foreach(explode(',',$value1) as $value2){
                $out[$key1][$key2][$step++] = $value2;
            }     
        }               
    }
}

?>
<div class="screen" style="color: black; text-align:center;">N</div>
<?php

//$record2 = mysqli_query($db, "SELECT * FROM `tblroom` where `Hostel_id`='$id';"); 
//$floorcount=0;
//$floorwiseRoomCount=0;
//$id=null;

foreach($out as $key1=>$item1){
    if($key1+1 == $floor){
        //$floorcount = $floorcount + 1;
        foreach($item1 as $key2=>$item2){
            //$floorwiseRoomCount = $floorwiseRoomCount + 1;
            ?>
            <div class="movie-row">
                <?php
                    foreach($item2 as $value){
                        //$row2 = mysqli_fetch_array($record2);
                        if($value == 'seat')
                            {
                                $class="seat";
                            }elseif($value == 'staffuse' )
                            {
                                $class="seat staffuse";
                            }elseif($value == 'occupied' )
                            {
                                $class="seat occupied";
                            }elseif($value == 'whiteseat')
                            {
                                $class="seat whiteseat";
                            }
                            ?>
                                <div class="<?php echo $class;?>"></div>
                            <?php    
                    }
                ?>
            </div>
            <?php
        }
    }
}

?>