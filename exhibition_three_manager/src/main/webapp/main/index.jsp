<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Exhibition Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/circle.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        
        <style>
       	  	table {text-align: center;}
        	#manager_div{width: 100px; height: 100px; background-color: white; border-radius: 100px; margin-left: 50px;}
        	#manager_name{margin-left: 30%; margin-top: 10px; width: 100px; color:white; font-weight: bold;}
        	hr {width:200px; margin: 0px auto; margin-top:10px;}
        	.member_tab {width:600px; border-spacing: 10px;}
        	th {color: #868B8E; margin-right: 10%; font-weight: normal; border-bottom: 1px solid #868B8E; border-top: 1px solid #868B8E;
        	 font-size: 15px; height: 50px;
        	}
   			
        </style>
          <script type="text/javascript">
        const numb = document.querySelector(".number");
        let counter = 0;
        setInterval(() => {
          if(counter == 100 ){
            clearInterval();
          }else{
            counter+=1;
            numb.textContent = counter + "%";
          }
        }, 80);
        </script>
        </head>
        </head>
 <body class="sb-nav-fixed">
 <%
if(session.getAttribute("admin_id")==null){
	response.sendRedirect("login.jsp");
}
%>
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.jsp">Exhibition Admin</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <div class="input-group">
                    <input class="form-control" type="text" placeholder="Search for..." aria-label="Search for..." aria-describedby="btnNavbarSearch" />
                    <button class="btn btn-primary" id="btnNavbarSearch" type="button"><i class="fas fa-search"></i></button>
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="settings.jsp">Settings</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="login.jsp">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
						<div id="manager_div"><img src="../assets/img/Profile-PNG-Clipart.png" style="width:100px; margin-left: 0px;"/></div>
							<div id="manager_name">
								<%=session.getAttribute("admin_id") %>
							</div>
							<hr/>
                          <div class="sb-sidenav-menu-heading">MEMBERS</div>
                            <a class="nav-link collapsed" href="admin_member.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i>
                                </div>
                               	회원 관리

                            </a>
                          <div class="sb-sidenav-menu-heading">EXHIBITIONS</div>
                            <a class="nav-link collapsed" href="ex_schedule.jsp" >
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                전시 일정관리
                            </a>
                            <a class="nav-link collapsed" href="ex_loc.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                전시장 관리
                            </a>
                            <div class="sb-sidenav-menu-heading">BOOKING</div>
                            <a class="nav-link" href="booking.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                예약 관리
                            </a>
                            <div class="sb-sidenav-menu-heading">BOARD</div>
                            <a class="nav-link" href="member.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                게시판 관리
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        Authentication
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="login.html">Login</a>
                                            <a class="nav-link" href="register.html">Register</a>
                                            <a class="nav-link" href="password.html">Forgot Password</a>
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseError" aria-expanded="false" aria-controls="pagesCollapseError">
                                        Error
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="401.html">401 Page</a>
                                            <a class="nav-link" href="404.html">404 Page</a>
                                            <a class="nav-link" href="500.html">500 Page</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                      
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
						<%=session.getAttribute("admin_id") %>
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Dashboard</h1>                        
                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                        회원 관리
                                    </div>
                                    <div class="card-body">
                                     <table class="member_tab" >
                                    	<tr>
                                    		<th>총 회원수</th>
                                    		<th>오늘 가입 회원수</th>
                                    	</tr>
                                    	<tr>
                                    		<td style="padding-left: 14%;">
                                    		<div class="circular" style=" margin-top:70px;">
										    <div class="inner"></div>
										    <div class="number">100명</div>
										    <div class="circle">
										      <div class="bar left">
										        <div class="progress"></div>
										      </div>
										      <div class="bar right">
										        <div class="progress"></div>
										      </div>
										    </div>
										  </div>
                                    		</td>
                                    		<td style="padding-left: 20%;">
                                    		<div class="circular" style=" margin-top:70px;">
										    <div class="inner"></div>
										    <div class="number">3명</div>
										    <div class="circle">
										      <div class="bar left">
										        <div class="progress"></div>
										      </div>
										      <div class="bar right">
										        <div class="progress"></div>
										      </div>
										    </div>
										  </div>
                                    		</td>
                                    	</tr>
                                    </table>
                                    <canvas id="myAreaChart" width="100%" height="40"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6" >
                                <div class="card mb-4">
                                    <div class="card-body">
                                    <div id="admin"></div>
                                    <canvas id="myAreaChart" width="100%" height="40"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                       전시
                                    </div>
                                    <div class="card-body">
                                      <table class="member_tab">
                                    	<tr>
                                    		<th>전시 일정 수</th>
                                    		<th>마감된 전시 일정</th>
                                    		<th>내일 마감 전시</th>
                                    	</tr>
                                    	<tr>
                                    		<td>5건</td>
                                    		<td>2건</td>
                                    		<td>3건</td>
                                    	</tr>
                                    </table>
                                    <canvas id="myBarChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                        추가관리
                                    </div>
                                    <div class="card-body">
                                     <table id="addon" cellspacing="10px">
                                    	<tr>
                                    		<th>예약:</h>
                                    		<td width="20%">N건</td>
                                    		<td width="10%"></td>
											<th>내일 마감될 전시 예정건</th>
                                    		<td width="20%">N건</td>
                                    	</tr>
                                    	<tr>
                                    		<th>오늘의 예약건수:</th>
                                    		<td width="20%">N건</td>
                                    		<td width="10%"></td>
											<th>신규 회원</th>
                                    		<td width="20%">N건</td>
                                    	</tr>
                                    	
                                    </table>
                                    <canvas id="myAreaChart" width="100%" height="40"></canvas>
                                    </div>
                                </div>
                            </div>
                            
                            </div>
                    </div>
                </main>
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2022</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>
