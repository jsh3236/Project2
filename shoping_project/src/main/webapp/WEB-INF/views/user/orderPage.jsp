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

/*
// 전체선택 함수
var check = false;
function checkAll(){
	var chk = document.getElementsByName("checkBox");
	if(check == false){
		check = true;
		for(var i=0; i<chk.length;i++){                                                                    
		chk[i].checked = true;     //모두 체크
		}
	}else{
		check = false;
		for(var i=0; i<chk.length;i++){                                                                    
		chk[i].checked = false;     //모두 해제
		}
	}
}


//삭제 함수
function deleteBtn(orderNum) {
	 if (confirm("정말 삭제 하시겠습니까?")){  //물어보기
		 location.href='${pageContext.request.contextPath}/user/deleteAction.do/orderNum/'+orderNum+'/page/${pageInfo.page}';
		}else{ 
			return; 
		} 
	   
}; // deleteBtn 
	
function updateBtn(orderNum) {
	$(document).ready( function(){
		 if (confirm($("#"+orderNum).val()+"개로 수정 하시겠습니까?")){  // 물어보기
		 	location.href='${pageContext.request.contextPath}/user/update/ordercount/'+orderNum+'/'+$("#"+orderNum).val()+'/${pageInfo.page }';
		 } else {
			 location.reload();
			 return;
		 }
	});
};// updateBtn
	
	
// 선택상품 구매
function selectOrder() {
	var chk = document.getElementsByName("checkBox"); // 체크박스객체를 담는다
	var checkList = new Array(); //체크된 체크박스의 모든 value 값을 담는다


	for(var i=0; i<chk.length;  i++){
		if(chk[i].checked == true){  //체크가 되어있는 값 구분
			checkList.push(chk[i].value);
		}
	}

	location.href='${pageContext.request.contextPath}/user/orderPage/'+checkList+"/${orderArticleList[0].username}";
	
}


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

function paymentSubmit(){
	
	document.getElementById("paymentform").submit();
	
}
 */
</script>



<style type="text/css">

/* 등록된 글이 없을 경우, 페이징 처리 */
#emptyArea, #pageList {
	margin: auto;
	text-align: center;
}

/* reset */
* {
	margin: 0;
	padding: 0;
}

p {
	text-align: center;
}

li {
	list-style: none;
}

a {
	text-decoration: none;
}

