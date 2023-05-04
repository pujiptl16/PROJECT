<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>
<%@include file="../../../../HBSScripts.jsp" %>
<%
	session = request.getSession(true);
	String username = (String)session.getAttribute("username");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Expires","0");
	response.setDateHeader("Expires",-1);

  Connection conn = con;
  Statement stmt = null;
  ResultSet rs = null;

  String id = session.getAttribute("userid").toString();
  String email = session.getAttribute("Email").toString();
  String contact = session.getAttribute("Phone").toString();
  String pid = "";
  String hid = "";
  String roomid = "";
  String roomFloor = "";
  String PackageName = "";
  String HostelName = "";
  String amount = "";
  boolean flag=false;
  
  
    if (session.getAttribute("username") == null || session.getId().equals("")) {
      //session.setAttribute("username", username);
      response.sendRedirect("../../../../form/login.php");
    } else {

    
      if (request.getParameter("CancelMap") != null) {
          request.removeAttribute("NextMap");
          request.removeAttribute("CancelPayment");
          out.println("<script>location.href='icon-material.jsp'</script>");
      }

      if (request.getParameter("NextMap") != null) {
        roomid = request.getParameter("RoomIndex");
        roomFloor = request.getParameter("HostelFloor");
        pid = request.getParameter("package");
        hid = request.getParameter("hostelName");

        String query = "SELECT * FROM `tblpackage` where Package_id=?";
        PreparedStatement pstmt = conn.prepareStatement(query);
        pstmt.setString(1, pid);
        rs = pstmt.executeQuery();

        while (rs.next()) {
          PackageName = rs.getString("Package_Name");
          amount = rs.getString("Package_Price");
        }

        query = "SELECT * FROM `tblhostel` where Hostel_id=?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, hid);
        rs = pstmt.executeQuery();

        while (rs.next()) {
          HostelName = rs.getString("Hostel_Name");
        }
        request.removeAttribute("NextMap");
      } else {
    	  out.println("<script>location.href='icon-material.jsp'</script>");
      }

      
      if (request.getParameter("CancelPayment") != null) {
        request.removeAttribute("NextMap");
        request.removeAttribute("CancelPayment");
        out.println("<script>location.href='icon-material.jsp'</script>");
      }
    }

%>

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
    <link href="../../../SearchStyle.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
    <!-- Favicon icon 
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    -->
    <!-- Custom CSS -->
    <link href="../../dist/css/style.min.css" rel="stylesheet">
    
        	<script>
  // Disable back button after form submission
  history.pushState(null, null, location.href);
  window.onpopstate = function () {
      history.go(1);
  };
</script>
    
      	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js"></script>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js" rel="stylesheet">
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
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
                       <%@include file="../../../HeaderFile.jsp" %>
        <!-- ============================================================== -->
        <!-- End Topbar header -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Left Sidebar - style you can find in sidebar.scss  -->
        <!-- ============================================================== -->
                
        <%@include file="StudentMenuFile.jsp" %>
        
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
                                        <input type="hidden" name="sid" id="sid" value="<%= id %>">
                                        <input type="hidden" name="semail" id="semail" value="<%= email %>">
                                        <input type="hidden" name="scontact" id="scontact" value="<%= contact %>">
                                        <input type="hidden" name="pid" id="pid" value="<%= pid %>">
                                        <input type="hidden" name="hid" id="hid" value="<%= hid %>">
                                        <input type="hidden" name="rid" id="rid" value="<%= roomid %>">
                                        <input type="hidden" name="floor" id="floor" value="<%= roomFloor %>">
                                        <div class="form-group">
                                                <label>Enrollment No.</label>
                                                <input type="text" name="EnNo" id="EnNo" class="form-control" value="<%= session.getAttribute("EnNo") %>" placeholder="Enrollment number" required readonly>
                                            </div>
                                            
                                            <div class="form-group">
                                                <label>Name</label>
                                                <input type="text" name="Name" id="Name" class="form-control" value="<%= session.getAttribute("FirstName") %>" placeholder="Name" required readonly>
                                            </div>

                                            <div class="form-group">
                                                <label>Hostel Name</label>
                                                <input type="text" name="HostelName" id="HostelName" class="form-control" value="<%= HostelName %>" placeholder="Hostel Name" required readonly>
                                            </div>
                                            
                                            <div class="list-group list-group-horizontal" style="justify-content:space-between;">
                                                <div class="form-group">
                                                    <label>Package</label>
                                                    <input type="text" name="PackageName" id="PackageName" class="form-control" value="<%= PackageName %>" placeholder="Package Name" required readonly>
                                                </div>
                                                <div class="form-group" style="margin-left:2%">
                                                    <label>Amount</label>
                                                    <input type="text" name="PackageAmount" id="PackageAmount"class="form-control" value="<%= amount %>" placeholder="Package Amount" required readonly>
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
                        url: "PayoutConfirmed.jsp",
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
                        	showSwal("PaymentSuccess");
                            //alert('Payment Successful. Thank You for choosing Dormzz.');
                            //location.href='icon-material.jsp';
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

<script type="text/javascript">
    document.addEventListener("contextmenu", function(e){
        e.preventDefault();
    }, false);
</script>

</body>

</html>