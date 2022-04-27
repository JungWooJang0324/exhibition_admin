<%@page import="org.json.simple.JSONObject"%>
<%@page import="DAO.AdminExhibitionDAO"%>
<%@page import="VO.ExhibitionVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int exNum = Integer.parseInt(request.getParameter("exNum"));
String exName=request.getParameter("exName");
int exHall=Integer.parseInt(request.getParameter("exHall"));
String startDate = request.getParameter("startDate");
String endDate = request.getParameter("endDate");
String intro = request.getParameter("intro");
String info = request.getParameter("info");
int totalNum = Integer.parseInt(request.getParameter("totalNum"));
int watchNum = Integer.parseInt(request.getParameter("watchNum"));

ExhibitionVO eVO = new ExhibitionVO();
eVO.setExNum(exNum);
eVO.setExName(exName);
eVO.setExHallNum(exHall);
eVO.setExhibitDateText(startDate);
eVO.setDeadLineText(endDate);
eVO.setExIntro(intro);
eVO.setExInfo(info);
eVO.setTotalCount(totalNum);
eVO.setWatchCount(watchNum);

AdminExhibitionDAO aeDAO = new AdminExhibitionDAO();
int cnt = aeDAO.updateEx(eVO);
JSONObject jsonObj = new JSONObject();
jsonObj.put("cnt",cnt);

out.print(jsonObj);
%>