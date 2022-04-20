<%@page import="java.io.Console"%>
<%@page import="VO.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="DAO.BoardManagerDAO"%>
<%@include file="admin_id_session.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="게시판 글 추가 process"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>

</head>
<body>
<jsp:useBean id="bVO" class="VO.BoardVO" scope="page"/>
<jsp:setProperty name="bVO" property="*"/>
<jsp:getProperty property="title" name="bVO"/>
<jsp:getProperty property="catNum" name="bVO"/>
<jsp:getProperty property="description" name="bVO"/>

<%
	System.out.println(bVO.getTitle());
	System.out.println(bVO.getCatNum());
	System.out.println(bVO.getDescription());

	//admin 테이블과 연결?
	bVO.setUserId("");
	BoardManagerDAO bDAO = new BoardManagerDAO(); 
	//bDAO.insertBoardAdmin(bVO);
	response.sendRedirect("board.jsp");
%>
</body>
</html>