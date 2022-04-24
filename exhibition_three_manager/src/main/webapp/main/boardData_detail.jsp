<%@page import="VO.BoardVO"%>
<%@page import="DAO.BoardManagerDAO"%>
<%@page import="java.util.List"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="VO.ExHallVO"%>
<%@page import="DAO.ExHallManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"%>
     
<%
//클릭된 게시글 번호
int bdId = Integer.parseInt(request.getParameter("bdId")) ;
//게시글 상세 조회
BoardManagerDAO bDAO = new BoardManagerDAO();
BoardVO bVO = bDAO.selectBoardDetail(bdId);
//게시글 상세 jsonObj 
JSONObject jsonObj = new JSONObject();
jsonObj.put("bdId", bVO.getBdId());
jsonObj.put("inputDate", bVO.getInputDate());
jsonObj.put("title", bVO.getTitle());
jsonObj.put("userId", bVO.getUserId());
jsonObj.put("catNum", bVO.getCatNum());
jsonObj.put("catName", bVO.getCatName());
jsonObj.put("description", bVO.getDescription());
jsonObj.put("imgFile", bVO.getImgFile());

out.println(jsonObj);

%>
