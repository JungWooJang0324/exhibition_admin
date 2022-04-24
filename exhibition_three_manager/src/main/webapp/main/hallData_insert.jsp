<%@page import="org.json.simple.JSONObject"%>
<%@page import="VO.ExHallVO"%>
<%@page import="DAO.ExHallManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
     
<%
//전시장 추가
String exName_add = request.getParameter("exName_add");
String exLoc_add = request.getParameter("exLoc_add");
String addr1_add = request.getParameter("addr1_add");
String addr2_add = request.getParameter("addr2_add");
String zipcode_add = request.getParameter("zipcode_add");
String lat_add = request.getParameter("lat_add");
String long_add = request.getParameter("long_add");
String mgrName_add = request.getParameter("mgrName_add");
String mgrTel_add = request.getParameter("mgrTel_add");
String exTel_add = request.getParameter("exTe_add");

//vo 넣기
try{
	ExHallVO ehVO = new ExHallVO();
	ehVO.setExName(exName_add);
	ehVO.setExLoc(exLoc_add);
	ehVO.setAddress1(addr1_add);
	ehVO.setAddress2(addr2_add);
	ehVO.setZipcode(zipcode_add);
	ehVO.setLongitude(Double.parseDouble(long_add));
	ehVO.setLatitude(Double.parseDouble(lat_add));
	ehVO.setMgrName(mgrName_add);
	ehVO.setMgrTel(mgrTel_add);
	ehVO.setExTel(exTel_add);
	
	ExHallManagerDAO ehmDAO = new ExHallManagerDAO();
	ehmDAO.insertExhibitonHall(ehVO); 
	
}catch(NumberFormatException e){
	e.printStackTrace();
}


//out.println(jsonObj);



%>
