<%@page import="org.json.simple.JSONObject"%>
<%@page import="DAO.ReservationManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int rezNum=Integer.parseInt(request.getParameter("rezNum"));

	ReservationManagerDAO rm=new ReservationManagerDAO();
	int cnt=rm.confirmReservation(rezNum);
	
	JSONObject jsonObj = new JSONObject();
	
	jsonObj.put("cnt", cnt);
	
	out.println(jsonObj.toJSONString());
%>