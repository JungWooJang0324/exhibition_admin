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
int bdId = Integer.parseInt(request.getParameter("bdId")) ;
int catNum =Integer.parseInt(request.getParameter("catNum"));
String title = request.getParameter("title");
String description = request.getParameter("description");
String inputDate = request.getParameter("inputDate");
String adminId = request.getParameter("adminId");
String imgFile = request.getParameter("imgFile");
String catName = request.getParameter("catName");

//vo 넣기
try{
	BoardVO bVO = new BoardVO();
	bVO.setBdId(bdId);
	bVO.setCatNum(catNum);
	bVO.setTitle(title);
	bVO.setDescription(description);
	bVO.setInputDate(inputDate);
	bVO.setAdminId(adminId);
	bVO.setImgFile(imgFile);
	bVO.setCatName(catName);
	
	BoardManagerDAO bDAO = new BoardManagerDAO();
	boolean updateFlag = bDAO.upadateBoard(bVO); 
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("updateFlag", updateFlag);
}catch(NumberFormatException e){
	e.printStackTrace();
} 


%>
