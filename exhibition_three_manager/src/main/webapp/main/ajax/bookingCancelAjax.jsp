<%@page import="org.json.simple.JSONObject"%>
<%@page import="DAO.ReservationManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    info="예약 수정ajax처리"
    %>
<%
	int rezNum=Integer.parseInt(request.getParameter("rezNum"));
	System.out.println(rezNum);
	ReservationManagerDAO rm=new ReservationManagerDAO();
	int cnt=rm.cancelReservation(rezNum);
	
	JSONObject jsonObj = new JSONObject();
	
	jsonObj.put("cnt", cnt);
	
	out.println(jsonObj.toJSONString());
%>