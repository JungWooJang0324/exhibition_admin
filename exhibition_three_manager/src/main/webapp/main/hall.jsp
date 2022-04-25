<%@page import="javax.imageio.plugins.tiff.ExifGPSTagSet"%>
<%@page import="DAO.ExHallManagerDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.apache.catalina.mbeans.UserMBean"%>
<%@page import="java.util.List"%>
<%@page import="VO.ExHallVO"%>
<%@include file="admin_id_session.jsp" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="전시장"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Exhibition Hall</title>
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
        <!-- 다음 우편번호 api -->
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
 	hr {width:200px; margin: 0px auto; margin-top:10px;}
</style>
<script  type="text/javascript">
$(function(){

	//전시장 상세보기 
	$(".trDetail").click(function(){
			
		//히든 전시장 넘버(ex_hall_num) 받기
		var hallNum = $(this).children().find("input:hidden[name=exHallName]").val();//클릭된 rnum 번호
		
		//넘버(ex_hall_num) 확인
		console.log(hallNum);
		
		//전시 상세 모달 show
		$("#hallDetail").modal('show');
		
		//값 받아오기
		$.ajax({
			url:"http://localhost/exhibition_three_manager/main/ajax/hallDetailAjax.jsp",
			type:"post",
			data:{ "hallNum":hallNum	},
			dataType:"json",
			error:function(xhr){
				alert("※에러"+xhr.status);
			},
			success:function(jsonObj){
				$("#exName_de").val(jsonObj.exName);
				$("#exNum_de").html(jsonObj.exNum);
				$("#addr_de").val(jsonObj.addr1);
				$("#addr_de").val(jsonObj.addr2);
				$("#zipcode_de").val(jsonObj.zipcode);
				$("#lat_de").val(jsonObj.latitude);
				$("#long_de").val(jsonObj.longitude);
				$("#mgrName_de").val(jsonObj.mgrName);
				$("#mgrTel_de").val(jsonObj.mgrTel);
				$("#exTel_de").val(jsonObj.exTel);
			}
		});
	});
	
	//전시 추가
	//메인 추가 버튼
	 $("#btnAdd").click(function(){
		
		 //전시 추가 모달 
		$("#addHall").modal('show');
		
		 //전시 추가 모달 확인 버튼 클릭
		$("#add").click(function(){
			//null 체크
			if($("#exName_add").val()==""|| $("#exLoc_add").val()=="" || $("#addr1_add").val()==""||
					$("#addr2_add").val()==""||  $("#zipcode_add").val()==""|| $("#lat_add").val()==""||
					$("#long_add").val()==""||	$("#mgrName_add").val()==""|| $("#mgrTel_add").val()==""||
					$("#exTel_add").val()==""){
						
				$("#nullChk").modal('show');
				return;
			}
			
			//추가 확인 모달
			$("#confirmAdd").modal('show');
			
			//추가 확인 모달 ok 클릭
			$("#addOk").click(function(){
				$("#confirmAdd").modal('hide'); //추가 확인 모달 사라지고
				$.ajax({
					url:"http://localhost/exhibition_three_manager/main/ajax/hallInsertAjax.jsp",
					type:"post",
					data:{
						exName_add : $("#exName_add").val(), 
						exLoc_add : $("#exLoc_add").val(), 
						addr1_add : $("#addr1_add").val(),
						addr2_add : $("#addr2_add").val(),
						zipcode_add : $("#zipcode_add").val(),
						lat_add : $("#lat_add").val(),
						long_add : $("#long_add").val(),
						mgrName_add : $("#mgrName_add").val(),
						mgrTel_add : $("#mgrTel_add").val(),
						exTel_add : $("#exTel_add").val()
					},
					error:function(xhr){
						alert("에러"+xhr.status);
					},
					success:function(){
						$("#addAlert").modal("show"); //추가되었다는 메시지
					}
				});
				//추가 후 새로고침
				location.reload();
			});//$("#addOk").click
		});//$("#add").click 
		
		//모달 안의 값 삭제
		$("#exName_add").val()=="";	$("#exLoc_add").val()=="" ;	$("#addr1_add").val()=="" ;
		$("#addr2_add").val()=="";  $("#zipcode_add").val()==""; $("#lat_add").val()=="";
		$("#long_add").val()=="";	$("#mgrName_add").val()==""; $("#mgrTel_add").val()==""; $("#exTel_add").val()==""
	 
	 }); // $("#btnAdd").click
	
	 
	 
	//전시장 수정 버튼 클릭 시 
	 $("#modifyBtn").click(function(){
		 
		 //전시 상세 모달 사라지고 
		 $("#hallDetail").modal('hide');
		//수정확인 모달 show
		 $("#confirmModify").modal('show');
		 
		 $("#modifyOk").click(function(){
			 $("#confirmModify").modal('hide');
			 
			$.ajax({
				url:"http://localhost/exhibition_three_manager/main/ajax/hallUpdateAjax.jsp",
				type:"post",
				data:{
					"exName_de" : $("#exName_de").val(),
					"hallNum_de": $("#exNum_de").text(),
					"addr1_de": $("#addr1_de").val(),
					"addr2_de": $("#addr2_de").val(),
					"zipcode_de" : $("#zipcode_de").val(),
					"lat_de" : $("#lat_de").val(),
					"long_de" : $("#long_de").val(),
					"mgrName_de" : $("#mgrName_de").val(),
					"mgrTel_de" : $("#mgrTel_de").val(),
					"exTel_de" : $("#exTel_de").val()				
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
	 
	 
	//전시장 삭제
	$("#deleteBtn").click(function(){
		 
		 //전시 상세 모달 사라지고 
		 $("#hallDetail").modal('hide');
		//수정확인 모달 show
		 $("#confirmDelete").modal('show');
		 
		 $("#deleteOk").click(function(){
			$("#confirmDelete").modal('hide');
			 
			$.ajax({
				url:"http://localhost/exhibition_three_manager/main/ajax/hallDeleteAjax.jsp",
				type:"get",
				data:{ "hallNum_de": $("#exNum_de").text()},
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
	
	
	
	//주소 찾기 (daum 주소찾기 api)
	$("#addr1_add").click(function(){
	   findAddr();
	});
	//주소 찾기 (daum 주소찾기 api)
	$("#addr2_de").click(function(){
	   findAddr();
	});
});//ready

function findAddr(){
	 new daum.Postcode({
	        oncomplete: function(data) {
	        	 // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 			$('#zipcode_add').val(data.zonecode);      // 우편번호(5자리)
 			$('#addr1_add').val(data.address);       // 기본주소 
	        }
	    }).open();
}
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
                        <h1 class="mt-4">전시장 관리</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp" style="text-decoration:none; color:#333;">Dashboard</a></li>
                            <li class="breadcrumb-item active">전시장 관리</li>
                        </ol>
                        <!-- 검색 div -->
                         <div  style="width: 400px; float: right; margin-bottom: 10px">
                            <form class="d-flex" id="searchFrm" action="http://localhost/local_prj2/main/hall2.jsp">
		                        	 <select name = "search" class="form-select" aria-label=".form-select-sm example"  >
										  <option value="exNum">전시장 번호 </option>
										  <option value="exName">전시장명</option>
										  <option value="exLoc">전시 위치</option>
									</select>
		                        	<input type="text" class="form-control" style="margin-right: 10px">
		                        	<button type="button" id="searchBtn" class="btn btn-outline-dark btn-sm" style="height: 35px;">
		                        		<i class="fa-solid fa-magnifying-glass"></i>
		                       		</button>
						      </form>
                        </div>
                        <!-- 전시장 테이블 -->
                        <div class="card-content" style="margin: 0px auto; clear:both;">
                            <div class="table-responsive">
                            	<form>
                            	<table class="table table-hover" id="hallTab" style="text-align: center">
                                    <thead>
                                        <tr>
                                            <th style="width: 300px">전시장 번호</th>
                                            <th>전시장 명</th>
                                            <th style="width: 400px">전시 위치</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                  	<%
  	    						 		ExHallManagerDAO ehmDAO = new ExHallManagerDAO();
  	                                  	List<ExHallVO> dlist = ehmDAO.selectAllExHall(0,10);
  	                                	pageContext.setAttribute("list", dlist);
                                  	%>
                                  	<c:forEach var="exVO" items="${list}">
                                        <tr style="cursor:pointer" class = "trDetail" >
                                            <td><c:out value="${exVO.rnum}"/></td>
                                            <td><c:out value="${exVO.exName}"/></td>                                          	
                                            <td><c:out value="${exVO.exLoc}"/></td>
                                            <td id="hiddenTd" style="padding: 0px;">
                                        		<input id="exHallName" class="exHallName" name="exHallName" type="hidden" value="${exVO.exHallNum}"/>
                                        	</td>
                                        </tr>
                                     </c:forEach>
                                   	<c:if test="${empty list}">
                              			<tr><td colspan="3">저장된 값이 없습니다</td></tr>
                           			</c:if>
                                     </tbody>
                                  </table>
                                  </form>
                                </div>
                              	<!-- 버튼 Div -->
                              	<div>
						  			<input type="button" id="btnAdd" class="btn btn-dark" style="float:right;" value="전시장 추가"/>
						  		</div>
                            </div>
                            <!-- 페이지 이동 -->                            
                            <div id="pageNavigation">
								<ul class="pagination justify-content-center"> 
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
				<!-- 전시장 추가 Modal -->
				<div class="modal fade" id="addHall" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true" >
				 <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable" >
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">전시장 추가</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body" >
				      	<form id="hallAddFrm" action="admin_">
					 	<table class="modalTab" style="margin: 0px auto; " >
					 		<tr>
					 			<th colspan="2" >전시장</th>
					 		</tr>
					 		<tr>
					 			<td>
					 				<input id="exName_add" type="text" name="exHall" placeholder="전시장명" style="margin-bottom: 10px"/>
				 				</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2">지역</th>
					 		</tr>
					 		<tr>
					 			<td  style="padding-bottom: 10px">
									<select class="inputBox" id="exLoc_add" name="exLoc">
										<option value="서울">서울</option>
										<option value="경기">경기</option>
										<option value="강원">강원</option>
										<option value="충북">충북</option>
										<option value="충남">충남</option>
										<option value="경북">경북</option>
										<option value="경남">경남</option>
										<option value="전북">전북</option>
										<option value="전남">전남</option>
										<option value="제주">제주</option>
									</select>
								</td>
					 		</tr>
					 		<tr>
					 			<th class="modalTh" style="width: 300px">주소</th><th class="modalTh">우편번호</th>
					 		</tr>

					 		<tr>
					 			<td>
					 				<input type="text" id="addr1_add" name="addr" placeholder="주소" />
				 				</td>
				 				<td style="padding-bottom: 10px">
				 					<input id="zipcode_add"type="text" name="zipcode" placeholder="우편번호" />
			 					</td>
					 		</tr>
					 		<tr>
					 			<td colspan="2" style="padding-bottom: 10px">
					 				<input type="text" id="addr2_add" name="addr" placeholder="상세주소" />
				 				</td>
					 		</tr>
					 		<tr>
					 			<th>위도</th><th >경도</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px">
					 				<input id="lat_add"  type="text" name="latitude" placeholder="위도" />
				 				</td>
			 					<td style="padding-bottom: 10px">
			 						<input id="long_add" type="text" name="longitutde" placeholder="경도" />
		 						</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" >전시장 담당자</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px">
					 				<input id="mgrName_add" type="text" name="mgrName" placeholder="담당자명" />	
				 				</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" >전시 담당자 번호</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px" >
					 				<input id="mgrTel_add" type="text" name="mgrTel" placeholder="담당자 번호" />
					 			</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" >전시장 번호</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px">
				 					<input id="exTel_add" type="text" name="exTel" placeholder="전시장 번호" />
				 				</td>
					 		</tr>
					 	</table>
					 	</form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">돌아가기</button>
				        <button id="add" type="button" class="btn btn-outline-info" data-bs-dismiss="modal" >전시 추가</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 전시장 상세 Modal -->
				<div class="modal fade" id="hallDetail" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">전시장 상세</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body" >
					 	<table class="modalTab">
					 		<tr>
					 			<th colspan="2">전시장 명</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px">
					 				<input type="text" id="exName_de" />
					 			</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2">전시장 번호</th>
					 		</tr>
					 		<tr>
					 			<td  style="padding-bottom: 10px" id="exNum_de"></td>
					 		</tr>
					 		<tr>
					 			<th style="width: 300px">상세주소</th>
					 			<th class="modalTh" style="width: 300px">우편번호</th>
					 		</tr>
					 		<tr>
					 			<td  >
					 				<input type="text" id="addr1_de" />
					 			</td>
					 			<td >
					 				<input type="text" id="zipcode_de" />
					 			</td>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px" colspan="2">
					 				<input type="text" id="addr2_de" />
					 			</td>
					 		</tr>
					 		<tr>
					 			<th>위도</th>
					 			<th>경도</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px">
					 				<input type="text" id="lat_de" />
					 			</td>
					 			<td style="padding-bottom: 10px">
					 				<input type="text" id="long_de" />
					 			</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" >전시장 담당자</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px">
					 				<input type="text" id="mgrName_de" />
					 			</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" >전시 담당자 번호</th>
					 		</tr>
					 		<tr>
					 			<td style="padding-bottom: 10px">
					 				<input type="text" id="mgrTel_de" />
					 			</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" >전시장 전화번호</th>
					 		</tr>
					 		<tr>
					 			<td  style="padding-bottom: 10px">
					 				<input type="text" id="exTel_de" />
					 			</td>
					 		</tr>
					 	</table>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">돌아가기</button>
				        <button id="deleteBtn" type="button" class="btn btn-outline-danger">전시장 삭제</button>
				        <button id="modifyBtn" type="button" class="btn btn-outline-info">전시장 수정</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 전시장 삭제 확인 모달  -->
				<div class="modal fade" id="confirmDelete" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body" style="text-align: center">
				        전시 내용을 삭제하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-primary" id="deleteOk">OK</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 전시장 수정 확인 모달  -->
				<div class="modal fade" id="confirmModify" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        전시 내용을 수정하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button id="modifyOk" type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 전시장 수정 확인 모달  -->
				<div class="modal fade" id="confirmAdd" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        전시장을 추가하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button id="addOk" type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 전시장 추가 알림  -->
				<div class="modal fade" id="addAlert" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        전시장이 추가되었습니다.
				      </div>
				      <div class="modal-footer">
				        <button id="addOk" type="button" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 빈칸 알림  -->
				<div class="modal fade" id="nullChk" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        데이터를 모두 입력해주세요.
				      </div>
				      <div class="modal-footer">
				        <button id="addOk" type="button" class="btn btn-primary" data-bs-dismiss="modal">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!--  모달 끝 -->
			</div>
			</div>
   		 </body>
</html>
