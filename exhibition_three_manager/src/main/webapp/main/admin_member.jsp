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
        <link href="http://<%=application.getInitParameter("domain") %>/css/styles.css" rel="stylesheet" />
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
     	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
      hr {width:200px; margin: 0px auto; margin-top:10px;}
      #member_tab{ text-align:center;}
      .memberTitle{font-weight:bold}
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
				url:"http://<%=application.getInitParameter("domain") %>/main/ajax/member_ajax.jsp",
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
					console.log(xhr.status);
					location.href="admin_error.html";
				},
				success : function(jsonObj){
					var msg = "??????";
					if(jsonObj.updateFlag){
						msg="??????";
					}//end if
					alert(msg);
					location.reload();
				}
		});//ajax  
	}
  	$(function(){
  		$("#searchBtn").click(function(){
  			//????????? submit
  			document.dataSearchFrm.submit();		
  		});//click
  		
  		$("#modifyBtn").click(function(){
  			var title = ["??????","????????????","????????????","??????","????????????"];
  			var data = [$("#userName"),$("#tel"),$("#zipcode"),$("#address1"),$("#address2")];
  			for(var i = 0; i < data.length; i++){//????????? ??????
  				if(data[i].val()==""){
  					alert(title[i]+"???(???) ??????????????????");
  					data[i].focus();
  					return;
  				}//end if
  			}//end for
  			$("#confirm").on('show.bs.modal',function(){
  				$("#confirmMsg").text("????????? ?????????????????????????");
  				$("#confirmHid").val("modify");
  			}).modal("show");
  		});//click	
  			
  		$("#deleteBtn").click(function(){
  			$("#confirm").on('show.bs.modal',function(){
  				$("#confirmMsg").text("????????? ?????????????????????????");
  				$("#confirmHid").val("delete");
  			}).modal("show");
  		});//click
  	$("#searchZipcode").click(function(){
	  	 new daum.Postcode({
		        oncomplete: function(data) {
		        	 // ???????????? ???????????? ????????? ??????????????? ????????? ????????? ???????????? ??????.
				$('#zipcode').val(data.zonecode);      // ????????????(5??????)
				$('#address1').val(data.address);       // ???????????? 
		        }
	 	  }).open();
  	});//click
	  	$(".exit").click(function(){
	  		$("#confirmExit").modal('show');
	  	});
  		$("#exitOk").click(function(){
	  		$("#confirmExit").modal('hide');
  			$("#memberDetail").modal('hide');
  		}); 
  	});//ready
