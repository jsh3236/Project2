<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Detail Information</title>
</head>
<body>
	<table>
		<tr>
			<td style="text-align: right; padding-right: 10px">결제번호:
			</td>
			<td> ${payment.paymentNum} 
			</td>
		</tr>
		<tr>
			<td style="text-align: right; padding-right: 10px">이름:
			</td>
			<td> ${payment.paymentName} 
			</td>
		</tr>
		<tr>
			<td style="text-align: right; padding-right: 10px">배송주소 :
			</td>
			<td> ${payment.paymentAddress}
			</td>
		</tr>
		<tr>
			<td style="text-align: right; padding-right: 10px">결제방법:
			</td>
			<td> ${payment.paymentMethod}
			</td>
		</tr>
		<tr>
			<td style="text-align: right; padding-right: 10px">핸드폰번호: 
			</td>
			<td>${payment.paymentPhone}
			</td>
		</tr>
		<tr>
			<td style="text-align: right; padding-right: 10px">결제금액: 
			</td>
			<td>${payment.paymentAmount}
			</td>
		</tr>
		
		
		
		
		
	</table>
</body>
</html>