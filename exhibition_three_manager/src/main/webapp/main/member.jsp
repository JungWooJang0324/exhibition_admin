<%@page import="java.sql.SQLException"%>
<%@page import="VO.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="DAO.AdminMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Exhibition Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
      
        <style>
        	#manager_div{width: 100px; height: 100px; background-color: white; border-radius: 100px; margin-left: 50px;}
        	#manager_name{margin-left: 30%; margin-top: 10px; width: 100px; color:white; font-weight: bold;}
        	hr {width:200px; margin: 0px auto; margin-top:10px;}
        	.member_tab {width:100%; border-spacing: 10px;  text-align: center;}
        	th {background-color: #EEEDE7; font-weight: bold; text-align: center;}
        	.member_tab th {background-color: #EEEDE7; font-size: 20px; font-weight: bold;}
        	.modalTab th {width:100%;}
        	#addon td {text-align: right; }
   			.circle {
   				margin-left:30%;
   				margin-top: 10%;
	            width: 120px;
	            height: 120px;
	            line-height: 120px;
	            -moz-border-radius: 50%;
	            border-radius: 50%;
	            border: solid 3px #1464F4;
	            background-color: #ffffff;
	            color: #1464F4;
	            text-align: center;
	            display: block;
	        }
        </style>
        
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        
        <script type="text/javascript">
        $(function() {
			$(".userId").click(function() {
				var el= document.getElementById("userId").getAttribute('data-value');
				<% AdminMemberDAO dao= new AdminMemberDAO();
				
				%>
			});
		}); //read
        
        </script>
</head>
<body class="sb-nav-fixed">
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
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
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
								관리자 이름
							</div>
							<hr/>
                          <div class="sb-sidenav-menu-heading">MEMBERS</div>
                            <a class="nav-link collapsed" href="member.jsp">
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
                        Start Bootstrap
                    </div>
                </nav>
            </div>
            
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">회원관리</h1>
                        
                        <div class="row">
                        
 				<div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                회원
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple" class="member_tab">
                                    <thead>
                                    <tr>
                                    	<th>USERID</th>
                                    	<th>NAME</th>
                                    	<th>ISUBSCRIBE_DATE</th>
                                    </tr>
                                    </thead>
    								<tbody>
    						 		<%
    						 		AdminMemberDAO amDAO = new AdminMemberDAO();
    						 		try {
	    						 		List<MemberVO> list = amDAO.selectAllMember();
	    						 		for(MemberVO mv: list){
	    						 		%>
	    						 		<tr>
	    						 			<td><%=mv.getUserId() %></td>
	    						 			<td><a href="#" data-bs-toggle="modal" id="userId" data-bs-target="#memberDetail" class="userId" data-value="<%=mv.getUserId()%>"><%=mv.getName() %></a></td>
	    						 			<td><%=mv.getIsubscribeDate()%></td>
	    						 		</tr>
	    						 		<% }
	    						 		
	    						 		}catch(SQLException e) {
	    									e.printStackTrace();
	    						 		}%>
									</tbody>
                                </table>
                            </div>
                        </div>
                        
                        <!-- 페이지 이동 -->                            
                            <div id="pageNavigation">
							  <ul class="pagination justify-content-center">
							    <li class="page-item disabled">
							      <a class="page-link" href="#" tabindex="-1"><</a>
							    </li>
							    <li class="page-item"><a class="page-link" href="#">1</a></li>
							     <li class="page-item active">
							      <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
							    </li>
							    <li class="page-item"><a class="page-link" href="#">3</a></li>
							    <li class="page-item">
							      <a class="page-link" href="#">></a>
							    </li>
							  </ul>
							</div>
                             <canvas id="myAreaChart" width="100%" height="40"></canvas>
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
                    
                    <div class="modal fade" id="memberDetail" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">회원 상세</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
					 	<table class="modalTab" style="width: 98%; border: 1px solid #333; ">
					 		<tr>
					 			<th colspan="2" class="modalTh">회원 id</th>
					 		</tr>
					 		<tr>
					 			<td id="id" class="modalTh">ㅑㅇ</td>
					 		</tr>
					 		
					 		<tr>
					 			<th colspan="2" class="modalTh">회원 명</th>
					 		</tr>
				 			<tr>
					 			<td id="memberName" class="modalTh">이름</td>
					 		</tr>
					 		
					 		<tr>
					 			<th class="modalTh" colspan="2" >상세주소</th>
					 		</tr>
					 		<tr>
					 			<td id="address1" class="modalTh">서울시 강남구</td>
					 		</tr>
							<tr>
					 			<td id="address2" class="modalTh">역삼동...</td>
							</tr>
					 		<tr>
					 			<th class="modalTh">우편번호</th>
					 		</tr>
							<tr>
					 			<td id="zipcode" class="modalTh">zipcode</td>
							</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">전화번호</th>
					 		</tr>
					 		<tr>
					 			<td id="tel" class="modalTh">Tel</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">가입일</th>
					 		</tr>
					 		<tr>
					 			<td id="subDate" class="modalTh">subscribe Date</td>
					 		</tr>
					 	</table>
				      </div>
				      </div></div></div>
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