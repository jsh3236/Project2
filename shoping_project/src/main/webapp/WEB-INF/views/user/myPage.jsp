<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<style>

a.myType {
	text-decoration: none;
	font-size: 50px;
}

a.myType:active,
a.myType:HOVER,
a.myType:VISITED,
a.myType:LINK
{
	color: black;
}

</style>


<meta charset="UTF-8">
<title>myPage</title>
</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<div style="text-align: center;">
		<h1>My Page</h1>
	</div>
	<br><br><br><br><br><br>
	<div style="text-align: center;">
		<a class="myType" href="${pageContext.request.contextPath}/user/orderList/1?username=<sec:authentication property='principal.username' />"> 장바구니 </a> 
	</div>
	<br>
	
	<div style="text-align: center;">
	<a class="myType" href="${pageContext.request.contextPath}/user/paymentComplete/<sec:authentication property='principal.username' />/1"> 구매 목록 </a> 
	</div>
	
	<br>
</body>
</html>