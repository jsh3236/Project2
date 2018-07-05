<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko-kr">
<head>
<title>Home</title>

<!-- 주소검색 : daum -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<!-- AngularJS lib -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.10/angular.min.js"></script> -->
<script src="<c:url value='/js/angularjs/1.6.10/angular.min.js' />"></script>

<!-- jQuery : 3.2.1 -->
<script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>

<!-- bootstrap JS : 3.3.7 -->
<script src="<c:url value='/js/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>

<!-- myCss -->
<link rel="stylesheet" href="<c:url value='/js/custom/myCss.css' />">

<script>

 //배송지 선택 함수
function display(num){
	if(num=='1') {
		user.style.display = 'block';
		direct.style.display = 'none';
	} else {
		user.style.display = 'none';
		direct.style.display = 'block';
	}
}



var app = angular.module('orderBody', []);
app.controller('orderAngularController', [ '$scope', function($scope) {


} ]);


	


//도로명 주소 검색
 function getPostcodeAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }
            
            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }
           
           // 주소 정보 전체 필드 및 내용 확인 : javateacher
//            var output = '';
//             for (var key in data) {
//                 output += key + ":" +  data[key]+"\n";
//             }
           
//             alert(output); 

            // 3단계 : 해당 필드들에 정보 입력
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('address').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('address2').focus();
            $("#address_msg").show();
        }
    }).open();
}

 // submit
function paymentSubmit(){
	$(document).ready( function(){
		var user = 1;
		var direct = 2;
		var cv = $("input[type=radio][name=mth]:checked").val();
		var orderList = new Array();
		var boardList = new Array();
		
		 <c:forEach var="article" items="${orderArticleList}">
			 orderList.push(${article.orderNum});
			 boardList.push(${article.boardNum});
		 </c:forEach>
		 
		$("input[type=hidden][name=boardNum]").val(boardList);
		$("input[type=hidden][name=boardNum2]").val(boardList);
		$("input[type=hidden][name=order]").val(orderList);
		$("input[type=hidden][name=order2]").val(orderList);
		$("input[type=hidden][name=paymentMethod]").val(cv);
		$("input[type=hidden][name=paymentMethod2]").val(cv);
		
		if($("input[type=radio][name=dst]:checked").val()==user) {
			$("input[type=hidden][name=flag]").val(user);
			document.getElementById("paymentform").submit();
		} else {
			$("input[type=hidden][name=flag2]").val(direct);
			document.getElementById("paymentform2").submit();
		}
	
	});
}

 
 function test() {
	 alert('1');
	 var articleList = new Array();
	 
	 <c:forEach var="article" items="${orderArticleList}">
	 	articleList.push(${article.orderNum});
	 </c:forEach>
	 
	 alert(articleList);
	 
/* 	 for(var i =0; i<'${fn:length(orderArticleList)}'; i++) {
			alert('${orderArticleList[i]}');
	 	} */
 }
 
</script>


</head>
<body ng-app="orderBody" ng-controller="orderAngularController" onload="display(1)">
	<c:set var="total" value="0" />
	<c:set var="totalstotal" value="0" />
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<br>
	

	
		<section id="listForm" style="width: 700px; margin: auto;">
			<h2>1. 주문상품 확인</h2><br>
			<table id="payment_tbl" class="mytable">
				<tr style="height: 35px; text-align: center; ">
					<th style="width: 200px;">
					 	이미지	
					</th>
					<th style="width: 300px;">
					 	상품명
					</th>
					<th  style="width: 100px;">
						옵션
					</th>
					<th style="width: 100px;">
						수량
					</th>
					<th style="width: 150px;">
						가격
					</th>
					<th style="width: 150px;">
						합계
					</th>
				</tr>
				<c:forEach items="${boardNumMap}" var="map" varStatus="mapSt">
				
					<tr style="border-bottom: 1px solid #369;">
								
						<td style="width: 200px;">
							<c:set var="setNum" value="${(setNum + map.value)}" />
							<a href="../boardDetail.do/boardNum/${map.key}/page/${pageInfo.page}">
													<img src="<c:url value='/image/${orderArticleList[fn:length(orderArticleList)-setNum].boardFile}' />" 
													width=50 height=50 style="padding: 30px" /> 
							</a>
						</td>
						<td colspan="4">
							<table>
								<c:forEach var="article" items="${orderArticleList}" varStatus="st">
									<c:if test="${article.boardNum eq map.key}">
									 	<c:set var="boardTotal" value="${(article.boardPrice*article.orderCount)}" />
										<c:set var="total" value="${total+boardTotal}" /> 
										<tr align="center">
											<td style="width: 310px;">	
												${article.boardSubject}
											</td>
											<td style="width: 90px;">
												${article.orderOption}
											</td>
											<td style="width: 90px;">	
												${article.orderCount}개
											</td>
											<td style="width: 150px;" >
												<fmt:formatNumber type="number" value="${article.boardPrice}"/> 원 &nbsp;
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</table>
						</td>
						<td style="width: 150px;">
							<fmt:formatNumber type="number" value="${total}" /> 원 
							<c:set var="totalstotal" value="${totalstotal+total}" />
							<c:set var="total" value="0" />
						</td>
		
					</tr>
				</c:forEach>
				
				<tr align="center" style="border-bottom: 1px solid #369; height: 50px;">
					<td colspan="5" style="text-align: right; padding-right: 20px; font-size: 15px;">
						최종결제금액
					</td>
					<td style="text-align: center;">
						<strong class="redfont"><fmt:formatNumber type="number" value="${totalstotal}"/></strong> 원 
					</td>
				</tr>
				
			</table>
			
			
			
			<br><br>
			<h2>2. 배송지 정보 입력</h2>
