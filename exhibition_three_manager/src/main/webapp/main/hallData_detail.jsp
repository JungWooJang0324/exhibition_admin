<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="VO.ExHallVO"%>
<%@page import="DAO.ExHallManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
     
<%
//클릭된 전시장 번호
int hallNum = Integer.parseInt(request.getParameter("hallNum")) ;
//전시 상세 조회
ExHallManagerDAO ehmDAO = new ExHallManagerDAO();
ExHallVO ehVO = ehmDAO.selectExhibitonHallDetail(hallNum);
//전시 상세 jsonObj 
JSONObject jsonObj = new JSONObject();
jsonObj.put("exName", ehVO.getExName());
jsonObj.put("exNum", ehVO.getExHallNum());
jsonObj.put("zipcode", ehVO.getZipcode());
jsonObj.put("latitude", ehVO.getLatitude());
jsonObj.put("longitude", ehVO.getLongitude());
jsonObj.put("mgrName", ehVO.getMgrName());
jsonObj.put("mgrTel", ehVO.getMgrTel());
jsonObj.put("exTel", ehVO.getExTel());
jsonObj.put("addr1", ehVO.getAddress1());
jsonObj.put("addr2", ehVO.getAddress2());

out.println(jsonObj);

%>
