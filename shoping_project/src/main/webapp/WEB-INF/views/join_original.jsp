<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>
<style>
#join-box {
				width: 250px;
				padding: 20px;
				margin: 0px auto;
				background: #fff;
				-webkit-border-radius: 10px;
				-moz-border-radius: 10px;
				border-radius: 10px;
				border: 1px solid #000;
				line-height: 30px;
		  }
</style>
</head>
<body>

	<div id="join-box">

		<h3>Join</h3>
			
		<form id="join" 
			  action="joinAction" 
			  method="post">
		
			ID : <input type="text" 
						id="username"
						name="username"
						maxlength="20"
						size="25">
				 <br>
			PW : <input type="password" 
						id="password"
						name="password"
						maxlength="20"
						size="25">
				 <br>	 		
			<input type="submit" value="join">&nbsp;
			<input type="reset" value="reset">&nbsp;
			
		</form>
	
	</div>		

</body>
</html>