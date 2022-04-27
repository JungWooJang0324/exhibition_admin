<%@page import="DAO.AdminExhibitionDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    %>
<%
String exNum = request.getParameter("exNum");
JSONObject jsonObj = new JSONObject();
AdminExhibitionDAO aeDAO = new AdminExhibitionDAO();
int cnt = aeDAO.deleteEx(exNum);
jsonObj.put("cnt", cnt);
out.print(jsonObj.toJSONString());

%>
