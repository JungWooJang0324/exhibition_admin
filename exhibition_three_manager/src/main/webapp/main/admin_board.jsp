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
		<!-- jQuery CDN -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
  		
        
        <style>
        	#manager_div{width: 100px; height: 100px; background-color: white; border-radius: 100px; margin-left: 50px;}
        	#manager_name{margin-left: 60px; margin-top: 10px; width: 100px; color:white; font-weight: bold;}
        	hr {width:200px; margin: 0px auto; margin-top:10px;}
        	#btnAddDiv{ text-align: right; margin-bottom: 100px}
        	#inputDiv{width: 80%; margin: 0px auto; margin-bottom: 30px}
        	#searchDate{ margin-bottom: 10px}
        	.modalTab{width: 500px; }
			.modalTh{font-size: 12px; color: #B2B2B2; padding-left: 20px; padding-right: 20px; padding-top: 20px }
			.modalTd{height: 40px; vertical-align: top; padding-left: 20px; padding-right: 20px}
        </style>
<script type="text/javascript">
$(function(){
	$("#btnAdd").click(function(){
		location.href="admin_add_post.jsp";
	});
});

</script> 
        </head>
 <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">Exhibition Admin</a>
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
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
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
                            <a class="nav-link collapsed" href="admin_hall.jsp">
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
                        <h1 class="mt-4" style="width: 90%; font-weight: bold;margin: 0px auto;">게시판 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"></li>
                        </ol>
                        <div id="inputDiv">
                        	<input id="searchDate" type="date" /><br>
                        	<input type="text">
                        	<input type="text" placeholder="내용을 입력해주세요">
                        
                        
                        </div>
                        <div class="card-content" style="width: 80%; margin: 0px auto">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="hallTables" style="text-align: center;">
                                    <thead>
                                        <tr>
                                            <th>글번호</th>
                                            <th>제목</th>
                                            <th>작성자</th>
                                            <th>작성일</th>
                                            <th>카테고리</th>
                                            <th>관리</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr class="odd gradeX">
                                            <td>1</td>
                                            <td><a href="#void">글제목</a></td>
                                            <td>김작성</td>
                                            <td>2022-04-06</td>
                                            <td>Q&A</td>
                                            <td><button type="button" class="btn btn-secondary btn-sm">삭제</button></td>
                                        </tr>
                                      </tbody>
                                   </table>
                                 </div>
                                 <div class="btnAdd" id="btnAddDiv">
                                 	<button type="button" class="btn btn-primary btn-lg" id="btnAdd">글쓰기</button>
								</div>
                               </div>
                               <div id="space"></div>
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
								    <li class="page-item"><a class="page-link" href="#">4</a></li>
								    <li class="page-item">
								      <a class="page-link" href="#">></a>
								    </li>
								  </ul>
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
                <!-- 게시글 내용 Modal -->
				<div class="modal fade" id="boardDetail" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">게시글 내용</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
					 	<table class="modalTab">
					 		<tr>
					 			<th class="modalTh">글 번호</th><th class="modalTh" style="width: 200px">수정/작성 일자</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd ">글 번호</td><td class="modalTd "><input type="date" class="inputBox"/></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">제목</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd ">안녕하세요</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">작성자</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd ">홍길동</td>
					 		</tr>
					 		<tr>
					 			<th class="modalTh">카테고리</th><th class="modalTh">카테고리 번호</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd ">
									<select class="inputBox">
										<option>후기</option>
										<option>QnA</option>
									</select>
								</td>
								<td class="modalTd ">1</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">글 내용</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd ">홍길동</td>
					 		</tr>
					 	</table>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">돌아가기</button>
				        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModify">게시글 수정</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 게시글 수정 확인 모달  -->
				<div class="modal fade" id="confirmModify" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        게시글을 수정하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
            </div>
        </div>
    </body>
</html>
