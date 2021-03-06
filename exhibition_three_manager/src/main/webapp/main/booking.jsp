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
        <link href="http://<%=application.getInitParameter("domain") %>/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <!-- jQuery CDN -->
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
 		<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="http://<%=application.getInitParameter("domain") %>/js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="http://<%=application.getInitParameter("domain") %>/assets/demo/chart-area-demo.js"></script>
        <script src="http://<%=application.getInitParameter("domain") %>/assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="http://<%=application.getInitParameter("domain") %>/js/datatables-simple-demo.js"></script>
     
<style>
        	
        	hr {width:200px; margin: 0px auto; margin-top:10px;}
        	#member_tab{ text-align:center;}
</style>
    <script type="text/javascript">
   	
    $( function() {	
    $("#findNamesBtn").click(function() {
    	document.dataSearchFrm.submit();
	});//findNamesBtn
    	
 	$("#bookingDetail").on("show.bs.modal", function(e) {		
	   	var num= $(e.relatedTarget).data('num');
    	var error="";
    	$.ajax({
			url:"http://<%=application.getInitParameter("domain") %>/main/ajax/bookingAjax.jsp",
			data: {"rezNum":num},
			async:false,
			type: "get",
			dataType:"json",
			error:function(xhr){
				console.log("bookingDetail "+xhr.status+", "+xhr.statusText);
			},
			success:function(jsonObj){
				$("#exName").val(jsonObj.exName);				
				$("#exNum").val(jsonObj.exNum);				
				$("#resNum").val(num);				
				$("#userName").val(jsonObj.userName);				
				$("#rezCount").val(jsonObj.rezCount);				
				$("#rezDate").val(jsonObj.rezDate);				
				$("#userId").val(jsonObj.userId);				
				$("#visitDate").val(jsonObj.visitDate);				
				$("#price").val(jsonObj.price);	
			}
		});//ajax
		
    });//bookingDetail
  
    $("#confirmModify").click(function() {
		$("#confirmModal").modal('show');
	})
});  //ready;

    function confirmModify() {
    	var num= $("#resNum").val();
 		var rezCount=$("#rezCount").val();
		var visitDate=$("#visitDate").val();
			
		var now= new Date();
		
		if(rezCount<1){
			alert("????????? 1??? ????????????????????????. ?????????????????? ???????????????.")
			location.href="booking.jsp";
			return;
		}
		
		if(now > new Date(visitDate)){
			alert("????????? ??? ?????? ???????????????.\n?????????????????? ???????????????.");
			location.href="booking.jsp";
			return;
				
		}
		if(rezCount=="" || visitDate==""){
			alert("??????????????? ??????????????? ???????????? ??? ????????????. ?????????????????? ???????????????.");
			location.href="booking.jsp";
			return;
		}
		 $.ajax({
			url:"http://<%=application.getInitParameter("domain") %>/main/ajax/bookingModifyAjax.jsp",
			data: {"rezCount":rezCount, "visitDate":visitDate, "rezNum":num},
			async:false,
			type: "get",
			dataType:"json",
			error:function(xhr){
				console.log("confirmModify : "+xhr.status+", "+xhr.statusText);
			},
			success:function(jsonObj){
				if(jsonObj.cnt > 0){
					alert("?????????????????????.")
					location.href="booking.jsp";
				}  
			}
		}); //ajax
	} //confirmModify
	
	function cancelRez() {
		var num= $("#mainRezNum").text();
		 $.ajax({
				url:"http://<%=application.getInitParameter("domain") %>/main/ajax/bookingCancelAjax.jsp",
				data: {"rezNum":num},
				async:false,
				type: "get",
				dataType:"json",
				error:function(xhr){
					console.log("cancelAjax : "+xhr.status+", "+xhr.statusText);
				},
				success:function(jsonObj){
					if(jsonObj.cnt > 0){
						alert("????????? ?????????????????????.")
						location.href="booking.jsp";
					}
				}  
			}); //ajax
	}//cancelRez
	
	//?????? ??????
	function rezConfirm() {
		var num= $("#mainRezNum").text();
		 $.ajax({
				url:"http://<%=application.getInitParameter("domain") %>/main/ajax/bookingConfirmAjax.jsp",
				data: {"rezNum":num},
				async:false,
				type: "get",
				dataType:"json",
				error:function(xhr){
					console.log("confirmAjax : "+xhr.status+", "+xhr.statusText);
				},
				success:function(jsonObj){
					if(jsonObj.cnt > 0){
						alert("????????? ?????????????????????.")
						location.href="booking.jsp";
					}
				}  
			}); //ajax
	}
	
    </script>
    </head>
    <%
	ReservationManagerDAO rmDao = new ReservationManagerDAO();
		
	int pageSize=5;
	String pageNum=request.getParameter("pageNum");
	if(pageNum==null){
		pageNum="1";
	}
	//???????????? ??????
		String nameSel=request.getParameter("nameSelection");
	  	if("".equals(nameSel) || nameSel==null){
	 		nameSel="name";
	 	}
	 	
	 	if(nameSel.equals("findExName")){
	 		nameSel="ex_name";
	 	}else{
	 		nameSel="name";
	 	} 
	 	
	 	//????????? ??????
	 	String vDate= request.getParameter("vDate");
	 	if(vDate==null || "".equals(vDate)){
	 		vDate="";
	 	}
	 	String findCatName= request.getParameter("findCatName");
	 	if(findCatName==null || "".equals(findCatName)){
	 		findCatName="";
	 	} 
	 	
	int cnt = rmDao.cntRez(nameSel, vDate, findCatName);
	
	int currentPage= Integer.parseInt(pageNum);
	int startRow=(currentPage-1)*pageSize+1;
	int endRow=currentPage * pageSize;	
	
	List<ReservationManagerVO> rezList = null;
	if(cnt>0){
		rezList= rmDao.selectReservation(startRow, endRow, nameSel, vDate, findCatName);
		pageContext.setAttribute("rezList", rezList);
	}
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
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                       <li><a class="dropdown-item" href="http://<%=application.getInitParameter("domain") %>/main/settings.jsp">Settings</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="http://<%=application.getInitParameter("domain") %>/main/logout.jsp">Logout</a></li>
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
                        <h1 class="mt-4">?????? ??????</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp" style="text-decoration:none; color:#333;">Dashboard</a></li>
                            <li class="breadcrumb-item active">?????? ??????</li>
                        </ol>
                        <!-- ????????? -->
							<div id="searchDiv" >
								
                            <form class="d-flex" action="http://<%=application.getInitParameter("domain") %>/main/booking.jsp" name="dataSearchFrm">
                            	<div class="input-group mb-3" style="width:300px; height:40px; margin-top:10px;" >
								  <span class="input-group-text" id="addon-wrapping">????????????</span>
					      		  <input type="date" name="vDate" class="form-control" placeholder="?????? ??????" style="width:200px;" id="vDate" value="${param.vDate}">
								</div>
	                         <div class="input-group mb-3" style="width:500px;margin-top:10px; margin-left: 100px;">
						  		<span class="input-group-text" id="addon-wrapping">????????????</span>
									 <select class="form-select" aria-label=".form-select-sm example" name="nameSelection" id="nameSel">
									  <option value="findUserName" ${(param.nameSelection =="findUserName")?"selected":"" } >????????? ??????</option>
									  <option value="findExName" ${(param.nameSelection =="findExName")?"selected":""} >?????? ??????</option>
									</select>
								  <input type="text" class="form-control" style="width:100px" name="findCatName" id="findCatName" value="${param.findCatName}">
								  <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal" id="findNamesBtn">??????</button>
								</div>
							      </form>
                        	</div>
                        	
                        	<div class="form-check form-check-inline">
							  
							</div>
						<div class="card-body">
                            <!-- ????????? ?????? -->
                                <table class="table table-hover" id="member_tab">
                            	<thead> 
							   <tr>
                                    	<th>????????????</th>
                                    	<th>?????????</th>
                                    	<th>?????????</th>
                                    	<th>????????????</th>
                                    	<th>????????????</th>
                                    	<th>??????</th>
                                   </tr>
						  	</thead> 
						  	<tbody id="bookingTBody"> 
								 <%if(cnt>0) {%>
									<c:forEach var="res" items="${rezList}">
						  		<tr style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#bookingDetail" data-num="${res.rezNum}"  class="rezList">
									<td id="mainRezNum"><span id="star"></span><c:out value="${res.rezNum}"/></td>
									<td><c:out value="${res.exName}"/></td>
									<td><c:out value="${res.userName}"/></td>
									<td><c:out value="${res.visitData}"/></td>
									<td id="rezStatus"><c:out value="${res.rezStatus}"/></td>
									
									<td>
									 	<button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#confirmCancel" >?????? ??????</button>
				        				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmOk">?????? ??????</button>
				        			</td>
						  		</tr>
						  			</c:forEach> 
						  	<%}else{%>
						  		<tr>
								<td colspan="5">?????? ???????????? ????????????.</td>
								</tr>	
						  	<%} %>
						  	</tbody> 
						  </table>
						  
                            </div>
                               <div id="pageNavigation">
								<ul class="pagination justify-content-center"> 
								<%
								if(cnt > 0){
									int pageCount = cnt/pageSize + (cnt%pageSize == 0 ? 0 : 1); //????????? ?????? ?????? ????????? ??? ?????????
									int pageBlock=5; // ????????? ????????? ????????? ????????? ??????
									int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;//???????????? ??????
									
									int endPage = startPage + pageBlock - 1;//????????? ????????? ??????

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
									??????
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
											<a style="margin-right:10px;text-decoration:none;"class="text-secondary" href="booking.jsp?pageNum=${i}&vDate=${param.vDate}&nameSelection=${param.nameSelection}&findCatName=${param.findCatName}">
											<c:out value="${i}"/>
											</a>
											</li> 
										</c:if>
										
									</c:forEach>
									
									
									<c:if test="${endPage lt pageCount}">
									<li>
										<a style="margin-right:10px;text-decoration:none;"class="text-secondary" href="booking.jsp?pageNum=${startPage+5}pageNum=${i}&vDate=${param.vDate}&nameSelection=${param.nameSelection}&findCatName=${param.findCatName}">
										??????
										</a>
										</li> 
								</c:if>
							<%	}//end if
								%>
								
								</ul> 
							</div>
                        </div>
                </main>
                	<jsp:include page="admin_footer.html"/>
               <!-- ?????? ?????? ?????? ??????  -->
              
				<div class="modal fade" id="bookingDetail" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">?????? ?????? ??????</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
					 	<table class="modalTab" style="width:98%;" cellpadding="5">
					 		<tr>
					 			<th class="modalTh">?????????</th>
					 			<th class="modalTh">?????? ??????</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"><input type="text" id="exName" class="form-control" readonly/></td>
					 			<td class="modalTd"><input type="text" id="exNum" class="form-control" style="width:100px" readonly/></td>
					 		</tr>
					 		<tr>
					 			<th class="modalTh">?????? ??????</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"><input type="text" id="resNum" class="form-control" style="width:100px" readonly/></td>
					 		</tr>
					 		<tr>
					 			<th class="modalTh">????????????</th>
					 		</tr>
					 		
					 		<tr>
					 			<td class="modalTd"><input type="text" id="userName" class="form-control" style="width:100px" readonly/></td>
					 		</tr>
					 		
					 		<tr>
					 			<th class="modalTh">????????? ID</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"><input type="text" id="userId" class="form-control" readonly/></td>
					 		</tr>
					 		
					 		<tr>
					 			<th class="modalTh">????????????</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"><input id="rezCount" type="number" class="inputBox"/>
					 			<span id="countWarning" style="font-size:10px; color:#ff0000;"></span></td>
					 		</tr>
					 		<tr>
					 			<th class="modalTh">????????????</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"><input type="date" id="rezDate" class="form-control" readonly/></td>
					 		</tr>
					 		<tr>
					 			<th class="modalTh">????????????</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd"><input id="visitDate" type="date" class="inputBox"/>
					 			<span id="visitWarning" style="font-size:10px; color:#ff0000;"></span></td>
					 		</tr>
					 		<tr>
					 			<th class="modalTh">????????????</th>
					 		</tr>
					 		<tr>
					 			<td class="modalTd" ><input type="text" id="price" class="form-control" readonly/></td>
					 		</tr>
					 	</table>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">????????????</button><!-- id="confirmModify"  -->
				        <button type="button" class="btn btn-outline-info" data-bs-toggle="modal" id="confirmModify">?????? ??????</button>
				      </div>
				    </div>
				  </div>
				</div>
	
				<!-- ???????????? ?????? modal -->
				<div class="modal fade" id="confirmCancel" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        ????????? ?????????????????????????
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-outline-info" onclick="cancelRez(${res.rezNum})">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- ?????? ?????? modal -->
				<div class="modal fade" id="confirmOk" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        ????????? ?????????????????????????
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-outline-info" onclick="rezConfirm(${res.rezNum})">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- ?????? ?????? modal -->
				<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        ?????????????????????????
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-outline-info" onclick="confirmModify(${res.rezNum})">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!--  -->
            </div>
        </div>
             
      
    </body>
</html>
