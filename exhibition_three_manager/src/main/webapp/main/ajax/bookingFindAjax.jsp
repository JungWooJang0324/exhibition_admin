<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="VO.ReservationManagerVO"%>
<%@page import="DAO.ReservationManagerDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String nameSel = request.getParameter("nameSel");
String rezDate= request.getParameter("rezDate");
String findCatName = request.getParameter("findCatName");

System.out.println("nameSel: "+nameSel);
System.out.println("findCatName"+findCatName);
ReservationManagerDAO rmDAO=new ReservationManagerDAO();
List<ReservationManagerVO> list=rmDAO.selectReservation2(nameSel, rezDate, findCatName);

JSONObject jsonObj= new JSONObject();

jsonObj.put("dateFlag", !list.isEmpty());

JSONObject jsonTmp= null;
JSONArray jsonArr=new JSONArray();

for(ReservationManagerVO rVO:list){
	jsonTmp=new JSONObject();
	jsonTmp.put("rezNum", rVO.getRezNum());
	jsonTmp.put("exName", rVO.getExName());
	jsonTmp.put("userName", rVO.getUserName());
	jsonTmp.put("visitDate",new SimpleDateFormat("yyyy-MM-dd").format( rVO.getVisitData()));
	jsonTmp.put("rezStatus", rVO.getRezStatus());
	
	jsonArr.add(jsonTmp);
}

jsonObj.put("list",jsonArr);

System.out.println(jsonObj.toJSONString());
out.println(jsonObj.toJSONString());

%>