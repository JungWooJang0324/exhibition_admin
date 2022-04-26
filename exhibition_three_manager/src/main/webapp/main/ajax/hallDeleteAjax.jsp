<%@page import="org.json.simple.JSONObject"%>
<%@page import="VO.ExHallVO"%>
<%@page import="DAO.ExHallManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
     
<%

try{
	//전시장 삭제
	String hallNum = request.getParameter("hallNum");
	
	ExHallManagerDAO ehmDAO = new ExHallManagerDAO();
	int cnt = ehmDAO.deleteExhibitonHall(Integer.parseInt(hallNum)); 
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("cnt", cnt);
	
}catch(NumberFormatException e){
	e.printStackTrace();
}





%>
