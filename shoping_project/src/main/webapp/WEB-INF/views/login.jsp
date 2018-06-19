<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login</title>
<style>
	.error {
				padding: 15px;
				margin-bottom: 20px;
				border: 1px solid transparent;
				border-radius: 4px;
				color: #a94442;
				background-color: #f2dede;
				border-color: #ebccd1;
		   }
	
	.msg {
			padding: 15px;
			margin-bottom: 20px;
			border: 1px solid transparent;
			border-radius: 4px;
			color: #31708f;
			background-color: #d9edf7;
			border-color: #bce8f1;
		 }
	
	#login-box {
					width: 230px;
					padding: 20px;
					margin: 0px auto;
					background: #fff;
					-webkit-border-radius: 10px;
					-moz-border-radius: 10px;
					border-radius: 10px;
					border: 1px solid #000;
			   }
				
	td { height: 30px; }			
</style>

<script src="http://code.jquery.com/jquery-2.1.0.min.js"></script>

<script>
	$(document).ready(function() {
		
		 // 필드 공백 제거
		 $("#username").val().replace(/\s/g, "");
		 $("#password").val().replace(/\s/g, "");
		 
		 $("#login").click(function() {
			
			// 공백 여부 점검
			if ($.trim($("#username").val()) == "" || 
				$.trim($("#password").val()) == "")   {
				
				alert("공백이 입력되었습니다. 다시 입력하십시오.");
				$("#username").val("");
				$("#password").val("");
				
			} else {
				
				$.ajax({
		    		url : "${pageContext.request.contextPath}/idCheck",
		    	    type: "get",
		    	    dataType: "text",
		        	data : {
		        		username : $("#username").val()
		        	},
		        	success : function(data) {
		        		
		        		if (data.trim() == "true") {
			           		 alert("로그인에 성공하셨습니다.");
			       			 document.loginForm.submit();
			           	} else 
			       			 alert("아이디가 존재하지 않습니다."); 
		        			 $("#username").focus();
			        	}
		        	
		    	}); // $.ajax
			} // if
	    	
	    }) // login
	    
	}) //
</script>
</head>
<body>

	<div id="login-box">

		<h3>Login</h3>
		
		<c:if test="${error eq 'true'}">
			<div class="msg">${msg}</div>
		</c:if>

		<form id="loginForm" 
			  name="loginForm" 
			  action="<c:url value='j_spring_security_check' />"
			  method="POST">
	 
			<table>
				<tr>
					<td>ID : </td>
					<td><input type="text" 
							   id = "username"	
							   name="username" />
					</td>
				</tr>
				<tr>
					<td>PW : </td>
					<td><input type="password" 
							   id="password"
							   name="password" />
					</td>
<!-- 					<td>
						<input id = "remember_me" name ="_spring_security_remember_me" type = "checkbox"/>Remember me
					</td> -->
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input id="login"
							   name="login" 
							   type="button"
							   value="login" />
						&nbsp;
						<input name="reset" 
							   type="reset" 
							   value="reset" />
					    &nbsp;
						<input id="joinbtn"
					    	   name="joinbtn" 	
					    	   type="button"
							   value="join"
							   onclick="location.href='${pageContext.request.contextPath}/join'" />	   
					</td>
				</tr>
			</table>
	 
		</form>
	
 	</div> <!-- login box -->	
</body>
</html>