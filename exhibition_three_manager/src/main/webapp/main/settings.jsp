<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="admin_id_session.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Settings</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="http://<%=application.getInitParameter("domain") %>/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
      
        <style>
        	#manager_div{width: 100%; height: 100%; background-color: white; margin: 0px auto;  
  				padding-left: 30%;
        		display: grid;
  				place-items: center;}
  			#manager_name {
  				padding-top: 10%;
  				padding-left: 30%;
  			}
  			
  			#manager_name> table > th {width: 50%; cellpadding: 10px;}
  			
  			
        </style>
        </head>
 <body class="sb-nav-fixed">
 <jsp:include page="admin_id_session.jsp"/>
               <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="index.jsp">Exhibition Admin</a>
            <!-- Sidebar Toggle-->
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
                        <li><a class="dropdown-item" href="settings.jsp">Settings</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="logout.jsp">Logout</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">SETTINGS</h1>                        
                        <div class="row" style="width: 100%" >
                            	<div id="manager_div"><img src="../assets/img/Profile-PNG-Clipart.png" style="width:100px;"/>
								<div id="manager_name">
									<table id="datatablesSimple" style="width:500px">
										<tr>
											<th>
											ID
											</th>
											<td><%=session.getAttribute("admin_id") %></td>
										</tr>
										
										<tr>
											<th>
											PASSWORD
											</th>
											<td>
											<a href="http://<%=application.getInitParameter("domain") %>/main/password.jsp">수정하기</a>
											</td>
										</tr>
										<tr>
										<th>
											가입일
										</th>
										<td>
											<%=session.getAttribute("admin_date") %>
										</td>
										</tr>
									
									</table>
								</div>
								<div style="margin-top: 50px;">
									<a class="btn btn-primary" id="loginBtn" href="http://<%=application.getInitParameter("domain") %>/main/index.jsp">메인으로 가기</a>
									<a class="btn btn-primary" id="loginBtn" href="#" onclick="history.back()">뒤로 가기</a>
								</div>
								</div>
                        </div>
                        
                       
                    </div>
                </main>
                </div>
               <div id="layoutAuthentication_footer">
             		<jsp:include page="admin_footer.html"/>
          		</div>
            </div>
     
    </body>
</html>
