<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DAO.BoardManagerDAO"%>
<%@page import="VO.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="VO.ExHallVO"%>
<%@page import="DAO.ExHallManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
     
<%

//전시장 수정
int catNum =Integer.parseInt(request.getParameter("catNum"));
String title = request.getParameter("title");
String description = request.getParameter("description");
int bdId = Integer.parseInt(request.getParameter("bdId"));
//vo 넣기
try{
	
	BoardVO bVO = new BoardVO();
	
	bVO.setCatNum(catNum);
	bVO.setTitle(title);
	bVO.setDescription(description);
	bVO.setBdId(bdId);
	
	BoardManagerDAO bDAO = new BoardManagerDAO();
	int cnt = bDAO.upadateBoard(bVO); 
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("updateFlag", cnt);
}catch(NumberFormatException e){
	e.printStackTrace();
} 


%>
