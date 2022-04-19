<%@page import="DAO.ReservationManagerDAO"%>
<%@page import="VO.ReservationManagerVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="VO.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="DAO.AdminMemberDAO"%>
<%@include file="admin_id_session.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- prefix -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Reservation</title>
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
        	
        	hr {width:200px; margin: 0px auto; margin-top:10px;}
        	#member_tab{ text-align:center;}
</style>
    <script type="text/javascript">
   
	
	$( function() {
 $("#bookingDetail").on("show.bs.modal", function(e) {		
    	var num= $(e.relatedTarget).data('num');
		var exName= $(e.relatedTarget).data('exName');
    	var userName= $(e.relatedTarget).data('userName');
    	var viData= $(e.relatedTarget).data('viData');
    	var rezStatus= $(e.relatedTarget).data('rezStatus');
    	var modal= $(this);
    	modal.find("#resNum").text(num);
    	modal.find("#exName").text(exName);
    	modal.find("#userName").text(userName);
    	modal.find("#viData").text(viData);
    	modal.find("#rezStatus").text(rezStatus);
    });
	});  

		
    $( "#reservationDate" ).datepicker({
		  dateFormat: "yy-mm-dd",
		  dayNames: [ "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" ],
		  dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		  monthNamesShort: [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" ],
		  monthNames: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ]
		});
    
	
    </script>
    </head>
    
    <body class="sb-nav-fixed">
   
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.jsp">Exhibition Admin</a>
<!--             Sidebar Toggle
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button> -->
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
                        <h1 class="mt-4">예약 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp" style="text-decoration:none; color:#333;">Dashboard</a></li>
                            <li class="breadcrumb-item active">예약 관리</li>
                        </ol>
                        <!-- 검색창 -->
							<div id="searchDiv" >
                            <div class="input-group flex-nowrap" style="width:300px;">
								  <span class="input-group-text" id="addon-wrapping">예약날짜</span>
					      		<input type="text" id="reservationDate" class="form-control" placeholder="예약 일자" style="width:200px">
								</div>
								
                            <form class="d-flex" >
			                         <div class="input-group mb-3" style="width:500px;margin-top:10px;">
								  		<span class="input-group-text" id="addon-wrapping">항목검색</span>
											 <select class="form-select" aria-label=".form-select-sm example" >
											  <option value="" selected="selected">사용자 이름</option>
											  <option value="">전시 이름</option>
											</select>
										  <input type="text" class="form-control" aria-label="회원 검색" style="width:100px">
									</div>
							      </form>
                        	</div>
                        	
                        	<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">
							  <label class="form-check-label" for="inlineRadio1">전체선택</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">
							  <label class="form-check-label" for="inlineRadio2">예약완료</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3" >
							  <label class="form-check-label" for="inlineRadio3">예약대기</label>
							</div>
							<div class="form-check form-check-inline">
							  <input class="form-check-input" type="radio" name="inlineRadioOptions" id="inlineRadio3" value="option3" >
							  <label class="form-check-label" for="inlineRadio4">예약취소</label>
							</div>
						<div class="card-body">
                            <!-- 테이블 정의 -->
                                <table class="table table-hover" id="member_tab">
                            	<thead> 
							   <tr>
                                    	<th>예약번호</th>
                                    	<th>전시명</th>
                                    	<th>예약자</th>
                                    	<th>예약일시</th>
                                    	<th>처리현황</th>
                                    	<th>관리</th>
                                    </tr>
						  	</thead> 
						  	<tbody> 
									<%
									ReservationManagerDAO rDAO = new ReservationManagerDAO();
									List<ReservationManagerVO> rezList = rDAO.selectReservation();
										
									pageContext.setAttribute("rezList", rezList);
									%>
									<c:forEach var="res" items="${rezList}">
						  		<tr style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#bookingDetail" data-num="${res.rezNum}"
						  		data-exName="${res.exName}" data-userName="${res.userName}" data-viData="${res.visitData}" data-rezStatus="${res.rezStatus}">
									<td><c:out value="${res.rezNum}"/></td>
									<td><c:out value="${res.exName}"/></td>
									<td><c:out value="${res.userName}"/></td>
									<td><c:out value="${res.visitData}"/></td>
									<td><c:out value="${res.rezStatus}"/></td>
									
									<td>
									 <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#confirmCancel">예약 취소</button>
				        				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmOk">예약 확인</button>
				        			</td>
						  		</tr>
						  			</c:forEach>
						  	
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
               <!-- 예약 관리 상세 모달  -->
              
				<div class="modal fade" id="bookingDetail" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">예약 관리 상세</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
					 	<table class="modalTab">
					 		<tr>
					 			<th colspan="2" class="modalTh">전시명</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd" id="exName"></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">전시 번호</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">예약 번호</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd" id="resNum"></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">예약자명</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd" id="userName"></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">예약일자</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">예약자 ID</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">방문기간</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd" id="rezStatus"></td>
					 		</tr>
					 	</table>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">돌아가기</button>
				        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModify">예약 수정</button>
				      </div>
				    </div>
				  </div>
				</div>
	<!-- 예약 수정 확인 모달  -->
	<div class="modal fade" id="confirmDelete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body" style="text-align: center">
	        예약 내용을 수정하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
	        <button type="button" class="btn btn-primary">OK</button>
	      </div>
	    </div>
	  </div>
	</div>
				<!-- 회원삭제 확인 modal -->
				<div class="modal fade" id="confirmCancel" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        예약을 취소하시겠습니까?
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
				<div class="modal fade" id="confirmOk tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        예약을 확인하시겠습니까?
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
