<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<%@page import="java.math.*"%>
<%@page import="java.util.*"%>
<%@page import="com.HBS.*" %>
<%@include file="../../../../DBConnection.jsp" %>

<%
	session = request.getSession(true);
	String username = (String)session.getAttribute("username");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Expires","0");
	response.setDateHeader("Expires",-1);
	    
	if(session.getId() == null || session.getAttribute("username") == null){
		//session.setAttribute("username", username);
		out.println("<script>location.href='../../../../form/login.jsp'</script>");
	}else{
	    
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
        	<script>
  // Disable back button after form submission
  history.pushState(null, null, location.href);
  window.onpopstate = function () {
      history.go(1);
  };
</script>
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
                            
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                            	<th scope="col">No.</th>
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
                                           <%
                                           		String id = (String)session.getAttribute("userid");
											    String query = "SELECT a.User_Status, a.Room_id, a.Trn_id, a.Timestamp_Check_In, a.Timestamp_Check_Out, b.Package_Name, c.Trn_Amount, d.Hostel_Name FROM tblhostel_record a "
											            + "LEFT JOIN tblpackage b ON a.Package_id = b.Package_id "
											            + "LEFT JOIN tbltransaction c ON a.Trn_id = c.Trn_id "
											            + "LEFT JOIN tblhostel d ON a.Hostel_id = d.Hostel_id "
											            + "WHERE a.user_id = ?";
											    PreparedStatement statement = con.prepareStatement(query);
											    statement.setString(1, id);
											    ResultSet record = statement.executeQuery();
												boolean purchased = false;
												
											    if (!record.next()) {
											    	purchased = false;
											%>
											        <tr>
											            <td colspan="8"><center>No Information Found / Kindly Purchase a Package.</center></td>
											        </tr>
											<%
											    } else {
											    	int num=0;
											    	do {
											    		num++;
											    		if(record.getString("User_Status").equals("InActive")){
											    			purchased = false;
											    		}else if(record.getString("User_Status").equals("Active")){
											    			purchased = true;
											    		}
											    		//System.out.println(purchased);
											            String floor = record.getString("Room_id").substring(3, 5);
											            String room = record.getString("Room_id").substring(5);
											%>
												<tr>
														<th><%= num %></th>
											            <td><%= record.getString("Package_Name") %></td>
											            <td><%= record.getString("Hostel_Name") %></td>
											            <td><%= room %></td>
											            <td><%= floor %></td>
											            <td><%= record.getDouble("Trn_Amount") %></td>
											            <td><%= record.getString("Timestamp_Check_In") %></td>
											            <td><%= record.getString("Timestamp_Check_Out") %></td>
											            <td><a href='../../../../InvoiceDownloader?invoice_id=<%= record.getString("Trn_id") %>'>Download</a></td>
											   </tr>
											<%
											        } while (record.next());
											    }
											%>

                                        </tbody>
                                    </table>
                                </div>
									<%
									    if (!purchased) {
									    
									%>
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
                                        <form method='POST' action='payout.jsp' class="form-horizontal form-material mx-2" id="RoomMapForm">
                                            <div class="form-group">
                                                <label>Pick a Package</label>
                                                <div class="col-sm-12">
                                                    <input type='hidden' name='PackagePrice' id='PackagePrice' value="1">
                                                    <input type='hidden' name='RoomIndex' id='RoomIndex' value="">
                                                    <select name="package" id="package" class="form-select shadow-none form-control-line" required>
                                                        <option value="" selected disabled>Select a Package</option>
                                                        <%
														  PreparedStatement pstmt = null;
														  ResultSet rs = null;
														  String sql = "SELECT * FROM tblpackage";
														    pstmt = con.prepareStatement(sql);
														    rs = pstmt.executeQuery();
														    while (rs.next()) {
														%>
														      <option value="<%=rs.getString("Package_id")%>"><%=rs.getString("Package_Name")%></option>
														<%
														    }
														%>

                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label>Hostel Name</label>
                                                <select name="hostelName" id="hostelName" class="form-select shadow-none form-control-line" required>
                                                    <option value="" selected disabled>Select a Hostel</option>

                                                    <%
													    PreparedStatement stmt = null;
													    rs = null;
													    
													    query = "SELECT * FROM tblhostel";
													    stmt = con.prepareStatement(query);
													    rs = stmt.executeQuery();
													        
													        while (rs.next()) {
													            String gender = rs.getString("Hostel_Category");
													            if(gender.equals(session.getAttribute("gender")) && (rs.getString("Hostel_Status").equals("Available") || rs.getString("Hostel_Status").equals("Fast Filling"))){
													                String hosteldata = String.format("%s || %s/%s || %s", rs.getString("Hostel_Name"), rs.getString("Available_Rooms"), rs.getString("Capacity"), rs.getString("Hostel_Distance"));
													%>
													                <option value="<%= rs.getString("Hostel_id") %>"><%= hosteldata %></option>
													<%
													            }
													        }
													%>

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
                                            You have selected <strong> <span id="count">0</span> </strong> Room for a price of <strong> â¹ <span id="total">0</span> /-</strong>
                                        </p>
                                    </div>
                                </div>
                               <% }  %>
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
                    url: "package.jsp",
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
                    url: "FindHostelFloor.jsp",
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
                url: "room-map-fetcher.jsp",
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
    
    <script type="text/javascript">
    document.addEventListener("contextmenu", function(e){
        e.preventDefault();
    }, false);
</script>
</body>

</html>