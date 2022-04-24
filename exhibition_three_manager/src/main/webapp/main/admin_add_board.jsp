<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="VO.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="DAO.BoardManagerDAO"%>
<%@include file="admin_id_session.jsp" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="게시판 글 추가 summernote"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Exhibition Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
  		<!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script> -->
		<!-- jQuery CDN -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
<style type="text/css">
#wrap{width: 90%; margin: 0px auto; margin-top: 30px};
</style>

<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js 1MB 이하 이미지만 올릴 수 있음-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>



<script type="text/javascript">
$(function(){
	 $('#summernote').summernote({ 
		height: 400,                 		// set editor height
		  	focus: true,                  // set focus to editable area after initializing summernote
			  lang: "ko-KR",
			  toolbar: [
		          ['style', ['style']],
		          ['font', ['bold', 'underline', 'clear']],
		          ['color', ['color']],
		          ['para', ['ul', 'ol', 'paragraph']]
		       
       ] });
	 
	 
	 $("#backBtn").click(function(){
		location.href="board.jsp";
	});
	 
	 
	 $("#addBtn").click(function(){
		 filechk();//파일 확장자 확인
		 checkNull();//빈칸 확인 

		 $("#addOk").click(function(){//모달ok 버튼이 눌리면
			$("#postFrm").submit();  //데이터 전송
		 });  
	 })

});//ready


function checkNull(){
	
	if($("#catNum").val()==0){
		 $('#categoryNull').modal('show');//카테고리 null 알림
		 $("#catNum").focus();
		 return;
	 }
	
	if($("#title").val()==""){
		 $("#title").focus();
		 $('#titleNull').modal('show');//제목 null 알림
		 return;
		 
	 }
	if($("#summernote").val()==""){
		$('#summernote').summernote('focus')
	 	$('#descriptionNull').modal('show');//내용 null 알림
		 return;
	 } 
	
	$('#confirmAdd').modal('show');
}


function filechk(){
	 var fileName = $("#upFile").val();
	 var ext = fileName.toLowerCase().substring(fileName.lastIndexOf(".")+1);
	 var compareExt ="png,jpg,gif,bmp".split(",");
	 var flag=false;
	 for(var i=0; i<compareExt.length; i++){
	 	if(compareExt[i]==ext){
	 		flag=true;
			break;
		}
	 }
		
	if(!flag){
		alert(fileName + "은 업로드 불가능합니다.\n이미지만 업로드 가능합니다.\n가능 확장자: png, jpg, gif, bmp");
		return; 
	}
}


</script>
</head>
<body>
<div id="wrap">
	<form  action="admin_board_process.jsp" id="postFrm"  name="postFrm" method="post">
	<div style="color:#D8D8D8 "> 작성자 </div>
	<div id="userId" style="font-size: 20px; margin-top: 5px;"> <%=session.getAttribute("admin_id") %> </div><hr>
	<div id="selectDiv">
		<select name="catNum" id="catNum" class="inputBox" style="margin-bottom: 5px; width: 12%; margin-right: 20px">
			<jsp:useBean id="bDAO" class="DAO.BoardManagerDAO" scope="page"/> 
			<jsp:useBean id="bVO" class="VO.BoardVO" scope="page"/> 
			<% List<BoardVO> list = new ArrayList<BoardVO>();
				list=bDAO.selectCategory();
				pageContext.setAttribute("list", list);
			%>
			<c:forEach var = "bVO" items="${list}">
				<option value="${bVO.catNum}"><c:out value="${bVO.catName}"/></option>
			</c:forEach>
		</select>
	</div>
	<div>	
		<input id="title" name="title" class="inputBox" type="text"  style="margin-bottom: 5px; width: 100%" placeholder=" 제목을 입력해주세요."/>
	</div>
	<div>
		<textarea id="summernote" name="description"></textarea>
	</div>
	<div>
		<input type="file" id="upFile" name="upFile"  />
	</div>
	<div id="btnDiv" style="margin-top: 30px">
		<button type="button" id="backBtn" class="btn btn-outline-dark" style="float: left;margin-left: 10px">뒤로가기</button> 
		<button type="button" id = "addBtn" class="btn btn-outline-info" 
			style="float: right; margin-right: 10px"  >게시글 추가</button>
	</div>
	</form>
</div>
<!-- 이후 모달 -->
<!-- 게시글 추가 확인 모달 -->
	<div class="modal fade" id="confirmAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"></span></button>
	      </div>
	      <div class="modal-body">
	        게시글을 추가하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
		        <button id="addOk" type="button" class="btn btn-primary">OK</button>
	      </div>
	    </div>
	  </div>
  </div>
  <!-- 카테고리 Null 알림 모달 -->
	<div class="modal fade" id="categoryNull" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"></span></button>
	      </div>
	      <div class="modal-body">
	        카테고리를 선택해주세요.
	      </div>
	      <div class="modal-footer">
		        <button  type="button" data-dismiss="modal" class="btn btn-primary">OK</button>
	      </div>
	    </div>
	  </div>
  </div>
  <!-- titleNull 알림 모달 -->
	<div class="modal fade" id="titleNull" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"></span></button>
	      </div>
	      <div class="modal-body">
	        제목을 입력해주세요.
	      </div>
	      <div class="modal-footer">
		        <button  type="button" data-dismiss="modal" class="btn btn-primary">OK</button>
	      </div>
	    </div>
	  </div>
  </div>
  <!-- descriptionNull 추가 알림 모달 -->
	<div class="modal fade" id="descriptionNull" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true"></span></button>
	      </div>
	      <div class="modal-body">
	        내용을 입력해주세요.
	      </div>
	      <div class="modal-footer">
		        <button  type="button" data-dismiss="modal" class="btn btn-primary">OK</button>
	      </div>
	    </div>
	  </div>
  </div>
</body>
</html>