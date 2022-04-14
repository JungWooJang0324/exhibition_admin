<%@page import="VO.ExhibitionVO"%>
<%@page import="DAO.AdminExhibitionDAO"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Exhibition Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <!-- jQuery CDN -->
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
 		<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
     	<style>
        	#manager_div{width: 100px; height: 100px; background-color: white; border-radius: 100px; margin-left: 50px;}
        	#manager_name{margin-left: 60px; margin-top: 10px; width: 100px; color:white; font-weight: bold;}
        	hr {width:200px; margin: 0px auto; margin-top:10px;}
        </style>
	<script type="text/javascript">
	$( function() {
		$( "#startDate" ).datepicker({
			  dateFormat: "yy-mm-dd",
			  dayNames: [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
			  dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
			  monthNamesShort: [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" ],
			  monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ]
			});
		$( "#endDate" ).datepicker({
			  dateFormat: "yy-mm-dd",
			  dayNames: [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
			  dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
			  monthNamesShort: [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" ],
			  monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ]
			});
	  } );
	 function exhibitionModalOpen(){
			$('#showModal').modal('show');	
		 
	 }//exhibitionModalOpen
		$(document).on('hidden.bs.modal', function (event) {

			if ($('.modal:visible').length) {

				$('body').addClass('modal-open');

			}

		});


	</script>  
    </head>
    <body class="sb-nav-fixed">
	<jsp:include page="admin_id_session.jsp"/>
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
                        <li><a class="dropdown-item" href="http://localhost/exhibition_three_manager/main/login.jsp">Logout</a></li>
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
                            <a class="nav-link collapsed" href="http://localhost/exhibition_three_manager/main/admin_member.jsp" >
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i>
                                </div>
                               	회원 관리

                            </a>
                          <div class="sb-sidenav-menu-heading">EXHIBITIONS</div>
                            <a class="nav-link collapsed" href="http://localhost/exhibition_three_manager/main/ex_schedule.jsp" style="background-color:#343a40">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                전시 일정관리
                            </a>
                            <a class="nav-link collapsed" href="http://localhost/exhibition_three_manager/main/hall.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                전시장 관리
                            </a>
                            <div class="sb-sidenav-menu-heading">BOOKING</div>
                            <a class="nav-link" href="http://localhost/exhibition_three_manager/main/booking.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                예약 관리
                            </a>
                            <div class="sb-sidenav-menu-heading">BOARD</div>
                            <a class="nav-link" href="http://localhost/exhibition_three_manager/main/board.jsp">
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
                                            <a class="nav-link" href="http://localhost/exhibition_three_manager/main/login.jsp">Login</a>
                                            <a class="nav-link" href="http://localhost/exhibition_three_manager/main/password.jsp">Forgot Password</a>
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
                        <h1 class="mt-4">전시 일정관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="http://localhost/exhibition_three_manager/main/index.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active">전시 일정관리</li>
                        </ol>
                        <div class="card mb-4">
                            <div class="card-body">
                            <!-- 회원 아이디 검색창 -->
                          <nav class="navbar navbar-expand-lg navbar-light bg-light">
							  <div class="container-fluid">
							    <a class="navbar-brand" href="#">Navbar</a>
							    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
							      <span class="navbar-toggler-icon"></span>
							    </button>
							    <div class="collapse navbar-collapse" id="navbarSupportedContent">
							      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
							        <li class="nav-item">
							          <a class="nav-link active" aria-current="page" href="#">Home</a>
							        </li>
							        <li class="nav-item">
							          <a class="nav-link" href="#">Link</a>
							        </li>
							        <li class="nav-item dropdown">
							          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							            Dropdown
							          </a>
							          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							            <li><a class="dropdown-item" href="#">Action</a></li>
							            <li><a class="dropdown-item" href="#">Another action</a></li>
							            <li><hr class="dropdown-divider"></li>
							            <li><a class="dropdown-item" href="#">Something else here</a></li>
							          </ul>
							        </li>
							        <li class="nav-item">
							          <a class="nav-link disabled">Disabled</a>
							        </li>
							      </ul>
							    </div>
							  </div>
							</nav>
															<!-- 검색창 끝 -->
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                전시 일정관리
                            </div>
                            <div class="card-body">
                               <form class="d-flex" style="float:right">
			                         <div class="input-group mb-3" style="width:300px;">
											 <select class="form-select" aria-label=".form-select-sm example" >
											  <option value="" selected="selected">전시명</option>
											  <option value="">전시 번호</option>
											  <option value="">담당자</option>
											</select>
										  <input type="text" class="form-control" aria-label="회원 검색" style="width:100px">
									</div>
							      </form>
                            <!-- 테이블 정의 -->
                                <table class="table table-hover" id="dataTables-example">
                            	<thead> 
							   <tr>
                                    <th>Exhibition Number</th>
                                    <th>Exhibition Name</th>
                                    <th>Input Date</th>
                                    <!-- 	<th>ISDELETED</th>
                                    	<th>ISUBSCRIBE_DATE</th> -->
                                    </tr>
						  	</thead> 
						  	<tbody> 
						  		  <%
						  		  AdminExhibitionDAO aDAO = new AdminExhibitionDAO();
						  		  try{
						  		  List<ExhibitionVO> ev = aDAO.selectExhibition(""); 
						  
						  		  for(ExhibitionVO eVO : ev){%>
                                    	<tr  style="cursor:pointer" data-bs-target="#showModal" data-bs-toggle="modal">
 											<td><%=eVO.getExNum()%></td>
 											<td><%=eVO.getExName()%></td>
 											<td><%=eVO.getInputDate()%></td>
                                    	</tr>
                                    	
                                   <% }//end for
							  		if(ev == null){
	                                 %>
	                                 <tr>
	                                 	<td colspan="3">조회된 데이터가 없습니다.</td>
	                                 </tr>
	                                 <%    
	                                }
						  		  }catch(SQLException e){
						  			  e.printStackTrace();
						  		  }//end catch
                                    %>
						  	</tbody> 
						  </table>
						  <div>
						  <button type="button" class="btn btn-dark" style="float:right;" data-bs-target="#addModal" data-bs-toggle="modal">전시 추가</button>
						  </div>
						  <!-- 페이지 -->
						    <div> 
								<ul class="pagination justify-content-center"> 
									<li ><a style="margin-right:5px;text-decoration:none;"class="text-secondary" href="">이전</a></li> 
									<li ><a style="margin-right:5px;text-decoration:none;"class="text-secondary" href="">1</a></li> 
									<li ><a style="margin-right:5px;text-decoration:none;"class="text-secondary" href="">2</a></li> 
									<li ><a style="margin-right:5px;text-decoration:none;"class="text-secondary" href="">3</a></li> 
									<li ><a style="margin-right:5px;text-decoration:none;"class="text-secondary" href="">다음</a></li> 
								</ul> 
						  </div>
						  <!-- 페이지 끝 -->
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
                 <!-- 전시 추가 modal  -->
	                <div class="modal fade" tabindex="-1" id="addModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2">
					  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">전시 추가</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
						      	<div class="mb-3">
								  <label for="exampleFormControlInput1" class="form-label">전시명</label>
								  <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="전시명"  style="width:200px">
								</div>
						      	<div class="mb-3">
								  <label for="exampleFormControlInput1" class="form-label">전시장</label>
							      	<select class="form-select" aria-label=".form-select-sm example" style="width:300px">
									  <option selected>서울 현대 미술관</option>
									  <option value="1">One</option>
									  <option value="2">Two</option>
									  <option value="3">Three</option>
									</select>
								</div>
					      	<div class="mb-3">
					      	<label class="form-label">전시 기간</label>
					      	<div class="row">
					      	<div class="col-6">
					      	<input type="text" id="startDate" class="form-control" placeholder="시작 일자" style="width:200px">
					      	</div>
					      	<div class="col-6">
					      	<input type="text" id="endDate" class="form-control" placeholder="마감 일자" style="width:200px">
					      	</div>
					      	</div>
					      	</div>
					      	<div class="mb-3" >
						      	<label class="form-label">전시 포스터</label>
						      	<div class="input-group mb-3" style="width:500px">
								  <input type="file" class="form-control" id="inputGroupFile02">
								</div>
						      	<div style="width:200px; height:200px;">
						      		<img src="images/adult.png" class="rounded float-start" alt="...">
						      	</div>	
					      	</div>
						    <div class="mb-3">
								<label for="exampleFormControlInput1" class="form-label">전시 간단 소개</label>
								  <textarea class="form-control" id="simpleIntroduce" rows="3" style="width:500px"></textarea>
							</div>
						    <div class="mb-3">
								<label for="exampleFormControlInput1" class="form-label">추가 이미지</label>
						      	<div class="input-group mb-3" style="width:500px">
								  <input type="file" class="form-control" id="inputGroupFile02">
								</div>
							</div>
						      	<div class="mb-3">
								  <label for="exampleFormControlTextarea1" class="form-label">전시 내용</label>
								  <textarea class="form-control" id="detailIntroduce" rows="10"></textarea>
								</div>
					      	<div class="row">
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="form-label">허용인원</label>
								<input type="text" class="form-control" id="exampleFormControlInput1" placeholder="100"  style="width:100px">
								</div>
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="form-label">관람인원</label>
								<input type="text" class="form-control" id="exampleFormControlInput1" placeholder="0"  style="width:100px">
								</div>
					      	</div>
						    <div class="mb-3">
								<label for="exampleFormControlTextarea1" class="form-label">담당자 이름</label>
								<input type="text" class="form-control" id="exampleFormControlInput1" placeholder="김전시"  style="width:100px">
							</div>
							
							<div class="row">
							<label class="form-label">전시 가격</label>
						    <div class="mb-3 col-4">
						    	<label>성인</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" aria-label="유아/65세 이상" >
								  <span class="input-group-text">원</span>
								</div>
							</div>
						    <div class="mb-3 col-4">
						    	<label>청소년</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" aria-label="유아/65세 이상" >
								  <span class="input-group-text">원</span>
								</div>
							</div>
						    <div class="mb-3 col-4">
						    	<label>유아/65세 이상</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" aria-label="유아/65세 이상" >
								  <span class="input-group-text">원</span>
								</div>
							</div>
							</div>
								
					      </div>
					      <div class="modal-footer">
					        <div class="container-fluid">
					      <div class="row">
					      	<div class="col-6 text-center">
					        <button type="button" class="btn btn-outline-dark"  data-bs-dismiss="modal">돌아가기</button>
					      	</div>
					      	<div class="col-6 text-center">
					        <button type="button" class="btn btn-outline-info"data-bs-target="#confirmAdd" data-bs-toggle="modal" >전시 추가</button>
					      	</div>
					      </div>
					      </div>
					      </div>
					    </div>
					  </div>
					</div>
				<!-- modal -->
                 <!-- 전시 조회 modal  -->
	                <div class="modal fade" tabindex="-1" id="showModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2">
					  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">전시 조회</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
						      	<div class="mb-3">
								  <label for="exampleFormControlInput1" class="form-label">전시명</label>
								</div>
						      	<div class="mb-3">
								  <label for="exampleFormControlInput1" class="form-label">전시장</label>
								</div>
					      	<div class="mb-3">
					      	<label class="form-label">전시 기간</label>
					      	</div>
					      	<div class="mb-3" >
						      	<label class="form-label">전시 포스터</label>
						      	<div style="width:200px; height:200px;">
						      		<img src="images/adult.png" class="rounded float-start" alt="...">
						      	</div>	
					      	</div>
						    <div class="mb-3">
								<label for="exampleFormControlInput1" class="form-label">전시 간단 소개</label>
							</div>
						    <div class="mb-3">
								<label for="exampleFormControlInput1" class="form-label">추가 이미지</label>
							</div>
						      	<div class="mb-3">
								  <label for="exampleFormControlTextarea1" class="form-label">전시 내용</label>
								</div>
					      	<div class="row">
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="form-label">허용인원</label>
								
								</div>
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="form-label">관람인원</label>
								
								</div>
					      	</div>
						    <div class="mb-3">
								<label for="exampleFormControlTextarea1" class="form-label">담당자 이름</label>
							</div>
							
							<div class="row">
							<label class="form-label">전시 가격</label>
						    
							</div>
								
					      </div>
					      <div class="modal-footer">
					        <div class="container-fluid">
					      <div class="row">
					      	<div class="col-4 text-center">
					        <button type="button" class="btn btn-outline-danger"data-bs-target="#confirmDelete" data-bs-toggle="modal" >전시 삭제</button>
					      	</div>
					      	<div class="col-4 text-center">
					        <button type="button" class="btn btn-outline-info" data-bs-target="#modifyModal" data-bs-toggle="modal">전시 수정</button>
					      	</div>
					      	<div class="col-4 text-center">
					        <button type="button" class="btn btn-outline-success" data-bs-target="#confirmShow" data-bs-toggle="modal">전시 노출</button>
					      	</div>
					      </div>
					      </div>
					      </div>
					    </div>
					  </div>
					</div>
				<!-- modal -->
                 <!-- 전시 수정 modal  -->
	                <div class="modal fade" tabindex="-1" id="modifyModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" >
					  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">전시 조회</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
						      	<div class="mb-3">
								  <label for="exampleFormControlInput1" class="form-label">전시명</label>
								  <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="전시명"  style="width:200px">
								</div>
						      	<div class="mb-3">
								  <label for="exampleFormControlInput1" class="form-label">전시장</label>
							      	<select class="form-select" aria-label=".form-select-sm example" style="width:300px">
									  <option selected>서울현대미술관</option>
									  <option value="1">One</option>
									  <option value="2">Two</option>
									  <option value="3">Three</option>
									</select>
								</div>
					      	<div class="mb-3">
					      	<label class="form-label">전시 기간</label>
					      	<div class="row">
					      	<div class="col-6">
					      	<input type="text" id="startDate" class="form-control" placeholder="시작 일자" style="width:200px">
					      	</div>
					      	<div class="col-6">
					      	<input type="text" id="endDate" class="form-control" placeholder="마감 일자" style="width:200px">
					      	</div>
					      	</div>
					      	</div>
					      	<div class="mb-3" >
						      	<label class="form-label">전시 포스터</label>
						      	<div class="input-group mb-3" style="width:500px">
								  <input type="file" class="form-control" id="inputGroupFile02">
								</div>
						      	<div style="width:200px; height:200px;">
						      		<img src="images/adult.png" class="rounded float-start" alt="...">
						      	</div>	
					      	</div>
						    <div class="mb-3">
								<label for="exampleFormControlInput1" class="form-label">전시 간단 소개</label>
								  <textarea class="form-control" id="simpleIntroduce" rows="3" style="width:500px"></textarea>
							</div>
						    <div class="mb-3">
								<label for="exampleFormControlInput1" class="form-label">추가 이미지</label>
						      	<div class="input-group mb-3" style="width:500px">
								  <input type="file" class="form-control" id="inputGroupFile02">
								</div>
							</div>
						      	<div class="mb-3">
								  <label for="exampleFormControlTextarea1" class="form-label">전시 내용</label>
								  <textarea class="form-control" id="detailIntroduce" rows="10"></textarea>
								</div>
					      	<div class="row">
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="form-label">허용인원</label>
								<input type="text" class="form-control" id="exampleFormControlInput1" placeholder="100"  style="width:100px">
								</div>
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="form-label">관람인원</label>
								<input type="text" class="form-control" id="exampleFormControlInput1" placeholder="0"  style="width:100px">
								</div>
					      	</div>
						    <div class="mb-3">
								<label for="exampleFormControlTextarea1" class="form-label">담당자 이름</label>
								<input type="text" class="form-control" id="exampleFormControlInput1" placeholder="김전시"  style="width:100px">
							</div>
							
							<div class="row">
							<label class="form-label">전시 가격</label>
						    <div class="mb-3 col-4">
						    	<label>성인</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" aria-label="유아/65세 이상" >
								  <span class="input-group-text">원</span>
								</div>
							</div>
						    <div class="mb-3 col-4">
						    	<label>청소년</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" aria-label="유아/65세 이상" >
								  <span class="input-group-text">원</span>
								</div>
							</div>
						    <div class="mb-3 col-4">
						    	<label>유아/65세 이상</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" aria-label="유아/65세 이상" >
								  <span class="input-group-text">원</span>
								</div>
							</div>
							</div>
								
					      </div>
					      <div class="modal-footer">
					        <div class="container-fluid">
					      <div class="row">
					      	<div class="col-6 text-center">
					        <button type="button" class="btn btn-outline-dark"  data-bs-target="#showModal" data-bs-toggle="modal" >돌아가기</button>
					      	</div>
					      	<div class="col-6 text-center">
					        <button type="button" class="btn btn-outline-info" data-bs-target="#confirmModify" data-bs-toggle="modal">전시 수정</button>
					      	</div>
					      </div>
					      </div>
					      </div>
					    </div>
					  </div>
					</div>
				<!-- 전시 수정 확인 modal -->
				<div class="modal fade" id="confirmModify" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        전시를 수정하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- modal -->
				
				<!-- 전시 삭제 확인 modal -->
				<div class="modal fade" id="confirmDelete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        전시를 삭제하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- modal -->
				<!-- 전시 추가 확인 modal -->
				<div class="modal fade" id="confirmAdd" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        전시를 추가하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- modal -->
				
				<!-- 전시 노출 확인 modal -->
				<div class="modal fade" id="confirmShow" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        전시를 사용자에게 보여주겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- modal -->
				
            </div>
        </div>
      
    </body>
</html>
