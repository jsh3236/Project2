<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>myPage</title>
</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<h1>My Page</h1><br><br>
	<input type="button" 
		   value="뒤로가기"
		   style="margin-left: 50px"
		   onclick="history.back()" />

</body>
</html>