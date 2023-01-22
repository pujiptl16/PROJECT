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
    $id=$_SESSION['userid'];
    $email=$_SESSION['Email'];
    $contact=$_SESSION['Phone'];
    $pid="";
    $hid="";
    $roomid="";
    $roomFloor="";
    $PackageName="";
    $HostelName="";
    $amount="";

    if (isset($_POST['CancelMap'])) {
        unset($_POST['CancelMap']);
        header('location: icon-material.php');
    }

    if(isset($_POST['NextMap']))
    {
        $roomid=$_POST['RoomIndex'];
        $roomFloor=$_POST['HostelFloor'];
        $pid = $_POST['package'];
        $hid = $_POST['hostelName'];

        $record = mysqli_query($db, "SELECT * FROM `tblpackage` where Package_id='$pid';");
        
        while ($row = mysqli_fetch_array($record)) 
        {
            $PackageName = $row['Package_Name'];
            $amount = $row['Package_Price'];
        }

       
        $record = mysqli_query($db, "SELECT * FROM `tblhostel` where Hostel_id='$hid';");
        while ($row = mysqli_fetch_array($record)) 
        {
            $HostelName = $row['Hostel_Name'];
        }
        unset($_POST['NextMap']);
    }
    else{
        header('location: icon-material.php');
    }
    
    if (isset($_POST['CancelPayment'])) {
        unset($_POST['NextMap']);
        unset($_POST['CancelPayment']);
        header('location: icon-material.php');
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
                                
                                <div class="booking" >
                                    <div class="moviebox" style="height:500px;">
                                        <div class="room-map" id="room-map">
                                        <form method='POST' action='' class="form-horizontal form-material mx-2" id="RoomMapForm">
                                        <input type="hidden" name="sid" id="sid" value="<?php echo $id; ?>">
                                        <input type="hidden" name="semail" id="semail" value="<?php echo $email; ?>">
                                        <input type="hidden" name="scontact" id="scontact" value="<?php echo $contact; ?>">
                                        <input type="hidden" name="pid" id="pid" value="<?php echo $pid; ?>">
                                        <input type="hidden" name="hid" id="hid" value="<?php echo $hid; ?>">
                                        <input type="hidden" name="rid" id="rid" value="<?php echo $roomid; ?>">
                                        <input type="hidden" name="floor" id="floor" value="<?php echo $roomFloor; ?>">
                                        <div class="form-group">
                                                <label>Enrollment No.</label>
                                                <input type="text" name="EnNo" id="EnNo" class="form-control" value="<?php echo $_SESSION['EnNo']; ?>" placeholder="Enrollment number" required readonly>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label>Name</label>
                                                <input type="text" name="Name" id="Name" class="form-control" value="<?php echo $_SESSION['FirstName']." ".$_SESSION['LastName']; ?>" placeholder="Name" required readonly>
                                            </div>

                                            <div class="form-group">
                                                <label>Hostel Name</label>
                                                <input type="text" name="HostelName" id="HostelName" class="form-control" value="<?php echo $HostelName; ?>" placeholder="Hostel Name" required readonly>
                                            </div>
                                            
                                            <div class="list-group list-group-horizontal" style="justify-content:space-between;">
                                                <div class="form-group">
                                                    <label>Package</label>
                                                    <input type="text" name="PackageName" id="PackageName" class="form-control" value="<?php echo $PackageName; ?>" placeholder="Package Name" required readonly>
                                                </div>
                                                <div class="form-group" style="margin-left:2%">
                                                    <label>Amount</label>
                                                    <input type="text" name="PackageAmount" id="PackageAmount"class="form-control" value="<?php echo $amount; ?>" placeholder="Package Amount" required readonly>
                                                </div>
                                            </div>
                                            <div class="form-group" style="justify-content:center; text-align:center; display:flex;">
                                                <div class="col-sm-12" style="width:40%;">
                                                    <button type='submit' name="rzp-button1" id="rzp-button1" class="btn btn-success text-white"><i class="fas fa-money-bill"></i> Pay</button>
                                                </div>
                                                <div class="col-sm-12" style="width:40%;">
                                                    <button type='submit' name="CancelPayment" class="btn btn-success text-white">Cancel</button>
                                                </div>
                                            </div>
                                        </form>
                                        </div>
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
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script>
            const PackageAmount = document.getElementById('PackageAmount');
            const PackageName = document.getElementById('PackageName');
            const EnNo = document.getElementById('EnNo');
            const Name = document.getElementById('Name');
            const Email = document.getElementById('semail');
            const Phone = document.getElementById('scontact');
            const UserId = document.getElementById('sid');
            const HostelId = document.getElementById('hid');
            const PackageId = document.getElementById('pid');
            const RoomIndex = document.getElementById('rid');
            const Floor = document.getElementById('floor');

            var options = {
                "key": "rzp_test_XR1TJnbInghMfc", // Enter the Key ID generated from the Dashboard
                "amount": PackageAmount.value*100,
                "currency": "INR",
                "name": "Dormzz LTD",
                "description": "Package : "+PackageName.value,
                "image": "../../assets/images/logo.png",
                "prefill":
                {
                "email": Email.value,
                "contact": Phone.value,
                },
                "handler": function (response) {
                ///alert(response.razorpay_payment_id);
                $.ajax({
                        url: "PayoutConfirmed.php",
                        type: "POST",
                        data: { PaymentId: response.razorpay_payment_id,
                                UserId: UserId.value,
                                HostelId: HostelId.value,
                                PackageId: PackageId.value,
                                RoomIndex: RoomIndex.value,
                                Floor: Floor.value,
                                Amount: PackageAmount.value
                                },
                        cache: false,
                        success: function(result){
                            alert('Payment Successful. Thank You for choosing Dormzz.');
                            location.href='icon-material.php';
                        }
                    });
                },
                "modal": {
                "ondismiss": function () {
                    if (confirm("Are you sure, you want to close the form?")) {
                    txt = "You pressed OK!";
                    console.log("Checkout form closed by the user");
                    } else {
                    txt = "You pressed Cancel!";
                    console.log("Complete the Payment")
                    }
                }
                }
            };
            var rzp1 = new Razorpay(options);
            document.getElementById('rzp-button1').onclick = function (e) {
                rzp1.open();
                e.preventDefault();
            }
</script>

</body>

</html>