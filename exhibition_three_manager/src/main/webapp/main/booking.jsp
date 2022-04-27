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
        <script src="../js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="../assets/demo/chart-area-demo.js"></script>
        <script src="../assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="../js/datatables-simple-demo.js"></script>
     
<style>
        	
        	hr {width:200px; margin: 0px auto; margin-top:10px;}
        	#member_tab{ text-align:center;}
</style>
    <script type="text/javascript">
   	
    var errorPage=["404","500","401"];
    $( function() {	
    $("#findNamesBtn").click(function() {
    	document.dataSearchFrm.submit();

	});//findNamesBtn
    	
    	
 	$("#bookingDetail").on("show.bs.modal", function(e) {		
	   	var num= $(e.relatedTarget).data('num');
    	var error="";
    	$.ajax({
			url:"http://localhost/exhibition_three_manager/main/ajax/bookingAjax.jsp",
			data: {"rezNum":num},
			async:false,
			type: "get",
			dataType:"json",
			error:function(xhr){
				alert("bookingDetail "+xhr.status+", "+xhr.statusText);
				//location.href="401.html";
			},
			success:function(jsonObj){
				$("#exName").html(jsonObj.exName);				
				$("#exNum").html(jsonObj.exNum);				
				$("#resNum").html(num);				
				$("#userName").html(jsonObj.userName);				
				$("#rezCount").val(jsonObj.rezCount);				
				$("#rezDate").html(jsonObj.rezDate);				
				$("#userId").html(jsonObj.userId);				
				$("#visitDate").val(jsonObj.visitDate);				
				$("#price").html(jsonObj.price);				
			}
		});//ajax
		
    });//bookingDetail
  
});  //ready;

    function confirmModify() {
    	var num= $("#resNum").text();
 		var rezCount=$("#rezCount").val();
		var visitDate=$("#visitDate").val();
				
		 $.ajax({
			url:"http://localhost/exhibition_three_manager/main/ajax/bookingModifyAjax.jsp",
			data: {"rezCount":rezCount, "visitDate":visitDate, "rezNum":num},
			async:false,
			type: "get",
			dataType:"json",
			error:function(xhr){
				alert("confirmModify : "+xhr.status+", "+xhr.statusText);
			//	location.href="401.html";
			},
			success:function(jsonObj){
				if(jsonObj.cnt > 0){
					alert("수정되었습니다.")
					location.href="booking.jsp";
				} else{
					location.href="401.html";
				} 
			}  
		}); //ajax
	} //confirmModify
	
	function cancelRez() {
		var num= $("#mainRezNum").text();
		 $.ajax({
				url:"http://localhost/exhibition_three_manager/main/ajax/bookingCancelAjax.jsp",
				data: {"rezNum":num},
				async:false,
				type: "get",
				dataType:"json",
				error:function(xhr){
					alert("cancelAjax : "+xhr.status+", "+xhr.statusText);
				//	location.href="401.html";
				},
				success:function(jsonObj){
					if(jsonObj.cnt > 0){
						alert("예약이 취소되었습니다.")
						location.href="booking.jsp";
					}
				}  
			}); //ajax
	}//cancelRez
	
	//예약 확인
	function rezConfirm() {
		var num= $("#mainRezNum").text();
		 $.ajax({
				url:"http://localhost/exhibition_three_manager/main/ajax/bookingConfirmAjax.jsp",
				data: {"rezNum":num},
				async:false,
				type: "get",
				dataType:"json",
				error:function(xhr){
					alert("confirmAjax : "+xhr.status+", "+xhr.statusText);
				//	location.href="401.html";
				},
				success:function(jsonObj){
					if(jsonObj.cnt > 0){
						alert("예약이 확인되었습니다.")
						location.href="booking.jsp";
					}
				}  
			}); //ajax
	}
	
	
	
    </script>
    </head>
    <%
	ReservationManagerDAO rmDao = new ReservationManagerDAO();
	int cnt = rmDao.cntRez();
		
	int pageSize=5;
	String pageNum=request.getParameter("pageNum");
	if(pageNum==null){
		pageNum="1";
	}
	//검색항목 설정
		String nameSel=request.getParameter("nameSelection");
	  	if("".equals(nameSel) || nameSel==null){
	 		nameSel="name";
	 	}
	 	
	 	if(nameSel.equals("findExName")){
	 		nameSel="ex_name";
	 	}else{
	 		nameSel="name";
	 	} 
	 	
	 	//검색어 설정
	 	String vDate= request.getParameter("vDate");
	 	if(vDate==null || "".equals(vDate)){
	 		vDate="";
	 	}
	 	String findCatName= request.getParameter("findCatName");
	 	if(findCatName==null || "".equals(findCatName)){
	 		findCatName="";
	 	} 
	 	
	int currentPage= Integer.parseInt(pageNum);
	int startRow=(currentPage-1)*pageSize+1;
	int endRow=currentPage * pageSize;	
	
	List<ReservationManagerVO> rezList = null;
	if(cnt>0){
		rezList= rmDao.selectReservation(startRow, endRow, nameSel, vDate, findCatName);
		pageContext.setAttribute("rezList", rezList);
	%>
	
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
								
                            <form class="d-flex" action="http://localhost/exhibition_three_manager/main/booking.jsp" name="dataSearchFrm">
                            	<div class="input-group mb-3" style="width:300px; height:40px; margin-top:10px;" >
								  <span class="input-group-text" id="addon-wrapping">방문날짜</span>
					      		  <input type="date" name="vDate" class="form-control" placeholder="방문 일자" style="width:200px;" id="vDate" value="${param.vDate}">
								</div>
	                         <div class="input-group mb-3" style="width:500px;margin-top:10px; margin-left: 100px;">
						  		<span class="input-group-text" id="addon-wrapping">항목검색</span>
									 <select class="form-select" aria-label=".form-select-sm example" name="nameSelection" id="nameSel">
									  <option value="findUserName" ${(param.nameSelection =="findUserName")?"selected":"" } >사용자 이름</option>
									  <option value="findExName" ${(param.nameSelection =="findExName")?"selected":""} >전시 이름</option>
									</select>
								  <input type="text" class="form-control" style="width:100px" name="findCatName" id="findCatName" value="${param.findCatName}">
								  <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal" id="findNamesBtn">검색</button>
								</div>
							      </form>
                        	</div>
                        	
                        	<div class="form-check form-check-inline">
							  
							</div>
						<div class="card-body">
                            <!-- 테이블 정의 -->
                                <table class="table table-hover" id="member_tab">
                            	<thead> 
							   <tr>
                                    	<th>예약번호</th>
                                    	<th>전시명</th>
                                    	<th>예약자</th>
                                    	<th>방문일시</th>
                                    	<th>처리현황</th>
                                    	<th>관리</th>
                                   </tr>
						  	</thead> 
						  	<tbody id="bookingTBody"> 
								 
									<c:forEach var="res" items="${rezList}">
						  		<tr style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#bookingDetail" data-num="${res.rezNum}"  class="rezList">
									<td id="mainRezNum"><c:out value="${res.rezNum}"/></td>
									<td><c:out value="${res.exName}"/></td>
									<td><c:out value="${res.userName}"/></td>
									<td><c:out value="${res.visitData}"/></td>
									<td id="rezStatus"><c:out value="${res.rezStatus}"/></td>
									
									<td>
									 	<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#confirmCancel" >예약 취소</button>
				        				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmOk">예약 확인</button>
				        			</td>
						  		</tr>
						  			</c:forEach> 
						  	</tbody> 
						  	<%}%>
						  </table>
						  
                            </div>
                               <div id="pageNavigation">
								<ul class="pagination justify-content-center"> 
								<%
								if(cnt > 0){
									int pageCount = cnt/pageSize + (cnt%pageSize == 0 ? 0 : 1); //레코드 수에 따른 페이지 수 구하기
									int pageBlock=5; // 한번에 보여질 페이지 번호의 갯수
									int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;//첫페이지 번호
									
									int endPage = startPage + pageBlock - 1;//마지막 페이지 번호

									if(endPage > pageCount){
										endPage = pageCount;
									}
									
									pageContext.setAttribute("currentPage", currentPage);
									pageContext.setAttribute("endPage", endPage);
									pageContext.setAttribute("startPage", startPage);
									pageContext.setAttribute("pageBlock", pageBlock);
									pageContext.setAttribute("pageCount", pageCount);

										%>  
									
									<c:if test="${startPage gt pageBlock}">
									<a style="margin-right:10px;text-decoration:none;"class="text-secondary page-item" href="booking.jsp?pageNum=<%=startPage-5%>&vDate=${param.vDate}&vDate=${param.vDate}&nameSelection=${param.nameSelection}&findCatName=${param.findCatName}">
									이전
									</a>
									</c:if>
									
									<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
										<c:if test="${i eq currentPage}">
											<li>
											<a style="margin-right:10px;"class="text-secondary" href="">
											<c:out value="${i}"/>
											</a>
											</li> 
										</c:if>
										<c:if test="${i ne currentPage}">
											<li>
											<a style="margin-right:10px;"class="text-secondary" href="booking.jsp?pageNum=${i}&vDate=${param.vDate}&nameSelection=${param.nameSelection}&findCatName=${param.findCatName}">
											<c:out value="${i}"/>
											</a>
											</li> 
										</c:if>
										
									</c:forEach>
									
									
									<c:if test="${endPage lt pageCount}">
									<li>
										<a style="margin-right:10px;text-decoration:none;"class="text-secondary" href="booking.jsp?pageNum=${startPage+5}pageNum=${i}&vDate=${param.vDate}&nameSelection=${param.nameSelection}&findCatName=${param.findCatName}">
										다음
										</a>
										</li> 
								</c:if>
							<%	}//end if
								%>
								
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
				      <div class="modal-body" >
					 	<table class="modalTab" style="width:98%;" cellpadding="5">
					 		<tr>
					 			<th colspan="2" class="modalTh">전시명</th>
					 			<th colspan="2" class="modalTh">전시 번호</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd" id="exName"></td>
					 			<td class="modalTd" id="exNum"></td>
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
					 			<th colspan="2" class="modalTh">예약자 ID</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd" id="userId"></td>
					 		</tr>
					 		
					 		<tr>
					 			<th colspan="2" class="modalTh">예약인원</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"><input id="rezCount" type="number" class="inputBox"/>
					 			<span id="countWarning" style="font-size:10px; color:#ff0000;"></span></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">예약일자</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd" id="rezDate"></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">방문기간</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"><input id="visitDate" type="date" class="inputBox"/>
					 			<span id="visitWarning" style="font-size:10px; color:#ff0000;"></span></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">예약가격</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd" id="price"></td>
					 		</tr>
					 	</table>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">돌아가기</button><!-- id="confirmModify"  -->
				        <button type="button" class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#confirmModify" onclick="confirmModify(${res.rezNum})">예약 수정</button>
				      </div>
				    </div>
				  </div>
				</div>
	
				<!-- 예약취소 확인 modal -->
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
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-outline-info" onclick="cancelRez(${res.rezNum})">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 예약 확인 modal -->
				<div class="modal fade" id="confirmOk" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        예약을 확인하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-outline-info" onclick="rezConfirm(${res.rezNum})">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!--  -->
            </div>
        </div>
             
      
    </body>
</html>
