<%@page import="DAO.AdminDAO"%>
<%@include file="admin_id_session.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Password Reset</title>
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <style>
        #passLenCk {font-size: 10px; color:#ff0000; font-weight: bold; }
        
        </style>
        
        <script type="text/javascript">
        $(function() {
        	var output="";
        	$("#newPass").focusout(function() {
	        	if($("#newPass").val().length>5){
	        		output="";
	        	}else{
	        		output="* 비밀번호는 6글자 이상 이어야 합니다.";
	        	}
	        	
	        	$("#passLenCk").html(output);
	        	
			}); //focusIn
        	
			$("#resetPw").click(function() {
				if($("#newPass").val() != $("#ckPass").val()){
					alert("비밀번호가 틀립니다!");
					$("#ckPass").val("");
					$("#ckPass").focus();
					$("#ckPass").css("border", "2px solid red");
					$("#ckLabel").css("color", "red");
					$("#ckLabel").css("font-weight", "bold");
					return;
				}
				
				if($("#newPass").val().length<6){
					alert("비밀번호는 6글자 이상이어야 합니다.");
					$("#newPass").focus();
					return;
				}

				$("#resetPass").submit();
			});
		});
        </script>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Password Recovery</h3></div>
                                    <div class="card-body">
                                        <div class="small mb-3 text-muted">새로운 비밀번호를 설정해 주세요 &nbsp;&nbsp;&nbsp;<span id="passLenCk"></span></div>
                                        <form action="resetPassck.jsp" id="resetPass">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="newPass" type="password" name="newPass"/>
                                                <label for="inputEmail">새로운 비밀번호 입력</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="ckPass" type="password"/>
                                                <label for="inputEmail" id="ckLabel">비밀번호 확인</label>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                                <a class="small" href="login.jsp">Return to login</a>
                                                <a class="btn btn-primary" href="#" id="resetPw">Reset Password</a>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <div id="layoutAuthentication_footer">
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2022</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
    </body>
</html>
