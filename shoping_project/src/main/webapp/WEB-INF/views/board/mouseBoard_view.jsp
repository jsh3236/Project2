<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>마우스 게시글 보기</title>

<!-- jQuery : 3.2.1 -->
<script src="http://code.jquery.com/jquery-Latest.min.js"></script>

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
 
 .tt {
 	width: 500px;
    height: 500px;
    margin: auto;
    text-align: center;
    border: 1px solid #EDEDED;
    border-collapse: collapse;
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

<script>
/*  List 옵션 가져와서 사용하는 함수  */
function getOption(opt, size) {
    /*
       List<String> : ${images} 파일 출력 형태 : [국화.jpg, 등대.jpg, 펭귄.jpg]
    */

    var temp = opt.replace("[", "")
                  .replace("]", "")
                  .trim();  //"[", "]", 공백 제거 (필수!)
    var optionList = temp.split(",", size);  //"," 구분자(delim) 중심으로 tokenizing  
    
    for (var i=0; i<size; i++) {    
    	var op = new Option();

   	    op.value = optionList[i].trim(); // 값 설정
	    op.text = optionList[i].trim(); // 텍스트 설정
   	    if(i==0) document.orderlistform.orderOption.options[0]=(op);
	    else document.orderlistform.orderOption.options.add(op); 
  	 } // for

 }
 
//$('#inputLength').val(arrInput.length);

 
 function orderlist() {
	 $(document).ready( function() {
		 var yes = 1;
		 var no = 0;
 		 if($("#orderOption option").index($("#orderOption option:selected"))!='0') {

			 if (confirm("현재 상품을 장바구니에 담았습니다. 장바구니로 이동 하시겠습니까?")){ 
				 $('#flag').val(yes);
				 document.getElementById('orderlistform').submit();
				// location.href = "${pageContext.request.contextPath}/user/orderList";
				}else{ 
					$('#flag').val(no);
					document.getElementById('orderlistform').submit();
					return; 
				} 
		 } else {
			 alert('옵션을 선택해 주세요.');
		 }
	 });
		 
 }
 
 function directOrder() {
	 
	 $(document).ready( function() {
		 
 		 if($("#orderOption option").index($("#orderOption option:selected"))!='0') {
				
 				$("#orderlistform").attr("action", "${pageContext.request.contextPath}/user/directOrderPage.do");
				 document.getElementById('orderlistform').submit();
				 
		 } else {
			 
			 alert('옵션을 선택해 주세요.');
			 
		 }
	 });
 }


</script>

</head>
 
<body>
<!-- 인클루드 -->
<div><jsp:include page="../include.jsp" flush="false" /></div>
<sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
</sec:authorize>
    <!-- 게시글 보기-->
   <sec:authorize access="hasRole('ROLE_ADMIN')">
    	<div style="padding-left: 30px; text-align: left;">
			<button type="button" class="btn btn-info btn-lg"
				onclick="location.href='${pageContext.request.contextPath}/admin/update/boardNum/${article.boardNum}'"
				style="margin-left: 50px">수정</button>
			<button type="button" class="btn btn-info btn-lg"
				onclick="location.href='${pageContext.request.contextPath}/admin/deleteAction.do/boardNum/${article.boardNum}/page/1'">삭제
			</button>
		</div>
	</sec:authorize>
						
    <br>
    
    <!-- 주문  form -->
    <form:form modelAttribute="orderlist" id="orderlistform"
			action="${pageContext.request.contextPath}/user/orderListAction.do"
			method="post" name="orderlistform">
			<!-- 게시판번호 유저이름 -->
			<sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
				<input type="hidden" id="username" name="username" value='<sec:authentication property="principal.username" />'/>
			</sec:authorize>
			<input type="hidden" id="boardNum" name="boardNum" value="${article.boardNum}"/>
			<input type="hidden" id="nowPage" name="nowPage" value="${nowPage}"/>
			<input type="hidden" id="boardPrice" name="boardPrice" value="${article.boardPrice}"/>
			<input type="hidden" id="boardSubject" name="boardSubject" value="${article.boardSubject}"/>
			<input type="hidden" id="boardFile" name="boardFile" value="${article.boardFile}"/>
			<input type="hidden" id="flag" name="flag" value="0"/>
			
			<!-- 게시판 디테일 정보 테이블 -->
	    <table class="tt">
	    
	    	<!-- 제품 이미지 (왼쪽 칸)-->
	    	<tr style="height: 0px">
	    		<td rowspan="6" style="border-right: 1px solid #EDEDED;">
	                <img src="<c:url value='/image/${article.boardFile}' />"
								width=250 height=250 style="padding: 30px" />
	    		</td>
	    	</tr>
	    	<!-- 제품 이미지 (왼쪽 칸) 끝-->
	    	
	    <!-- ######## 제품 정보 (오른쪽 칸) ######## -->
	    
			<!-- 제품 이름(and 조회수) -->	    	
	    	<tr class="tr_bg" style="border-top: 1px solid #EDEDED;">
	    		<td colspan="2" style="text-align: center; font-weight: 700; font-size: 16pt">
	            	${article.boardSubject} 
	            	<p style="text-align: right; font-weight: 400; font-size: 12pt">조회수 : ${article.boardReadCount}<p>
				</td>
			</tr>
			<!-- 제품 이름(and 조회수) 끝-->	  
			
			<!-- 제품 판매가 -->
			<tr class="tr_bg">
				<td colspan="2">
					판매가 : <fmt:formatNumber type="number" value="${article.boardPrice}" /> 원
				</td>
			</tr>          
			<!-- 제품 판매가 끝-->
			
			<!-- 제품 옵션 -->
			<tr class="tr_bg">
				<td colspan="1"> 옵션 : </td>
				<td>
						<select id="orderOption" name="orderOption" style="height: 25px; width: 150px">
	         					  <option value="optionVal">textVal</option>
						</select>
					
				</td>
			</tr>
			<!-- 제품 옵션 끝 -->
			
			<!-- 제품 주문수량 -->
			<tr class="tr_bg">
				<td colspan="1"> 주문수량 : </td>
				<td>
						<input type="number" value=1 id="orderCount" name="orderCount" min=1 style="height: 25px; width: 50px; text-align: center;"/>
				</td>
			</tr>
			<!-- 제품 주문수량 끝-->
			
			<!-- 구매하기 장바구니 버튼 -->			
			<tr class="tr_bg">
				<td>
					<a class="but" href="#" onclick="directOrder();"> 구매하기 </a> 
				</td>
				<td>
					<a class="but" href="#" onclick="orderlist();" > 장바구니 </a>
				</td>
			</tr>
			<!-- 구매하기 장바구니 버튼 끝 -->	
			
		<!--######## 제품 정보 (오른쪽 칸) 끝 ########-->
			
	    </table>
	    <!-- 게시판 디테일 정보 테이블 끝-->
	    
    </form:form>
    <!-- 주문 form 끝 -->
    
    <!-- 제품 상세정보 -->
    <div style="margin-top: 200px">
            ${article.boardContent}
    </div>
    <div>
           <img  src="<c:url value='/image/${article.boardFileContent}' />"
							 style="padding: 30px" /> 
	</div>
	 <!-- 제품 상세정보 끝 -->
	 
    
    <!-- 옵션 추가 스크립트 -->
    <script>
            getOption("${optionList}", "${optionList.size()}");
    </script>
    <!-- 옵션 추가 스크립트 끝 -->
</body>
</html>