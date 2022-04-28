<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="DAO.AdminExhibitionDAO"%>
<%@page import="VO.ExhibitionVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
File saveDirectory = new File("C:/Users/user/git/exhibition_admin/exhibition_three_manager/src/main/webapp/images");
if(!saveDirectory.exists()){
	saveDirectory.mkdirs();
}
int size = 1024*1024*10;
MultipartRequest mr = new MultipartRequest(request,saveDirectory.getPath(),size,"UTF-8",new DefaultFileRenamePolicy());


int exNum = Integer.parseInt(mr.getParameter("exNum"));
String exName=mr.getParameter("exName");
int exHall=Integer.parseInt(mr.getParameter("exHall"));
String startDate = mr.getParameter("startDate");
String endDate = mr.getParameter("endDate");
String intro = mr.getParameter("exIntro");
String info = mr.getParameter("exInfo");
int totalNum = Integer.parseInt(mr.getParameter("totalCount"));
int watchNum = Integer.parseInt(mr.getParameter("watchCount"));
String poster = mr.getFilesystemName("modifyExPoster");
String addImg = mr.getFilesystemName("modifyAddImg");


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
eVO.setExhibitionPoster(poster);
eVO.setAddImg(addImg);

AdminExhibitionDAO aeDAO = new AdminExhibitionDAO();
int cnt = aeDAO.updateEx(eVO);
%>