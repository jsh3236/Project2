<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
 <h1>Test!</h1>
 
 <h1>테스트</h1>
 <br>
 <jsp:include page="${viewPage}" flush="false" />

<img src="<c:url value='/image/${viewPage}' />" width=300 height=300 />
viewPage : ${viewPage}

</body>
</html>