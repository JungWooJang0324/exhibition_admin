<%@page import="org.json.simple.JSONObject"%>
<%@page import="VO.ExHallVO"%>
<%@page import="DAO.ExHallManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
     
<%

try{
	//전시장 삭제
	String hallNum_de = request.getParameter("hallNum_de");
	
	ExHallManagerDAO ehmDAO = new ExHallManagerDAO();
	boolean deleteFlag = ehmDAO.deleteExhibitonHall(Integer.parseInt(hallNum_de)); 
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("deleteFlag", deleteFlag);
	
}catch(NumberFormatException e){
	e.printStackTrace();
}





%>
