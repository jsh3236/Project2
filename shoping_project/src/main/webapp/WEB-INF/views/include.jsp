<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
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
		   position: fixed; width: 100%; z-index: 9999; top: 0; left: 0; color: white;}
	header a{display:  block; color: black;}
	h1{color: black; line-height: 75px; float: left; padding-left: 200px; font-size: 30px;}
	.menu{float:right;  font-size: 15px;}
	.menu li{float: left;}
	.menu a{line-height: 75px; color: black; padding: 0 15px; display:  block;}
	
</style>

</head>
<body>
<sec:authorize access="!isAuthenticated()">
<h1>
	<header>
		<div class="wrapper">
			<h1><a href="${pageContext.request.contextPath}/">Computer</a></h1>
			<nav>
				<ul class="menu">
					<li><a href="${pageContext.request.contextPath}/mouse">Mouse</a></li>
					<li><a href="${pageContext.request.contextPath}/keyboard">KeyBoard</a></li>
					<li><a href="${pageContext.request.contextPath}/head">Headphone</a></li>
					<li><a href="${pageContext.request.contextPath}/monitor">Monitor</a></li>
					<li><a href="#"></a></li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
					<li><a href="${pageContext.request.contextPath}/login">login</a></li>
						
					<li><a style="padding-right: 30px"href="${pageContext.request.contextPath}/join">join</a></li>
				</ul>			
			</nav>
		</div>
	</header>
</h1>
<br><br><br><br><br>
</sec:authorize>

<sec:authorize access="hasRole('ROLE_ADMIN')">
<h1>
	<header>
		<div class="wrapper">
			<h1><a href="${pageContext.request.contextPath}/">Computer</a></h1>
			<nav>
				<ul class="menu">
					<li><a href="${pageContext.request.contextPath}/mouse">Mouse</a></li>
					<li><a href="${pageContext.request.contextPath}/keyboard">KeyBoard</a></li>
					<li><a href="${pageContext.request.contextPath}/head">Headphone</a></li>
					<li><a href="${pageContext.request.contextPath}/monitor">Monitor</a></li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
					<li><a href="${pageContext.request.contextPath}/logoutForm">logout</a></li>
					<li><a style="padding-left: 0px;" href="${pageContext.request.contextPath}/admin/home"> 관리자 님</a></li>
						
					<li><a style="padding-right: 30px"href="${pageContext.request.contextPath}/join">join</a></li>
				</ul>			
			</nav>
		</div>
	</header>
</h1>
<br><br><br><br><br>
</sec:authorize>


<sec:authorize access="hasRole('ROLE_USER')">
<h1>
	<header>
		<div class="wrapper">
			<h1><a href="${pageContext.request.contextPath}/">Computer</a></h1>
			<nav>
				<ul class="menu">
					<li><a href="${pageContext.request.contextPath}/mouse">Mouse</a></li>
					<li><a href="${pageContext.request.contextPath}/keyboard">KeyBoard</a></li>
					<li><a href="${pageContext.request.contextPath}/head">Headphone</a></li>
					<li><a href="${pageContext.request.contextPath}/monitor">Monitor</a></li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
					<li><a href="${pageContext.request.contextPath}/logoutForm">logout</a></li>
					<li><a style="padding-left: 0px;" href="${pageContext.request.contextPath}/user/myPage">
					<sec:authentication property="principal.username" />님</a></li>
						
					<li><a style="padding-right: 30px"href="${pageContext.request.contextPath}/join">join</a></li>
				</ul>			
			</nav>
		</div>
	</header>
</h1>
<br><br><br><br><br>
</sec:authorize>

</body>
</html>



