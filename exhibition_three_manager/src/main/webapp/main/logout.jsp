<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.invalidate();
	String domain=application.getInitParameter("domain");
	String requestUrl="http://"+domain+"/main/index.jsp";
	response.sendRedirect(requestUrl);
%>