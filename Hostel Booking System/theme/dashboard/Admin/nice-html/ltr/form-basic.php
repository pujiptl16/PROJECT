<?php
session_start();
$db = mysqli_connect('localhost', 'root', '', 'dormz');
$update = false;
$fname="";
$lname="";
$EnNo="";
$email="";
$department="";
$phone="";
$password="";
$username="";
$gender="";

if(session_id()=="" || !isset($_SESSION['username'])) 
{
	$_SESSION['username'] = $username;
	echo "<script>location.href='../../../../form/login.php'</script>";
}
else
{
    //echo "<script>form-basic.php'</script>";
    if (isset($_GET['del'])) {
        $id = $_GET['del'];
        $query = "DELETE FROM tblregister WHERE user_id='$id'";
        mysqli_query($db, $query);
        $_SESSION['message'] = "User Deleted Successfully."; 
        header('location: form-basic.php');
    }
    

	if (isset($_GET['edit'])) {
		$id = $_GET['edit'];
		$update = true;
		$record = mysqli_query($db, "SELECT * FROM tblregister WHERE user_id=$id");

		if ($record->num_rows == 1 ) {
			$n = mysqli_fetch_array($record);
			$fname = $n['FirstName'];
			$lname = $n['LastName'];
            $EnNo = $n['EnrollmentNo'];
            $email = $n['Email'];
            $department = $n['DepartmentName'];
            $phone = $n['PhoneNo'];
            $username = $n['Username'];
            $gender = $n['Gender'];
		}
	}
    
    if (isset($_POST['StudUpdate'])) {
        $id = $_POST['id'];
        $fname = $_POST['Fname'];
        $lname = $_POST['Lname'];
        $EnNo = $_POST['EnNo'];
        $email = $_POST['Email'];
        $department = $_POST['Department'];
        $phone = $_POST['Phone'];
        $username = $_POST['Username'];
        $password = $_POST['Password'];
        $gender = $_POST['Gender'];
        $hash_pass = password_hash($password, PASSWORD_DEFAULT);
        $record = mysqli_query($db, "SELECT * FROM tblregister WHERE Username='$username';");
        $row = mysqli_fetch_assoc($record);
        $did = $id;
        if($record->num_rows != 0) {
            $did = $row['user_id'];
        }

		if($record->num_rows <= 1 && $did == $id)
		{
            if (filter_var($email, FILTER_VALIDATE_EMAIL))
            {
                mysqli_query($db, "UPDATE tblregister SET FirstName='$fname', LastName='$lname', Username='$username',`Password`='$hash_pass', EnrollmentNo='$EnNo', Email='$email', DepartmentName='$department', Gender='$gender', PhoneNo='$phone' WHERE user_id=$id");
                $_SESSION['message'] = "User Updated Successfully.";
                unset($_GET['StudUpdate']);
                header('location: form-basic.php');
            }
            else{
				echo"<script>alert('Invalid Email Address.')</script>";
			}
        }
        else
		{
			echo"<script>alert('Username is Taken. Please Use different username.')</script>";
		}
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
    <title>Dormzz - User Panel</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/niceadmin-lite/" />
    <link rel="shortcut icon" type="image/x-icon" href="../../../../images/favicon.png" />
    <!-- Favicon icon 
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    -->
    <link href="../../dist/css/style.min.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->

<script>
        function isNumber(evt) {
                evt = (evt) ? evt : window.event;
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                        return false;
                }
                return true;
        }

        function checkDelete(){
                return confirm('Are you sure?');
        }
</script>

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
                            <a class="sidebar-link waves-effect waves-dark sidebar-link" href="feedback.php"
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
                        <h4 class="page-title">User Panel</h4>
                    </div>
                    <div class="col-7 align-self-center">
                        <div class="d-flex align-items-center justify-content-end">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="#">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">User Panel</li>
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
                        <div class="card card-body">
                            <h4 class="card-title">User Analytics</h4>
                            <h5 class="card-subtitle"> Manage Users</h5>
                            
                            <?php if (isset($_GET['edit'])) { ?>
                            
                            <form action="" method="post" class="form-horizontal mt-4">
                                <input type="hidden" name="id" value="<?php echo $id; ?>">
                                <div class="form-group">
                                    <label>First Name</label>
                                    <input type="text" name="Fname" class="form-control" value="<?php echo $fname; ?>" placeholder="First Name" required>
                                </div>
                                <div class="form-group">
                                    <label>Last Name</label>
                                    <input type="text" name="Lname" class="form-control" value="<?php echo $lname; ?>" placeholder="Last Name" required>
                                </div>
                                <div class="form-group">
                                    <label>Enrollment Number</label>
                                    <input type="text" name="EnNo" class="form-control" value="<?php echo $EnNo; ?>" placeholder="Enrollment No." required>
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" name="Email" id="example-email" value="<?php echo $email; ?>" class="form-control" placeholder="Email" required>
                                </div>
                                <div class="form-group">
                                    <label>Username</label>
                                    <input type="text" name="Username" class="form-control" value="<?php echo $username; ?>" placeholder="Username" required>
                                </div>
                                <div class="form-group">
                                    <label>Password</label>   
                                    <input type="password" name="Password" value="" class="form-control" Placeholder="Password" required>
                                </div>
                                <div class="form-group">
                                    <label>Department</label>
                                    <input type="text" name="Department" class="form-control" value="<?php echo $department; ?>" placeholder="Department" required>
                                </div>
                                <div class="form-group">
                                    <label>Gender</label>
                                    <select name="Gender"  class="form-control" required>
                                        <option value="Boys" <?php if($gender == "Boys") { ?> selected <?php } ?> >Male</option>
                                        <option value="Girls"  <?php if($gender == "Girls") { ?> selected <?php } ?> >Female</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Phone No.</label>
                                    <input type="text" name="Phone" class="form-control" value="<?php echo $phone; ?>" placeholder="Phone No." required>
                                </div>
                                <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="submit" name="StudUpdate" class="btn btn-success text-white">Update</button>
                                        </div>
                                    </div>
                            </form>

                            <?php unset($_GET['edit']); } ?>
                            <div class="table-responsive">
                                <div class="comment-widgets" style="height:650px;">
                                    <table class="table">
                                    <?php if (isset($_SESSION['message'])): ?>
                                                
                                                <tr scope="col" <?php if($_SESSION['message'] == 'User Deleted Successfully.'){ ?> class="table-danger" <?php } else { ?> class="table-success" <?php } ?>>
                                                    <th colspan='9'>
                                                            <center>
                                                            <?php
                                                                    echo $_SESSION['message'];
                                                                    
                                                                    $_SESSION['flag']++;

                                                                    if($_SESSION['flag'] > 1){
                                                                            unset($_SESSION['message']);
                                                                            $_SESSION['flag'] = 0;
                                                                    }
                                                                          
                                                            ?>
                                                            </center>
                                                    </th>
                                                </tr>
                                            
                                            <?php endif ?>
                                        <thead>
                                            <tr style=" position: -webkit-sticky; position: sticky;top: 0; z-index: 1; background: #fff;">
                                                <th scope="col">No.</th>
                                                <th scope="col">Name</th>
                                                <th scope="col">Enrollment No.</th>
                                                <th scope="col">Email</th>
                                                <th scope="col">Department</th>
                                                <th scope="col">Hostel</th>
                                                <th scope="col">Phone No.</th>
                                                <th scope="col" colspan=2>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <?php $record = mysqli_query($db, "SELECT * FROM tblregister"); ?>
                                        <?php    
                                            $num=1;
                                            while ($row = mysqli_fetch_array($record)) 
                                            { ?>
                                                <tr>
                                                <th scope="row"><?php echo $num; $num=$num+1; ?></th>
                                                    <td><?php echo $row['FirstName']." ".$row['LastName']; ?></td>
                                                    <td><?php echo $row['EnrollmentNo']; ?></td>
                                                    <td><?php echo $row['Email']; ?></td>
                                                    <td><?php echo $row['DepartmentName']; ?></td>
                                                    <td><?php echo "1"; ?></td>
                                                    <td><?php echo $row['PhoneNo']; ?></td>
                                                    <td><a href="form-basic.php?edit=<?php echo $row['user_id']; ?>">Edit</a></td>
                                                    <td><a href="form-basic.php?del=<?php echo $row['user_id']; ?>" onclick="return checkDelete()">Delete</a></td>
                                                </tr>
                                                <?php } ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                                


                                <!-- <form class="form-horizontal mt-4">
                                <div class="form-group">
                                    <label>Default Text <span class="help"> e.g. "George deo"</span></label>
                                    <input type="text" class="form-control" value="George deo...">
                                </div>
                                <div class="form-group">
                                    <label for="example-email">Email <span class="help"> e.g.
                                            "example@gmail.com"</span></label>
                                    <input type="email" id="example-email" name="example-email" class="form-control"
                                        placeholder="Email">
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <input type="password" class="form-control" value="password">
                                </div>
                                <div class="form-group">
                                    <label>Placeholder</label>
                                    <input type="text" class="form-control" placeholder="placeholder">
                                </div>
                                <div class="form-group">
                                    <label>Text area</label>
                                    <textarea class="form-control" rows="5"></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Read only input</label>
                                    <input class="form-control" type="text" placeholder="Readonly input here…" readonly>
                                </div>
                                <div class="form-group">
                                    <fieldset disabled>
                                        <label for="disabledTextInput">Disabled input</label>
                                        <input type="text" id="disabledTextInput" class="form-control"
                                            placeholder="Disabled input">
                                    </fieldset>
                                </div>
                                <div class="form-group row pt-3">
                                    <div class="col-sm-4">
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="customCheck1">
                                            <label class="form-check-label mb-0" for="customCheck1">Check this custom
                                                checkbox</label>
                                        </div>
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="customCheck2">
                                            <label class="form-check-label mb-0" for="customCheck2">Check this custom
                                                checkbox</label>
                                        </div>
                                        <div class="form-check">
                                            <input type="checkbox" class="form-check-input" id="customCheck3">
                                            <label class="form-check-label mb-0" for="customCheck3">Check this custom
                                                checkbox</label>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="form-check">
                                            <input type="radio" id="customRadio1" name="customRadio"
                                                class="form-check-input">
                                            <label class="form-check-label mb-0" for="customRadio1">Toggle this custom
                                                radio</label>
                                        </div>
                                        <div class="form-check">
                                            <input type="radio" id="customRadio2" name="customRadio"
                                                class="form-check-input">
                                            <label class="form-check-label mb-0" for="customRadio2">Toggle this custom
                                                radio</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Input Select</label>
                                    <select class="form-select shadow-none col-12" id="inlineFormCustomSelect">
                                        <option selected>Choose...</option>
                                        <option value="1">One</option>
                                        <option value="2">Two</option>
                                        <option value="3">Three</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Default file upload</label>
                                    <input type="file" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label>Custom File upload</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Upload</span>
                                        </div>
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="inputGroupFile01">
                                            <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Helping text</label>
                                    <input type="text" class="form-control" placeholder="Helping text">
                                    <span class="help-block"><small>A block of help text that breaks onto a new line and
                                            may extend beyond one line.</small></span> </div>
                            </form> -->
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