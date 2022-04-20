<%@page import="DAO.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String sessionId = (String)session.getAttribute("admin_id");
	String newPass =  request.getParameter("newPass");
	
	AdminDAO ad=new AdminDAO();
	boolean flag=ad.resetPass(sessionId, newPass);
	
	if(flag){
		session.invalidate();
		response.sendRedirect("http://localhost/exhibition_three_manager/main/index.jsp");
	}
%>
