<%@page import="DAO.BoardManagerDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="VO.ExHallVO"%>
<%@page import="DAO.ExHallManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
     
<%

try{
	//전시장 삭제
	int bdId = Integer.parseInt(request.getParameter("bdId_de")) ;
	
	BoardManagerDAO bDAO = new BoardManagerDAO();
	int cnt =bDAO.deleteBoardAdmin(bdId);; 
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("cnt", cnt);
	
}catch(NumberFormatException e){
	e.printStackTrace();
}





%>
