<%@ page language="java" pageEncoding="UTF-8"%>

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
		// out.println("<script>student_dash_index.jsp'</script>");
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
    <title>Dormzz - Student Mess Panel</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/niceadmin-lite/" />
    <link rel="shortcut icon" type="image/x-icon" href="../../../../images/favicon.png" />
    <!-- Favicon icon 
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    -->
    <!-- Custom CSS -->
    <link href="../../dist/css/style.min.css" rel="stylesheet">
    <link href="../../../SearchStyle.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
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
                                        <%
										    String id = (String) session.getAttribute("userid");
										    String dishIds = "";
										    ResultSet record = null;
										    
										        record = con.createStatement().executeQuery("SELECT b.Hostel_Name, b.Mess_id, c.Mess_Name, c.user_id, d.FirstName, d.LastName, e.Dish_id from tblhostel_record a LEFT JOIN tblhostel b ON a.Hostel_id=b.Hostel_id LEFT JOIN tblmess c ON b.Mess_id=c.Mess_id LEFT JOIN tblregister d ON c.user_id=d.user_id LEFT JOIN tblmess_menu e ON c.MessMenu_id=e.MessMenu_id where a.user_id='" + id + "' and a.User_Status !='InActive'");
										        if (!record.next()) {
										%>
										            <tr>
										                <td colspan=8><center>No Information Found. / Kindly Purchase a Package.</center></td>
										            </tr>
										<%
										        } else {
										            int num = 1;
										            do {
										                dishIds = record.getString("Dish_id");
										%>
										                <tr>
										                    <td scope="row"><%= record.getString("Hostel_Name") %></td>
										                    <td scope="row"><%= record.getString("Mess_Name") %></td>
										                    <td scope="row"><%= (record.getString("FirstName")==null || record.getString("LastName") == null) ? "N.A" : record.getString("FirstName") + " " + record.getString("LastName") %></td>
										                    <td scope="row">7:30 AM - 10:00 PM</td>
										                </tr>
										<%
										            } while (record.next());
										        }
										%>

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
                                        <%
											if(dishIds == null || dishIds.isEmpty()){
											%>
											    <tr>
											        <td colspan="8"><center>Menu is not assigned yet.</center></td>
											    </tr>
											<%
											}else{
											    String data = dishIds;
											    String[] dataArray = data.split(":");
											    List<String[]> out1 = new ArrayList<String[]>();
											    int step = 0;
											    //out.println(Arrays.toString(dataArray));
											    for (String item : dataArray) {
											        String[] valueArray = item.split(",");
											        String[] row = new String[valueArray.length];
											        for (int i = 0; i < valueArray.length; i++) {
											            row[i] = valueArray[i];
											        }
											        out1.add(row);
											        //out.println("<br>"+Arrays.toString(row));
											    }
												// out.println("<br>"+Arrays.toString(out1));
											    
												int[] lengths = out1.stream().mapToInt(i -> i.length).toArray();
											    int min_m = Arrays.stream(lengths).min().getAsInt();
											    int max_m = Arrays.stream(lengths).max().getAsInt();
											    
											    //out.println("<br>"+Arrays.toString(lengths));
											    //out.println("<br>"+ min_m + " " + max_m);
											    int num = 1;
											    int index = 0;
											    while(num <= max_m){ 
											%>
											        <tr>
											            <td><%=num%></td>
											            <% 
											            if(num <= lengths[0]){ %>
											                <td>
											                    <% 
											                    int i = index;
											                    if(i < out1.get(0).length){
												                    id = out1.get(0)[i];
												                    record = con.createStatement().executeQuery("SELECT * FROM `tbldish` WHERE Dish_id='" + id + "';");
												                    if(record.next()) {
												                        String dish = record.getString("DishName");
												                        out.println(dish);
												                    }
											                    }
											                    %>
											                </td>
											            <% }else{ %>
											                <td></td>
											            <% }
											            if (num <= lengths[1]) { %>
											                <td>
											                    <% 
											                    //int i = lengths[0]+index;
											                    int i = index;
											                    if(i < out1.get(1).length){
											                    	id = out1.get(1)[i];
											                    	//out.println(i +" "+ id +" "+ out1.get(1).length);
											                    	record = con.createStatement().executeQuery("SELECT * FROM `tbldish` WHERE Dish_id='" + id + "';");
												                    if(record.next()) {
												                        String dish = record.getString("DishName");
												                        out.println(dish);
												                    }
											                    }
											                    %>
											                </td>
											            <% }else{ %>
											                <td></td>
											            <% }
											            if (num <= lengths[2]) { %>
											            <td>
											                <% 
											                //int i = lengths[0] + lengths[1] + index;
											                int i = index;
											                if (i < out1.get(2).length) {
											                    id = out1.get(2)[i];
											                    record = con.createStatement().executeQuery("SELECT * FROM `tbldish` WHERE Dish_id='" + id + "';");
											                    if (record.next()) {
											                        String dish = record.getString("DishName");
											                        out.println(dish);
											                    }
											                }
											                %>
											            </td>
											        <% } else { %>
											            <td></td>
											        <% }
											            if (num <= lengths[3]) { %>
											                <td>
											                    <% 
											                    //int i = lengths[0]+lengths[1]+lengths[2]+index;
											                    int i = index;
											                    if(i < out1.get(3).length){
											                    	id = out1.get(3)[i];										                    
												                    record = con.createStatement().executeQuery("SELECT * FROM `tbldish` WHERE Dish_id='" + id + "';");
												                    if(record.next()) {
												                        String dish = record.getString("DishName");
												                        out.println(dish);
												                    }
											                    }
											                    %>
											                </td>
											            <% }else{ %>
											                <td></td>
											            <% } %>
											        </tr>
											    <% 
											        num = num + 1;
											        index = index + 1;
											    } 
											}%>

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