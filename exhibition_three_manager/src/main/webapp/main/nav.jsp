<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style>
#manager_div{width: 100px; height: 100px; background-color: white; border-radius: 100px; margin-left: 50px;}
#manager_name{margin-left: 35%; margin-top: 10px; width: 100px; color:white; font-weight: bold;}
</style>
 <div class="sb-sidenav-menu">
                        <div class="nav">
						<div id="manager_div"><img src="../assets/img/Profile-PNG-Clipart.png" style="width:100px; margin-left: 0px;"/></div>
							<div id="manager_name">
								<%=session.getAttribute("admin_id") %>
							</div>
							<hr/>
                          <div class="sb-sidenav-menu-heading">MEMBERS</div>
                            <a class="nav-link collapsed" href="http://localhost/exhibition_three_manager/main/admin_member.jsp" id="nav_member">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i>
                                </div>
                               	회원 관리

                            </a>
                          <div class="sb-sidenav-menu-heading">EXHIBITIONS</div>
                            <a class="nav-link collapsed" href="http://localhost/exhibition_three_manager/main/ex_schedule.jsp" id="nav_exhibition">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                전시 일정관리
                            </a>
                            <a class="nav-link collapsed" href="http://localhost/exhibition_three_manager/main/hall.jsp" id="nav_hall">
                                <div class="sb-nav-link-icon"><i class="fas fa-columns"></i></div>
                                전시장 관리
                            </a>
                            <div class="sb-sidenav-menu-heading">BOOKING</div>
                            <a class="nav-link" href="http://localhost/exhibition_three_manager/main/booking.jsp" id="nav_booking">
                                <div class="sb-nav-link-icon"><i class="fas fa-chart-area"></i></div>
                                예약 관리
                            </a>
                            <div class="sb-sidenav-menu-heading">BOARD</div>
                            <a class="nav-link" href="http://localhost/exhibition_three_manager/main/board.jsp" id="nav_board">
                                <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                                게시판 관리
                            </a>
                            <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                    <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                        Authentication
                                        <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                                    </a>
                                    
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
                        <%=session.getAttribute("admin_id") %>
                    </div>
