<%@page import="DAO.ExHallManagerDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.apache.catalina.mbeans.UserMBean"%>
<%@page import="java.util.List"%>
<%@page import="VO.ExHallVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="전시장"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Exhibition Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
		<!-- jQuery CDN -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

<style>
 	#manager_div{width: 100px; height: 100px; background-color: white; border-radius: 100px; margin-left: 50px;}
 	#manager_name{margin-left: 60px; margin-top: 10px; width: 100px; color:white; font-weight: bold;}
 	hr {width:200px; margin: 0px auto; margin-top:10px;}
	#searchDiv{ margin-bottom: 30px; text-align: right}
 	#btnAddDiv{ text-align: right; margin-top: 20px; position: relative}
 	#pageNavigation{position: absolute; bottom: 20%; left: 50%}
 	.modalTab{width: 90%; }
	.modalTh{font-size: 12px; color: #B2B2B2; padding-left: 20px; padding-right: 20px; padding-top: 20px }
	.modalTd{height: 40px; vertical-align: top; padding-left: 20px; padding-right: 20px};
</style>
<script type="text/javascript">
$(function({
	$("#btnAdd").click(function(){
		$("#hallAddfrm").submit();
	});
});
</script> 
 </head>
 
 <body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="http://localhost/project2/main/index.jsp">Exhibition Admin</a>
            <!-- Sidebar Toggle-->
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
                        <li><a class="dropdown-item" href="#!">Settings</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="#!">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
						<div id="manager_div"><img src="../assets/img/Profile-PNG-Clipart.png" style="width:100px; margin-left: 0px;"/></div>
							<div id="manager_name">
								관리자 이름
							</div>
							<hr/>
                          <div class="sb-sidenav-menu-heading">MEMBERS</div>
                            <a class="nav-link collapsed" href="admin_member.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i>
                                </div>
                               	회원 관리

                            </a>
                          <div class="sb-sidenav-menu-heading">EXHIBITIONS</div>
                            <a class="nav-link collapsed" href="ex_schedule.jsp" >
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                전시 일정관리
                            </a>
                            <a class="nav-link collapsed" href="hall.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                전시장 관리
                            </a>
                            <div class="sb-sidenav-menu-heading">BOOKING</div>
                            <a class="nav-link" href="booking.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                예약 관리
                            </a>
                            <div class="sb-sidenav-menu-heading">BOARD</div>
                            <a class="nav-link" href="board.jsp">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                게시판 관리
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        Authentication
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="login.html">Login</a>
                                            <a class="nav-link" href="register.html">Register</a>
                                            <a class="nav-link" href="password.html">Forgot Password</a>
                                        </nav>
                                    </div>
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseError" aria-expanded="false" aria-controls="pagesCollapseError">
                                        Error
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                        <nav class="sb-sidenav-menu-nested nav">
                                            <a class="nav-link" href="401.html">401 Page</a>
                                            <a class="nav-link" href="404.html">404 Page</a>
                                            <a class="nav-link" href="500.html">500 Page</a>
                                        </nav>
                                    </div>
                                </nav>
                            </div>
                      
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Start Bootstrap
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content">
                <main>
                <div id="test">
                </div>
                    <div class="container-fluid px-4" style="width: 90%;">
	                	<!-- 제목  -->
                        <h1 class="mt-4" style=" font-weight: bold; margin: 0px auto;">전시장 관리</h1>
                        <ol class="breadcrumb mb-4"  style="height: 30px; font-weight: bold;margin: 0px auto;">
                            <li class="breadcrumb-item active" style="margin-left: 10px"><a href="index.jsp">Dashboard</a></li>
                            <li class="breadcrumb-item active">전시장 관리</li>
                        </ol>
                        <!-- 검색 div -->
                        <div id="searchDiv" >
                        	<input type="text" placeholder="내용을 검색해주세요">
                        	<button type="button" class="btn btn-outline-dark btn-sm" style="height: 30px;">
                        		<i class="fa-solid fa-magnifying-glass"></i>
                       		</button>
                        </div>
                        <!-- 전시장 테이블 -->
                        <div class="card-content" style=" margin: 0px auto">
                            <div class="table-responsive">
                            	<form>
                                <table class="table table-striped table-bordered table-hover" id="hallTables" style="text-align: center;">
                                    <thead>
                                        <tr>
                                            <th style="width: 300px">전시장번호</th>
                                            <th>전시장 명</th>
                                            <th style="width: 400px">전시 위치</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                  	<%
                                  	ExHallManagerDAO ehmDAO = new ExHallManagerDAO(); 
                                  	List<ExHallVO> list = ehmDAO.selectExhibitonHall("");
                                  	for(ExHallVO ehVO: list){
                                  	%>
                                        <tr class="odd gradeX">
                                            <td><%=ehVO.getExHallNum()%></td>
                                            <td><a href="#void" data-bs-toggle="modal" data-bs-target="#hallDetail"><%=ehVO.getExName() %></a></td>                                          	
                                            <td><%=ehVO.getExLoc() %></td>
                                        </tr>
                                   	 <%}
                                   	if(list==null){%>
                              			<tr><td colspan="3">"저장된 값이 없습니다."</td></tr>
                           			<%}%>	 
                                     </tbody>
                                  </table>
                                  </form>
                                </div>
                              	<!-- 버튼 Div -->
                              	<div class="btnAdd" id="btnAddDiv">
	                              	<button type="button" class="btn btn-primary btn-lg" id="btnAdd" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addHall">
	                              		전시장 추가
	                          		</button>
								</div>
                            </div>
                            <!-- 페이지 이동 -->                            
                            <div id="pageNavigation">
							  <ul class="pagination justify-content-center">
							    <li class="page-item disabled">
							      <a class="page-link" href="#" tabindex="-1"><</a>
							    </li>
							    <li class="page-item"><a class="page-link" href="#">1</a></li>
							     <li class="page-item active">
							      <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
							    </li>
							    <li class="page-item"><a class="page-link" href="#">3</a></li>
							    <li class="page-item">
							      <a class="page-link" href="#">></a>
							    </li>
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
				<div class="modal fade" id="addHall" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">전시장 추가</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				      	<form id="hallAddFrm" action="admin_">
					 	<table class="modalTab">
					 		<tr>
					 			<th colspan="2" class="modalTh">전시장</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd">
					 				<input type="text" name="exHall" placeholder="전시장명"/>
				 				</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">주소</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd">
									<select class="inputBox" id="exLoc" name="exLoc">
										<option value="seoul">서울</option>
										<option value="gyenggi">경기</option>
									</select>
								</td>
					 		</tr>
					 		<tr>
					 			<th class="modalTh">상세주소</th><th class="modalTh" style="padding-left: 20px">우편번호</th>
					 		</tr>
					 		<tr>
					 			<td  class="modalTd">
					 				<input type="text" id="address" name="addr" placeholder="주소"/>
				 				</td>
				 				<td class="modalTd">
				 					<input id="zipcode"type="text" name="zipcode" placeholder="우편번호" />
			 					</td>
					 		</tr>
					 		<tr>
					 			<th class="modalTh">위도</th><th class="modalTh" style="padding-left: 20px">경도</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd">
					 				<input id="lat"  type="text" name="latitude" placeholder="위도"/>
				 				</td>
			 					<td  class="modalTd">
			 						<input id="lng" type="text" name="longitutde" placeholder="경도"/>
		 						</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">전시장 담당자</th>
					 		</tr>
					 		<tr>
					 			<td  class="modalTd">
					 				<input id="mgrName" type="text" name="mgrName" placeholder="담당자명"/>	
				 				</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">전시 담당자 번호</th>
					 		</tr>
					 		<tr>
					 			<td  class="modalTd">
					 				<input id="mgrTel" type="text" name="mgrTel" placeholder="담당자 번호"/>
					 			</td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">전시장 번호</th>
					 		</tr>
					 		<tr>
					 			<td  class="modalTd">
				 					<input id="exTel" type="text" name="exTel" placeholder="전시장 번호"/>
				 				</td>
					 		</tr>
					 	</table>
					 	</form>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">돌아가기</button>
				        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#confirmAdd">전시 추가</button>
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
				      <div class="modal-body">
					 	<table class="modalTab">
					 		<tr>
					 			<th colspan="2" class="modalTh">전시장 명</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">전시장 번호</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTh"></td>
					 		</tr>
					 		<tr>
					 			<th class="modalTh">상세주소</th><th class="modalTh">우편번호</th>
					 		</tr>
					 		<tr>
					 			<td id="address1" class="modalTh"></td><td id="address2" class="modalTh"></td>
					 		</tr>
					 		<tr>
					 			<th class="modalTh">위도</th><th class="modalTh">경도</th>
					 		</tr>
					 		<tr>
					 			<td id="lat" class="modalTh"></td><td id="lng" class="modalTh"></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">전시장 담당자</th>
					 		</tr>
					 		<tr>
					 			<td id="mgrName" class="modalTh"></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">전시 담당자 번호</th>
					 		</tr>
					 		<tr>
					 			<td id="mgrTel" class="modalTh"></td>
					 		</tr>
					 		<tr>
					 			<th colspan="2" class="modalTh">전시장 번호</th>
					 		</tr>
					 		<tr>
					 			<td id="exTel" class="modalTh"></td>
					 		</tr>
					 	</table>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">돌아가기</button>
				        <button type="button" class="btn btn-danger" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#confirmDelete">전시장 삭제</button>
				        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModify">전시장 수정</button>
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
				        <button type="button" class="btn btn-primary">OK</button>
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
				        <button type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 전시장 수정 확인 모달  -->
				<div class="modal fade" id="confirmAdd"" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
				        <button type="button" class="btn btn-primary">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- 수정확인 모달 끝 -->
			</div>
   		 </body>
</html>
