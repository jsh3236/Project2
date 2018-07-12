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
<title>view writer</title>

<!-- jQuery : 3.2.1 -->
<script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>

<!-- myCss -->
<link rel="stylesheet" href="<c:url value='/js/custom/myCompl.css' />">

<!-- bootstrap JS : 3.3.7 -->
<script src="<c:url value='/js/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>

<script>

function writeReview() {
	
	document.getElementById('reviewform').submit();
	
}


</script>

</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<br><br>
	
	<form:form modelAttribute="review" id="reviewform"
			action="${pageContext.request.contextPath}/user/reviewWriteAction.do"
			method="post" name="reviewform">
		
		<input type="hidden" id="username" name="username" value="<sec:authentication property="principal.username" />" />
		<input type="hidden" id="complNum" name="complNum" value="${paymentCompl.complNum}" />
		<input type="hidden" id="boardNum" name="boardNum" value="${paymentCompl.boardNum}" />
				
		<table>
			<tr>
				<td>
					<img src="<c:url value='/image/${paymentCompl.boardFile}' />" width=75 height=75 />
				</td>
				<td>
					${paymentCompl.boardSubject}<br>
					<font style="font-size: 10px; color: gray;">${paymentCompl.orderOption}</font>
				</td>
			</tr>
			
			<tr>
				<td>
					<img src="<c:url value='/image/check.png' />" width=16 height=14.7 />상품(필수)
				</td>
				<td>
					매우 불만족 <input type="radio" id="score" name="score" value="1"> &nbsp;&nbsp;&nbsp;
					불만족 <input type="radio" id="score" name="score" value="2"> &nbsp;&nbsp;&nbsp;
					보통 <input type="radio" id="score" name="score" value="3"> &nbsp;&nbsp;&nbsp;
					만족 <input type="radio" id="score" name="score" value="4"> &nbsp;&nbsp;&nbsp;
					매우 만족 <input type="radio" id="score" name="score" value="5">
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<input type="text" id="subject" name="subject" placeholder="제목을 입력해 주세요." />
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<input type="text" id="content" name="content" placeholder="내용을 입력해 주세요." />
				</td>
			</tr>
			
		</table>
	
	</form:form>
	
	<br>
	
	<div align="center">
		<button type="button" onclick="writeReview();"><span>확인</span></button> &nbsp;&nbsp;
		<button type="button" onclick="history.go(-1);"><span>취소</span></button>
	</div>
			
	
</body>
</html>