<%-- 			<form:form modelAttribute="payment"
				action="${pageContext.request.contextPath}/admin/paymentAction.do"
				method="post" name="paymentform" id="paymentform"> --%>

			<table class="type03" align="center">
			
			<!------------------ 배송지 선택 ------------------->
				<tr>
					<th scope="row" align="center">배송지 선택</th>
					<td>
						<input type="radio" id="dst" name="dst" value="1" onclick="display(this.value);" checked="checked" />${user.name} &nbsp;&nbsp;
						<input type="radio" id="dst" name="dst" value="2" onclick="display(this.value);"  />직접 입력
					</td>
				</tr>
			<!------------------ 배송지 선택 끝 ------------------->
		<form action="${pageContext.request.contextPath}/user/paymentAction.do"
			method="post" name="paymentform" id="paymentform">
			
			<input type="hidden" name="boardNum" value="" />
			<input type="hidden" name="order" value="" />
			<input type="hidden" name="username" value="${orderArticleList[0].username}" />
			<input type="hidden" name="paymentAmount" value="${totalstotal}" />
			<input type="hidden" name="paymentMethod" value="0" />
			<input type="hidden" name="flag" value="0" />
			
		<!-- 유저를 골랐을 경우 -->
			<table id="user" class="type03" style="border-bottom: 1px solid #ccc;">
				<tr style="border-bottom: hidden; border-right: hidden;">
					<th scope="row" align="center">이름</th>
					<td colspan="2">
						<input type="hidden" name="paymentName" value="${user.name}" />
						${user.name}
					</td>
				</tr>
				<tr style="border-bottom: hidden; border-right: hidden;">
					<th scope="row" align="center">주소</th>
					<td colspan="2">
						<input type="hidden" name="paymentAddress" value="${user.address}" />
						${user.address}
					</td>
				</tr>
				<tr style="border-right: hidden; border-bottom: hidden;">
					<th scope="row" align="center">연락처</th>
					<td colspan="2">
						<input type="hidden" name="paymentPhone" value="${user.phone}" />
						${user.phone}
					</td>
				</tr>
			</table>
		</form>
			
		<form action="${pageContext.request.contextPath}/user/paymentAction.do"
			method="post" name="paymentform2" id="paymentform2">
			
			<input type="hidden" name="boardNum2" value="" />
			<input type="hidden" name="order2" value="" />
			<input type="hidden" name="username" value="${orderArticleList[0].username}" />
			<input type="hidden" name="paymentAmount" value="${totalstotal}" />
			<input type="hidden" name="paymentMethod2" value="1" /> 
			<input type="hidden" name="flag2" value="0" />
			<!-- 직접 입력을 눌렀을 경우 -->
			<table id="direct" class="type03" align="center">
				<tr style="border-right: hidden; border-bottom: hidden">
					<th scope="row" align="center">이름</th>
					<td>
						<input type="text" 
							   id="paymentName" 
							   name="paymentName"
							   size=15 
							   maxlength="10" 
							   style="height: 20px" 
							   ng-model="name"
						       ng-pattern="/^[가-힣]{2,4}$/" 
							   ng-required="true" />
					</td>
					<div id="username_msg" 
							ng-model="username_msg"
							ng-show="order.paymentName.$error.pattern">
							<font size="2"> 
								영문 숫자를 조합하여 6~20자 이내로 입력 <br> 
								(대소문자 구별. 한글/특수문자 사용 불가)
							</font>
					</div>
				</tr>
				<tr style="border-bottom: hidden; border-right: hidden;">
					<th scope="row" align="center">주소</th>
					<td>
						<input type="text"
							   id="postcode"
							   name="postcode"
							   size=20
							   style="height: 20px" 
							   readonly /><br>
						<input type="text"
							   id="address"
							   name="address"
							   size=50 
							   maxlength="300" 
							   style="height: 20px"
							   ng-required = "true" 
							   readonly />
							   
						<input type="button" 
							   value="주소 찾기" 
							   onClick="getPostcodeAddress()" />
						<input type="text"
							   id="address2"
							   name="address2"
							   size=50 
							   maxlength="300"
							   style="height: 20px; margin-top: 5px;"
							   ng-required = "true" /> &nbsp;
					
						<div id="phone_msg" ng-model="phone_msg" ng-show="order.address2.$error.pattern">
								<font id="address_msg" size="2" style="display: none"> 
									상세 주소를 입력해주세요.
								</font>
						</div>
					</td>
				</tr>
				<tr style="border-top: hidden; border-right: hidden;">
				<!-- <input type="hidden" id="paymentPhone" name="paymentPhone" value="$('#phone')-$('#phone2')-$('#phone3')" /> -->
					<th scope="row" align="center">연락처</th>
					<td>
					
						<input type="text" 
							   id="phone" 
							   name="phone"
							   size=3 
							   maxlength="3" 
							   style="height: 20px"
							   ng-model="phone"
	                    	   ng-required = "true"
	                     	   ng-pattern="/^\d{3}$/"> - 
						
						<input type="text" 
							   id="phone2" 
							   name="phone2" 
							   size=4 
							   maxlength="4"
							   style="height: 20px"
							   ng-model="phone2"
	              			   ng-required = "true"
	                 	       ng-pattern="/^\d{3,4}$/"> - 
						
						<input type="text" 
							   id="phone3"
							   name="phone3"
							   size=4 
							   maxlength="4" 
							   style="height: 20px;"
							   ng-model="phone3"
	              			   ng-required = "true"
	                 	       ng-pattern="/^\d{4}$/">
	                 	      
						<div id="phone_msg" ng-model="phone_msg" ng-show="order.phone.$error.pattern||order.phone2.$error.pattern||order.phone3.$error.pattern">
							<font size="2"> 
								핸드폰 번호를 제대로 입력하세요.
							</font>
						</div>
					</td>
				</tr>
				</table>
				<!-- 직접 입력을 눌렀을 경우 끝-->
				</form>
			</table>
			
			
			<br><br>
			<h2>3. 결제 정보 입력</h2><br>
			
			<table id="board_tbl" class="mytable" style="width: 700px">
			<!------------------ 결제 방법 선택 ------------------->
				<tr style="height: 35px; text-align: left; width: 700px;">
					<th scope="row" align="center">결제방법 선택</th>
				</tr>
				<tr style="height: 60px; text-align: left;" >
					<td style="padding-left: 150px;">
						<input type="radio" name="mth" value="신용/체크카드"  checked="checked" />신용/체크카드 <br>
					</td>
				</tr>
				<tr style="height: 60px; text-align: left;" >
					<td style="padding-left: 150px;">
						<input type="radio" name="mth" value="무통장입금" /> 무통장입금
						<input style="margin-left: 30px;" type="radio" name="mth" value="실시간계좌이체" /> 실시간계좌이체
						<input style="margin-left: 30px;" type="radio" name="mth" value="CMA계좌이체" /> CMA계좌이체
					</td>
				</tr>
				<tr style="border-bottom: 1px solid #369; height: 60px; text-align: left;">
					<td style="padding-left: 150px;">
						<input type="radio" name="mth" value="휴대폰결제"  />휴대폰결제
					</td>
				</tr>
			</table>
			
			<br><br>
			<h2>4. 결제 하기</h2><br>		
			<table class="mytable" style="width: 700px">
				<tr style="border-top: 1px solid #369; border-bottom: 1px solid #369; height: 300px">
					<td>
						<strong id="paymentAmount" class="redfont" style="font-weight: 1300; font-size: 34px"><fmt:formatNumber type="number" value="${totalstotal}"/></strong> 원
					</td>
					<td style="padding-left: 100px">
						<button class="whiteBtn" type="button" onclick="paymentSubmit();"><span>결제하기</span></button>
					</td>
				</tr>
			</table>
			
			
			
		</section>
		
		
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</body>
</html>
