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
    echo "<script>student_dash_index.php'</script>";
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
    <title>Dormzz - Student Dashboard</title>
    <link rel="shortcut icon" type="image/x-icon" href="../../../../images/favicon.png" />
    <link rel="canonical" href="https://www.wrappixel.com/templates/niceadmin-lite/" />
    <!-- Favicon icon -->
    <!-- <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    Custom CSS -->
    <link href="../../assets/libs/chartist/dist/chartist.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="../../dist/css/style.min.css" rel="stylesheet">
    <link href="../../dist/css/hostel.css" rel="stylesheet">
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
                                <span class="hide-menu">My Clubs</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="table-basic.php"
                                aria-expanded="false">
                                <i class="mdi mdi-silverware-variant"></i>
                                <span class="hide-menu">Mess</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="icon-material.php"
                                aria-expanded="false">
                                <i class="mdi mdi-currency-inr"></i>
                                <span class="hide-menu">Payment</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="starter-kit.php"
                                aria-expanded="false">
                                <i class="mdi mdi-panda"></i>
                                <span class="hide-menu">Leave</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="CRC.php"
                                aria-expanded="false">
                                <i class="mdi mdi-comment-alert-outline"></i>
                                <span class="hide-menu">Complain / Request</span>
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
                        <h4 class="page-title"><?php echo $_SESSION['FirstName'];?>'s Dashboard</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
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
                <div class="row">
                    <!-- column -->
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-title">List of Hostels</h4>
                            </div>
                            
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">No.</th>
                                            <th scope="col">Name</th>
                                            <th scope="col">Capacity</th>
                                            <th scope="col">Address</th>
                                            <th scope="col">Distance</th>
                                            <th scope="col">Type</th>
                                            <th scope="col">Status</th>
                                            <th scope="col">Book</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <?php $record = mysqli_query($db, "SELECT * FROM `tblhostel`;"); ?>
                                    <?php    
                                        $num=1;
                                        while ($row = mysqli_fetch_array($record)) 
                                        { 
                                            $gender = $row['Hostel_Category'];
                                            if($gender == $_SESSION['gender']){
                                        ?>
                                            
                                            <tr>
                                            <th scope="row"><?php echo $num; $num=$num+1; ?></th>
                                                <td><?php echo $row['Hostel_Name']; ?></td>
                                                <td><?php echo $row['Capacity']; ?></td>
                                                <td><?php echo $row['Address']; ?></td>
                                                <td><?php echo $row['Hostel_Distance']; ?></td>
                                                <td><?php echo $row['Hostel_Type']; ?></td>
                                                <td><?php if($row['Hostel_Status']=="Available") { ?> <span class="label label-success label-rounded"> <?php echo $row['Hostel_Status']; }
                                                        elseif($row['Hostel_Status']=="Fast Filling") { ?> <span class="label label-info label-rounded"> <?php echo $row['Hostel_Status']; }
                                                        elseif($row['Hostel_Status']=="Full") { ?> <span class="label label-danger label-rounded"> <?php echo $row['Hostel_Status']; } ?></td>
                                                <td><a href="table-basic.php?edit=<?php echo $row['Hostel_id']; ?>" class="label label-primary label-custom">SELECT</a></td>
                                            </tr>
                                            <?php } 
                                        } ?>
                                    </tbody>
                                </table>
                            </div>

                            <!-- <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th class="border-top-0">NAME</th>
                                            <th class="border-top-0">STATUS</th>
                                            <th class="border-top-0">DISTANCE</th>
                                            <th class="border-top-0">TYPE</th>
                                            <th class="border-top-0">BOOK</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>

                                            <td class="txt-oflo">PUSHPAM TARSADIA GIRLS HOSTEL</td>
                                            <td><span class="label label-success label-rounded">AVAILABLE</span></td>
                                            <td class="txt-oflo">150 METERS</td>
                                            <td><span class="font-medium">IN CAMPUS</span></td>
                                            <td><a href="" class="label label-primary label-custom">SELECT</a></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">KABIR BOYS HOSTEL</td>
                                            <td><span class="label label-danger label-rounded">FULL</span></td>
                                            <td class="txt-oflo">100 METERS</td>
                                            <td><span class="font-medium">IN CAMPUS</span></td>
                                            <td><a href="" class="label label-primary label-custom">SELECT</a></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">LAXMI WORKING WOMENS HOSTEL</td>
                                            <td><span class="label label-success label-rounded">AVAILABLE</span></td>
                                            <td class="txt-oflo">1 KM</td>
                                            <td><span class="font-medium">OUT CAMPUS</span></td>
                                            <td><a href="" class="label label-primary label-custom">SELECT</a></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">SHAKTI BOYS HOSTEL</td>
                                            <td><span class="label label-success label-rounded">AVAILABLE</span></td>
                                            <td class="txt-oflo">8 KM</td>
                                            <td><span class="font-medium">OUT CAMPUS</span></td>
                                            <td><a href="" class="label label-primary label-custom">SELECT</a></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">BLUE STAR BOYS HOSTEL</td>
                                            <td><span class="label label-info label-rounded">FAST FILLING</span></td>
                                            <td class="txt-oflo">11 KM</td>
                                            <td><span class="font-medium">OUT CAMPUS</span></td>
                                            <td><a href="" class="label label-primary label-custom">SELECT</a></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">GAYATRI GIRLS HOSTEL</td>
                                            <td><span class="label label-success label-rounded">AVAILABLE</span> </td>
                                            <td class="txt-oflo">5 KM</td>
                                            <td><span class="font-medium">OUT CAMPUS</span></td>
                                            <td><a href="" class="label label-primary label-custom">SELECT</a></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">OBEROI BOYS HOSTEL</td>
                                            <td><span class="label label-success label-rounded">AVAILABLE</span> </td>
                                            <td class="txt-oflo">11 KM</td>
                                            <td><span class="font-medium">OUT CAMPUS</span></td>
                                            <td><a href="" class="label label-primary label-custom">SELECT</a></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">MOHINI GIRLS HOSTEL</td>
                                            <td><span class="label label-success label-rounded">AVAILABLE</span> </td>
                                            <td class="txt-oflo">1 KM</td>
                                            <td><span class="font-medium">OUT CAMPUS</span></td>
                                            <td><a href="" class="label label-primary label-custom">SELECT</a></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">AATMIYA BOYS HOSTEL</td>
                                            <td><span class="label label-danger label-rounded">FULL</span> </td>
                                            <td class="txt-oflo">5 KM</td>
                                            <td><span class="font-medium">PG</span></td>
                                            <td><a href="" class="label label-primary label-custom">SELECT</a></td>
                                        </tr>
                                        <tr>

                                            <td class="txt-oflo">PUROHIT GIRLS HOSTEL</td>
                                            <td><span class="label label-success label-rounded">AVAILABLE</span> </td>
                                            <td class="txt-oflo">8 KM</td>
                                            <td><span class="font-medium">PG</span></td>
                                            <td><a href="" class="label label-primary label-custom">SELECT</a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div> -->
                        </div>
                    </div>
                </div>
                <!-- ============================================================== -->
                <!-- Recent comment and chats -->
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
    <!--This page JavaScript -->
    <!--chartis chart-->
    <script src="../../assets/libs/chartist/dist/chartist.min.js"></script>
    <script src="../../assets/libs/chartist-plugin-tooltips/dist/chartist-plugin-tooltip.min.js"></script>
    <script src="../../dist/js/pages/dashboards/dashboard1.js"></script>
</body>

</html>