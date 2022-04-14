<%@page import="java.sql.SQLException"%>
<%@page import="VO.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="DAO.AdminMemberDAO"%>
<%@ include file="admin_id_session.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Member</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <!-- jQeury CDN -->
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
     
<style>
        	
        	hr {width:200px; margin: 0px auto; margin-top:10px;}
        	#member_tab{ text-align:center;}
</style>
    <script type="text/javascript">
    /* function memberDetailModal(){
 		$('#myModal').modal('show'); 
    } */
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
                    <div class="container-fluid px-4" style="width:90%">
                        <h1 class="mt-4">회원 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp" style="text-decoration:none; color:#333;">Dashboard</a></li>
                            <li class="breadcrumb-item active">회원 관리</li>
                        </ol>
                        <!-- 검색창 -->
							<div id="searchDiv" >
                            <form class="d-flex" style="float:right">
			                         <div class="input-group mb-3" style="width:300px;">
											 <select class="form-select" aria-label=".form-select-sm example" style="height:35px;">
											  <option value="" selected="selected">이름</option>
											  <option value="">아이디</option>
											  <option value="">가입일</option>
											</select>
										  <input type="text" class="form-control" aria-label="회원 검색" style="width:100px;height:35px; margin-right:10px;">
										    <button type="button" class="btn btn-outline-dark btn-sm" style="height: 35px;">
                                 <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
									</div>
							      </form>
                        	</div>
                        
                            <div class="card-body">
                            <!-- 테이블 정의 -->
                                <table class="table table-hover" id="member_tab">
                            	<thead> 
							   <tr>
                                    	<th>ID</th>
                                    	<th>이름</th>
                                    	<th>가입일</th>
                                    </tr>
						  	</thead> 
						  	<tbody> 
						  		 <%
    						 		AdminMemberDAO amDAO = new AdminMemberDAO();
    						 		try {
	    						 		List<MemberVO> list = amDAO.selectAllMember();
	    						 		for(MemberVO mv: list){
	    						 		%>
                                    	<tr style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#myModal">
	    						 			<td><input type="hidden" name="userId" id="userId"  value="<%=mv.getUserId()%>"><%=mv.getUserId()%></td>
	    						 			<td><%=mv.getName()%></td>
	    						 			<td><%=mv.getIsubscribeDate()%></td>
	    						 		</tr>
	    						 		<% }
	    						 		
	    						 		}catch(SQLException e) {
	    									e.printStackTrace();
	    						 		}%>
						  	</tbody> 
						  </table>
						  
                            </div>
                               <div id="pageNavigation">
								<ul class="pagination justify-content-center"> 
									<li ><a style="margin-right:5px;text-decoration:none;"class="text-secondary page-item" href="">이전</a></li> 
									<li ><a style="margin-right:5px;text-decoration:none;"class="text-secondary" href="">1</a></li> 
									<li ><a style="margin-right:5px;text-decoration:none;"class="text-secondary" href="">2</a></li> 
									<li ><a style="margin-right:5px;text-decoration:none;"class="text-secondary" href="">3</a></li> 
									<li ><a style="margin-right:5px;text-decoration:none;"class="text-secondary" href="">다음</a></li> 
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
	               <!-- 회원 상세 조회 modal  -->
	                <div class="modal fade" tabindex="-1" id="myModal" role="dialog"aria-hidden="true" aria-labelledby="exampleModalToggleLabel" style=" z-index:1051;">
					  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">회원 상세 정보</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					    <table class="modalTab" style="width: 98%; ">
					 		<tr>
					 			<th colspan="2" class="modalTh">ID(Email)</th>
					 		</tr>
					 		<tr>
					 			<td id="id" class="modalTh">ㅑㅇ</td>
					 		</tr>
					 		
					 		<tr>
					 			<th colspan="2" class="modalTh">회원명</th>
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
					      <div class="modal-footer">
					        <div class="container-fluid">
					      <div class="row">
					      	<div class="col-6 text-center">
					        <button type="button" class="btn btn-outline-danger" data-bs-target="#confirmDelete" data-bs-toggle="modal">회원 삭제</button>
					      	</div>
					      	<div class="col-6 text-center">
					        <button type="button" class="btn btn-outline-info" data-bs-target="#modifyModal" data-bs-toggle="modal" >회원 수정</button>
					      	</div>
					      </div>
					      </div>
					      </div>
					    </div>
					  </div>
					</div>
				<!-- modal -->
	               <!-- 회원 수정 modal  -->
	                <div class="modal fade" tabindex="-1" id="modifyModal" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2">
					  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">회원 수정</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					      	<div class="text-secondary">ID(Email)</div>
					      	<div class="input-group input-group-sm mb-3" style="width:700px">
							  <input type="text" class="form-control" placeholder="Username" aria-label="Username">
							  <span class="input-group-text">@</span>
							  <input type="text" class="form-control" placeholder="Server" aria-label="Server">
							  <button class="btn btn-outline-info" type="button" id="button-addon2">중복 확인</button>
							  <div style="color:#FF0000">&nbsp; &nbsp;중복확인 메시지</div>
							</div>
					      	<div class="text-secondary">이름</div>
					      	<div class="input-group input-group-sm mb-3" style="width:200px">
							</div>
					      	<div class="text-secondary">전화번호</div>
					      	<div class="input-group input-group-sm mb-3" style="width:200px">
							  <input type="text" class="form-control" placeholder="전화번호">
							</div>
					      	<div>우편번호</div>
					      	<div class="input-group input-group-sm mb-3" style="width:250px">
							  <input type="text" class="form-control" placeholder="우편번호">
							   <button class="btn btn-outline-info" type="button" id="button-addon2">우편번호검색</button>
							</div>
					      	<div class="row"><div class="col-6">주소</div> <div class="col-6">상세주소</div></div>
					      	<div class="row">
					      	<div class="col-6">
					      	<div class="input-group input-group-sm mb-3" style="width:250px">
							  <input type="text" class="form-control" placeholder="주소">
							</div>
					      	 </div>
					      	<div class="col-6">
					      	<div class="input-group input-group-sm mb-3" style="width:350px">
							  <input type="text" class="form-control" placeholder="상세주소">
							</div>
					      	</div> 
					      	 </div>
					      	<div>가입일</div>
					      	<div class="input-group input-group-sm mb-3" style="width:200px">
							</div>
					      </div>
					      <div class="modal-footer">
					        <div class="container-fluid">
					      <div class="row">
					      	<div class="col-6 text-center">
					        <button type="button" class="btn btn-outline-dark" data-bs-target="#myModal" data-bs-toggle="modal" data-bs-dismiss="modal">돌아가기</button>
					      	</div>
					      	<div class="col-6 text-center">
					        <button type="button" class="btn btn-outline-info" data-bs-target="#confirmModify" data-bs-toggle="modal">회원 수정</button>
					      	</div>
					      </div>
					      </div>
					      </div>
					    </div>
					  </div>
					</div>
				<!-- modal -->
				<!-- 회원삭제 확인 modal -->
				<div class="modal fade" id="confirmDelete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        회원을 삭제하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 회원삭제 확인 modal -->
				<!-- 회원 수정 확인 modal -->
				<div class="modal fade" id="confirmModify" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        회원을 수정하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!--  -->
            </div>
        </div>
             
      
    </body>
</html>
