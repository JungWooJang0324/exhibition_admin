<%@page import="VO.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="DAO.BoardManagerDAO"%>
<%@include file="admin_id_session.jsp" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="게시판"%>
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
});


</script> 
        </head>
 <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.html">Exhibition Admin</a>
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
									  <option value="" selected="selected">제목 </option>
									  <option value="">작성자</option>
									  <option value="">작성일</option>
									  <option value="">카테고리</option>
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
                                    <%
                                  	BoardManagerDAO bDAO = new BoardManagerDAO(); 
                                  	List<BoardVO> list = bDAO.selectBoardAdmin("");
                                  	for(BoardVO bVO: list){
                                  	%>
                                         <tr style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#boardDetail">
                                            <td><%= bVO.getBdId()%></td>
                                            <td><%=bVO.getTitle() %></td>                                          	
                                            <td><%=bVO.getUserId() %></td>
                                            <td><%=bVO.getInputDate() %></td>
                                            <td><%=bVO.getCatName() %></td>
                                   	 		<td><button type="button" class="btn btn-secondary btn-sm">삭제</button></td>
                                   	 <%}
                                   	if(list==null){%>
                              			<tr>
                              				<td colspan="3">"등록된 글이 없습니다."</td>
                              				<td><button type="button" class="btn btn-secondary btn-sm">삭제</button></td>
                              			</tr>
                           			<%}%>	 
                                      </tbody>
                                   </table>
                                 </div>
                                <!-- 글쓰기 버튼 -->
                                <div>
						  			<button type="button" class="btn btn-dark" style="float:right;" data-bs-target="#addModal" data-bs-toggle="modal">글쓰기</button>
						  		</div>
                               </div>
                               <!-- 페이지 이동 -->
	                            <div> 
								<ul class="pagination justify-content-center"> 
									<li ><a style="margin-right:5px;text-decoration:none;"class="text-secondary" href="">이전</a></li> 
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
                <!-- 게시글 내용 Modal -->
				<div class="modal fade" id="boardDetail" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			 	<div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">게시글 내용</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
					 	<table id="modalTab" style="width: 98%">
					 	<thead>
					 		<tr>
					 			<th style="width: 300px">글 번호</th>
					 			<th style="width: 300px">수정/작성 일자</th>
					 		</tr>
				 		</thead>
				 		<tbody>
					 		<tr>
					 		<% BoardVO bVO= bDAO.selectBoardDetail(1); %>
					 			<td><%=bVO.getBdId()%></td>
					 			<td><%=bVO.getInputDate()%></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2">제목</th>
					 		</tr>
					 		<tr>
					 			<td  colspan="2"><%=bVO.getTitle()%></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2">작성자</th>
					 		</tr>
					 		<tr>
					 			<td colspan="2"><%=bVO.getUserId()%></td>
					 		</tr>
					 		<tr>
					 			<th>카테고리</th>
					 			<th>카테고리 번호</th>
					 		</tr>
					 		<tr>
					 			<td>
									<select>
						 			<% switch(bVO.getCatNum()){
					 					case 1 : %>	
											<option value="Q&A" selected>QnA</option>
										<% case 2 : %>
											<option>후기</option>
					 				<%} %>
									</select>
								</td>
								<td><%=bVO.getCatNum()%></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2">글 내용</th>
					 		</tr>
					 		<tr>
					 			<td colspan="2"><textarea style="overflow-y:scroll;width: 760px; height: 200px "><%=bVO.getDescription().replaceAll("br", "\n")%></textarea></td>
					 		</tr>
					 		</tbody>
					 	</table>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal"  >돌아가기</button>
				        <button type="button" class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#confirmModify">게시글 수정</button>
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
