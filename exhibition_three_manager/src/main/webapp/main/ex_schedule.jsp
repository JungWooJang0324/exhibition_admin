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
        <link href="http://localhost/exhibition_three_manager/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <!-- jQuery CDN -->
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
 		<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
     	<style>
	     	hr {width:200px; margin: 0px auto; margin-top:10px;}
	     	.exTitle{font-weight:bold}
	     	#memberTab{text-align:center;}
        </style>
	<script type="text/javascript">
	
		function releaseExhibition(){
			var exNum = $("#exNum").val();
			
			$.ajax({
				url:"http://localhost/exhibition_three_manager/main/ajax/exhibition_release.jsp",
				data:{"exNum":exNum},
				type:"post",
				dataType:"json",
				async:false,
				error:function(xhr){
					alert(xhr.status+" / "+xhr.statusText);
				},//error
				success:function(jsonObj){
					if(jsonObj.cnt > 0){
						alert("사용자 페이지에 업데이트 되었습니다.");
						/* $("#confirmRelease").modal('hide');
						$("#modifyModal").modal('hide'); */
						location.reload();
					}else{
						alert("실패");
					}				
				}//success
			}) 
		}//releaseExhibition
		
		function deleteExhibition(){
			var num= $("#exNum").val();
			var poster=$("#hidPoster").val();
			var addImg=$("#hidAddImg").val();
			alert(num);
			 $.ajax({
					url:"http://localhost/exhibition_three_manager/main/ajax/exhibition_delete.jsp",
					data: {"exNum":num, "poster":poster,"addImg":addImg},
					type: "post",
					dataType:"json",
					async:false,
					error:function(xhr){
						alert("cancelAjax : "+xhr.status+", "+xhr.statusText);
					//	location.href="401.html";
					},
					success:function(jsonObj){
						if(jsonObj.cnt > 0){
							alert("전시가 취소되었습니다.");
							location.reload();
						}
					}  
				}); //ajax
		}//deleteExhibition
		
		function compareExt(file){//파일 확장자 검사
			var compareExt="png,jpg,gif,bmp".split(",");
			var fileExt = file.toLowerCase().substring(file.lastIndexOf(".")+1);
			var flag=false;
			for(var i = 0; i < compareExt.length; i++){
				if(compareExt[i] == fileExt){
					flag=true;
					break;
				}//end if
			}//end for
			return flag;
		}
		function updateExhibition(){
			$("#modifyExhibition").submit();
			alert("전시 수정을 완료했습니다.");
			location.reload();
		}
		
		function addExhibition(){
			$("#addFrm").submit();
			alert("전시가 추가되었습니다.");
			location.reload();
		}//addExhibition
			
		$(function(){
			 $("#searchBtn").click(function(){
				document.dataSearchFrm.submit();
			}); 
			$("#addModal").on('hidden.bs.modal',function(e){
					$(this).find('form')[0].reset();
			});
			$("#modifyModal").on('show.bs.modal', function(e) {
				var exNum = $(e.relatedTarget).data('num');
				$.ajax({
					url:"http://localhost/exhibition_three_manager/main/ajax/exhibition_detail.jsp",
					data:{"exNum": exNum},
					dataType:"json",
					error : function(xhr){
						alert(xhr.status+" / "+xhr.statusText);
					},
					success : function(jsonObj){
						$("#exNum").val(exNum);
					 	$("#startDate").val(jsonObj.exhibitDate);
						$("#endDate").val(jsonObj.deadline); 
						$("#exIntro").val(jsonObj.exIntro);
						$("#exName").val(jsonObj.exName);
						$("#exInfo").val(jsonObj.exInfo);
						$("#totalCount").val(jsonObj.totalCount);
						$("#watchCount").val(jsonObj.watchCount); 
						$("#adult").val(jsonObj.adult); 
						$("#teen").val(jsonObj.teen); 
						$("#child").val(jsonObj.child); 
						$("#exHall").val(jsonObj.exHallNum);
						$("#hidPoster").val(jsonObj.exPoster);
						$("#hidAddImg").val(jsonObj.addImg);
						$("#posterImg").attr("src","../images/"+jsonObj.exPoster);//포스터 보이기
						$("#addImage").attr("src","../images/"+jsonObj.addImg);//추가이미지 보이기
						$("#exStatus").val(jsonObj.exStatus);
						if(new Date().getTime() > new Date(jsonObj.exhibitDate).getTime()){
							//이미 시작된 전시에 readonly 추가
							$("#startDate").attr("readonly","readonly");
						}else{
							//그 외에 readonly 삭제
							$("#startDate").removeAttr("readonly","readonly");
						}//end else
					} })//ajax;
			});
			$("#statusBtn").click(function(){
				if($("#exStatus").val()=="Y"){
					alert("이미 사용자 페이지에 업데이트 된 전시입니다.");
					return;
				}//end if
				$("#confirmRelease").modal('show');
			});//click
			$("#deleteBtn").click(function(){
				$("#confirmDelete").modal('show');
			});//click
			$("#modifyBtn").click(function(){
				var title =["전시명","전시시작일","전시마감일","전시간단소개","전시소개","허용인원","관람인원","가격","가격","가격"];
				var value=[$("#exName"),$("#startDate"),$("#endDate"),$("#exIntro"),$("#exInfo"),$("#totalCount"),$("#watchCount"),$("#adult"),$("#teen"),$("#child")];
				for(var i = 0; i < title.length; i++){
					if(value[i].val().trim()==""){
						alert(title+"을 입력해 주세요");
						value[i].focus();
						return;
					}//end if
				}//end for
			    
				var nowDate = new Date();
				var endDate = new Date($("#endDate").val());
				if(endDate.getTime() < nowDate.getTime()){
					alert("마감일을 현재날짜 이후로 설정해주세요");
					$("#endDate").focus();
					return;
				}//end if
			
				if(startDate > endDate){
					alert("마감일은 시작일 이후로 설정해주세요");
					$("#endDate").focus();
					return;
				}//end if 
				var poster=$("#modifyExPoster").val();
				if(poster.trim()!=""){
					if(!compareExt(poster)){
						alert("이미지만 업로드 가능합니다.\n 가능 확장자 png,jpg,gif,bmp");
						$("#modifyExPoster").focus();
						return;
					}//end if
				}//end if
				
				var addImg = $("#modifyAddImg").val();
				if(addImg.trim()!=""){
					if(!compareExt(addImg)){
						alert("이미지만 업로드 가능합니다.\n 가능 확장자 png,jpg,gif,bmp");
						$("#modifyAddImg").focus();
						return;
					}//end if
				}//end if
				
				var pattern_num= /^[0-9]+$/;
				
				if(!pattern_num.test(value[5].val())||!pattern_num.test(value[6].val())){
					alert("허용인원과 관람인원은 숫자로 입력해주세요");
					value[5].focus();
					return;
				}//end if
				if(!pattern_num.test(value[7].val())||!pattern_num.test(value[8].val())||!pattern_num.test(value[9].val())){
					alert("가격은 숫자로 입력해주세요");
					value[7].focus();
					return;
				}//end if
			
				$("#confirmModify").modal('show');
			})//click
			$("#addExBtn").click(function(){
				var title =["전시명","전시시작일","전시마감일","전시간단소개","전시소개","허용인원","관람인원","가격","가격","가격"];
				var value=[$("#addExName"),$("#addStartDate"),$("#addEndDate"),$("#addIntro"),$("#addInfo"),$("#addTotalNum"),$("#addWatchNum"),$("#addAdult"),$("#addTeen"),$("#addChild")];
				for(var i = 0; i < title.length; i++){
					if(value[i].val().trim()==""){
						alert(title[i]+"을 입력해 주세요");
						value[i].focus();
						return;
					}//end if
				}//end for
				var nowDate = new Date();
				var startDate = new Date($("#addStartDate").val());
				var endDate = new Date($("#addEndDate").val());
				
				if(startDate.getTime() < nowDate.getTime()){
					alert("시작일을 현재날짜 이후로 설정해주세요");
					$("#addStartDate").focus();
					return;
				}//end if
				if(startDate > endDate){
					alert("마감일은 시작일 이후로 설정해주세요");
					$("#addEndDate").focus();
					return;
				}//end if 
				if($("#addExHall").val()==""){
					alert("전시장을 입력해주세요");
					$("#addExHall").focus();
					return;
				}
				var poster=$("#addExPoster").val();
				if(poster.trim()==""){
					alert("포스터를 입력해주세요");
					$("#addExPoster").focus();
					return;
				}
				if(!compareExt(poster)){
					alert("이미지만 업로드 가능합니다.\n 가능 확장자 png,jpg,gif,bmp");
					$("#addExPoster").focus();
					return;
				}
				var addImg = $("#addAddImg").val();
				if(addImg.trim()==""){
					alert("추가 이미지를 입력해주세요");
					$("#addAddImg").focus();
					return;
				}
				if(!compareExt(addImg)){
					alert("이미지만 업로드 가능합니다.\n 가능 확장자 png,jpg,gif,bmp");
					$("#addAddImg").focus();
					return;
				}
				var pattern_num= /^[0-9]+$/;
				
				if(!pattern_num.test(value[5].val())||!pattern_num.test(value[6].val())){
					alert("허용인원과 관람인원은 숫자로 입력해주세요");
					value[5].focus();
					return;
				}//end if
				if(!pattern_num.test(value[7].val())||!pattern_num.test(value[8].val())||!pattern_num.test(value[9].val())){
					alert("가격은 숫자로 입력해주세요");
					value[7].focus();
					return;
				}//end if
				$("#confirmAdd").modal('show');
			});//click
			$(".exit").click(function(){
				$("#confirmExit").modal('show');
			});
			$("#exitOk").click(function(){
				$("#confirmExit").modal('hide');
				$("#modifyModal").modal('hide');
				$("#addModal").modal('hide');
			})
		  })//ready;
		  
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
                                <table class="table table-hover" id="memberTab" >
                            	<thead> 
								   <tr>
	                                    <th>전시번호</th>
	                                    <th>전시명</th>
	                                    <th>입력일</th>
	                               </tr>
						  		</thead> 
						  		<tbody> 
						  		  <%
						  		 
						  		 if(count > 0 ){
	    						 	
	    						 		request.setAttribute("dataList",list);
	    						 		%>
	    						 		<c:forEach var="list" items="${dataList }">
                                    	<tr style="cursor:pointer" class="detailTab" data-bs-target="#modifyModal" data-bs-toggle="modal" data-num="${list.exNum }">
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
               	<div id="layoutAuthentication_footer">
             		<jsp:include page="admin_footer.html"/>
          		</div>
                 <!-- 전시 추가 modal  -->
	                <div class="modal fade" tabindex="-1" id="addModal" data-bs-backdrop="static" data-bs-keyboard="false">
					  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">전시 추가</h5>
					        <button type="button" class="btn-close exit"  aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					     <form id="addFrm" method="post"action="http://localhost/exhibition_three_manager/main/ajax/exhibition_add.jsp" enctype="multipart/form-data" target='blankifr'>
						      	<div class="mb-3">
								  <label for="exampleFormControlInput1" class="exTitle">전시명</label>
								  <input type="email" class="form-control" id="addExName" name="addExName" placeholder="전시명"  style="width:200px">
								</div>
						      	<div class="mb-3">
								  <label for="exampleFormControlInput1" class="exTitle">전시장 / 담당자</label>
							      	<select class="form-select" id="addExHall" name="addExHall"aria-label=".form-select-sm example" style="width:400px">
									  <option value="" selected>전시장 / 담당자를 선택해주세요</option>
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
					      	<div class="row">
					      	<div class="col-6">
					      	<label class="exTitle">시작일</label>
					      	<input type="date" id="addStartDate" name="addStartDate" class="form-control" placeholder="시작 일자" style="width:200px">
					      	</div>
					      	<div class="col-6">
					      	<label class="exTitle">마감일</label>
					      	<input type="date" id="addEndDate" name="addEndDate"class="form-control" placeholder="마감 일자" style="width:200px">
					      	</div>
					      	</div>
					      	</div>
					      	<div class="mb-3" >
						      	<label class="exTitle">전시 포스터</label>
						      	<div class="input-group mb-3" style="width:500px">
						      	
								  <input type="file" class="form-control" id="addExPoster" name="addExPoster">
						    	
								</div>
								<label class="exTitle">추가 이미지</label>
						      	<div class="input-group mb-3" style="width:500px">
								  <input type="file" class="form-control" id="addAddImg" name="addAddImg">
								</div>
					      	</div>
						    <div class="mb-3">
								<label for="exampleFormControlInput1" class="exTitle">전시 간단 소개</label>
								  <textarea class="form-control" id="addIntro"name="addIntro"  rows="3" style="width:500px"></textarea>
							</div>
						   
						      	<div class="mb-3">
								  <label for="exampleFormControlTextarea1" class="exTitle">전시 내용</label>
								  <textarea class="form-control" id="addInfo" name="addInfo" rows="10"></textarea>
								</div>
					      	<div class="row">
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="exTitle">허용인원</label>
								<input type="text" class="form-control" id="addTotalNum" name="addTotalNum" placeholder="100"  style="width:100px">
								</div>
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="exTitle">관람인원</label>
								<input type="text" class="form-control" id="addWatchNum" name="addWatchNum" placeholder="0"  style="width:100px">
								</div>
					      	</div>
							
							<div class="row">
							<label class="exTitle">전시 가격</label>
						    <div class="mb-3 col-4">
						    	<label class="exTitle">성인</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" aria-label="성인" id="addAdult" name="addAdult">
								  <span class="input-group-text" >원</span>
								</div>
							</div>
						    <div class="mb-3 col-4">
						    	<label class="exTitle">청소년</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" aria-label="청소년" id="addTeen"name="addTeen">
								  <span class="input-group-text" >원</span>
								</div>
							</div>
						    <div class="mb-3 col-4">
						    	<label class="exTitle">유아/65세 이상</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" aria-label="유아/65세 이상"id="addChild"name="addChild" >
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
					        <a type="button" class="btn btn-outline-dark exit">돌아가기</a>
					      	</div>
					      	<div class="col-6 text-center">
					        <button type="button" class="btn btn-outline-info" id="addExBtn">전시 추가</button>
					      	</div>
					      </div>
					      </div>
					      </div>
					    </div>
					  </div>
					</div>
				<!-- modal -->
                 <!-- 전시 수정&상세 modal  -->
	                <div class="modal fade" tabindex="-1" id="modifyModal" data-bs-backdrop="static" data-bs-keyboard="false"aria-hidden="true" >
					  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">전시 조회</h5>
					        <button type="button" class="btn-close exit" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					      <form id="modifyExhibition"action="http://localhost/exhibition_three_manager/main/ajax/exhibition_update.jsp" method="post" enctype="multipart/form-data" target='blankifr'>
					      <div class="row">
						      <div class="col-6">
							      <label class="exTitle">전시 번호 </label>
								  <input type="text" id="exNum" name="exNum" class="form-control" readonly="readonly" style="width:70px;height:30px;margin-bottom:20px;text-align:center;"/>	
						      </div>
						      <div class="col-6">
							      <label class="exTitle">전시 노출 여부 </label>
								  <input type="text" id="exStatus" name="exStatus" class="form-control" readonly="readonly" style="width:70px;height:30px;margin-bottom:20px;text-align:center;"/>	
						      </div>
					      </div>
						      	<div class="mb-3">
								  <label for="전시명" class="exTitle">전시명</label>
								  <input type="text" class="form-control" id="exName" name="exName" style="width:200px"/>
								</div>
						      	<div class="mb-3">
								  <label for="exampleFormControlInput1" class="exTitle">전시장 / 담당자</label>
							      	 	<select class="form-select" id="exHall" name="exHall"aria-label=".form-select-sm example" style="width:400px">
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
					      	<div class="row">
					      	<div class="col-6">
					      	<label class="exTitle">시작일</label>
					      	<input type="date" id="startDate" name="startDate" class="form-control" placeholder="시작 일자"  style="width:200px">
					      	</div>
					      	<div class="col-6">
					      	<label class="exTitle">마감일</label>
					      	<input type="date" id="endDate"name="endDate" class="form-control" placeholder="마감 일자" style="width:200px">
					      	</div>
					      	</div>
					      	</div>
					      	<div class="mb-3" >
						      	<label class="exTitle">전시 포스터</label>
						      	<div class="input-group mb-3" style="width:500px">
						      	 <input type="file" class="form-control" id="modifyExPoster" name="modifyExPoster">
						      	 <input type="hidden" id="hidPoster" name ="hidPoster"/>
								</div>
								  <img id="posterImg"/>
					      	</div>
						    <div class="mb-3">
								<label for="exampleFormControlInput1" class="exTitle">전시 간단 소개</label>
								  <textarea class="form-control" id="exIntro" name="exIntro" rows="3" style="width:500px"></textarea>
							</div>
						    <div class="mb-3">
								<label for="exampleFormControlInput1" class="exTitle">추가 이미지</label>
						      	<div class="input-group mb-3" style="width:500px">
						      	<input type="file" class="form-control" id="modifyAddImg" name="modifyAddImg">
						      	<input type="hidden" id="hidAddImg" name="hidAddImg"/>
								</div>
								  <img id="addImage"/>
							</div>
						      	<div class="mb-3">
								  <label for="exampleFormControlTextarea1" class="exTitle">전시 내용</label>
								  <textarea class="form-control" id="exInfo"name="exInfo" rows="10"></textarea>
								</div>
					      	<div class="row">
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="exTitle">허용인원</label>
								<input type="text" class="form-control" id="totalCount"name="totalCount" placeholder="100"  style="width:100px">
								</div>
						      	<div class="mb-3 col-6">
								  <label for="exampleFormControlTextarea1" class="exTitle">관람인원</label>
								<input type="text" class="form-control" id="watchCount"name="watchCount" placeholder="0"  style="width:100px">
								</div>
					      	</div>
							
							<div class="row">
							<label class="exTitle">전시 가격</label>
						    <div class="mb-3 col-4">
						    	<label class="exTitle">성인</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" id="adult" name="adult">
								  <span class="input-group-text">원</span>
								</div>
							</div>
						    <div class="mb-3 col-4">
						    	<label class="exTitle">청소년</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control" id="teen" name="teen">
								  <span class="input-group-text">원</span>
								</div>
							</div>
						    <div class="mb-3 col-4">
						    	<label class="exTitle">유아/65세 이상</label>
								<div class="input-group" style="width:150px">
								  <input type="text" class="form-control"id="child" name="child">
								  <span class="input-group-text">원</span>
								</div>
							</div>
							</div>
								
					      </form>
					      </div>
					      <div class="modal-footer">
					      			<button type="button" class="btn btn-outline-dark exit">돌아가기</button>
							        <button type="button" class="btn btn-outline-danger" id="deleteBtn">전시 삭제</button>
							        <button type="button" class="btn btn-outline-info" id="modifyBtn">전시 수정</button>
							        <button type="button" class="btn btn-outline-success" id="statusBtn">전시 노출</button>
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
				        <button type="button" class="btn btn-primary" onclick="updateExhibition()">Ok</button>
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
				        <button type="button" class="btn btn-primary" id="confirmDeleteOk" onclick="deleteExhibition()">Ok</button>
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
				        <button type="button" class="btn btn-primary" id="addExhibitionOk" onclick="addExhibition()">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- modal -->
				
				<!-- 전시 노출 확인 modal -->
				<div class="modal fade" id="confirmRelease" tabindex="-1"data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
				        <button type="button" class="btn btn-primary" onclick="releaseExhibition()">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- modal -->
				
				<!-- 종료 확인 modal -->
				<div class="modal fade" id="confirmExit" tabindex="-1"data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        지금 종료하면 작성했던 내용은 저장되지 않습니다.<br>
				        종료하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-primary" id="exitOk">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- modal -->
				
            </div>
        </div>
      
    </body>
    <iframe name='blankifr' style='display:none;'></iframe>
</html>
