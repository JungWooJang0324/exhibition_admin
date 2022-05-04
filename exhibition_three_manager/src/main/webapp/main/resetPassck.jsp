
<%@page import="org.apache.tomcat.util.codec.binary.Base64"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="DAO.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String sessionId = (String)session.getAttribute("admin_id");
	String newPass =  request.getParameter("newPass");
	
	MessageDigest  md = MessageDigest.getInstance("SHA-512");
	
	md.update(newPass.getBytes());

	Base64 base=new Base64();
	String newPassNew=new String( base.encode( md.digest()));

	AdminDAO ad=new AdminDAO();
	boolean flag=ad.resetPass(sessionId, newPassNew);
	
	if(flag){
		session.invalidate();
		String url=application.getInitParameter("domain");
		String redirectUrl="http://"+url+"/main/index.jsp";

		response.sendRedirect(redirectUrl);
	}
%>