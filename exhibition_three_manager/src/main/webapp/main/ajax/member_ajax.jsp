<%@page import="org.json.simple.JSONObject"%>
<%@page import="DAO.AdminMemberDAO"%>
<%@page import="VO.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true"
    %>
<%
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String tel = request.getParameter("tel");
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String isDeleted = request.getParameter("isDeleted");
	
	/* if("".equals(zipcode) || "".equals(address1)|| "".equals(address2)){
		jsonObj.put("updateFlag", false);
		jsonObj.put("errMsg","주소를 입력해주세요");
		out.print(jsonObj.toJSONString());
		return;
	}//end if */
	
	MemberVO mVO = new MemberVO();
	mVO.setUserId(id);
	mVO.setTel(tel);
	mVO.setName(name);
	mVO.setZipcode(zipcode);
	mVO.setAddress1(address1);
	mVO.setAddress2(address2);
	mVO.setIsDeleted(isDeleted);
	
	AdminMemberDAO aDAO = new AdminMemberDAO();
	boolean updateFlag = aDAO.updateMember(mVO);
	
	JSONObject jsonObj = new JSONObject();
	jsonObj.put("updateFlag", updateFlag);


	out.print(jsonObj.toJSONString());
%>