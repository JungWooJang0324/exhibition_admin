<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.Date"%>
<%@page import="DAO.ReservationManagerDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    info="예약 수정ajax처리"
    %>
<%
	int rezCount=Integer.parseInt(request.getParameter("rezCount"));
	String visitDate= request.getParameter("visitDate");
	int rezNum=Integer.parseInt(request.getParameter("rezNum"));

	ReservationManagerDAO rm=new ReservationManagerDAO();
	int cnt=rm.updateReservation(rezCount, visitDate , rezNum);
	
	JSONObject jsonObj = new JSONObject();
	
	jsonObj.put("cnt", cnt);
	System.out.println(cnt);
	out.println(jsonObj.toJSONString());
%>