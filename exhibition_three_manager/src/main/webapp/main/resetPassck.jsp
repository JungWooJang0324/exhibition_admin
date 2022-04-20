
<%@page import="java.security.MessageDigest"%>
<%@page import="DAO.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String sessionId = (String)session.getAttribute("admin_id");
	String newPass =  request.getParameter("newPass");
	
	MessageDigest  md = MessageDigest.getInstance("SHA-512");
	md.update(newPass.getBytes());
		
	String newPassNew=new String(md.digest());

	
	
	AdminDAO ad=new AdminDAO();
	boolean flag=ad.resetPass(sessionId, newPassNew);
	
	if(flag){
		session.invalidate();
		response.sendRedirect("http://localhost/exhibition_three_manager/main/index.jsp");
	}
%>