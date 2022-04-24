<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="VO.ExHallVO"%>
<%@page import="DAO.ExHallManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
     
<%

//전시장 수정
String exName_de = request.getParameter("exName_de");
String hallNum_de = request.getParameter("hallNum_de");
String addr1_de = request.getParameter("addr1_de");
String addr2_de = request.getParameter("addr2_de");
String zipcode_de = request.getParameter("zipcode_de");
String lat_de = request.getParameter("lat_de");
String long_de = request.getParameter("long_de");
String mgrName_de = request.getParameter("mgrName_de");
String mgrTel_de = request.getParameter("mgrTel_de");
String exTel_de = request.getParameter("exTe_de");

//vo 넣기
try{
	ExHallVO ehVO2 = new ExHallVO();
	ehVO2.setExHallNum(Integer.parseInt(hallNum_de));
	ehVO2.setExName(exName_de);
	ehVO2.setAddress1(addr1_de);
	ehVO2.setAddress2(addr2_de);
	ehVO2.setZipcode(zipcode_de);
	ehVO2.setLongitude(Double.parseDouble(long_de));
	ehVO2.setLatitude(Double.parseDouble(lat_de));
	ehVO2.setMgrName(mgrName_de);
	ehVO2.setMgrTel(mgrTel_de);
	ehVO2.setExTel(exTel_de);
	
	ExHallManagerDAO ehmDAO = new ExHallManagerDAO();
	boolean updateFlag = ehmDAO.upadateExhibitonHall(ehVO2); 
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("updateFlag", updateFlag);
}catch(NumberFormatException e){
	e.printStackTrace();
} 


%>
