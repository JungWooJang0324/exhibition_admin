<%@page import="kr.co.sist.util.img.ImageResize"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="DAO.AdminExhibitionDAO"%>
<%@page import="DAO.AdminDAO"%>
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

String exName = mr.getParameter("addExName");
int exHall = Integer.parseInt(mr.getParameter("addExHall"));
String startDate = mr.getParameter("addStartDate");
String endDate = mr.getParameter("addEndDate");
String intro = mr.getParameter("addIntro");
String info = mr.getParameter("addInfo");
int totalCount = Integer.parseInt(mr.getParameter("addTotalNum"));
int watchCount = Integer.parseInt(mr.getParameter("addWatchNum"));
String posterName = mr.getFilesystemName("addExPoster");
String addImgName = mr.getFilesystemName("addAddImg");
int adult = Integer.parseInt(mr.getParameter("addAdult")); 
int child = Integer.parseInt(mr.getParameter("addChild"));
int teen = Integer.parseInt(mr.getParameter("addTeen"));
AdminExhibitionDAO aeDAO = new AdminExhibitionDAO();
aeDAO.insertCategory(exName);


ExhibitionVO eVO = new ExhibitionVO();
eVO.setExNum(aeDAO.selectCat(exName));
eVO.setExhibitionPoster(posterName);
eVO.setExName(exName);
eVO.setExHallNum(exHall);
eVO.setExhibitDateText(startDate);
eVO.setDeadLineText(endDate);
eVO.setExIntro(intro);
eVO.setExInfo(info);
eVO.setTotalCount(totalCount);
eVO.setWatchCount(watchCount);
eVO.setAddImg(addImgName);  
eVO.setAdult(adult);
eVO.setChild(child);
eVO.setTeen(teen);

aeDAO.insertExhibition(eVO);
int ex_num = aeDAO.selectExnum(exName, startDate);
eVO.setExNum(ex_num);

/* ImageResize.resizeImage(saveDirectory.getPath()+"/"+posterName, 80,60);
ImageResize.resizeImage(saveDirectory.getPath()+"/"+addImgName, 80,60); */


aeDAO.insertPrice(eVO);


%>