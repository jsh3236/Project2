<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko-kr">
<head>
<title>admin home</title>

<!-- jQuery : 3.2.1 -->
<script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>

<!-- myCss -->
<link rel="stylesheet" href="<c:url value='/js/custom/myCompl.css' />">

<!-- bootstrap JS : 3.3.7 -->
<script src="<c:url value='/js/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>
<script>

function openDetail(){  
    window.open("detail", "detailWindow", "width=200, height=300, toolbar=no, menubar=no, scrollbars=no,titlebar = no, resizable=no" );
    document.getElementById("detailform").submit();
}
</script>

</head>
<body>
<div><jsp:include page="../include.jsp" flush="false" /></div>
<br><br><br><br><br>
	<div style="text-align: center;">
		<h2>관리자 메뉴</h2>
	</div>
	<br><br>
	
	<div style="text-align: center;">
		<button class="whiteBtn" type="button" onclick="location.href='${pageContext.request.contextPath}/admin/paymentComplete/1'"><span>구매 목록 관리</span></button>
	</div> 
	
	<br>
	
	<div style="text-align: center;">
		<button class="whiteBtn" type="button" onclick="location.href='${pageContext.request.contextPath}/admin/manage.do'"><span>빅데이터 관리</span></button>
	</div>
	
</body>
</html>