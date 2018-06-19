<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Secured Admin Home</title>
</head>
<body>
	<jsp:include page="../include.jsp" flush="false" />
	<h3>Hello World!</h3>
	<h4>관리자 ${username},  ${message}</h4>
</body>
</html>