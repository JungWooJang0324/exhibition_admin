<%@page import="DAO.AdminExhibitionDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    %>
<%
String rezNum=request.getParameter("exNum");
System.out.println(rezNum);
AdminExhibitionDAO aDAO=new AdminExhibitionDAO();
int cnt=aDAO.deleteEx(rezNum);

JSONObject jsonObj = new JSONObject();

jsonObj.put("cnt", cnt);

out.println(jsonObj.toJSONString());
%>
