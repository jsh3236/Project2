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
 
 .btn {
  display: inline-block;
  padding: 6px 12px;
  margin-bottom: 0;
  font-size: 14px;
  font-weight: normal;
  line-height: 1.42857143;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
}

.btn-info {
  color: #fff;
  background-color: #5bc0de;
  border-color: #46b8da;
}
.btn-info:focus,
.btn-info.focus {
  color: #fff;
  background-color: #31b0d5;
  border-color: #1b6d85;
}
.btn-info:hover {
  color: #fff;
  background-color: #31b0d5;
  border-color: #269abc;
}
.btn-info:active,
.btn-info.active,
.open > .dropdown-toggle.btn-info {
  color: #fff;
  background-color: #31b0d5;
  border-color: #269abc;
}
.btn-info:active:hover,
.btn-info.active:hover,
.open > .dropdown-toggle.btn-info:hover,
.btn-info:active:focus,
.btn-info.active:focus,
.open > .dropdown-toggle.btn-info:focus,
.btn-info:active.focus,
.btn-info.active.focus,
.open > .dropdown-toggle.btn-info.focus {
  color: #fff;
  background-color: #269abc;
  border-color: #1b6d85;
}
.btn-info:active,
.btn-info.active,
.open > .dropdown-toggle.btn-info {
  background-image: none;
}
.btn-info.disabled:hover,
.btn-info[disabled]:hover,
fieldset[disabled] .btn-info:hover,
.btn-info.disabled:focus,
.btn-info[disabled]:focus,
fieldset[disabled] .btn-info:focus,
.btn-info.disabled.focus,
.btn-info[disabled].focus,
fieldset[disabled] .btn-info.focus {
  background-color: #5bc0de;
  border-color: #46b8da;
}
.btn-info .badge {
  color: #5bc0de;
  background-color: #fff;
}

.btn-lg,
.btn-group-lg > .btn {
  padding: 10px 16px;
  font-size: 18px;
  line-height: 1.3333333;
  border-radius: 6px;
}

.btn-lg .caret {
  border-width: 5px 5px 0;
  border-bottom-width: 0;
}

 
</style>
</head>
 
<body>
<!-- 인클루드 -->
<div><jsp:include page="../include.jsp" flush="false" /></div>
    <!-- 게시글 보기-->
    <sec:authorize access="hasRole('ROLE_ADMIN')">
    	<div style="padding-left: 30px; text-align: left;">
			<button type="button" class="btn btn-info btn-lg"
				onclick="location.href='${pageContext.request.contextPath}/admin/mouseBoardwrite'"
				style="margin-left: 50px">수정</button>
			<button type="button" class="btn btn-info btn-lg"
				onclick="location.href='${pageContext.request.contextPath}/admin/deleteAction.do/boardNum/${article.boardNum}/page/1'">삭제
			</button>
		</div>
	</sec:authorize>
						
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