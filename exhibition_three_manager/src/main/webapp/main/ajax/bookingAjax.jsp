<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.el.parser.SimpleNode"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="VO.ReservationManagerVO"%>
<%@page import="DAO.ReservationManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    info="예약 ajax처리"
    %>
<%
int num=Integer.parseInt(request.getParameter("rezNum"));

ReservationManagerDAO rmDAO=new ReservationManagerDAO();
ReservationManagerVO rVO=rmDAO.selectOneReservation(num);

JSONObject jsonObj= new JSONObject();

jsonObj.put("exName", rVO.getExName());
jsonObj.put("exNum", rVO.getExNum());
jsonObj.put("userName", rVO.getUserName());
jsonObj.put("rezCount", rVO.getRezCount());
jsonObj.put("rezDate",new SimpleDateFormat("yyyy-MM-dd").format( rVO.getRezData()));
jsonObj.put("userId", rVO.getUserId());

jsonObj.put("visitDate", new SimpleDateFormat("yyyy-MM-dd").format(rVO.getVisitData()) );
jsonObj.put("price", rVO.getPrice());

out.println(jsonObj.toJSONString());
System.out.println("-------------"+num);
System.out.println(jsonObj.toJSONString());
%>