<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_id_session.jsp" %>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        
        <style>
       	  	table {text-align: center;}
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
	            
	          }
	        }, 80);
        </script>
        </head>
 <body class="sb-nav-fixed">
         <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="http://localhost/exhibition_three_manager/main/index.jsp">Exhibition Admin</a>
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
                        <li><a class="dropdown-item" href="http://localhost/exhibition_three_manager/main/settings.jsp">Settings</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="http://localhost/exhibition_three_manager/main/logout.jsp">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                     <jsp:include page="nav.jsp"/>
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
