<%@page import="org.json.simple.JSONObject"%>
<%@page import="DAO.AdminExhibitionDAO"%>
<%@page import="DAO.AdminDAO"%>
<%@page import="VO.ExhibitionVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String poster = request.getParameter("poster");
String exName = request.getParameter("exName");
int exHall = Integer.parseInt(request.getParameter("exHall"));
String startDate = request.getParameter("startDate");
String endDate = request.getParameter("endDate");
String intro = request.getParameter("intro");
String info = request.getParameter("info");
int totalCount = Integer.parseInt(request.getParameter("totalCount"));
int watchCount = Integer.parseInt(request.getParameter("watchCount"));
String addImg = request.getParameter("addImg");

ExhibitionVO eVO = new ExhibitionVO();
eVO.setExhibitionPoster(poster);
eVO.setExName(exName);
eVO.setExHallNum(exHall);
eVO.setExhibitDateText(startDate);
eVO.setDeadLineText(endDate);
eVO.setExIntro(intro);
eVO.setExInfo(info);
eVO.setTotalCount(totalCount);
eVO.setWatchCount(watchCount);
eVO.setAddImg(addImg);


AdminExhibitionDAO aeDAO = new AdminExhibitionDAO();
int cnt = aeDAO.insertExhibition(eVO);

JSONObject jsonObj = new JSONObject();

jsonObj.put("cnt",cnt);
out.print(jsonObj.toJSONString());
%>