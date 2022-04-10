<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<style type="text/css">
#wrap{width: 90%; margin: 0px auto; margin-top: 30px};
</style>

<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js 1MB 이하 이미지만 오릴 수 있음-->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>



<script type="text/javascript">
$(function(){
	 $('#summernote').summernote({ 
			height: 400,                 // set editor height
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
	 
	 $("#addPost").click(function(){
		 $("#confirmAdd").modal('show');	
	 });
});//ready


</script>
</head>
<body>
<div id="wrap">
	<form method="post">
	<div style="color:#D8D8D8 "> 작성자 </div>
	<div id="name" style="font-size: 20px; margin-top: 5px;"> 홍길동 </div><hr>
	<div id="selectDiv">
		<select id="selectBoard" class="inputBox" style="margin-bottom: 5px; width: 80%">
			<option>게시판을 선택해주세요.</option>
		</select>
		<select id="selecthead" class="inputBox" style="margin-bottom: 5px; width: 19%">
			<option>말머리 선택</option>
		</select>
	</div>
	<div id="subjectDiv">
		<input id="subject" class="inputBox" type="text"  style="margin-bottom: 5px; width: 100%"placeholder=" 제목을 입력해주세요."/>
	</div>
	<div id="summernote">
		<p>내용을 입력해주세요</p>
	</div>
	</form>
	<div id="btnDiv" style="margin-top: 30px">
		<button type="button" class="btn btn-primary" style="float: left;margin-left: 10px">뒤로가기</button> 
		<button type="button" id = "addPost" class="btn btn-primary" 
			style="float: right;margin-right: 10px" data-bs-toggle="modal" data-bs-target="#confirmAdd" >게시글 추가</button>
	</div>
	<!-- 게시글 추가 확인 모달  -->
	<div class="modal fade" id="confirmAdd" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body" style="text-align: center">
	        게시글을 추가하시겠습니까?
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
	        <button type="button" class="btn btn-primary">OK</button>
	      </div>
	    </div>
	  </div>
	</div>
	
</div>
<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Launch demo modal
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        ...
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>