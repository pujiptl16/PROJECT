
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
                <a href="student_dash_index.jsp" class="logo">
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
                      <!--  
                      <div class="wrapper">
      					<div class="search-input">
      						<a href="" target="_blank" hidden></a>
		                        <div class="icon"><i class="fas fa-search"></i></div>
		                        <input type="text" id="search" name="search" class="form-control" placeholder="Search &amp; enter">
			                        <a class="srh-btn">
			                            <i class="ti-close"></i>
			                        </a>
			                        <div class="autocom-box">
									</div>
						 		
							</div>
						</div> -->
						
						    <div class="wrapper">
							  <div class="search-input">
							    <a href="" target="_blank" hidden></a>
							    <input type="text" placeholder="Type to search..">
							    <a class="srh-btn">
			                            <i class="ti-close"></i>
		                        </a>
		                        <div class="autocom-box">
							      <!-- here list are inserted from javascript -->
							    </div>
							    <div class="icon"><i class="fas fa-search"></i></div>
							  </div>
							</div>
							
							<script src="../../../js/script.js"></script>
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
                        <img src="<%= session.getAttribute("ProfilePic") %>" alt="user" class="rounded-circle" width="31" height="31">
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
<script type="text/javascript">

	//Disable back button after form submission
	history.pushState(null, null, location.href);
	window.onpopstate = function () {
		history.go(1);
	};

	//Disable Right Click
    document.addEventListener("contextmenu", function(e){
        e.preventDefault();
    }, false);
</script>

