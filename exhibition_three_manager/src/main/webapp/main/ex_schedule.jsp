<%@page import="VO.ExHallVO"%>
<%@page import="VO.ExhibitionVO"%>
<%@page import="DAO.AdminExhibitionDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="VO.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="DAO.AdminMemberDAO"%>
<%@include file="admin_id_session.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
   
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Exhibition Schedule</title>
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
        </style>
	<script type="text/javascript">
	$( function() {
		$("#searchBtn").click(function(){
			document.dataSearchFrm.submit();
		});
		function detailExhibition(id,name,date,addr1,addr2,zipcode,tel){
		  	$("#myModal").on('show.bs.modal',function(e){
		  		var modal= $(this);
		    	modal.find("#id").text(id);
		  		modal.find("#memberName").text(name);
		  		modal.find("#subDate").text(date);
		  		modal.find("#address1").text(addr1);
		  		modal.find("#address2").text(addr2);
		  		modal.find("#zipcode").text(zipcode);
		  		modal.find("#tel").text(tel);
		  	});
		  	$("#myModal").modal('show');
	  	}
	
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
	  });
	 
	</script>  
    </head>
        <%
    int pageSize = 5; // 한 페이지에 출력할 레코드 수
    
 	// 페이지 링크를 클릭한 번호 / 현재 페이지
 	String pageNum = request.getParameter("pageNum");
 	if (pageNum == null){ // 클릭한게 없으면 1번 페이지
 		pageNum = "1";
 	}
 	
 	//검색항목 설정
 	String query = request.getParameter("dataSearchItem");
 	if("".equals(query) || query==null){
 		query="ex_name";
 	}//end if
 	//검색어 설정
 	String field= request.getParameter("dataSearchText");
 	if(field==null || "".equals(field)){
 		field="";
 	}
 	// 연산을 하기 위한 pageNum 형변환 / 현재 페이지
 	int currentPage = Integer.parseInt(pageNum);

 	// 해당 페이지에서 시작할 레코드 / 마지막 레코드
 	int startRow = (currentPage - 1) * pageSize + 1;
 	int endRow = currentPage * pageSize;

 	int count = 0;
 	AdminExhibitionDAO aeDAO = new AdminExhibitionDAO();
 	count = aeDAO.getCount(field,query); // 데이터베이스에 저장된 총 갯수
 	
 	List<ExhibitionVO> list = null;
 	if (count > 0) {
 		// getList()메서드 호출 / 해당 레코드 반환
 		list = aeDAO.selectEx(startRow, endRow, field, query);
 	}
 %>
    <body class="sb-nav-fixed">

        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="http://localhost/exhibition_three_manager/main/index.jsp">Exhibition Admin</a>
            <!-- <!-- Sidebar Toggle-->
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
                        <h1 class="mt-4">전시 일정관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item active"><a href="index.jsp" class="breadcrumb-item active" style="text-decoration:none">Dashboard</a></li>
                            <li class="breadcrumb-item active">전시 일정관리</li>
                        </ol>
                        <div class="card-body">
                               <form class="d-flex" style="float:right" action="http://localhost/exhibition_three_manager/main/ex_schedule.jsp" name="dataSearchFrm">
			                         <div class="input-group mb-3" style="width:350px;">
											 <select class="form-select" aria-label=".form-select-sm example" style="height:35px;" name="dataSearchItem" >
											  <option ${(param.dataSearchItem=="ex_name")?"selected":""} value="ex_name">전시명</option>
											  <option ${(param.dataSearchItem=="ex_num")?"selected":""} value="ex_num">전시번호</option>
											  <option ${(param.dataSearchItem=="input_date")?"selected":""} value="input_date">입력일</option>
											</select>
										  <input type="text" class="form-control" aria-label="전시 검색" value="${param.dataSearchText}" name="dataSearchText" style="width:100px;height:35px; margin-right:10px;" >
										      <button type="button" class="btn btn-outline-dark btn-sm" style="height: 35px;" id="searchBtn">
                                 			<i class="fa-solid fa-magnifying-glass"></i>
                                 			</button>
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
						  		 
						  		 if(count > 0 ){
	    						 	
	    						 		request.setAttribute("dataList",list);
	    						 		%>
	    						 		<c:forEach var="list" items="${dataList }">
                                    	<tr style="cursor:pointer" data-bs-target="#showModal" data-bs-toggle="modal">
 											<td><c:out value="${list.exNum }"/></td>
 											<td><c:out value="${list.exName }"/></td>
 											<td><c:out value="${list.inputDate }"/></td>
                                    	</tr>
	    						 		</c:forEach>
                                   <%
                                   }else{
	                                %>
	                                 <tr>
	                                 	<td colspan="3" style="text-align:center">조회된 데이터가 없습니다.</td>
	                                 </tr>
	                                <%    
	                                }//end else
                                    %>
						  	</tbody> 
						  </table>
						  <div>
						  <button type="button" class="btn btn-dark" style="float:right;" data-bs-target="#addModal" data-bs-toggle="modal">전시 추가</button>
						  </div>
						  <!-- 페이지 -->
						    <div> 
									<ul class="pagination justify-content-center"> 
								<%
								if(count > 0){
									int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1); //레코드 수에 따른 페이지 수 구하기
									
									int pageBlock=10; // 한번에 보여질 페이지 번호의 갯수
									
									int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;//첫페이지 번호
									
									int endPage = startPage + pageBlock - 1;//마지막 페이지 번호

									if(endPage > pageCount){
										endPage = pageCount;
									}
									
									if(startPage > pageBlock){ // 11,21,31...페이지 이상 넘어갔을 경우 이전 버튼이 보인다
										%>  
									<li>
					<a style="margin-right:10px;text-decoration:none;"class="text-secondary page-item" href="ex_schedul.jsp?pageNum=<%=startPage-5%>&dataSearchItem=${param.dataSearchItem}&dataSearchText=${param.dataSearchText}">
									이전
									</a>
									</li> <% 
										}//end if
										 for(int i = startPage; i <= endPage; i++){ 
											 if(i == currentPage){ //현재 페이지인 경우 링크 생략
										 	%>
											<li>
											<a style="margin-right:10px;"class="text-secondary" href="">
											<%=i %>
											</a>
											</li> 
											<%  
											 }else{
											%>
											<li>
											<a style="margin-right:10px;text-decoration:none;"class="text-secondary" 
											href="ex_schedule.jsp?pageNum=<%=i%>&dataSearchItem=${param.dataSearchItem}&dataSearchText=${param.dataSearchText}">
											<%=i %>
											</a>
											</li> 
											<% 	 
											 }
											 %>
										<%
										 }//end for
											if(endPage < pageCount){//전체 페이지 수가 현재 블록 페이지 수보다 클 경우 다음 버튼
										%>
										<li>
										<a style="margin-right:10px;text-decoration:none;"class="text-secondary" href="ex_schedule.jsp?pageNum=<%=startPage+5%>&dataSearchItem=${param.dataSearchItem}&dataSearchText=${param.dataSearchText}">
										다음
										</a>
										</li> 
										 <% 
											}//end if
								}//end if
								%>
								</ul> 
						  </div>
						  <!-- 페이지 끝 -->
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
	                <div class="modal fade" tabindex="-1" id="addModal" data-bs-backdrop="static" data-bs-keyboard="false"aria-hidden="true" aria-labelledby="exampleModalToggleLabel2">
					  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">전시 추가</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					      <form action="http://localhost/exhibition_three_manager/main/ex_schedule.jsp" id="addFrm">
						      	<div class="mb-3">
								  <label for="exampleFormControlInput1" class="form-label">전시명</label>
								  <input type="email" class="form-control" id="exName" name="exName" placeholder="전시명"  style="width:200px">
								</div>
						      	<div class="mb-3">
								  <label for="exampleFormControlInput1" class="form-label">전시장 / 담당자</label>
							      	<select class="form-select" id="addExHall"aria-label=".form-select-sm example" style="width:400px">
									  <option selected>전시장과 담당자를 선택해주세요</option>
									  <%
									  	try{
									 	List<ExHallVO> exNameList = aeDAO.selectExhibitionHall();
									  	for(ExHallVO eVO : exNameList){
									  %>
									   <option value='<%=eVO.getExHallNum()%>'><%=eVO.getExName()%> / 담당자 : <%=eVO.getMgrName() %></option>
									   <%
									  	}//end for
									  	}catch(SQLException e){
									  		e.printStackTrace();
									  	}
									   %>
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
								  <input type="file" class="form-control" id="exPoster">
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
								  <input type="file" class="form-control" id="addImg">
								</div>
							</div>
						      	<div class="mb-3">
								  <label for="exampleFormControlTextarea1" class="form-label">전시 내용</label>
								  <textarea class="form-control" id="detailIntroduce" rows="10"></textarea>
								</div>
					      	<div class="row">
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="form-label">허용인원</label>
								<input type="text" class="form-control" id="totalNum" placeholder="100"  style="width:100px">
								</div>
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="form-label">관람인원</label>
								<input type="text" class="form-control" id="watchNum" placeholder="0"  style="width:100px">
								</div>
					      	</div>
							
							<div class="row">
							<label class="form-label">전시 가격</label>
						    <div class="mb-3 col-4">
						    	<label>성인</label>
								<div class="input-group" id="adult"style="width:150px">
								  <input type="text" class="form-control" aria-label="성인" id="adult">
								  <span class="input-group-text" >원</span>
								</div>
							</div>
						    <div class="mb-3 col-4">
						    	<label>청소년</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" aria-label="청소년" id="teen">
								  <span class="input-group-text" >원</span>
								</div>
							</div>
						    <div class="mb-3 col-4">
						    	<label>유아/65세 이상</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" aria-label="유아/65세 이상"id="child" >
								  <span class="input-group-text" >원</span>
								</div>
							</div>
							</div>
					      </form>
					      </div>
					      <!-- modal body end -->
					      <div class="modal-footer">
					        <div class="container-fluid">
					      <div class="row">
					      	<div class="col-6 text-center">
					        <a type="button" class="btn btn-outline-dark"  data-bs-dismiss="modal" href="http://localhost/exhibition_three_manager/main/hall.jsp">돌아가기</a>
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
	                <div class="modal fade" tabindex="-1" id="showModal" data-bs-backdrop="static" data-bs-keyboard="false"aria-hidden="true" aria-labelledby="exampleModalToggleLabel2">
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
	                <div class="modal fade" tabindex="-1" id="modifyModal" data-bs-backdrop="static" data-bs-keyboard="false"aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" >
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
				<div class="modal fade" id="confirmModify" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"aria-labelledby="exampleModalLabel" aria-hidden="true">
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
				<div class="modal fade" id="confirmDelete" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"aria-labelledby="exampleModalLabel" aria-hidden="true">
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
				<div class="modal fade" id="confirmAdd" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"aria-labelledby="exampleModalLabel" aria-hidden="true">
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
				        <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- modal -->
				
				<!-- 전시 노출 확인 modal -->
				<div class="modal fade" id="confirmShow" tabindex="-1"data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
