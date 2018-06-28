<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>myPage</title>
</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<div style="margin: auto;">
		<h1>My Page</h1>
	</div>
	<div style="margin: auto;">
		<a class="but" href="${pageContext.request.contextPath}/user/orderList/1?username=<sec:authentication property='principal.username' />"> 장바구니 </a> 
	</div>
	
	<br><br>
	<div style="margin: auto;">
		<input type="button" 
			   value="뒤로가기"
			   style="margin-left: 50px"
			   onclick="history.back()" />
	</div>
</body>
</html>