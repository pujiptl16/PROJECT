<?php
session_start();
$db = mysqli_connect('localhost', 'root', '', 'dormz');

if(session_id()=="" || !isset($_SESSION['username'])) 
{
	$_SESSION['username'] = $username;
	echo "<script>location.href='../../../../form/login.php'</script>";
}
else
{
    //echo "<script>starter-kit.php'</script>";
    $fdate="";
    $tdate="";
    $reason="";
    $id="";

    if (isset($_POST['ApplyLeave'])) {
        $fdate = $_POST['FDate'];
        $tdate = $_POST['TDate'];
        $reason = mysqli_real_escape_string($db, $_POST['Reason']);
        $aid = $_SESSION['userid'];
        
        mysqli_query($db, "INSERT INTO `tblleave`(`User_id`, `Leave_Reason`, `Leave_From`, `Leave_To`)
        VALUES ('$aid','$reason','$fdate','$tdate')");
        $_SESSION['message'] = "Leave applied Successfully.";
        header('location: starter-kit.php');
    }

    if (isset($_GET['edit'])) {
		$id = $_GET['edit'];
		$record = mysqli_query($db, "SELECT * FROM tblleave WHERE Leave_id=$id");

		if ($record->num_rows == 1 ) {
			$n = mysqli_fetch_array($record);
			$fdate = $n['Leave_From'];
            $tdate = $n['Leave_To'];
            $reason = $n['Leave_Reason'];
		}
	}

    if (isset($_POST['UpdateLeave'])) {
        $id = $_POST['id'];
        $fdate = $_POST['FDate'];
        $tdate = $_POST['TDate'];
        $reason = mysqli_real_escape_string($db, $_POST['Reason']);
        $aid = $_SESSION['userid'];
        
        mysqli_query($db, "UPDATE `tblleave` SET `Leave_Reason`='$reason',`Leave_From`='$fdate',`Leave_To`='$tdate' WHERE `Leave_id`='$id';");
        $_SESSION['message'] = "Leave updated Successfully.";
        header('location: starter-kit.php');
    }
   

}

?>
<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords"
        content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, Nice lite admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, Nice admin lite design, Nice admin lite dashboard bootstrap 5 dashboard template">
    <meta name="description"
        content="Nice Admin Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
    <meta name="robots" content="noindex,nofollow">
    <title>Dormzz - Student Mess Panel</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/niceadmin-lite/" />
    <link rel="shortcut icon" type="image/x-icon" href="../../../../images/favicon.png" />
    <!-- Favicon icon 
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    -->
    <!-- Custom CSS -->
    <link href="../../dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body>
    <!-- ============================================================== -->
    <!-- Preloader - style you can find in spinners.css -->
    <!-- ============================================================== -->
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- Main wrapper - style you can find in pages.scss -->
    <!-- ============================================================== -->
    <div id="main-wrapper" data-navbarbg="skin6" data-theme="light" data-layout="vertical" data-sidebartype="full"
        data-boxed-layout="full">
        <!-- ============================================================== -->
        <!-- Topbar header - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <header class="topbar" data-navbarbg="skin6">
            <nav class="navbar top-navbar navbar-expand-md navbar-light">
                <div class="navbar-header" data-logobg="skin5">
                    <!-- This is for the sidebar toggle which is visible on mobile only -->
                    <a class="nav-toggler waves-effect waves-light d-block d-md-none" href="javascript:void(0)">
                        <i class="ti-menu ti-close"></i>
                    </a>
                    <!-- ============================================================== -->
                    <!-- Logo -->
                    <!-- ============================================================== -->
                    <div class="navbar-brand">
                        <a href="student_dash_index.php" class="logo">
                            <!-- Logo icon -->
                            <b class="logo-icon">
                                <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                                <!-- Dark Logo icon 
                                <img src="../../assets/images/logo-icon.png" alt="homepage" class="dark-logo" />
                                Light Logo icon 
                                <img src="../../../../images/favicon.png" alt="homepage" class="light-logo" /> -->
                                <svg width="30px" height="30px" viewBox="0 0 45 44" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                                    <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                        <g id="Group" transform="translate(2.000000, 2.000000)" stroke="#57CBCC" stroke-width="3">
                                            <ellipse id="Oval" cx="20.5" cy="20" rx="20.5" ry="20"></ellipse>
                                            <path d="M6,7 L33.5,34.5" id="Line-2" stroke-linecap="square"></path>
                                            <path d="M21,20 L34,7" id="Line-3" stroke-linecap="square"></path>
                                        </g>
                                    </g>
                            </svg>
                            </b>
                            <!--End Logo icon -->
                            <!-- Logo text -->
                            <span class="logo-text">
                                <!-- dark Logo text
                                <img src="../../assets/images/logo-text.png" alt="homepage" class="dark-logo" />
                                 -->
                                <!-- Light Logo text -->
                                <img src="../../assets/images/logo-light-text.png" class="light-logo" alt="homepage" />
                            </span>
                        </a>
                    </div>
                    <!-- ============================================================== -->
                    <!-- End Logo -->
                    <!-- ============================================================== -->
                    <!-- ============================================================== -->
                    <!-- Toggle which is visible on mobile only -->
                    <!-- ============================================================== -->
                    
                </div>
                <!-- ============================================================== -->
                <!-- End Logo -->
                <!-- ============================================================== -->
                <div class="navbar-collapse collapse" id="navbarSupportedContent" data-navbarbg="skin6">
                    <!-- ============================================================== -->
                    <!-- toggle and nav items -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav float-start me-auto">
                        <!-- ============================================================== -->
                        <!-- Search -->
                        <!-- ============================================================== -->
                        <li class="nav-item search-box">
                            <a class="nav-link waves-effect waves-dark" href="javascript:void(0)">
                                <div class="d-flex align-items-center">
                                    <i class="mdi mdi-magnify font-20 me-1"></i>
                                    <div class="ms-1 d-none d-sm-block">
                                        <span>Search</span>
                                    </div>
                                </div>
                            </a>
                            <form class="app-search position-absolute">
                                <input type="text" class="form-control" placeholder="Search &amp; enter">
                                <a class="srh-btn">
                                    <i class="ti-close"></i>
                                </a>
                            </form>
                        </li>
                    </ul>
                    <!-- ============================================================== -->
                    <!-- Right side toggle and nav items -->
                    <!-- ============================================================== -->
                    <ul class="navbar-nav float-end">
                        <!-- ============================================================== -->
                        <!-- User profile and search -->
                        <!-- ============================================================== -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-muted waves-effect waves-dark pro-pic" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="<?php echo $_SESSION['ProfilePic']; ?>" alt="user" class="rounded-circle" width="31" height="31">
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end user-dd animated" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="javascript:void(0)"><i class="ti-user me-1 ms-1"></i>
                                    My Profile</a>
                                <a class="dropdown-item" href="javascript:void(0)"><i class="ti-wallet me-1 ms-1"></i>
                                    My Balance</a>
                                <a class="dropdown-item" href="javascript:void(0)"><i class="ti-email me-1 ms-1"></i>
                                    Inbox</a>
                            </ul>
                        </li>
                        <!-- ============================================================== -->
                        <!-- User profile and search -->
                        <!-- ============================================================== -->
                    </ul>
                </div>
            </nav>
        </header>
        <!-- ============================================================== -->
        <!-- End Topbar header -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <aside class="left-sidebar" data-sidebarbg="skin5">
                <!-- Sidebar scroll-->
                <div class="scroll-sidebar">
                    <!-- Sidebar navigation-->
                    <nav class="sidebar-nav">
                        <ul id="sidebarnav">
                            <li class="sidebar-item">
                                <a class="sidebar-link waves-effect waves-dark sidebar-link" href="student_dash_index.php"
                                    aria-expanded="false">
                                    <i class="mdi mdi-av-timer"></i>
                                    <span class="hide-menu">Dashboard</span>
                                </a>
                            </li>
                            <li class="sidebar-item">
                                <a class="sidebar-link waves-effect waves-dark sidebar-link" href="pages-profile.php"
                                    aria-expanded="false">
                                    <i class="mdi mdi-account-network"></i>
                                    <span class="hide-menu">Profile</span>
                                </a>
                            </li>
                            <li class="sidebar-item">
                                <a class="sidebar-link waves-effect waves-dark sidebar-link" href="form-basic.php"
                                    aria-expanded="false">
                                    <i class="mdi mdi-arrange-bring-forward"></i>
                                    <span class="hide-menu">My Clubs</span>
                                </a>
                            </li>
                            <li class="sidebar-item">
                                <a class="sidebar-link waves-effect waves-dark sidebar-link" href="table-basic.php"
                                    aria-expanded="false">
                                    <i class="mdi mdi-border-none"></i>
                                    <span class="hide-menu">Mess</span>
                                </a>
                            </li>
                            <li class="sidebar-item">
                                <a class="sidebar-link waves-effect waves-dark sidebar-link" href="icon-material.php"
                                    aria-expanded="false">
                                    <i class="mdi mdi-face"></i>
                                    <span class="hide-menu">Payment</span>
                                </a>
                            </li>
                            <li class="sidebar-item">
                                <a class="sidebar-link waves-effect waves-dark sidebar-link" href="starter-kit.php"
                                    aria-expanded="false">
                                    <i class="mdi mdi-file"></i>
                                    <span class="hide-menu">Leave</span>
                                </a>
                            </li>
                            <li class="sidebar-item">
                                <a class="sidebar-link waves-effect waves-dark sidebar-link" href="CRC.php"
                                    aria-expanded="false">
                                    <i class="mdi mdi-file"></i>
                                    <span class="hide-menu">Complain / Request</span>
                                </a>
                            </li>
                            <li class="sidebar-item">
                                <a class="sidebar-link waves-effect waves-dark sidebar-link" href="../../../../logout.php"
                                    aria-expanded="false">
                                    <i class="mdi mdi-alert-outline"></i>
                                    <span class="hide-menu">Logout</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                    <!-- End Sidebar navigation -->
                </div>
                <!-- End Sidebar scroll-->
            </aside>
            <!-- ============================================================== -->
        <!-- End Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Page wrapper  -->
        <!-- ============================================================== -->
        <div class="page-wrapper">
            <!-- ============================================================== -->
            <!-- Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-5 align-self-center">
                        <h4 class="page-title">Mess Panel</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Mess Panel</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Bread crumb and right sidebar toggle -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- Container fluid  -->
            <!-- ============================================================== -->
            <div class="container-fluid">
                <!-- ============================================================== -->
                <!-- Start Page Content -->
                <!-- ============================================================== -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Mess Corner</h4>
                                <h5 class="card-subtitle">Daily Menu</h5>
                                <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-1-box-multiple-outline"></i>Mess Information</h6>

                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">Hostel Name</th>
                                                <th scope="col">Mess Name</th>
                                                <th scope="col">Mess Chief</th>
                                                <th scope="col">Mess Hours</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <?php 
                                            $id = $_SESSION['userid'];
                                            $dish_ids = "";
                                            $record = mysqli_query($db, "SELECT b.Hostel_Name, b.Mess_id, c.Mess_Name, c.user_id, d.FirstName, d.LastName, e.Dish_id from tblhostel_record a LEFT JOIN tblhostel b ON a.Hostel_id=b.Hostel_id LEFT JOIN tblmess c ON b.Mess_id=c.Mess_id LEFT JOIN tblregister d ON c.user_id=d.user_id LEFT JOIN tblmess_menu e ON c.MessMenu_id=e.MessMenu_id where a.user_id='$id';"); ?>
                                        <?php    
                                            if($record->num_rows==0){
                                                ?>
                                                <tr>
                                                    <td colspan=8><center>No Information Found. / Kindly Purchase a Package.</center></td>
                                                </tr>
                                                <?php
                                            }
                                            $num=1;
                                            while ($row = mysqli_fetch_array($record)) 
                                            {   $dish_ids = $row['Dish_id'];
                                                ?>
                                                <tr>
                                                    <td scope="row"><?php echo $row['Hostel_Name']; ?></td>
                                                    <td scope="row"><?php echo $row['Mess_Name']; ?></td>
                                                    <td scope="row"><?php echo $row['FirstName']." ".$row['LastName']; ?></td>
                                                    <td scope="row"><?php echo "7:30 AM - 10:00 PM" ?></td>
                                                </tr>
                                                <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-2-box-multiple-outline"></i> Today's Menu</h6>
                            <div class="table-responsive">
                                <div class="comment-widgets" style="height:350px;">
                                    <table class="table">
                                        <thead>
                                            <tr style=" position: -webkit-sticky; position: sticky;top: 0; z-index: 1; background: #fff;">
                                                <th scope="col">No.</th>
                                                <th scope="col">Morning</th>
                                                <th scope="col">Afternoon</th>
                                                <th scope="col">Evening</th>
                                                <th scope="col">Night</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <?php    
                                            if($dish_ids==""){
                                                ?>
                                                <tr>
                                                    <td colspan=8><center>Menu is not assigned yet.</center></td>
                                                </tr>
                                                <?php
                                            }else{
                                                $data = $dish_ids;
                                                $data = explode(":", $data);
                                                $out = array();
                                                $step = 0;
                                                //print_r($data);
                                                
                                                foreach($data as $key1=>$item){
                                                    foreach(explode(',',$item) as $value1){
                                                        $out[$key1][$step++] = $value1;
                                                    }
                                                }

                                                $lengths = array_map('count', $out);
                                                $min_m = min($lengths);
                                                $max_m = max($lengths);
                                                $num=1;
                                                $index=0;
                                                while($num<=$max_m) 
                                                { 
                                                ?>
                                                    <tr>
                                                        <td><?php echo $num;?></td>
                                                        <?php
                                                            if($num<=$lengths[0]){
                                                                ?>
                                                                    <td>
                                                                        <?php 
                                                                            $id = $out[0][$index];
                                                                            $record = mysqli_query($db, "SELECT * FROM `tbldish` WHERE Dish_id='$id';");
                                                                            $row = mysqli_fetch_assoc($record);
                                                                            $dish = $row['DishName'];
                                                                            echo $dish;
                                                                        ?>
                                                                    </td>
                                                                <?php
                                                            }else{
                                                                ?>
                                                                    <td></td>
                                                                <?php
                                                            }
                                                            
                                                            if ($num<=$lengths[1]) {
                                                                ?>
                                                                    <td>
                                                                        <?php 
                                                                            $id = $out[1][$lengths[0]+$index];
                                                                            $record = mysqli_query($db, "SELECT * FROM `tbldish` WHERE Dish_id='$id';");
                                                                            $row = mysqli_fetch_assoc($record);
                                                                            $dish = $row['DishName'];
                                                                            echo $dish;
                                                                        ?>
                                                                    </td>
                                                                <?php
                                                            }else{
                                                                ?>
                                                                    <td></td>
                                                                <?php
                                                            }
                                                            
                                                            if ($num<=$lengths[2]) {
                                                                ?>
                                                                    <td>
                                                                        <?php 
                                                                            $id = $out[2][$lengths[0]+$lengths[1]+$index];
                                                                            $record = mysqli_query($db, "SELECT * FROM `tbldish` WHERE Dish_id='$id';");
                                                                            $row = mysqli_fetch_assoc($record);
                                                                            $dish = $row['DishName'];
                                                                            echo $dish;
                                                                        ?>
                                                                    </td>
                                                                <?php
                                                            }else{
                                                                ?>
                                                                    <td></td>
                                                                <?php
                                                            }
                                                            
                                                            if ($num<=$lengths[3]) {
                                                                ?>
                                                                    <td>
                                                                        <?php 
                                                                            $id = $out[3][$lengths[0]+$lengths[1]+$lengths[2]+$index];
                                                                            $record = mysqli_query($db, "SELECT * FROM `tbldish` WHERE Dish_id='$id';");
                                                                            $row = mysqli_fetch_assoc($record);
                                                                            $dish = $row['DishName'];
                                                                            echo $dish;
                                                                        ?>
                                                                    </td>
                                                                <?php
                                                            }else{
                                                                ?>
                                                                    <td></td>
                                                                <?php
                                                            }
                                                        ?>
                                                    </tr>
                                                    <?php
                                                    $num = $num + 1;
                                                    $index = $index + 1;
                                                }
                                            } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- End PAge Content -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- Right sidebar -->
                <!-- ============================================================== -->
                <!-- .right-sidebar -->
                <!-- ============================================================== -->
                <!-- End Right sidebar -->
                <!-- ============================================================== -->
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- footer -->
            <!-- ============================================================== -->
            <footer class="footer text-center">
            All Rights Reserved by DORMZZ. Designed and Developed by
                <a href="http://www.utu.ac.in/bmiit" target="_blank">BMIITIANS</a>.
            </footer>
            <!-- ============================================================== -->
            <!-- End footer -->
            <!-- ============================================================== -->
        </div>
        <!-- ============================================================== -->
        <!-- End Page wrapper  -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->
    <script src="../../assets/libs/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap tether Core JavaScript -->
    <script src="../../assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <!-- slimscrollbar scrollbar JavaScript -->
    <script src="../../assets/extra-libs/sparkline/sparkline.js"></script>
    <!--Wave Effects -->
    <script src="../../dist/js/waves.js"></script>
    <!--Menu sidebar -->
    <script src="../../dist/js/sidebarmenu.js"></script>
    <!--Custom JavaScript -->
    <script src="../../dist/js/custom.min.js"></script>
</body>

</html>