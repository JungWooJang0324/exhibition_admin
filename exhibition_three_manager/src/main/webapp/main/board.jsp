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
        	
        </style>
        
<script type="text/javascript">

$(function(){
	
	$("#searchBtn").click(function(){
		document.searchFrm.submit();		
	});
	 
	
	//글쓰기버튼 클릭
	$("#btnAdd").click(function(){
		location.href="admin_add_board.jsp";
	});
	
	//게시글 상세보기 
	$(".trDetail").click(function(){
			
		var bdId = $(this).children().find("input:hidden[name=bdId]").val();
		
		//게시글 넘버(bd_id) 확인
		//console.log(bdId);
		
		$("#boardDetail").modal('show'); 
		
		$.ajax({
			url:"http://localhost/exhibition_three_manager/main/ajax/boardDetailAjax.jsp",
			type:"post",
			data:{ "bdId":bdId	},
			dataType:"json",
			error:function(xhr){
				console.log("※에러"+xhr.status);
				location.href="admin_error.html";
			},
			success:function(jsonObj){
				$("#bdId_de").val(jsonObj.bdId);
				$("#inputDate_de").val(jsonObj.inputDate);
				$("#title_de").val(jsonObj.title);
				$("#id_de").val((jsonObj.userId==""||jsonObj.userId==null)? jsonObj.adminId:jsonObj.userId );
				$("#catName_de").val(jsonObj.catNum); 
				$("#description_de").val(jsonObj.description.replaceAll("br", "\n"));
				$("#imgFile_de").val(jsonObj.imgFile);
			}
		}); 
	});
	
	 
	//게시글 수정 버튼 클릭 시 
	 $("#modifyBtn").click(function(){
		 
		 $("#confirmModify").modal('show');
		 
		 $("#modifyOk").click(function(){
			 $("#confirmModify").modal('hide');
			$.ajax({
				url:"http://localhost/exhibition_three_manager/main/ajax/boardUpdateAjax.jsp",
				type:"post",
				data:{
					"catNum" : $("#catName_de").val(),
					"title": $("#title_de").val(),
					"description": $("#description_de").val(),
					"bdId" : $("#bdId_de").val()
				},
				datatype:"json",
				error:function(xhr){
					alert("※에러"+xhr.status);
				},
				success:function(jsonObj){
					if(jsonObj.cnt!=0){
						alert("업데이트 성공!");
						location.reload();
					}else{
						alert("업데이트 실패!");
					}	
				}
			}); 
		});// $("#modifyOk") .click 
	});// $("#").click
	
	
});


//게시글 삭제
function deletePost( dbId ){
	//tr클릭 게시글 상세 팝업 막기
	event.stopPropagation(); 
	
	 $("#confirmDelete").modal('show');
	 
	 $("#deleteOk").click(function(){
		$("#confirmDelete").modal('hide');
		$.ajax({
			url:"http://localhost/exhibition_three_manager/main/ajax/boardDeleteAjax.jsp",
			type:"post",
			data:{ "bdId_de": dbId },
			error:function(xhr){
				alert("※에러"+xhr.status);
			},
			datatype : "json",
			success:function(jsonObj){
				if(jsonObj.cnt!=0){
					alert("삭제 성공!");
					location.reload();
				}else{
					alert("삭제 실패!");
				}	 
			}
		}); 
	});// $("#modifyOk") .click 
}

