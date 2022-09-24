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
    //echo "<script>table-basic.php'</script>";
    $Hname = "";
    $capacity = "";
    $availRooms = "";
    $rector = "";
    $mess = "";
    $address = "";
    $distance = "";
    $Type = "";
    $Status = "";

    if (isset($_GET['del'])) {
        $id = $_GET['del'];
        $query = "DELETE FROM tblhostel WHERE Hostel_id='$id'";
        mysqli_query($db, $query);
        header('location: table-basic.php');
    }
    
	
    if (isset($_POST['AddHostel'])) {
        $Hname = $_POST['Name'];
        $category = $_POST['category'];
        $capacity = $_POST['Capacity'];
        $availRooms = $_POST['AvailRooms'];
        $rector = $_POST['Rector'];
        $mess = $_POST['Messchief'];
        $address = $_POST['Address'];
        $distance= $_POST['Distance'];
        $Type= $_POST['Type'];
        $Status= $_POST['Status'];

        mysqli_query($db, "INSERT INTO `tblhostel`(`Capacity`, `Hostel_Name`, `Hostel_Category`, `Hostel_Status`, `Hostel_Distance`, `Hostel_Type`, `Available_Rooms`, `user_id`, `Mess_id`, `Address`)
                            VALUES ('$capacity','$Hname', '$category', '$Status','$distance','$Type','$availRooms','$rector','$mess','$address')");
        header('location: table-basic.php');
    }


    if (isset($_GET['edit'])) {
		$id = $_GET['edit'];
		$update = true;
		$record = mysqli_query($db, "SELECT * FROM tblhostel WHERE Hostel_id=$id");

		if ($record->num_rows == 1 ) {
			$n = mysqli_fetch_array($record);
			$Hname = $n['Hostel_Name'];
            $category = $n['Hostel_Category'];
			$capacity = $n['Capacity'];
            $availRooms = $n['Available_Rooms'];
            $rector = $n['user_id'];
            $mess = $n['Mess_id'];
            $address = $n['Address'];
            $distance= $n['Hostel_Distance'];
            $Type= $n['Hostel_Type'];
            $Status= $n['Hostel_Status'];
		}
	}

    if (isset($_POST['HostelUpdate'])) {
        $id = $_POST['id'];
        $Hname = $_POST['Name'];
        $category = $_POST['category'];
        $capacity = $_POST['Capacity'];
        $availRooms = $_POST['AvailRooms'];
        $rector = $_POST['Rector'];
        $mess = $_POST['Messchief'];
        $address = $_POST['Address'];
        $distance= $_POST['Distance'];
        $Type= $_POST['Type'];
        $Status= $_POST['Status'];

        mysqli_query($db, "UPDATE `tblhostel` SET `Capacity`='$capacity',`Hostel_Name`='$Hname',`Hostel_Category`='$category',`Hostel_Status`='$Status',`Hostel_Distance`='$distance',`Hostel_Type`='$Type',`Available_Rooms`='$availRooms',`user_id`='$rector',`Mess_id`='$mess',`Address`='$address' WHERE Hostel_id=$id");
        header('location: table-basic.php');
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
    <title>Dormzz - Mess Corner</title>
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
                                <i class="mdi mdi-account"></i>
                                <span class="hide-menu">Profile</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="form-basic.php"
                                aria-expanded="false">
                                <i class="mdi mdi-gamepad"></i>
                                <span class="hide-menu">Users</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="table-basic.php"
                                aria-expanded="false">
                                <i class="mdi mdi-silverware-variant"></i>
                                <span class="hide-menu">Hostels</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="icon-material.php"
                                aria-expanded="false">
                                <i class="mdi mdi-currency-inr"></i>
                                <span class="hide-menu">Packages</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="starter-kit.php"
                                aria-expanded="false">
                                <i class="mdi mdi-panda"></i>
                                <span class="hide-menu">Roles</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="starter-kit.php"
                                aria-expanded="false">
                                <i class="mdi mdi-comment-alert-outline"></i>
                                <span class="hide-menu">Feedback</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="../../../../logout.php"
                                aria-expanded="false">
                                <i class="mdi mdi-logout-variant"></i>
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
                        <h4 class="page-title">Hostels Panel</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Hostels Panel</li>
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
                                <h4 class="card-title">Hostels</h4>
                                <h6 class="card-subtitle">Manage Hostels
                                    <!-- <code>.table</code>-based tables look in Bootstrap. All table styles are inherited
                                    in Bootstrap 4, meaning any nested tables will be styled in the same manner as the
                                    parent. -->
                                </h6>
                                <h6 class="card-title mt-5"><i
                                        class="me-1 font-18 mdi mdi-numeric-1-box-multiple-outline"></i><a href="table-basic.php?add">Add Hostel</a></h6>
                                
                                <?php if (isset($_GET['add'])) { ?>
                                    
                                    <form action="" method="post" class="form-horizontal mt-4">
                                        <input type="hidden" name="id" value="<?php echo $id; ?>">
                                        <div class="form-group">
                                            <label>Hostel Name</label>
                                            <input type="text" name="Name" class="form-control" value="<?php echo $Hname; ?>" placeholder="Hostel Name">
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Category</label>
                                            <select name="category" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="Girls" selected>Girls</option>
                                                <option value="Boys">Boys</option>
                                                <option value="Both">Both</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Capacity</label>
                                            <input type="text" name="Capacity" class="form-control" value="<?php echo $capacity; ?>" placeholder="Capacity">
                                        </div>
                                        <div class="form-group">
                                            <label>Available Rooms</label>
                                            <input type="text" name="AvailRooms" class="form-control" value="<?php echo $availRooms; ?>" placeholder="Available Rooms">
                                        </div>
                                        <div class="form-group">
                                            <label>Rector</label>
                                            <input type="text" name="Rector" id="example-email" value="<?php echo $rector; ?>" class="form-control" placeholder="Rector">
                                        </div>
                                        <div class="form-group">
                                            <label>Mess Chief</label>
                                            <input type="text" name="Messchief" class="form-control" value="<?php echo $mess; ?>" placeholder="Mess Chief">
                                        </div>
                                        <div class="form-group">
                                            <label>Address</label>
                                            <input type="text" name="Address" class="form-control" value="<?php echo $address; ?>" placeholder="Address">
                                        </div>
                                        <div class="form-group">
                                            <label>Distance</label>
                                            <input type="text" name="Distance" class="form-control" value="<?php echo $distance; ?>" placeholder="Hostel Distance">
                                        </div>
                                        <div class="form-group">
                                            <label>Location Type</label>
                                            <select name="Type" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="In Campus" selected>In Campus</option>
                                                <option value="Off Campus">Off Campus</option>
                                                <option value="PG">PG</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Status</label>
                                            <select name="Status" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="Available" selected>Available</option>
                                                <option value="Fast Filling">Fast Filling</option>
                                                <option value="Full">Full</option>
                                                <option value="Not Available">Not Available</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                                <div class="col-sm-12">
                                                    <button type="submit" name="AddHostel" class="btn btn-success text-white">Add</button>
                                                </div>
                                            </div>
                                    </form>

                                    <?php unset($_GET['edit']); } ?>
                                
                                <h6 class="card-title mt-5"><i
                                        class="me-1 font-18 mdi mdi-numeric-2-box-multiple-outline"></i> Available Hostels</h6>
                                
                                    <?php if (isset($_GET['edit'])) { ?>
                                    
                                        <form action="" method="post" class="form-horizontal mt-4">
                                        <input type="hidden" name="id" value="<?php echo $id; ?>">
                                        <div class="form-group">
                                            <label>Hostel Name</label>
                                            <input type="text" name="Name" class="form-control" value="<?php echo $Hname; ?>" placeholder="Hostel Name">
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Category</label>
                                            <select name="category" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="Girls" <?php if($category=="Girls"){?> selected <?php } ?> >Girls</option>
                                                <option value="Boys" <?php if($category=="Boys"){?> selected <?php } ?> >Boys</option>
                                                <option value="Both" <?php if($category=="Both"){?> selected <?php } ?> >Both</option>
                                                <option value="Other" <?php if($category=="Other"){?> selected <?php } ?>>Other</option>
                                            </select>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label>Capacity</label>
                                            <input type="text" name="Capacity" class="form-control" value="<?php echo $capacity; ?>" placeholder="Capacity">
                                        </div>
                                        <div class="form-group">
                                            <label>Available Rooms</label>
                                            <input type="text" name="AvailRooms" class="form-control" value="<?php echo $availRooms; ?>" placeholder="Available Rooms">
                                        </div>
                                        <div class="form-group">
                                            <label>Rector</label>
                                            <input type="text" name="Rector" id="example-email" value="<?php echo $rector; ?>" class="form-control" placeholder="Rector">
                                        </div>
                                        <div class="form-group">
                                            <label>Mess Chief</label>
                                            <input type="text" name="Messchief" class="form-control" value="<?php echo $mess; ?>" placeholder="Mess Chief">
                                        </div>
                                        <div class="form-group">
                                            <label>Address</label>
                                            <input type="text" name="Address" class="form-control" value="<?php echo $address; ?>" placeholder="Address">
                                        </div>
                                        <div class="form-group">
                                            <label>Distance</label>
                                            <input type="text" name="Distance" class="form-control" value="<?php echo $distance; ?>" placeholder="Hostel Distance">
                                        </div>
                                        <div class="form-group">
                                            <label>Location Type</label>
                                            <select name="Type" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="In Campus" selected>In Campus</option>
                                                <option value="Off Campus">Off Campus</option>
                                                <option value="PG">PG</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label>Status</label>
                                            <select name="Status" class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                                <option value="Available" <?php if($Status=="Available"){?> selected <?php } ?> >Available</option>
                                                <option value="Fast Filling" <?php if($Status=="Fast Filling"){?> selected <?php } ?> >Fast Filling</option>
                                                <option value="Full" <?php if($Status=="Full"){?> selected <?php } ?> >Full</option>
                                                <option value="Not Available" <?php if($Status=="Not Available"){?> selected <?php } ?> >Not Available</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                                <div class="col-sm-12">
                                                    <button type="submit" name="AddHostel" class="btn btn-success text-white">Add</button>
                                                </div>
                                            </div>
                                    </form>

                                    <?php unset($_GET['edit']); } ?>

                                    <div class="table-responsive">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">No.</th>
                                                        <th scope="col">Name</th>
                                                        <th scope="col">Capacity</th>
                                                        <th scope="col">Available Rooms</th>
                                                        <th scope="col">Rector</th>
                                                        <th scope="col">Mess Chief</th>
                                                        <th scope="col">Address</th>
                                                        <th scope="col">Distance</th>
                                                        <th scope="col">Type</th>
                                                        <th scope="col">Status</th>
                                                        <th scope="col" colspan=2>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                <?php $record = mysqli_query($db, "SELECT * FROM `tblhostel`;"); ?>
                                                <?php    
                                                    $num=1;
                                                    while ($row = mysqli_fetch_array($record)) 
                                                    { ?>
                                                        <tr>
                                                        <th scope="row"><?php echo $num; $num=$num+1; ?></th>
                                                            <td><?php echo $row['Hostel_Name']; ?></td>
                                                            <td><?php echo $row['Capacity']; ?></td>
                                                            <td><?php echo $row['Available_Rooms']; ?></td>
                                                            <td><?php echo $row['user_id']; ?></td>
                                                            <td><?php echo $row['Mess_id']; ?></td>
                                                            <td><?php echo $row['Address']; ?></td>
                                                            <td><?php echo $row['Hostel_Distance']; ?></td>
                                                            <td><?php echo $row['Hostel_Type']; ?></td>
                                                            <td><?php echo $row['Hostel_Status']; ?></td>
                                                            <td><a href="table-basic.php?edit=<?php echo $row['Hostel_id']; ?>">Edit</a></td>
                                                            <td><a href="table-basic.php?del=<?php echo $row['Hostel_id']; ?>">Delete</a></td>
                                                        </tr>
                                                        <?php } ?>
                                                </tbody>
                                            </table>
                                        </div>
                                
                                <!-- <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">First</th>
                                                <th scope="col">Last</th>
                                                <th scope="col">Handle</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th scope="row">1</th>
                                                <td>Mark</td>
                                                <td>Otto</td>
                                                <td>@mdo</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">2</th>
                                                <td>Jacob</td>
                                                <td>Thornton</td>
                                                <td>@fat</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">3</th>
                                                <td>Larry</td>
                                                <td>the Bird</td>
                                                <td>@twitter</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <h6 class="card-title"><i
                                        class="me-1 font-18 mdi mdi-numeric-2-box-multiple-outline"></i> Table Without
                                    Outside Padding</h6>
                            </div>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">First</th>
                                            <th scope="col">Last</th>
                                            <th scope="col">Handle</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td>@mdo</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">2</th>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>@fat</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">3</th>
                                            <td>Larry</td>
                                            <td>the Bird</td>
                                            <td>@twitter</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Table Header</h4>
                                <h6 class="card-subtitle">Similar to tables, use the modifier classes .thead-light to
                                    make <code>&lt;thead&gt;</code>s appear light.</h6>
                            </div>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead class="table-light">
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">First</th>
                                            <th scope="col">Last</th>
                                            <th scope="col">Handle</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td>@mdo</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">2</th>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>@fat</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">3</th>
                                            <td>Larry</td>
                                            <td>the Bird</td>
                                            <td>@twitter</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Striped rows</h4>
                                <h6 class="card-subtitle">Use <code>.table-striped</code> to add zebra-striping to any
                                    table row within the <code>&lt;tbody&gt;</code>.</h6>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">First</th>
                                            <th scope="col">Last</th>
                                            <th scope="col">Handle</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td>@mdo</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">2</th>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>@fat</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">3</th>
                                            <td>Larry</td>
                                            <td>the Bird</td>
                                            <td>@twitter</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Boredered Table</h4>
                                <h6 class="card-subtitle">Add <code>.table-bordered</code> for borders on all sides of
                                    the table and cells.</h6>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">First</th>
                                            <th scope="col">Last</th>
                                            <th scope="col">Handle</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td>@mdo</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">2</th>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>@fat</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">3</th>
                                            <td colspan="2">Larry the Bird</td>
                                            <td>@twitter</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Hoverable Rows</h4>
                                <h6 class="card-subtitle">Add <code>.table-hover</code> to enable a hover state on table
                                    rows within a <code>&lt;tbody&gt;</code>.</h6>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">First</th>
                                            <th scope="col">Last</th>
                                            <th scope="col">Handle</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>Mark</td>
                                            <td>Otto</td>
                                            <td>@mdo</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">2</th>
                                            <td>Jacob</td>
                                            <td>Thornton</td>
                                            <td>@fat</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">3</th>
                                            <td colspan="2">Larry the Bird</td>
                                            <td>@twitter</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Contextual Table</h4>
                                <h6 class="card-subtitle">Use contextual classes to color table rows or individual
                                    cells.</h6>
                            </div>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Class</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="table-active">
                                            <th scope="row">Active</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Default</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr class="table-primary">
                                            <th scope="row">Primary</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Secondary</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr class="table-success">
                                            <th scope="row">Success</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Danger</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr class="table-danger">
                                            <th scope="row">Warning</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Info</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr class="table-info">
                                            <th scope="row">Light</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Dark</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Table With Caption</h4>
                                <h6 class="card-subtitle">A <code>&lt;caption&gt;</code> functions like a heading for a
                                    table. It helps users with screen readers to find a table and understand what it’s
                                    about and decide if they want to read it.</h6>
                                <div class="table-responsive">
                                    <table class="table">
                                        <caption>List of users</caption>
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">First</th>
                                                <th scope="col">Last</th>
                                                <th scope="col">Handle</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th scope="row">1</th>
                                                <td>Mark</td>
                                                <td>Otto</td>
                                                <td>@mdo</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">2</th>
                                                <td>Jacob</td>
                                                <td>Thornton</td>
                                                <td>@fat</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">3</th>
                                                <td>Larry</td>
                                                <td>the Bird</td>
                                                <td>@twitter</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Responsive tables</h4>
                                <h6 class="card-subtitle">Responsive tables allow tables to be scrolled horizontally
                                    with ease. Make any table responsive across all viewports by wrapping a
                                    <code>.table</code> with <code>.table-responsive</code>. Or, pick a maximum
                                    breakpoint with which to have a responsive table up to by using
                                    <code>.table-responsive{-sm|-md|-lg|-xl}</code>.</h6>
                            </div>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                            <th scope="col">Heading</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">2</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">3</th>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                            <td>Cell</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="table-responsive mt-3">
                                <table class="table table-bordered table-responsive-lg">
                                    <thead>
                                        <tr>
                                            <th scope="col">#</th>
                                            <th scope="col">Table header</th>
                                            <th scope="col">Table header</th>
                                            <th scope="col">Table header</th>
                                            <th scope="col">Table header</th>
                                            <th scope="col">Table header</th>
                                            <th scope="col">Table header</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row">1</th>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">2</th>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">3</th>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                            <td>Table cell</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">Breakpoint Specific</h4>
                                <h6 class="card-subtitle">Use <code>.table-responsive{-sm|-md|-lg|-xl}</code> as needed
                                    to create responsive tables up to a particular breakpoint. From that breakpoint and
                                    up, the table will behave normally and not scroll horizontally.</h6>
                                <div class="table-responsive-sm">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th scope="row">1</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">2</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">3</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="table-responsive-md">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th scope="row">1</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">2</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">3</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="table-responsive-lg">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th scope="row">1</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">2</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">3</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="table-responsive-xl">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                                <th scope="col">Heading</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th scope="row">1</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">2</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                            <tr>
                                                <th scope="row">3</th>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div> -->
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
                <a href="http://www.utu.ac.in/bmiit" target="_blank">BMIITIANS</a>..
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