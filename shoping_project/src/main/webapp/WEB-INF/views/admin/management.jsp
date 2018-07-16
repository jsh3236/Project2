<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<title>ManageMment</title>

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
		<h1>상품 판매 현황</h1>
		<br><br><br><br><br>
		
	</div>
	<div class="main_slider_content">
		<h1>상품 별 판매현황</h1>
		<h6>막대그래프형 뷰</h6>
		<img src="<c:url value='/image/${viewPage}' />" />
	</div>
	
	<br><br><br><br>
	
	<div class="main_slider_content">
		<h1>리뷰 텍스트 마이닝</h1>
		<h6>리뷰 단어의 빈도를 통한 성향 확인</h6>
		<img src="<c:url value='/image/${reviewText}' />" />
	</div>
	
	
	
</body>
</html>