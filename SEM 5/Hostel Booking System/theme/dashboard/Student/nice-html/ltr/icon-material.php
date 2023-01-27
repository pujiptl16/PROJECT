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
    $id = $_SESSION['userid'];
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
    <title>Dormzz - Room Map</title>
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
    <style>
        .movie-container {
        margin: 20px 0;
        }

        .movie-container select {
        background-color: #fff;
        border: 0;
        border-radius: 5px;
        font-size: 14px;
        margin-left: 10px;
        padding: 5px 15px 5px 15px;
        -moz-appearance: none;
        -webkit-appearance: none;
        appearance: none;
        }

        .moviebox {
        width:50%;
        height:350px; 
        padding:10px;
        perspective: 1000px;
        margin-bottom: 30px;
        }

        .hostelbox{
            padding:50px;
            height:100%;
            width:50%;
        }
        .room-map{
            border-radius:30px;
            height:100%;
            width: 80%;
            padding: 10px;
            margin: auto; 
            box-shadow: rgba(0, 0, 0, 0.45) 0px 25px 20px -20px;
        }

        .booking{
            display:flex;
            place-items:center;

        }

        .movie-row{
        display: flex;  
        justify-content: center;
        align-items: center;
        }

        .seat {
        background-color: #c9c9c9;
        height: 15px;
        width: 25px;
        margin: 5px;
        border-radius: 2px;
        }
        .seat.whiteseat{
        background-color: #ffffff;
        }

        .seat.staffuse{
        background-color: #e65656;
        }

        .seat.selected {
        background-color: #6feaf6;
        }

        .seat.occupied {
        background-color: #444451;
        }

        .seat:nth-of-type(2) {
        margin-right: 18px;
        }

        .seat:nth-last-of-type(2) {
        margin-left: 18px;
        }

        .seat:not(.occupied,.whiteseat,.staffuse):hover {
        cursor: pointer;
        transform: scale(1.2);
        }

        .showcase .seat:not(.occupied,.whiteseat,.staffuse):hover {
        cursor: default;
        transform: scale(1);
        }

        .showcase {
        background-color: rgba(0, 0, 0, 0.1);
        padding: 10px 10px;
        border-radius: 10px;
        color: rgb(58, 58, 58);
        list-style-type: none;
        display: flex;
        justify-content: space-between;
        }

        .showcase li {
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 10px;
        }

        .showcase li small {
        margin-left: 10px;
        }

        .movie-row {
        display: flex;
        }

        .screen {
        background-color: #fff;
        height: 40px;
        width: 40px;
        border-radius: 50%;
        margin: 15px auto 30px;
        box-shadow: 0 3px 10px rgba(255, 255, 255, 0.75);
        }

        p.text {
        margin: 5px 0;
        }

        p.text span {
        color: #444451;
        }

    </style>
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
                        <h4 class="page-title">Room Panel</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Room Panel</li>
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
                                <h4 class="card-title">Payment Panel</h4>
                                <h5 class="card-subtitle">Book Room</h5>
                                <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-1-box-multiple-outline"></i>Your Package Detaiils</h6>
                            
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">Package Name</th>
                                                <th scope="col">Hostel Name</th>
                                                <th scope="col">Room Number</th>
                                                <th scope="col">Floor</th>
                                                <th scope="col">Amount Paid</th>
                                                <th scope="col">Purchase Date</th>
                                                <th scope="col">Due Date</th>
                                                <th scope="col">Download Receipt</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php
                                            $record=mysqli_query($db, "SELECT b.Package_Name, d.Hostel_Name, a.Room_id, c.Trn_Amount, a.Timestamp_Check_In, a.Timestamp_Check_Out from tblhostel_record a 
                                            LEFT JOIN tblpackage b on a.Package_id=b.Package_id
                                            LEFT JOIN tbltransaction c on a.Trn_id=c.Trn_id
                                            LEFT JOIN tblhostel d on a.Hostel_id=d.Hostel_id
                                            where a.user_id='$id';");
                                            
                                            if($record->num_rows==0){
                                                ?>
                                                
                                                <tr>
                                                    <td scope="col" colspan=8><center>No Information Found / Kindly Purchase a Package.</center></td>
                                                    
                                                </tr>
                                                <?php
                                            }else{
                                                $row = mysqli_fetch_assoc($record);
                                                $Floor=substr($row['Room_id'], 3, 2);
                                                $Room=substr($row['Room_id'], -2);
                                                ?>
                                                <td scope="col"><?php echo $row['Package_Name']; ?></td>
                                                <td scope="col"><?php echo $row['Hostel_Name']; ?></td>
                                                <td scope="col">Room Number</td>
                                                <td scope="col">Floor</tD>
                                                <td scope="col"><?php echo $row['Trn_Amount']; ?></td>
                                                <td scope="col"><?php echo $row['Timestamp_Check_In']; ?></td>
                                                <td scope="col"><?php echo $row['Timestamp_Check_Out']; ?></td>
                                                <td scope="col"><a href='icon-material.php?download'>Download</a></td>
                                                <?php
                                            }
                                            ?>
                                        </tbody>
                                    </table>
                                </div>
                                <?php
                                    if($record->num_rows == 0){   
                                ?>
                                <h6 class="card-title mt-5"><i class="me-1 font-18 mdi mdi-numeric-2-box-multiple-outline"></i> Available Packages
                                </h6>

                                <ul class="showcase">
                                    <li>
                                        <div class="seat"></div>
                                        <small>Available</small>;
                                    </li>

                                    <li>
                                        <div class="seat selected"></div>
                                        <small>Selected</small>
                                    </li>

                                    <li>
                                        <div class="seat occupied"></div>
                                        <small>Occupied</small>
                                    </li>

                                    <li>
                                        <div class="seat staffuse"></div>
                                        <small>Staff use only</small>
                                    </li>
                                </ul>
                                <div class="booking">
                                    <div class="hostelbox">
                                        <form method='POST' action='payout.php' class="form-horizontal form-material mx-2" id="RoomMapForm">
                                            <div class="form-group">
                                                <label>Pick a Package</label>
                                                <div class="col-sm-12">
                                                    <input type='hidden' name='PackagePrice' id='PackagePrice' value="1">
                                                    <input type='hidden' name='RoomIndex' id='RoomIndex' value="">
                                                    <select name="package" id="package" class="form-select shadow-none form-control-line" required>
                                                        <option value="" selected disabled>Select a Package</option>
                                                        <?php $record = mysqli_query($db, "SELECT * FROM `tblpackage`;"); ?>
                                                        <?php    
                                                            while ($row = mysqli_fetch_array($record)) 
                                                            { ?>
                                                                <option value="<?php echo $row['Package_id']; ?>"><?php echo $row['Package_Name']; ?></option>
                                                        <?php } ?>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>Hostel Name</label>
                                                <select name="hostelName" id="hostelName" class="form-select shadow-none form-control-line" required>
                                                    <option value="" selected disabled>Select a Hostel</option>

                                                    <?php $record = mysqli_query($db, "SELECT * FROM `tblhostel`;"); ?>
                                                    <?php
                                                        while ($row = mysqli_fetch_array($record)) 
                                                        { 
                                                            $gender = $row['Hostel_Category'];
                                                            if($gender == $_SESSION['gender'] && ($row['Hostel_Status']=="Available" || $row['Hostel_Status']=="Fast Filling")){
                                                                $hosteldata = sprintf("%s || %s/%s || %s",$row['Hostel_Name'],$row['Available_Rooms'],$row['Capacity'],$row['Hostel_Distance']);
                                                        ?>
                                                            <option value="<?php echo $row['Hostel_id']; ?>"><?php echo $hosteldata; ?></option>
                                                        <?php } 
                                                    } ?>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                            <label>Floor</label>
                                                <select name="HostelFloor" id="HostelFloor" class="form-select shadow-none form-control-line" required>
                                                </select>
                                            </div>
                                            <div class="form-group" style="justify-content:center; text-align:center; display:flex;">
                                                <div class="col-sm-12" style="width:20%;">
                                                    <button type='submit' name="NextMap" class="btn btn-success text-white" onclick="VerifyRoomSelection()">Next</button>
                                                </div>
                                                <div class="col-sm-12" style="width:20%;">
                                                    <button type='submit' name="CancelMap" class="btn btn-success text-white">Cancel</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="moviebox">
                                        <div class="room-map" id="room-map">
                                        </div>
                                        <p class="text" style="text-align:center; margin:4%;">
                                            You have selected <strong> <span id="count">0</span> </strong> Room for a price of <strong> ₹ <span id="total">0</span> /-</strong>
                                        </p>
                                    </div>
                                </div>
                                <?php } ?>
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
    <script>
        const container = document.querySelector('.moviebox');
        const seats = document.querySelectorAll('.movie-row .seat:not(.occupied');
        const count = document.getElementById('count');
        const total = document.getElementById('total');
        const movieSelect = document.getElementById('package');
        const Price = document.getElementById('PackagePrice');
        const HostelSelect = document.getElementById('hostelName');
        const FloorSelect = document.getElementById('HostelFloor');
        

        let ticketPrice = +movieSelect.value;

        // update total and count
        function updateSelectedCount() {
        const selectedSeats = document.querySelectorAll('.movie-row .seat.selected');

        const seatsIndex = [...selectedSeats].map((seat) => [...seats].indexOf(seat));

        const selectedSeatsCount = selectedSeats.length;

        const RoomPrice = +Price.value;

        count.innerText = selectedSeatsCount;
        total.innerText = selectedSeatsCount * RoomPrice;

        var id = document.getElementById('package');
        let package_id = +id.value;
                $.ajax({
                    url: "package.php",
                    type: "POST",
                    data: { package_id: package_id },
                    cache: false,
                    success: function(result){
                        $("#PackagePrice").val(result); 
                    }
                });
        }

        movieSelect.addEventListener('mouseleave', (e) => {
        ticketPrice = +e.target.value;
        updateSelectedCount();
        });

        HostelSelect.addEventListener('mouseleave', (e) => {
        ticketPrice = +e.target.value;
        updateSelectedCount();
        });

        FloorSelect.addEventListener('mouseleave', (e) => {
        ticketPrice = +e.target.value;
        updateSelectedCount();
        });
        // Seat click event
        container.addEventListener('click', (e) => {
            if(document.getElementById('package').value != ""){
                if(document.querySelectorAll('.movie-row .seat.selected').length<1){
                    if (e.target.classList.contains('seat') && !e.target.classList.contains('occupied') && !e.target.classList.contains('whiteseat') && !e.target.classList.contains('staffuse')) {
                        e.target.classList.toggle('selected');
                        updateSelectedCount();
                        const seatsIndex = +[...(document.querySelectorAll('.movie-row .seat.selected'))].map((seat) => [...(document.querySelectorAll('.movie-row .seat:not(.occupied'))].indexOf(seat));
                        $("#RoomIndex").val(seatsIndex);   
                    }
                }
                else{
                    if (e.target.classList.contains('selected'))
                    {
                        e.target.classList.remove('selected');
                    }
                    else{
                        alert("You can select only one Room.");
                    }
                    updateSelectedCount();
                }
            }else{
                alert('Please Select a Package First.');
            }
        });

        // intial count and total
        updateSelectedCount();
        
        $(document).ready(function() {
            $('#hostelName').on('change', function() {
                var hostel_id = this.value;
                $.ajax({
                    url: "FindHostelFloor.php",
                    type: "POST",
                    data: { hostel_id: hostel_id },
                    cache: false,
                    success: function(result){
                        $("#HostelFloor").html(result);
                    }
                });
            }); 
        });

        $('#HostelFloor').on('change', function() {
            const id = document.getElementById('hostelName');
            var hostel_id = id.value;
            var HostelFloor = this.value;
            $.ajax({
                url: "room-map-fetcher.php",
                type: "POST",
                data: { hostel_id: hostel_id,
                    HostelFloor: HostelFloor },
                cache: false,
                success: function(result){
                    $("#room-map").html(result);
                }
            });
        });

        $("form").on("submit", function (e) {
            if(document.querySelectorAll('.movie-row .seat.selected').length<1){
                alert('Kindly Select a Room First.');
                e.preventDefault();
                return false;
            }
        });

    </script>
</body>

</html>