<%@page import="DAO.AdminMemberDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="VO.MemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="DAO.AdminMemberDAO"%>
<%@ include file="admin_id_session.jsp" %>
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
     
  	function detailMember(id,name,date,addr1,addr2,zipcode,tel){
	  	 $("#memberDetail").on('show.bs.modal',function(e){
	  		var idServer = id.split('@');
	  		$("#id").val(idServer[0]);
	  		$("#server").val(idServer[1]);
	  		$("#userName").val(name);
	  		$("#tel").val(tel);
	  		$("#zipcode").val(zipcode);
	  		$("#address1").val(addr1);
	  		$("#address2").val(addr2);
	  		$("#subDate").val(date);
	  	}).modal('show');
  	}
  	function modifyMember(){
			$("#confirm").modal("hide");
	  		$("#memberDetail").modal('hide');
			
	  		let name=$("#userName").val();
			let tel=$("#tel").val();
			let zipcode=$("#zipcode").val();
			let address1=$("#address1").val();
			let address2=$("#address2").val();
			let isDeleted="f";
			
	  		if($("#confirmHid").val()=="delete"){
				name="-"; tel="-"; zipcode="-"; address1="-"; address2="-"; isDeleted="t";
			}
			var id = $("#id").val()+"@"+$("#server").val();
			if($("#server").val()==""){
				id=$("#id").val();
			}//end if
			
			$.ajax({
				url:"http://localhost/exhibition_three_manager/main/ajax/member_ajax.jsp",
				data : {
					"id":id,
					"name" : name,
					"tel" : tel,
					"zipcode" : zipcode,
					"address1" : address1,
					"address2" : address2,
					"isDeleted" : isDeleted
				},
				dataType:"json",
				error : function(xhr){
					alert(xhr.status);
				},
				success : function(jsonObj){
					var msg = "실패";
					if(jsonObj.updateFlag){
						msg="성공";
					}//end if
					alert(msg);
					location.reload();
				}
		});//ajax  
	}
  	$(function(){
  		$("#searchBtn").click(function(){
  			//검색어 submit
  			document.dataSearchFrm.submit();		
  		});//click
  		
  		$("#modifyBtn").click(function(){
  			var title = ["이름","전화번호","우편번호","주소","상세주소"];
  			var data = [$("#userName"),$("#tel"),$("#zipcode"),$("#address1"),$("#address2")];
  			for(var i = 0; i < data.length; i++){//유효성 검사
  				if(data[i].val()==""){
  					alert(title[i]+"을(를) 입력해주세요");
  					data[i].focus();
  					return;
  				}//end if
  			}//end for
  			$("#confirm").on('show.bs.modal',function(){
  				$("#confirmMsg").text("회원을 수정하시겠습니까?");
  				$("#confirmHid").val("modify");
  			}).modal("show");
  		});//click	
  			
  		$("#deleteBtn").click(function(){
  			$("#confirm").on('show.bs.modal',function(){
  				$("#confirmMsg").text("회원을 삭제하시겠습니까?");
  				$("#confirmHid").val("delete");
  			}).modal("show");
  		});//click
  	});//ready
  	
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
 		query="userid";
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
 	AdminMemberDAO aDAO = new AdminMemberDAO();
 	count = aDAO.getCount(field,query); // 데이터베이스에 저장된 총 갯수
 	
 	List<MemberVO> list = null;
 	if (count > 0) {
 		// getList()메서드 호출 / 해당 레코드 반환
 		list = aDAO.selectMember(startRow, endRow, field, query);
 	}
 %>
    
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
                            <form action="http://localhost/exhibition_three_manager/main/admin_member.jsp" name="dataSearchFrm" class="d-flex" style="float:right">
			                         <div class="input-group mb-3" style="width:300px;">
										 <select class="form-select" aria-label=".form-select-sm example" name="dataSearchItem" style="height:35px;">
											  <option ${(param.dataSearchItem =="name")?"selected":""} value="name">이름</option>
											  <option ${(param.dataSearchItem =="userid")?"selected":""} value="userid">아이디</option>
											  <option ${(param.dataSearchItem =="isubscribe_date")?"selected":""} value="isubscribe_date">가입일</option>
										  </select>
										  <input type="text" class="form-control" value="${param.dataSearchText}" name="dataSearchText"style="width:100px;height:35px; margin-right:10px;">
										  <button type="button" class="btn btn-outline-dark btn-sm" id="searchBtn" style="height: 35px;">
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
						  		 
						  		 if(count > 0 ){
	    						 		
	    						 		request.setAttribute("dataList",list);
	    						 		%>
	    						 		<c:forEach var="data" items="${dataList}">
                                    	<tr style="cursor:pointer" 
                                    	onclick="detailMember('${data.userId}','${data.name }','${data.isubscribeDate}','${data.address1}','${data.address2}','${data.zipcode}','${data.tel}')">
	    						 			<td><input type="hidden" name="userId" id="userId"  value="<c:out value="${data.userId }"/>"><c:out value="${data.userId }"/></td>
	    						 			<td><c:out value="${data.name}"/></td>
	    						 			<td><c:out value="${data.isubscribeDate}"/></td>
	    						 		</tr>
	    						 		</c:forEach>
	    						 		<%
	    						 		}else{
											%>
											<tr>
											<td colspan="3">조회 데이터가 없습니다.</td>
											</tr>											
											<%		    						 		
	    						 		
	    						 		}//end else
	    						 		%>
						  	</tbody> 
						  </table>
						  
                            </div>
                               <div id="pageNavigation">
								<ul class="pagination justify-content-center"> 
								<%
								if(count > 0){
									int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1); //레코드 수에 따른 페이지 수 구하기
									
									int pageBlock=5; // 한번에 보여질 페이지 번호의 갯수
									
									int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;//첫페이지 번호
									
									int endPage = startPage + pageBlock - 1;//마지막 페이지 번호

									if(endPage > pageCount){
										endPage = pageCount;
									}
									
									if(startPage > pageBlock){ // 11,21,31...페이지 이상 넘어갔을 경우 이전 버튼이 보인다
										%>  
									<li>
								<a style="margin-right:10px;text-decoration:none;"class="text-secondary page-item" href="admin_member.jsp?pageNum=<%=startPage-5%>&dataSearchItem=${param.dataSearchItem}&dataSearchText=${param.dataSearchText}">
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
											 }else{ //현재 페이지가 아닌 경우 링크 설정
												 %>
											<li>
											<a style="margin-right:10px;text-decoration:none;"class="text-secondary" id="pNum"href="admin_member.jsp?pageNum=<%=i%>&dataSearchItem=${param.dataSearchItem}&dataSearchText=${param.dataSearchText}">
											<%=i %>
											</a>
											</li> 
												  <% 										
											 }//end else
											 %>
										<%
										 }//end for
											if(endPage < pageCount){
										%>
										<li>
										<a style="margin-right:10px;text-decoration:none;"class="text-secondary" href="admin_member.jsp?pageNum=<%=startPage+5%>&dataSearchItem=${param.dataSearchItem}&dataSearchText=${param.dataSearchText}">
										다음
										</a>
										</li> 
										 <% 
											}//end if
								}//end if
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
	               <!-- 회원 수정 modal  -->
	                <div class="modal fade" tabindex="-1" id="memberDetail" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false" >
					  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">회원 수정</h5>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					      	<div class="text-secondary">ID(Email)</div>
					      	<div class="input-group input-group-sm mb-3" style="width:450px">
							  <input type="text" class="form-control" id="id" placeholder="Username" readonly/>
							  <span class="input-group-text">@</span>
							  <input type="text" class="form-control" id="server" placeholder="Server" readonly/>
							</div>
					      	<div class="text-secondary">이름</div>
					      	<div class="input-group input-group-sm mb-3" style="width:200px">
					      	<input type="text" class="form-control" id="userName" placeholder="이름" readonly/>
							</div>
					      	<div class="text-secondary">전화번호</div>
					      	<div class="input-group input-group-sm mb-3" style="width:200px">
							  <input type="text" class="form-control" id="tel"placeholder="전화번호"/>
							</div>
					      	<div>우편번호</div>
					      	<div class="input-group input-group-sm mb-3" style="width:250px">
							  <input type="text" class="form-control" id="zipcode" placeholder="우편번호" />
							   <button class="btn btn-outline-info" type="button" id="searchZipcode">우편번호검색</button>
							</div>
					      	<div class="row"><div class="col-6">주소</div> <div class="col-6">상세주소</div></div>
					      	<div class="row">
					      	<div class="col-6">
					      	<div class="input-group input-group-sm mb-3" style="width:250px">
							  <input type="text" class="form-control" id="address1" placeholder="주소"/>
							</div>
					      	 </div>
					      	<div class="col-6">
					      	<div class="input-group input-group-sm mb-3" style="width:350px">
							  <input type="text" class="form-control" id="address2" placeholder="상세주소"/>
							</div>
					      	</div> 
					      	 </div>
					      	<div>가입일</div>
					      	<div class="input-group input-group-sm mb-3" style="width:200px">
							<input type="text" class="form-control" id="subDate" placeholder="가입일"readonly/>
							</div>
					      </div>
					      <div class="modal-footer">
							        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">돌아가기</button>
							        <button type="button" class="btn btn-outline-danger" id="deleteBtn">회원 삭제</button>
							        <button type="button" class="btn btn-outline-info" id="modifyBtn">회원 수정</button>
					      </div>
					    </div>
					  </div>
					</div>
				<!-- modal -->
				<!-- 확인 modal -->
		 		<div class="modal fade" id="confirm" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"  aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        <span id="confirmMsg"></span>
				        <input type="hidden" id="confirmHid" value=""/>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-primary" id="modifyOkBtn" onclick="modifyMember()">Ok</button>
				      </div>
				    </div>
				  </div>
				</div> 
				<!--  -->
            </div>
        </div>
             
      
    </body>
</html>
