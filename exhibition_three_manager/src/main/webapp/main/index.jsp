<%@page import="DAO.BoardManagerDAO"%>
<%@page import="DAO.AdminExhibitionDAO"%>
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

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
       <title>Exhibition Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="http://<%=application.getInitParameter("domain") %>/css/styles.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        
	<style>
		hr {width:200px; margin: 0px auto; margin-top:10px;}
       	#member_tab{ text-align:center;}
	</style>
    </head>
    
    <body class="sb-nav-fixed">
   
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="http://<%=application.getInitParameter("domain") %>/main/index.jsp">Exhibition Admin</a>
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
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Dashboard</h1>                        
                        <div class="row">
                            <div class="col-xl-6">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                        ?????? ??????
                                    </div>
                                    <%
                                    	AdminMemberDAO amd = new AdminMemberDAO();
                                    	int cntAll= amd.selectAllMember().size();
                                    	int cntToday = amd.countTodayMem();
                                    %>
                                    
                                    <div class="card-body" onclick="location.href='admin_member.jsp'">
                                     <table class="table table-hover">
                                    	<tr style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#myModal">
                                    		<th>??? ?????????</th>
                                    		<th>?????? ?????? ?????????</th>
                                    	</tr>
                                    	<tr>
                                    		<td>
                                    		<c:out value="<%=cntAll %>"/>
                                    		</td>
                                    		
                                    		<td>
                                    		<c:out value="<%=cntToday %>"/>
                                    		</td>
                                    		
                                    	</tr>
                                    </table>
                                    <canvas id="myAreaChart" width="100%" height="40"></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6" onclick="location.href='board.jsp'">
                                <div class="card mb-4">
                                <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                       ????????? ??????
                                    </div>
                                     <%
                                    	BoardManagerDAO bmd=new BoardManagerDAO();
                                     	int cntNewContext = bmd.cntNewContext();
                                    %>
                                    <div class="card-body">
                                      <table class="table table-hover" >
                                    	<tr style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#myModal">
                                    		<th>??? ??????</th>
                                    	</tr>
                                    	<tr style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#myModal">
                                    		<td><%=cntNewContext %></td>
                                    	</tr>
                                    </table>
                                    <canvas id="myBarChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                        <div class="row">
                            <div class="col-xl-6" onclick="location.href='ex_schedule.jsp'">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-bar me-1"></i>
                                       ?????? ??????
                                    </div>
                                    
                                    <%
                                    	AdminExhibitionDAO aed = new AdminExhibitionDAO();
                                    	int allEx=aed.selectAllEx();
                                    	int ended = aed.endedEx();
                                    	int endTomorrow= aed.endsTomorrow();
                                    %>
                                    <div class="card-body">
                                      <table class="table table-hover" >
                                    	<tr style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#myModal">
                                    		<th>????????? ?????? ???</th>
                                    		<th>????????? ?????? ??????</th>
                                    		<th>?????? ?????? ??????</th>
                                    	</tr>
                                    	<tr style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#myModal">
                                    		<td><%=allEx %>???</td>
                                    		<td><%=ended %>???</td>
                                    		<td><%=endTomorrow %>???</td>
                                    	</tr>
                                    </table>
                                    <canvas id="myBarChart" width="100%" height="40"></canvas></div>
                                </div>
                            </div>
                            <div class="col-xl-6" onclick="location.href='booking.jsp'">
                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-chart-area me-1"></i>
                                        ????????????
                                    </div>
                                    <%
                                    	ReservationManagerDAO rmd=new ReservationManagerDAO();
                                    	int cntReserve= rmd.countReservation();
                                    	int cntTodayRez = rmd.countTodaysReservation();
                                    %>
                                    <div class="card-body">
                                     <table class="table table-hover" >
                                    	<tr style="cursor:pointer" data-bs-toggle="modal" data-bs-target="#myModal">
                                    		<th>??????</h>
                                    		<th>????????? ????????????</th>
                                    	</tr>
                                    	<tr>
                                    		<td width="20%"><%=cntReserve %>???</td>
                                    		<td width="20%"><%=cntTodayRez %>???</td>
                                    	</tr>
                                    </table>
                                    <canvas id="myAreaChart" width="100%" height="40"></canvas>
                                    </div>
                                </div>
                            </div>
                            
                            </div>
                            </div>
                    </div>
                </main>
               	<jsp:include page="admin_footer.html"/>
            </div>
        </div>
             
      
    </body>
</html>
