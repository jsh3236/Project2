<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
	<title>Home</title>
	
<style type="text/css">

	/* reset */
	*{margin: 0; padding: 0;}
	li{list-style: none;}
	a{text-decoration: none;}
	
	/* common */
	.wrapper{width: 100%; margin: 0 auto;}
	.clearfix{content: ''; display: block; clear: both;}
	
	/* header */
	header{height: 75px; border: 1px solid #D3D3D3;
		   position: fixed; width: 100%; z-index: 9999; top: 0; left: 0;}
	header a{display:  block; color: black;}
	h1{color: black; line-height: 75px; float: left; padding-left: 200px; font-size: 30px;}
	.menu{float:right;  font-size: 15px;}
	.menu li{float: left;}
	.menu a{line-height: 75px; color: black; padding: 0 15px; display:  block;}
	
</style>

</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
키보드

</body>
</html>
