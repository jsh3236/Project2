<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Detail Information</title>
</head>
<body>
	이름: ${payment.paymentName} <br>
	배송주소 : ${payment.paymentAddress}<br>
	결제방법: ${payment.paymentMethod}<br>
	핸드폰번호: ${payment.paymentPhone}<br>
	결제금액: ${payment.paymentAmount}
	진행상태: ${payment.paymentProgress}
</body>
</html>