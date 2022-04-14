<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
if(session.getAttribute("admin_id")==null){
	response.sendRedirect("http://localhost/exhibition_three_manager/main/login.jsp");
	return;
}
%>