</script>
    </head>
    <%
    int pageSize = 5; // ??? ???????????? ????????? ????????? ???
    
 	// ????????? ????????? ????????? ?????? / ?????? ?????????
 	String pageNum = request.getParameter("pageNum");
 	if (pageNum == null){ // ???????????? ????????? 1??? ?????????
 		pageNum = "1";
 	}
 	
 	//???????????? ??????
 	String query = request.getParameter("dataSearchItem");
 	if("".equals(query) || query==null){
 		query="userid";
 	}//end if
 	//????????? ??????
 	String field= request.getParameter("dataSearchText");
 	if(field==null || "".equals(field.trim())){
 		field="";
 	}
 	// ????????? ?????? ?????? pageNum ????????? / ?????? ?????????
 	int currentPage = Integer.parseInt(pageNum);

 	// ?????? ??????????????? ????????? ????????? / ????????? ?????????
 	int startRow = (currentPage - 1) * pageSize + 1;
 	int endRow = currentPage * pageSize;

 	int count = 0;
 	AdminMemberDAO aDAO = new AdminMemberDAO();
 	count = aDAO.getCount(field,query); // ????????????????????? ????????? ??? ??????
 	
 	List<MemberVO> list = null;
 	if (count > 0) {
 		// getList()????????? ?????? / ?????? ????????? ??????
 		list = aDAO.selectMember(startRow, endRow, field, query);
 	}
 %>
    
    <body class="sb-nav-fixed">
   
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="http://<%=application.getInitParameter("domain") %>/main/index.jsp">Exhibition Admin</a>
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
                            <form action="http://<%=application.getInitParameter("domain") %>/main/admin_member.jsp" name="dataSearchFrm" class="d-flex" style="float:right">
			                         <div class="input-group mb-3" style="width:300px;">
										 <select class="form-select" aria-label=".form-select-sm example" name="dataSearchItem" style="height:35px;">
											  <option ${(param.dataSearchItem =="name")?"selected":""} value="name">??????</option>
											  <option ${(param.dataSearchItem =="userid")?"selected":""} value="userid">?????????</option>
											  <option ${(param.dataSearchItem =="isubscribe_date")?"selected":""} value="isubscribe_date">?????????</option>
										  </select>
										  <input type="text" class="form-control" value="${param.dataSearchText}" name="dataSearchText"style="width:100px;height:35px; margin-right:10px;">
										  <button type="button" class="btn btn-outline-dark btn-sm" id="searchBtn" style="height: 35px;">
                                 			<i class="fa-solid fa-magnifying-glass"></i>
                               			  </button>
									</div>
							      </form>
                        	</div>
                        
                            <div class="card-body">
                            <!-- ????????? ?????? -->
                                <table class="table table-hover" id="member_tab">
                            	<thead> 
							   <tr>
                                    	<th>ID</th>
                                    	<th>??????</th>
                                    	<th>?????????</th>
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
											<td colspan="3">?????? ???????????? ????????????.</td>
											</tr>						<%		    						 		
	    						 		
	    						 		}//end else
	    						 		%>
						  	</tbody> 
						  </table>
						  
                            </div>
                               <div id="pageNavigation">
								<ul class="pagination justify-content-center"> 
								<%
								if(count > 0){
									int pageCount = count/pageSize + (count%pageSize == 0 ? 0 : 1); //????????? ?????? ?????? ????????? ??? ?????????
									
									int pageBlock=5; // ????????? ????????? ????????? ????????? ??????
									
									int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;//???????????? ??????
									
									int endPage = startPage + pageBlock - 1;//????????? ????????? ??????

									if(endPage > pageCount){
										endPage = pageCount;
									}
									
									if(startPage > pageBlock){ // 11,21,31...????????? ?????? ???????????? ?????? ?????? ????????? ?????????
										%>  
									<li>
					<a style="margin-right:10px;text-decoration:none;"class="text-secondary page-item" href="admin_member.jsp?pageNum=<%=startPage-5%>&dataSearchItem=${param.dataSearchItem}&dataSearchText=${param.dataSearchText}">
									??????
									</a>
									</li> <% 
										}//end if
										 for(int i = startPage; i <= endPage; i++){ 
											 if(i == currentPage){ //?????? ???????????? ?????? ?????? ??????
										 	%>
											<li>
											<a style="margin-right:10px;"class="text-secondary" href="">
											<%=i %>
											</a>
											</li> 
											<%  
											 }else{ //?????? ???????????? ?????? ?????? ?????? ??????
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
										??????
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
                	<jsp:include page="admin_footer.html"/>
	               <!-- ?????? ?????? modal  -->
	                <div class="modal fade" tabindex="-1" id="memberDetail" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false" >
					  <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h5 class="modal-title">?????? ??????</h5>
					        <button type="button" class="btn-close exit" aria-label="Close"></button>
					      </div>
					      <div class="modal-body">
					      	<div class="memberTitle">ID(Email)</div>
					      	<div class="input-group input-group-sm mb-3" style="width:450px">
							  <input type="text" class="form-control" id="id" placeholder="Username" readonly/>
							  <span class="input-group-text">@</span>
							  <input type="text" class="form-control" id="server" placeholder="Server" readonly/>
							</div>
					      	<div class="memberTitle">??????</div>
					      	<div class="input-group input-group-sm mb-3" style="width:200px">
					      	<input type="text" class="form-control" id="userName" placeholder="??????" readonly/>
							</div>
					      	<div class="memberTitle">????????????</div>
					      	<div class="input-group input-group-sm mb-3" style="width:200px">
							  <input type="text" class="form-control" id="tel"placeholder="????????????"/>
							</div>
					      	<div class="memberTitle">????????????</div>
					      	<div class="input-group input-group-sm mb-3" style="width:250px">
							  <input type="text" class="form-control" id="zipcode" placeholder="????????????" />
							   <button class="btn btn-outline-info" type="button" id="searchZipcode">??????????????????</button>
							</div>
					      	<div class="row"><div class="memberTitle col-6">??????</div> <div class="memberTitle col-6">????????????</div></div>
					      	<div class="row">
					      	<div class="col-6">
					      	<div class="input-group input-group-sm mb-3" style="width:250px">
							  <input type="text" class="form-control" id="address1" placeholder="??????"/>
							</div>
					      	 </div>
					      	<div class="col-6">
					      	<div class="input-group input-group-sm mb-3" style="width:350px">
							  <input type="text" class="form-control" id="address2" placeholder="????????????"/>
							</div>
					      	</div> 
					      	 </div>
					      	<div class="memberTitle">?????????</div>
					      	<div class="input-group input-group-sm mb-3" style="width:200px">
							<input type="text" class="form-control" id="subDate" placeholder="?????????"readonly/>
							</div>
					      </div>
					      <div class="modal-footer">
							        <button type="button" class="btn btn-outline-dark exit">????????????</button>
							        <button type="button" class="btn btn-outline-danger" id="deleteBtn">?????? ??????</button>
							        <button type="button" class="btn btn-outline-info" id="modifyBtn">?????? ??????</button>
					      </div>
					    </div>
					  </div>
					</div>
				<!-- modal -->
            </div>
        </div>
				<!-- ?????? modal -->
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
             <!-- ?????? ?????? modal -->
				<div class="modal fade" id="confirmExit" tabindex="-1"data-bs-backdrop="static" data-bs-keyboard="false" aria-labelledby="exampleModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        ?????? ???????????? ???????????? ????????? ???????????? ????????????.<br>
				        ?????????????????????????
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
				        <button type="button" class="btn btn-primary" id="exitOk">Ok</button>
				      </div>
				    </div>
				  </div>
				</div>
				<!-- modal -->
      
    </body>
</html>
