<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>마우스 게시글 보기</title>
<style>

#articleForm {
    width: 500px;
    height: 500px;
    margin: auto;
}
 
h2 {
    text-align: center;
}
 
#basicInfoArea {
    height: 40px;
    text-align: center;
}
 
#articleContentArea {
/* 	border: 1px solid black; */
	background: white;
    margin-top: 20px;
    height: 350px;
    text-align: center;
    overflow: auto;
}
 
#commandList {
	float:right;
    margin: auto;
    width: 500px;
    text-align: center;
}

.a2 {
	width : 110px;
	color: black; 
	display:  block;
	line-height: 50px; color: black; padding: 0 15px; display:  block;
	text-align: center;
 }
 
 table {
 	width: 500px;
    height: 500px;
    margin: auto;
    text-align: center;
    bordercolor: #EDEDED;
    border: 3px;
    border-collapse: collapse;
	text-align: left;
 }
 .tr_bg {
 	width: 400px;
 	background-color: #FAFAFA;
 }
 td {
 	text-align: left;
 	padding-left: 20px;
 	padding-right: 20px;
 	
 }
 div {
 	text-align: center;
 	
 	
 }
 
 .but {
 	 background-color: #B1B6BD; 
 	 color: white;
 	 font-weight: 700;
 	 width : 110px;
	display:  block;
	line-height: 50px; padding: 0 15px;  display:  block;
 }
 
</style>
</head>
 
<body>
<!-- 인클루드 -->
<div><jsp:include page="../include.jsp" flush="false" /></div>
    <!-- 게시글 보기-->
    <br>
    <table>
    	<tr>
    		<td rowspan="5">
                <img src="<c:url value='/image/${article.boardFile}' />"
							width=250 height=250 style="padding: 30px" />
    		</td>
    	</tr>
    	<tr class="tr_bg" >
    		<td colspan="2" style="text-align: center; font-weight: 700; font-size: 16pt">
            	${article.boardSubject} 
            	<p style="text-align: right; font-weight: 400; font-size: 12pt">조회수 : ${article.boardReadCount}<p>
			</td>
		</tr>
		<tr class="tr_bg">
			<td colspan="2">
				판매가 : ${article.boardPrice} 원
			</td>
		</tr>          
		<tr class="tr_bg">
			<td colspan="2"> 옵션 : </td>
		</tr>
		<tr class="tr_bg">
			<td>
				<a class="but" href="${pageContext.request.contextPath}/board/mouse/${nowPage}"> 구매하기 </a> 
			</td>
			<td>
				<a class="but" href="${pageContext.request.contextPath}/board/mouse/${nowPage}"> 장바구니 </a>
			</td>
		</tr>
    </table>
    <div style="margin-top: 200px">
            ${article.boardContent}
    </div>
    <div>
           <img  src="<c:url value='/image/${article.boardFileContent}' />"
							 style="padding: 30px" /> 
	</div>
    <div>
        <a class="a2" href="boardDeleteForm.bo?board_num=${article.boardNum}&page=${nowPage}">삭제 </a> 
        <a class="a2" href="${pageContext.request.contextPath}/board/mouse/${nowPage}"> 목록</a>
    </div>
</body>
</html>