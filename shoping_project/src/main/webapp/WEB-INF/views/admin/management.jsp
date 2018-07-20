<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<title>ManageMment</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Colo Shop Template">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/single_styles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/single_responsive.css">

<style>
.main_slider
{
	width: 100%;
	height: 700px;
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center center;
	margin: auto;
	
}
.main_slider_content
{
	width: 60%;
	text-align: center;
}
.main_slider_content h6
{
	font-weight: 500;
	text-transform: uppercase;
	margin-bottom: 29px;
}
.main_slider_content h1
{
	font-weight: 400;
	line-height: 1;
}
</style>
	
<!-- jQuery : 3.2.1 -->
<script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>
</head>


<body>
<div><jsp:include page="../include.jsp" flush="false" /></div>
<div style="text-align: center;">
	<br><br><br><br><br><br><br>
	
</div>
<div class="main_slider_content" style="width: 1600px;">
	<h1 style="margin-bottom: 50px">상품 별</h1>
	<table style="margin: auto;">
		<tr>
			<td>
				<h2>판매현황</h2>
				<h6>막대그래프형 뷰</h6>
			</td>
			<td style="margin-left: 40px;padding-left: 100px;padding-right: 250px;">
				<h2>리뷰 점수 </h2>
				<h6>평균점수 1당 별(실점수)</h6>
			</td>
		</tr>
		<tr>
			<td>
				<img src="<c:url value='/image/${viewPage}' />" />
			</td>
			<td style="vertical-align: top; margin-left: 40px;padding-left: 100px;padding-right: 250px;">
				<c:forEach var="array" items="${boardName}" varStatus="st">
					
					<div class="user_rating" style="text-align: right;">
						${array}
						
						<ul class="star_rating">
							<c:choose>
								<c:when test="${ScoreStarArray[st.index] eq 1}">
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								</c:when>
								<c:when test="${ScoreStarArray[st.index] eq 2}">
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								</c:when>
								<c:when test="${ScoreStarArray[st.index] eq 3}">
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								</c:when>
								<c:when test="${ScoreStarArray[st.index] eq 4}">
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								</c:when>
								<c:when test="${ScoreStarArray[st.index] eq 5}">
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
								</c:when>
								<c:otherwise>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								</c:otherwise>
							</c:choose>
						</ul>
						(${ScoreArray[st.index]})
					</div>
						
				</c:forEach>		 
			</td>
		</tr>
	</table>
</div>
	
	<br><br><br><br>
	
	<div class="main_slider_content" style="width: 1600px;">
		<h1>리뷰 텍스트 마이닝</h1>
		<h6>리뷰 단어의 빈도를 통한 성향 확인</h6>
		<img src="<c:url value='/image/${reviewText}' />" />
	</div>
	
	
	
	
</body>
</html>