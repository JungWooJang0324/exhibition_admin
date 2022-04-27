<%@page import="DAO.AdminExhibitionDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    info="전시 노출"
    %>
<%
JSONObject jsonObj = new JSONObject();
String exNum = request.getParameter("exNum");
AdminExhibitionDAO aeDAO = new AdminExhibitionDAO();
int cnt = aeDAO.releaseEx(exNum);
jsonObj.put("cnt", cnt);

out.println(jsonObj.toJSONString());
%>
