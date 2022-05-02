<%@page import="DAO.AdminExhibitionDAO"%>
<%@page import="VO.ExhibitionVO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    %>
<%
int exNum = Integer.parseInt(request.getParameter("exNum"));
AdminExhibitionDAO aDAO = new AdminExhibitionDAO();
ExhibitionVO eVO = aDAO.selectExDetail(exNum);
JSONObject jsonObj = new JSONObject();
jsonObj.put("exName",eVO.getExName());
jsonObj.put("exIntro",eVO.getExIntro());
jsonObj.put("totalCount",eVO.getTotalCount());
jsonObj.put("watchCount",eVO.getWatchCount());
jsonObj.put("exInfo",eVO.getExInfo());
jsonObj.put("exPoster",eVO.getExhibitionPoster());
jsonObj.put("addImg",eVO.getAddImg());
jsonObj.put("adult",eVO.getAdult());
jsonObj.put("teen",eVO.getTeen());
jsonObj.put("child",eVO.getChild());
jsonObj.put("exhibitDate",eVO.getExhibitDateText());
jsonObj.put("deadline",eVO.getDeadLineText());
jsonObj.put("exHallNum",eVO.getExHallNum());

String exStatus = eVO.getExStatus();
jsonObj.put("exStatus", "t".equals(exStatus)? "N":"Y");


out.print(jsonObj.toJSONString());

%>