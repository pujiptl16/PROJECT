<?php
session_start();
$db = mysqli_connect('localhost', 'root', '', 'dormz');

if(isset($_POST['PaymentId']) && 
isset($_POST['UserId']) &&
isset($_POST['Amount'])){

    $uid = $_POST['UserId'];
    $Amount = $_POST['Amount'];
    $Mode="Online";
    $PayId = $_POST['PaymentId'];
    $Status="Sucsess";
    $HostelId=$_POST['HostelId'];
    $PackageId=$_POST['PackageId'];
    $RoomIndex=$_POST['RoomIndex'];
    $Floor=$_POST['Floor'];
    $checkoutdate = date('Y-m-d', strtotime('150 days'))." 12:00:00"; 
    $Status="Active";
    
    $record = mysqli_query($db, "SELECT * FROM `tblhostel` where `Hostel_id`='$HostelId';"); 
    $row = mysqli_fetch_array($record);
    $AvailableRooms=$row['Available_Rooms']-1;
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

    $RoomCount=0;
    foreach($out as $key1=>$item1){
        foreach($item1 as $key2=>$item2){
            foreach($item2 as $key3=>$value){            
                if($key1+1 == $Floor && $RoomCount == $RoomIndex)
                {
                    $out[$key1][$key2][$key3] = 'occupied';
                }
                $RoomCount=$RoomCount+1;    
            }
        }
        $RoomCount=0;
    }
    $count1=0;
    $count2=0;
    $mapdata="";
    
    foreach($out as $key1=>$item1){
        $count2=0;
        foreach($item1 as $key2=>$item2){
            $count1=0;
            foreach($item2 as $value){
                if($count1==count($item2)-1){
                    if($count2!=count($item1)-1){
                        echo $value.":";
                        $mapdata=$mapdata.$value.":";
                    }else{
                        echo $value;
                        $mapdata=$mapdata.$value;
                    }
                }else{
                    echo $value.","; 
                    $mapdata=$mapdata.$value.",";
                }
                $count1=$count1+1;  
            }
            if($count2==count($item1)-1){
                echo "]";
                $mapdata=$mapdata."]";
            }
            $count2=$count2+1; 
            echo "<br>";
        }
    }

    $roomid="";

    if($HostelId<10)
    {
        if($Floor<10){
            $roomid=$HostelId."000";
            $roomid=$roomid.$Floor;
            if($RoomIndex<10){
                $roomid=$roomid."0".$RoomIndex;
            }
            else if($RoomIndex>=10 && $RoomIndex<100){
                $roomid=$roomid.$RoomIndex;
            }   
        }
        else if($Floor>=10 && $Floor<99){
            $roomid=$HostelId."00";
            $roomid=$roomid.$Floor;
            if($RoomIndex<10){
                $roomid=$roomid."0".$RoomIndex;
            }
            else if($RoomIndex>=10 && $RoomIndex<100){
                $roomid=$roomid.$RoomIndex;
            }   
        }
    }

$record = mysqli_query($db, "INSERT INTO `tblhostel_record`(`user_id`, `Hostel_id`, `Package_id`, `Room_id`, `Timestamp_Check_Out`, `User_Status`)
VALUES ('$uid','$HostelId','$PackageId','$roomid','$checkoutdate','$Status');"); 

$record = mysqli_query($db, "SELECT * FROM tblhostel_record ORDER BY `Record_id` DESC LIMIT 1");
if($record->num_rows == 0){
    $rid = 1;
}else{
    $row = mysqli_fetch_assoc($record);
    $rid = $row['Record_id'];
}

$record = mysqli_query($db, "INSERT INTO `tbltransaction`(`user_id`, `Record_id`, `Trn_Amount`, `Trn_Mode`, `Trn_refference_id`, `Trn_Status`)
VALUES ('$uid','$rid','$Amount','$Mode','$PayId','Success')");

$record = mysqli_query($db, "SELECT * FROM `tbltransaction` ORDER BY `Trn_id` DESC LIMIT 1");

if($record->num_rows == 0){
    $tid = 1;
}else{
    $row = mysqli_fetch_assoc($record);
    $tid = $row['Trn_id'];
}

$record = mysqli_query($db, "UPDATE `tblhostel_record` SET `Trn_id`='$tid' WHERE `Record_id`='$rid';");
//$row = mysqli_fetch_array($record);

$record = mysqli_query($db, "UPDATE `tblhostel` SET `Available_Rooms`='$AvailableRooms', `Hostel_Map`='$mapdata' WHERE Hostel_id='$HostelId';"); 

}

?>