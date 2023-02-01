<?php
$data = "staffuse,staffuse,seat,seat,seat,seat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat]seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat:staffuse,staffuse,seat,seat,seat,seat,seat,seat]seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,staffuse,staffuse:seat,seat,seat,seat,seat,seat,staffuse,staffuse]seat,seat,seat,seat,seat,seat,staffuse,staffuse:seat,seat,seat,seat,seat,seat,staffuse,staffuse:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,whiteseat,whiteseat,whiteseat,whiteseat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat:seat,seat,seat,seat,seat,seat,seat,seat]";
echo $data;
echo "<br><br><br>";
$data = explode("]", $data);
$out = array();
$step = 0;
$last = count($data);
$last--;

foreach($data as $key1=>$item){
    if ($key1!=$last){
        foreach(explode(':',$item) as $key2=>$value1){
            foreach(explode(',',$value1) as $value2){
                $out[$key1][$key2][$step++] = $value2;
            }
            
        }
    
    }
}
// $count1=0;
// $count2=0;
// foreach($out as $key1=>$item1){
//     $count2=0;
//     foreach($item1 as $key2=>$item2){
//         $count1=0;
//         foreach($item2 as $value){
//             if($count1==count($item2)-1){
//                 if($count2!=count($item1)-1){
//                     echo $value.":";
//                 }else{
//                     echo $value;
//                 }
//             }else{
//                 echo $value.",";  
//             }
//             $count1=$count1+1;  
//         }
//         if($count2==count($item1)-1){
//             echo "]";
//         }
//         $count2=$count2+1; 
//         echo "<br>";
//     }
// }

// echo "<br><br>";
$RoomCount=0;
foreach($out as $key1=>$item1){
    foreach($item1 as $key2=>$item2){
        foreach($item2 as $key3=>$value){            
            if($key1+1 == 4 && $RoomCount == 49)
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
echo "<br><br>";
echo $mapdata;
// $data = "1,2:3,4,5,6:7:8,9,10,11,12";
// $data = explode(":", $data);
// $out = array();
// $step = 0;
// $last = count($data);
// $last--;
// print_r($data);
// foreach($data as $key1=>$item){
//     //if ($key1!=$last){
//         foreach(explode(',',$item) as $value1){
//             $out[$key1][$step++] = $value1;
//         }
//     //}
// }
// echo "<br><br><br>=================================><br>";
// foreach($out as $key1=>$item1){
//         foreach($item1 as $value){
//             echo $value." ";    
//         }
//         echo "<br>";
// }
// echo "<br><br><br>=================================>";
// print '<pre>';
// print_r($out);
// print '</pre>';

// $data = "1,2:3,4,5,6:7:8,9,10,11,12";
// $master = explode(":", $data);
// echo "<br><prev>";
// print_r($master);
// echo "</prev>";
// $morning = explode(",",$master[0]);
// echo "<br><prev>";
// print_r($morning);
// echo "</prev>";
// $afternoon = explode(",",$master[1]);
// echo "<br><prev>";
// print_r($afternoon);
// echo "</prev>";
// $evening = explode(",",$master[2]);
// echo "<br><prev>";
// print_r($evening);
// echo "</prev>";
// $night = explode(",",$master[3]);
// echo "<br><prev>";
// print_r($night);
// echo "</prev><br>";

// $lengths = array_map('count', $out);
// print_r($lengths);
//   // Show min and max string length
// echo "<br>The shortest is " . min($lengths) .
//      ". The longest is " . max($lengths);

// echo "<br>Master Array Size : ".sizeof($master);

//echo date("F 1, Y", strtotime("1 months"));
// $currentDate = date('Y-m-d H:i:s');
// $checkoutdate = date('Y-m-d', strtotime('150 days'))." 12:00:00"; 
// echo $currentDate;
// echo "<br>";
// echo $date;
// $HostelId=2;
// $RoomIndex=2;
// $Floor=9;

// $roomid="";

// if($HostelId<10)
// {
//     if($Floor<10){
//         $roomid=$HostelId."000";
//         $roomid=$roomid.$Floor;
//         if($RoomIndex<10){
//             $roomid=$roomid."0".$RoomIndex;
//         }
//         else if($RoomIndex>=10 && $RoomIndex<100){
//             $roomid=$roomid.$RoomIndex;
//         }   
//     }
//     else if($Floor>=10 && $Floor<99){
//         $roomid=$HostelId."00";
//         $roomid=$roomid.$Floor;
//         if($RoomIndex<10){
//             $roomid=$roomid."0".$RoomIndex;
//         }
//         else if($RoomIndex>=10 && $RoomIndex<100){
//             $roomid=$roomid.$RoomIndex;
//         }   
//     }
// }
// echo $roomid;
// echo "<BR>";
// $Floor=substr($roomid, 3, 2);
// $Room=substr($roomid, -2);
// echo $Floor;
// echo $Room;
?>
