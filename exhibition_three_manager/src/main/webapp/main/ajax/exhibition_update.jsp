<%@page import="java.lang.reflect.Field"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="DAO.AdminExhibitionDAO"%>
<%@page import="VO.ExhibitionVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
File saveDirectory = new File("E:/exhibTest_service/images");
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
String hidPoster = mr.getParameter("hidPoster");
File hidPosterPath = new File(saveDirectory.getPath()+"/"+hidPoster);
String hidAddImg = mr.getParameter("hidAddImg");
File hidAddImgPath = new File(saveDirectory.getPath()+"/"+hidAddImg);
String poster = mr.getFilesystemName("modifyExPoster");
String addImg = mr.getFilesystemName("modifyAddImg");
int adult = Integer.parseInt(mr.getParameter("adult"));
int child = Integer.parseInt(mr.getParameter("child"));
int teen = Integer.parseInt(mr.getParameter("teen"));

if(poster==null||"".equals(poster)){//포스터를 입력하지 않은경우
	poster=hidPoster;
}else if(hidPosterPath.exists()){
	hidPosterPath.delete();
}//end else if
if(addImg==null||"".equals(addImg)){//추가 이미지를 입력하지 않은 경우
	addImg=hidAddImg;
}else if(hidAddImgPath.exists()){
	hidAddImgPath.delete();
}//end else if


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
eVO.setAdult(adult);
eVO.setChild(child);
eVO.setTeen(teen);

AdminExhibitionDAO aeDAO = new AdminExhibitionDAO();

aeDAO.updateCat(eVO);
aeDAO.updateEx(eVO);
aeDAO.updatePrice(eVO);
%>