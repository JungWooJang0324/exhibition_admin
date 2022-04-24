<%@page import="java.util.ArrayList"%>
<%@page import="DAO.BoardManagerDAO"%>
<%@page import="VO.BoardVO"%>
<%@page import="java.util.List"%>
<%@include file="admin_id_session.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="게시판"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Board</title>
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
        	#searchDiv{ margin-bottom: 30px; text-align: right}
      	/* 	#btnAddDiv{ text-align: right; margin-top: 20px; position: relative}
 			#pageNavigation{position: absolute; bottom: 20%; left: 50%} */
        	
        </style>
        
<script type="text/javascript">
$(function(){
	$("#btnAdd").click(function(){
		location.href="admin_add_board.jsp";
	});
	
	//게시글 상세보기 
	$(".trDetail").click(function(){
			
		//게시글 넘버(bd_id) 받기
		var bdId = $(this).children().find("input:hidden[name=bdId]").val();//클릭된 rnum 번호
		
		//게시글 넘버(bd_id) 확인
		console.log(bdId);
		
		//게시글 상세 모달 show
		$("#boardDetail").modal('show'); 
		
		//값 받아오기
		$.ajax({
			url:"http://localhost/exhibition_three_manager/main/boardData_detail.jsp",
			type:"post",
			data:{ "bdId":bdId	},
			dataType:"json",
			error:function(xhr){
				alert("※에러"+xhr.status);
			},
			success:function(jsonObj){
				$("#bdId_de").html(jsonObj.bdId);
				$("#inputDate_de").val(jsonObj.inputDate);
				$("#title_de").val(jsonObj.title);
				$("#userId_de").val(jsonObj.userId);
				$("#catNum_de").val(jsonObj.catNum);
				$("#catName_de").val(jsonObj.catName); 
				$("#description_de").val(jsonObj.description.replaceAll("br", "\n"));
				$("#imgFile_de").vals(jsonObj.imgFile);
			}
		}); 
	});
	
	 
	//게시글 수정 버튼 클릭 시 
	 $("#modifyBtn").click(function(){
		 
		 //게시글 상세 모달 사라지고 
		 $("#boardDetail").modal('hide');
		//수정 확인 모달 show
		 $("#confirmModify").modal('show');
		 
		 $("#modifyOk").click(function(){
			 $("#confirmModify").modal('hide');
			 
			$.ajax({
				url:"http://localhost/exhibition_three_manager/main/boardData_update.jsp",
				type:"post",
				data:{
					"bdId" : $("#bdId_de").text(),
					"catNum" : $("#catNum_de").val(),
					"title": $("#title_de").val(),
					"description": $("#description_de").val(),
					"inputDate_de": $("#inputDate_de").val(),
					"adminId_de" : $("#adminId_de").val(),
					"imgFile_de" : $("#imgFile_de").val(),
					"catName_de" : $("#catName_de").val(),
				},
				datatype:"json",
				error:function(xhr){
					alert("※에러"+xhr.status);
				},
				success:function(jsonObj){
					if(jsonObj.updateFlag){
						alert("업데이트 실패!")
						return;
					}	
						alert("성공!");
					
				}
			}); 
			location.reload();
		});// $("#modifyOk") .click 
	});// $("#modifyBtn").click
	 
	 
	//게시글 삭제
	$("#deleteBtn").click(function(){
		 
		//삭제 확인 모달 show
		 $("#confirmDelete").modal('show');
		 
		 $("#deleteOk").click(function(){
			$("#confirmDelete").modal('hide');
			 
			$.ajax({
				url:"http://localhost/exhibition_three_manager/main/boardData_delete.jsp",
				type:"get",
				data:{ "bdId_de": $("#bdId_de").text()},
				error:function(xhr){
					alert("※에러"+xhr.status);
				},
				datatype : "json",
				success:function(jsonObj){
					if(jsonObj.deleteFlag){
						alert("삭제 실패")
						return;
					}	
						alert("성공");
				}
			}); 
			location.reload();
		});// $("#modifyOk") .click 
	});// $("#modifyBtn").click 
	
});


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
                        <h1 class="mt-4">게시판 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp" style="text-decoration:none; color:#333;">Dashboard</a></li>
                            <li class="breadcrumb-item active">게시판 관리</li>
                        </ol>
                        <!-- 검색 div -->
                        <div class="card-body" style="width: 400px; float: right;">
                            <form class="d-flex">
	                        	 <select class="form-select" aria-label=".form-select-sm example"   >
									  <option value="title" selected="selected">제목 </option>
									  <option value="userId">작성자</option>
									  <option value="inputDate">작성일</option>
									  <option value="category">카테고리</option>
								</select>
	                        	<input type="text" class="form-control" style="margin-right: 10px">
	                        	<button type="button" class="btn btn-outline-dark btn-sm" style="height: 35px;">
	                        		<i class="fa-solid fa-magnifying-glass"></i>
	                       		</button>
						      </form>
                        </div>
                        <!-- 전시장 테이블 -->
                        <div class="card-content" style=" margin: 0px auto; clear:both;">
                            <div class="table-responsive">
                            	<table class="table table-hover" id="boardTab" style="text-align: center">
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
                                   	<jsp:useBean id="bDAO" class="DAO.BoardManagerDAO" scope="page"/> 
                                   <%
                                  	List<BoardVO> dList = bDAO.selectAllBoard(0,10);
                                  	pageContext.setAttribute("list", dList);
                                  	%>
                                  	<c:forEach var="bVO" items="${list}">
                                         <tr class="trDetail" style="cursor:pointer">
                                            <td><c:out value="${bVO.rnum}"/></td>
                                            <td><c:out value="${bVO.title}"/></td>                                          	
                                            <td><c:out value="${bVO.userId}"/></td>
                                            <td><c:out value="${bVO.inputDate}"/></td>
                                            <td><c:out value="${bVO.catName}"/></td>
                                   	 		<td><button id="deleteBtn" type="button" class="btn btn-secondary btn-sm">삭제</button></td>
	                                   	 	<td id="hiddenTd" style="padding: 0px;">
                                        		<input id="bdId" class="bdId" name="bdId" type="hidden" value="${bVO.bdId}"/>
                                        	</td>
	                                   	 </tr>
                                   	</c:forEach>
                                   	<c:if test="${empty list}">
                              			<tr>
                              				<td colspan="6">등록된 글이 없습니다</td>
                              			</tr>
                          			</c:if>
                                      </tbody>
                                   </table>
                                 </div>
                                <!-- 글쓰기 버튼 -->
                                <div>
						  			<button type="button" class="btn btn-dark" style="float:right;" id="btnAdd" data-bs-target="#addModal" data-bs-toggle="modal">글쓰기</button>
						  		</div>
                               </div>
               		 <!-- 페이지 이동 -->
                   	 <div id="pageNavigation">
							<ul class="pagination justify-content-center"> 
							</ul>
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
                <!-- 게시글 상세 Modal -->
				<div class="modal fade" id="boardDetail" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			 	<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">게시글 내용</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
					 	<table id="modalTab">
					 	<thead>
					 		<tr>
					 			<th style="width: 300px">글 번호</th>
					 			<th style="width: 300px">수정/작성 일자</th>
					 		</tr>
				 		</thead>
				 		<tbody>
					 		<tr>
					 			<td id="bdId_de" style="padding-bottom: 10px"></td>
					 			<td style="padding-bottom: 10px"><input type="date" id="inputDate_de" /></td>
					 		</tr>
					 		<tr>
					 			<th >제목</th>
					 			<th>카테고리</th>
					 			
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px" >
					 				<input type="text" id="title_de" />
				 				</td>
					 			<td style="padding-bottom: 10px"> 
									<select id="catName_de" name="catName_de">
										<jsp:useBean id="bVO" class="VO.BoardVO" scope="page"/> 
										<% List<BoardVO> list = new ArrayList<BoardVO>();
											list=bDAO.selectCategory();
											pageContext.setAttribute("list", list);
										%>
										<c:forEach var = "bVO" items="${list}">
											<option value="${bVO.catName}"><c:out value="${bVO.catName}"/></option>
										</c:forEach>
									</select>
									<input type="hidden" id="catNum_de" />
								</td>
					 		</tr>
					 		<tr>
					 			<th>작성자</th>
					 			<th>이미지</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px">
					 				<input type="text" id="userId_de" />
				 				</td>
								<td style="padding-bottom: 10px" >
									<input type="text" id="imgFile_de"/>
								</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2">글 내용</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px" colspan="2">
					 				<textarea id="description_de" style="overflow-y:scroll;width: 760px; height: 200px ">
					 				</textarea>
				 				</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2"></th>
					 		</tr>
					 		</tbody>
					 	</table>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal"  >돌아가기</button>
				        <button id="modifyBtn" type="button" class="btn btn-outline-info">게시글 수정</button>
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
				        <button id="modifyOk" type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 게시글 삭제 확인 모달  -->
				<div class="modal fade" id="confirmDelete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        게시글을 삭제하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button id="deleteOk" type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
            </div>
        </div>
    </body>
</html>
