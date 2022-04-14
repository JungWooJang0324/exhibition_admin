<%@page import="DAO.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String id= request.getParameter("admin_id");
	String pw= request.getParameter("admin_pw");
	
	AdminDAO ad = new AdminDAO();
	String date =ad.login(id, pw);
	
	if(date !=""){
		session.setAttribute("admin_id", id);
		session.setAttribute("admin_date", date);
        response.sendRedirect("index.jsp");
		
	}else {
		%>
		<script type="text/javascript">
		alert("아이디와 비밀번호가 틀립니다!");
		
		history.back();
		</script>
				
	<%}
%>