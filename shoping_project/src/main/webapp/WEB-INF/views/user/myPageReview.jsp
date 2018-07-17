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


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/single_styles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/single_responsive.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/bootstrap4/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/themify-icons/themify-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.css">

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/styles/bootstrap4/popper.js"></script>
<script src="${pageContext.request.contextPath}/resources/styles/bootstrap4/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/easing/easing.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/single_custom.js"></script>


<script>

function writeReview() {
	
	document.getElementById('reviewform').submit();
	
}


</script>

</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<br><br><br><br><br><br>
	
		
		
			
		<div class="col-lg-6 add_review_col" style="margin: auto;">

			<div class="add_review">
				<form id="review_form" id="reviewform" action="${pageContext.request.contextPath}/user/reviewWriteAction.do" method="post">
				
					<input type="hidden" id="username" name="username" value="<sec:authentication property="principal.username" />" />
					<input type="hidden" id="complNum" name="complNum" value="${paymentCompl.complNum}" />
					<input type="hidden" id="boardNum" name="boardNum" value="${paymentCompl.boardNum}" />
					
					<div>
						<h1 style="font-size: 34px; text-align: center; font-weight: 800;">리뷰쓰기</h1>
						<table>
						<tr>
							<td style="width: 120px">
								<img src="<c:url value='/image/${paymentCompl.boardFile}' />" width=100 height=100 />
							</td>
							<td style="width: 400px">
								${paymentCompl.boardSubject}<br>
								<font style="font-size: 10px; color: gray;">${paymentCompl.orderOption}</font>
							</td>
						</tr>
						
						</table>
					</div>
					<div>
						<img src="<c:url value='/image/check.png' />" width=16 height=14.7 style="margin-bottom: 5px"/><h1>상품:</h1> &nbsp;&nbsp;&nbsp;
						매우 불만족 <input type="radio" id="score" name="score" value="1"> &nbsp;&nbsp;&nbsp;
						불만족 <input type="radio" id="score" name="score" value="2"> &nbsp;&nbsp;&nbsp;
						보통 <input type="radio" id="score" name="score" value="3"> &nbsp;&nbsp;&nbsp;
						만족 <input type="radio" id="score" name="score" value="4"> &nbsp;&nbsp;&nbsp;
						매우 만족 <input type="radio" id="score" name="score" value="5"> <br>
						<input class="form_input input_email" type="text" id="subject" name="subject" placeholder="제목을 입력해 주세요." /> 
						<textarea id="content" class="input_review" name="content"  placeholder="내용을 입력해 주세요." rows="4"></textarea>
					</div>
					<div class="text-left text-sm-right">
						<button id="review_submit" type="submit" class="red_button review_submit_btn trans_300" style="width: 100%" value="Submit">완료</button>
					</div>
				</form>
			</div>

		</div>	
		
	
</body>
</html>