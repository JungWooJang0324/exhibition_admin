<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("admin_id")==null){
	
	String url=application.getInitParameter("domain");
	String redirectUrl="http://"+url+"/main/login.jsp";
	response.sendRedirect(redirectUrl);
	return;
}
%>