function chkByte(obj, maxByte){
	var str = obj.value;
	var str_len = str.length;

	var rbyte = 0;
	var rlen = 0;
	var one_char = "";
	var str2 = "";

	for(var i=0; i<str_len; i++){
		one_char = str.charAt(i);
		
		if(escape(one_char).length > 4){
		    rbyte += 3;                                         //한글3Byte
		}else{
		    rbyte++;                                            //영문 등 나머지 1Byte
		}
	
		if(rbyte <= maxByte){
		    rlen = i+1;                                          //return할 문자열 갯수
		}
	}

	if(rbyte > maxByte){
	    alert("한글 "+Math.floor(maxByte/3)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	    str2 = str.substr(0,rlen);                                  //문자열 자르기
	    obj.value = str2;
	    fnChkByte(obj, maxByte);
	    return;
	}
}
<%
BoardManagerDAO bDAO = new BoardManagerDAO();


//한 페이지 출력 글 수
int pageSize = 5;

//한 페이지 정보 설정
String pageNum = request.getParameter("pageNum"); 
if(pageNum == null){
	pageNum = "1";
}

//각 페이지의 첫 행 번호 // 마지막 번호
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1; 
int endRow = currentPage * pageSize;

String option  = request.getParameter("option"); //검색 조건 
String keyword  = request.getParameter("keyword");//검색 단어

//전시장 총 개수
int cnt = bDAO.getTotalRows(option, keyword);

//넘버링
int number = cnt; 
if(option==null||"".equals(option)){  
	option = "title";
}
if(keyword==null||"".equals(keyword)){ 
	keyword = "";
	number = cnt - ((currentPage - 1) * pageSize);
}

%>
</script> 
 </head>
 <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="http://localhost/exhibition_three_manager/main/index.jsp">Exhibition Admin</a>
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
                        <h1 class="mt-4">게시판 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp" style="text-decoration:none; color:#333;">Dashboard</a></li>
                            <li class="breadcrumb-item active">게시판 관리</li>
                        </ol>
                        <!-- 검색 div -->
                        <div class="card-body" style="width: 400px; float: right;">
                            <form class="d-flex" id = "searchFrm" class="d-flex" name="searchFrm" action="http://localhost/exhibition_three_manager/main/board.jsp">
	                        	 <select name = "option" id="option" class="form-select" aria-label=".form-select-sm example"   >
									  <option ${param.option =="title"? "selected":""} value="title">제목 </option>
									  <option ${param.option =="userid"? "selected":""} value="userid">작성자</option>
									  <option ${param.option =="input_date"? "selected":""} value="input_date">작성일</option>
									  <option ${param.option =="cat_name"? "selected":""} value="cat_name">카테고리</option>
								</select>
	                        	<input type="text" id="search"  name="keyword" value="${param.keyword}" class="form-control" style="margin-right: 10px">
	                        	<button type="button" id="searchBtn" class="btn btn-outline-dark btn-sm" style="height: 35px;">
	                        		<i  class="fa-solid fa-magnifying-glass"></i>
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
                                  	List<BoardVO> dList = bDAO.selectBoard(startRow, pageSize, option, keyword);
                                  	pageContext.setAttribute("list", dList);
                                  	%>
                                  	<c:forEach var="bVO" items="${list}">
                                         <tr class="trDetail" style="cursor:pointer">
                                        <%--  <td><c:out value="${bVO.rnum}"/></td>  --%>
                                            <td><%=number-- %></td>
                                            <td><c:out value="${bVO.title}"/></td>                                          	
                                            <td>
                                            	<c:choose>
                                            	<c:when test="${bVO.userId !=null }">
                                           			 <c:out value="${bVO.userId}"/>
												</c:when>
                                            	<c:when test="${bVO.adminId !=null}">
                                           			 <c:out value="${bVO.adminId}"/>
												</c:when>
                                            	</c:choose>
                                           	</td>
                                            <td><c:out value="${bVO.inputDate}"/></td>
                                            <td><c:out value="${bVO.catName}"/></td>
                                   	 		<td><button id="deleteBtn" type="button" class="btn btn-secondary btn-sm" onclick="deletePost(${bVO.bdId})">삭제</button></td>
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
								<%
									if(cnt!=0){
										
										//전체 페이지 수
										int pageCount = cnt / pageSize + (cnt%pageSize == 0 ? 0:1);
										
										//한 페이지에 보여질 페이지 개수
										int pageBlock = 5; 
										
										//한 페이지에 보여줄 페이지 블럭 시작 번호
										int startPage = ((currentPage-1)/pageBlock)*pageBlock+1; 
										
										//한 페이지에 보여줄 페이지 블럭 끝 번호 
										int endPage = startPage + pageBlock-1; 
										if(endPage > pageCount){
											endPage = pageCount; 
										}
									
								%>
								<%if(startPage>pageBlock){ %>
									<li>
										<a  href="board.jsp?pageNum=<%=startPage - pageBlock %>&option=${param.option}&keyword=${param.keyword}" style="margin-right:10px;text-decoration:none;"class="text-secondary page-item">이전</a>
									</li>
								<%}
								  for(int i=startPage; i<=endPage; i++){
								  	if(i==currentPage){%>
										<li><a style="margin-right:10px;text-decoration:none;"class="text-secondary">
											<%=i %>
										</a></li>
									<%}else{%>
										<li><a href="board.jsp?pageNum=<%=i %>&option=${param.option}&keyword=${param.keyword}" style="margin-right:10px;"class="text-secondary page-item">
											<%=i %>
										</a></li>
								<%		}
							  		}
							  		
							  		if(endPage<pageCount){%>	
							  			<li>
										<a  href="board.jsp?pageNum=<%=startPage + pageBlock %>&option=${param.option}&keyword=${param.keyword}" style="margin-right:10px;text-decoration:none;"class="text-secondary page-item page-item">다음</a>
										</li>
								<%	}
						  		}%>
						  		
							</ul>
               		</div>
                </main>
                	<jsp:include page="admin_footer.html"/>
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
					 			<td>
					 				<input type="text" id="bdId_de"  name="bdId_de" class="form-control" readonly="readonly" style="width:100px;height:30px;margin-bottom:20px;"/>
					 			</td>
					 			<td>
					 				<input type="text" id="inputDate_de" name="inputDate_de" class="form-control" readonly="readonly" style="width:120px;height:30px;margin-bottom:20px;"/>
					 			</td>
					 		</tr>
					 		<tr>
					 			<th >제목</th>
					 			<th>카테고리</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 20px;" >
					 				<input type="text" id="title_de" class="form-control" style="width: 200px" onKeyUp="javascript:chkByte(this,'100')"/>
				 				</td>
					 			<td style="padding-bottom: 20px"> 
									<select id="catName_de" name="catName_de" class="form-select">
										<jsp:useBean id="bVO" class="VO.BoardVO" scope="page"/> 
										<% List<BoardVO> list = new ArrayList<BoardVO>();
											list=bDAO.selectCategory();
											pageContext.setAttribute("list", list);
										%>
										<c:forEach var = "bVO" items="${list}">
											<option value="${bVO.catNum}"><c:out value="${bVO.catName}"/></option>
										</c:forEach>
									</select>
								</td>
					 		</tr>
					 		<tr>
					 			<th>작성자</th>
					 			<th>이미지</th>
					 		</tr>
					 		<tr>
					 			<td >
				 					<input type="text" id="id_de"  name="id_de" class="form-control" readonly="readonly" style="width:200px; height:30px;margin-bottom:20px;"/>
				 				</td>
								<td >
									<input type="text" id="imgFile_de"  name="imgFile_de" class="form-control" readonly="readonly" style="width:300px;height:30px;margin-bottom:20px;"/>
								</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2">글 내용</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 20px" colspan="2">
					 				<textarea id="description_de" class="form-control" style="overflow-y:scroll;width: 760px; height: 200px ">
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
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal" >돌아가기</button>
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