a:active,
a:HOVER,
a:VISITED,
a:LINK
{
	color: black;
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


.pagination {
  display: inline-block;
  padding-left: 0;
  margin: 20px 0;
  border-radius: 4px;
}
.pagination > li {
  display: inline;
}
.pagination > li > a,
.pagination > li > span {
  position: relative;
  float: left;
  padding: 6px 12px;
  margin-left: -1px;
  line-height: 1.42857143;
  color: #337ab7;
  text-decoration: none;
  background-color: #fff;
  border: 1px solid #ddd;
}
.pagination > li:first-child > a,
.pagination > li:first-child > span {
  margin-left: 0;
  border-top-left-radius: 4px;
  border-bottom-left-radius: 4px;
}
.pagination > li:last-child > a,
.pagination > li:last-child > span {
  border-top-right-radius: 4px;
  border-bottom-right-radius: 4px;
}
.pagination > li > a:hover,
.pagination > li > span:hover,
.pagination > li > a:focus,
.pagination > li > span:focus {
  z-index: 2;
  color: #23527c;
  background-color: #eee;
  border-color: #ddd;
}
.pagination > .active > a,
.pagination > .active > span,
.pagination > .active > a:hover,
.pagination > .active > span:hover,
.pagination > .active > a:focus,
.pagination > .active > span:focus {
  z-index: 3;
  color: #fff;
  cursor: default;
  background-color: #337ab7;
  border-color: #337ab7;
}
.pagination > .disabled > span,
.pagination > .disabled > span:hover,
.pagination > .disabled > span:focus,
.pagination > .disabled > a,
.pagination > .disabled > a:hover,
.pagination > .disabled > a:focus {
  color: #777;
  cursor: not-allowed;
  background-color: #fff;
  border-color: #ddd;
}
.pagination-lg > li > a,
.pagination-lg > li > span {
  padding: 10px 16px;
  font-size: 18px;
  line-height: 1.3333333;
}
.pagination-lg > li:first-child > a,
.pagination-lg > li:first-child > span {
  border-top-left-radius: 6px;
  border-bottom-left-radius: 6px;
}
.pagination-lg > li:last-child > a,
.pagination-lg > li:last-child > span {
  border-top-right-radius: 6px;
  border-bottom-right-radius: 6px;
}
.pagination-sm > li > a,
.pagination-sm > li > span {
  padding: 5px 10px;
  font-size: 12px;
  line-height: 1.5;
}
.pagination-sm > li:first-child > a,
.pagination-sm > li:first-child > span {
  border-top-left-radius: 3px;
  border-bottom-left-radius: 3px;
}
.pagination-sm > li:last-child > a,
.pagination-sm > li:last-child > span {
  border-top-right-radius: 3px;
  border-bottom-right-radius: 3px;
}

.mytable { border-collapse:collapse; text-align: center; font-size: 12px;}  
.mytable td { border: none; }
.mytable th { border: none; border-bottom: 3px solid #369; border-top: 1px solid #369; }

.redfont {
	font-size: 21px;
	font-weight:800;
	color: red;
}

.whiteBtn {
  display: inline-block;
  border-radius: 4px;
  background-color: #f4511e;
  border: none;
  color: white;
  text-align: center;
  font-size: 15px;
  font-weight:800;
  padding: 20px;
  width: 180px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
}

.whiteBtn span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.whiteBtn span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.whiteBtn:hover span {
  padding-right: 25px;
}

.whiteBtn:hover span:after {
  opacity: 1;
  right: 0;
}

/* 테이블 모양  */
table.type03 {
	width: 700px;
	border-collapse: collapse;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	border-left: 3px solid #369;
	border-right: hidden;
	margin: 20px 10px;
	font-size: 12px;
}

table.type03 th {
	width: 147px;
	padding: 10px;
	font-weight: bold;
	vertical-align: middle;
	color: #153d73;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

table.type03 td {
	padding: 10px;
	vertical-align: middle;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

/* 에러 출력시.값이 있을 때 필드 외곽선(적색) 표시  */
input.ng-invalid.ng-not-empty {
	border: 2px solid red;
}



</style>

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
		<%-- 		<c:set var="setNum" value="${article.boardNum}" /> <br> --%>
					<tr style="border-bottom: 1px solid #369;">
								
						<%-- <c:if test="${boardNumMap.get(article.boardNum)}" /> --%>
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
				
			<form action="${pageContext.request.contextPath}/user/paymentAction.do"
				method="post" name="paymentform" id="paymentform">
			<input type="text" name="paymentName" value="11" />
			<table class="type03" align="center">
			
			<!------------------ 배송지 선택 ------------------->
				<tr>
					<th scope="row" align="center">배송지 선택</th>
					<td>
						<input type="radio" name="dst" value="1" onclick="display(this.value);" checked="checked" />${user.name} &nbsp;&nbsp;
						<input type="radio" name="dst" value="2" onclick="display(this.value);"  />직접 입력
					</td>
				</tr>
			<!------------------ 배송지 선택 끝 ------------------->
			
			<!-- 유저를 골랐을 경우 -->
			<table id="user" class="type03" style="border-bottom: 1px solid #ccc;">
				<tr style="border-bottom: hidden; border-right: hidden;">
					<th scope="row" align="center">이름</th>
					<td colspan="2">
						<p style="text-align: left" id="paymentName">${user.name}</p>
					</td>
				</tr>
				<tr style="border-bottom: hidden; border-right: hidden;">
					<th scope="row" align="center">주소</th>
					<td colspan="2">
						<p style="text-align: left" id="paymentAddress">${user.address}</p>
					</td>
				</tr>
				<tr style="border-right: hidden; border-bottom: hidden;">
					<th scope="row" align="center">연락처</th>
					<td colspan="2">
						<p style="text-align: left" id="paymentPhone">${user.phone}</p>
					</td>
				</tr>
			</table>
			
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
						<!-- <input type="hidden" id="paymentAddress" name="paymentAddress" value="$('#postcode'),$('#address'),$('#address2')" /> -->
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
						<input type="radio" name="mth" value="card"  checked="checked" />신용/체크카드 <br>
					</td>
				</tr>
				<tr style="height: 60px; text-align: left;" >
					<td style="padding-left: 150px;">
						<input type="radio" name="mth" value="mutong" /> 무통장입금
						<input style="margin-left: 30px;" type="radio" name="mth" value="iche" /> 실시간계좌이체
						<input style="margin-left: 30px;" type="radio" name="mth" value="cmaiche" /> CMA계좌이체
					</td>
				</tr>
				<tr style="border-bottom: 1px solid #369; height: 60px; text-align: left;">
					<td style="padding-left: 150px;">
						<input type="radio" name="mth" value="phone"  />휴대폰결제
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
						<!-- <button class="whiteBtn" type="button" onclick="paymentSubmit();"><span>결제하기</span></button> -->
						<input type="submit" value="전송" />
					</td>
				</tr>
			</table>
			
		</section>
	
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</body>
</html>
