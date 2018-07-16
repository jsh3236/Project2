<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>

<!-- myCss -->
<link rel="stylesheet" href="<c:url value='/js/custom/myCompl.css' />">

<meta charset="UTF-8">
<title>myPage</title>
</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<br><br><br><br><br><br>
	
	<div style="text-align: center;">
		<h2>마이 페이지</h2>
	</div>
	<br><br>
	
	<div style="text-align: center;">
		<button class="whiteBtn" onclick="location.href='${pageContext.request.contextPath}/user/orderList/1?username=<sec:authentication property='principal.username' />'"><span>장바구니</span></button> 
	</div>
	<br>
	
	<div style="text-align: center;">
		<button class="whiteBtn" onclick="location.href='${pageContext.request.contextPath}/user/paymentComplete/<sec:authentication property='principal.username' />/1'"><span>구매 목록</span></button> 
	</div>
	
	<br>
	
</body>
</html>