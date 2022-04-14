<%@page import="VO.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="DAO.BoardManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="게시판 글 추가 summernote"%>
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
		<!-- jQuery CDN -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
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
		          ['para', ['ul', 'ol', 'paragraph']],
		          ['table', ['table']],
		          ['insert', [ 'picture']]
       ] });
	 
	 $("#backBtn").click(function(){
		location.href="http://localhost/exhibition_three_manager/main/board.jsp";
	});
	 
});//ready


</script>
</head>
<body>
<jsp:include page="admin_id_session.jsp"/>
<div id="wrap">
	<form name= "addBoardAdminFrm" method="post">
	<% BoardManagerDAO bDAO = new BoardManagerDAO(); 
		%>
	<div style="color:#D8D8D8 "> 작성자 </div>
	<div id="name" style="font-size: 20px; margin-top: 5px;"> <%=session.getAttribute("admin_id") %> </div><hr>
	<div id="selectDiv">
		<select id="selectBoard" class="inputBox" style="margin-bottom: 5px; width: 80%">
			<option></option>
		</select>
		<select id="selecthead" class="inputBox" style="margin-bottom: 5px; width: 19%">
			<option>말머리 선택</option>
		</select>
	</div>
	<div id="subjectDiv">
		<input id="subject" class="inputBox" type="text"  style="margin-bottom: 5px; width: 100%"placeholder=" 제목을 입력해주세요."/>
	</div>
	<div id="summernote" >
		<p></p>
	</div>
	<div id="btnDiv" style="margin-top: 30px">
		<button type="button" id="backBtn" class="btn btn-secondary" style="float: left;margin-left: 10px">뒤로가기</button> 
		<button type="button" id = "addBtn" class="btn btn-primary" 
			style="float: right; margin-right: 10px" data-toggle="modal" data-target="#confirmAdd" >게시글 추가</button>
	</div>
	</form>
<!-- 모달 -->
</div>
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
		        <button type="button" class="btn btn-primary">OK</button>
	      </div>
	    </div>
	  </div>
  </div>
</body>
</html>