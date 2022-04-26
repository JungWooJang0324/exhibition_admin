<%@page import="org.json.simple.JSONObject"%>
<%@page import="VO.ExHallVO"%>
<%@page import="DAO.ExHallManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
     
<%
//전시장 추가
String exName = request.getParameter("exName");
String exLoc = request.getParameter("exLoc");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");
String zipcode = request.getParameter("zipcode");
String lat = request.getParameter("lat");
String longi = request.getParameter("longi");
String mgrName = request.getParameter("mgrName");
String mgrTel = request.getParameter("mgrTel");
String exTel = request.getParameter("exTel");

//vo 넣기
try{
	ExHallVO ehVO = new ExHallVO();
	ehVO.setExName(exName);
	ehVO.setExLoc(exLoc);
	ehVO.setAddress1(addr1);
	ehVO.setAddress2(addr2);
	ehVO.setZipcode(zipcode);
	ehVO.setLongitude(Double.parseDouble(longi));
	ehVO.setLatitude(Double.parseDouble(lat));
	ehVO.setMgrName(mgrName);
	ehVO.setMgrTel(mgrTel);
	ehVO.setExTel(exTel);
	
	ExHallManagerDAO ehmDAO = new ExHallManagerDAO();
	ehmDAO.insertExhibitonHall(ehVO); 
	
}catch(NumberFormatException e){
	e.printStackTrace();
}


//out.println(jsonObj);



%>
