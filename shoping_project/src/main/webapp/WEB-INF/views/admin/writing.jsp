<%--@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8"> 
<title>MVC 게시판</title>
 

<style type="text/css">
#registForm {
	width: 500px;
	height: 610px;
	border: 1px solid white;
	margin: auto;
}

h2 {
	text-align: center;
}

table {
	margin: auto;
	width: 450px;
}

.td_left {
	width: 150px;
	background: white;
}

.td_right {
	width: 300px;
	background: white;
}

#commandCell {
	text-align: center;
}

/* 추가 : spring form 점검 메시지 */
.formErr {
	color: red;
	font-size: 9pt;
}

/* 여기까지 강사님 css */

/* reset */
* {
	margin: 0;
	padding: 0;
}

li {
	list-style: none;
}

a {
	text-decoration: none;
}

/* common */
.wrapper {
	width: 100%;
	margin: 0 auto;
}

.clearfix {
	content: '';
	display: block;
	clear: both;
}

/* header */
header {
	height: 75px;
	border: 1px solid #D3D3D3;
	position: fixed;
	width: 100%;
	z-index: 9999;
	top: 0;
	left: 0;
}

header a {
	display: block;
	color: black;
}

h1 {
	color: black;
	line-height: 75px;
	float: left;
	padding-left: 200px;
	font-size: 30px;
}

.menu {
	float: right;
	font-size: 15px;
}

.menu li {
	float: left;
}

.menu a {
	line-height: 75px;
	color: black;
	padding: 0 15px;
	display: block;
}

/* 테이블 모양  */
table.type03 {
	width: 50%;
	border-collapse: collapse;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	border-left: 3px solid #369;
	border-right: hidden;
	margin: auto;
}

table.type03 th {
	width: 300px;
	padding: 10px;
	font-weight: bold;
	font-size: 15px;
	vertical-align: middle;
	color: #153d73;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

table.type03 td {
	width: 600px;
	padding: 10px;
	vertical-align: middle;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

/* 전체 font 컬러 지정 */
font {
	color: #8BBDFF;
}
</style>

</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<!-- 게시판 등록 -->
	<section id="writeForm">

		<h2>마우스 상품 등록</h2>

		<form:form modelAttribute="board"
			action="${pageContext.request.contextPath}/admin/writeAction.do"
			method="post" enctype="multipart/form-data" name="boardform">

			<table class="type03">

				<tr>
					<th><label for="boardSubject">제 목</label></th>
					<td class="td_right" style="height: 20px;"><input name="boardSubject" type="text"
						id="boardSubject" required="required" style="height: 25px;"/> <form:errors
							path="boardSubject" /></td><br>
				</tr>
				
				<tr>
					<th><label for="boardContent">내 용</label></th>
					<td><textarea id="boardContent" name="boardContent" cols="60"
							rows="20" required="required"></textarea> <form:errors
							path="boardContent" /></td>
				</tr>
				
				
				<tr>
					<th><label for="boardPrice">금 액</label></th>
					<td class="td_right"><input name="boardPrice" type="text"
						id="boardPrice" required="required" style="height: 25px;"/>  <form:errors
							path="boardPrice" /></td>
				</tr>
				
				<tr>
					<th><label for="boardFile"> 메인 사진 </label></th>
					<td class="td_right"><input name="boardFile" type="file"
						id="boardFile" /></td>
				</tr>
				
				<tr>
					<th><label for="boardFileContent"> 내용 사진 </label></th>
					<td class="td_right"><input name="boardFileContent" type="file"
						id="boardFileContent" /></td>
				</tr>
				

			</table>
			<br>
			<section id="commandCell">
				<input type="submit" value="등록">&nbsp;&nbsp; <input
					type="reset" value="다시쓰기" />
			</section>

		</form:form>

	</section>
	<!-- 게시판 등록 //-->

</body>
</html>
