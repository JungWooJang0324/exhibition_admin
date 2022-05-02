<%@page import="java.io.File"%>
<%@page import="DAO.AdminExhibitionDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    %>
<%
String exNum=request.getParameter("exNum");
String poster = request.getParameter("poster");
String addImg = request.getParameter("addImg");

AdminExhibitionDAO aDAO=new AdminExhibitionDAO();
int cnt=aDAO.deleteEx(exNum);
File posterPath = new File("C:/Users/user/git/exhibition_admin/exhibition_three_manager/src/main/webapp/images"+poster);
File addImgPath = new File("C:/Users/user/git/exhibition_admin/exhibition_three_manager/src/main/webapp/images"+addImg);

if(posterPath.exists()){
	posterPath.delete();
}//end if
if(addImgPath.exists()){
	addImgPath.delete();
}//end if

JSONObject jsonObj = new JSONObject();

jsonObj.put("cnt", cnt);

out.println(jsonObj.toJSONString());
%>
