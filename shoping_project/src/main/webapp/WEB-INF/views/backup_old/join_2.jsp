<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>회원가입 폼</title>
<style>

/* 테이블 모양  */
table.type03 {
	border-collapse: collapse;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	border-left: 3px solid #369;
	border-right: hidden;
	margin: 20px 10px;
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
	width: 300px;
	padding: 10px;
	vertical-align: middle;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

/* 에러 출력시.값이 있을 때 필드 외곽선(적색) 표시  */
input.ng-invalid { /*, input.ng-not-empty */
	border: 2px solid red;
}

/* 전체 font 컬러 지정 */
font {
	color: #8BBDFF;
}
</style>


<!-- jQuery UI CSS : 캘린더(datePicker) -->
<link rel="stylesheet"
	href="<c:url value='/jQuery/ui/1.12.1/jquery-ui.min.css' />">

<!-- 주소검색 : daum -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<!-- jQuery -->
<script src="<c:url value='/jQuery/3.3.1/jquery-3.3.1.min.js' />"></script>

<!-- jQuery UI -->
<script src="<c:url value='/jQuery/ui/1.12.1/jquery-ui.min.js' />"></script>

<!-- jQuery UI : 캘린더(datePicker) 설정(한글 지원) -->
<script src="<c:url value='/custom/datepicker.ko.js' />"></script>

<!-- 폼 점검(form validation) -->
<%-- <script src="<c:url value='/custom/memberJoinAngularValidator.js' />"></script> --%>

<!-- AngularJS lib -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.10/angular.min.js"></script> -->
<script src="<c:url value='/angularjs/1.6.10/angular.min.js' />"></script>


<!-- AngularJS -->
<script>
	var app = angular.module('joinBody', []);

	app.controller('joinAngularController', [ '$scope', function($scope) {

		// TODO
		// 아이디 중복 점검
		/* $scope.idBtnHandler = function() {
		    
			// 아이디 필드 점검 
		    if ($scope.memberJoin.id_fld.$valid == true) {
		     //  sendId(); // 비동기적 폼 점검 
		    }   
		};  */

	} ]);

	
/* 	$(function() {
		
		// jQuery : 아이디 폼 점검과 중복 점검 메시지 충돌 방지을 위한 초기화
		$("#id").focus(function() {
			$("#id_msg2").text(""); // 메시지 초기화
		}); //
		
		// email을 선택할 경우의 함수 
		$("#email2").change(function() {
			if($("#email2").val()=="0"){
				$("#email3").show();	
			}
			else {
				document.getElementById("email3").value = '';
				$("#email3").hide();
			}
		});
		
		// 주소 경고  메세지 설정
		$("#address2").change(function() {
			$("#address_msg").hide();
		});
		
		
		
	});
	 */
	
	// 도로명 주소 검색
/* 	    function getPostcodeAddress() {
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
// 	               var output = '';
// 	                for (var key in data) {
// 	                    output += key + ":" +  data[key]+"\n";
// 	                }
	               
// 	                alert(output); 
	 
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
 */
</script>

</head>

<body ng-app="joinBody" ng-controller="joinAngularController">

	<form id="join" 
		  name="join" 
		  action="joinAction" 
		  method="get"
		  onsubmit="alert('1')">
		  
		<table class="type03" align="center">
		
		<!------------------ 이름 ------------------->
			<tr>
				<th scope="row" align="center">이름</th>
				<td>
					<input type="text" 
						   id="name" 
						   name="name"
						   size=15 
						   maxlength="10" 
						   style="height: 20px" 
						   ng-model="name"
					       ng-pattern="/^[가-힣]{2,4}$/" 
						   ng-required="true" />
				</td>
				
				<td style="border-left: hidden">	
					<div id="name_msg" 
						ng-model="name_msg"
						ng-show="join.name.$error.pattern">
						<font size="2">
							한글로 4글자 이내로 입력해 주세요. 
						</font>
					</div>
				</td>
			</tr>
			
			<!------------------ 이름 끝 ------------------->

			<!------------------ 아이디 ------------------->
			<tr>
				<th scope="row" align="center">아이디</th>
				<td>
					<input type="text" 
						   id="username" 
						   name="username" 
						   size=15 
						   maxlength="20"
						   style="height: 20px" 
						   ng-model="username"
						   ng-pattern="/^[a-zA-Z]{1}\w{5,19}$/" 
						   ng-required="true"> &nbsp;

					<input type="button" value="중복 확인"><br> 
					<font size="2">
						[아이디 중복 확인 결과 표기]
					</font>
				</td>

				<td style="border-left: hidden">
					<div id="username_msg" 
						ng-model="username_msg"
						ng-show="join.username.$error.pattern">
						<font size="2"> 
							영문 숫자를 조합하여 6~20자 이내로 입력 <br> 
							(대소문자 구별. 한글/특수문자 사용 불가)
						</font>
					</div>
				</td>
			</tr>
			
			<!------------------ 아이디 끝 ------------------->

			<!------------------ 비밀번호 ------------------->
			<tr>
				<th scope="row" align="center">비밀번호</th>
				<td>
					<input type="password" id="pw" name="pw" size=15 maxlength="20"
					style="height: 20px" value="비밀번호 입력" placeholder="비밀번호"
					ng-model="pw"
					ng-pattern="/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,20}$/"
					ng-required="true">	&nbsp; 
					
					<input type="password" id="rpw"
					name="rpw" size=15 maxlength="20" style="height: 20px"
					value="비밀번호 확인" placeholder="비밀번호 확인"
					ng-model="rpw"
					ng-pattern="/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,20}$/"
					ng-required="true">
				</td>

				<td valign="top" style="border-left: hidden">
					<div id="pw_msg" ng-model="pw_msg" ng-show="join.pw.$error.pattern||join.rpw.$error.pattern">
						<font size="2"> 
							영문, 숫자, 특수문자를 조합하여<br> 
							(8~20자 이내로 입력)
						</font>
					</div>
				</td>
			</tr>
			
			<!------------------ 비밀번호 끝 ------------------->

			<!------------------ 성별 ------------------->
			<tr>
				<th scope="row" align="center">성별</th>
				<td colspan="2">남 <input type="radio" id="gender" name="gender"
					value="m"> 여 <input type="radio" id="gender" name="gender"
					value="f">
				</td>
			</tr>
			
			<!------------------ 성별 끝 ------------------->

			<!------------------ 전화번호 ------------------->
			<tr>
				<th scope="row" align="center">전화번호</th>
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
                 	       
				</td>
				
				<td valign="top" style="border-left: hidden">
					<div id="phone_msg" ng-model="phone_msg" ng-show="join.phone.$error.pattern||join.phone2.$error.pattern||join.phone3.$error.pattern">
						<font size="2"> 
							핸드폰 번호를 제대로 입력하세요.
						</font>
					</div>
				</td>
				
			</tr>
			
			<!------------------ 전화번호 끝 ------------------->
			
			<!------------------ 우편 번호 ------------------->
			<tr>
				<th scope="row" align="center">우편번호</th>
				
				<td colspan="2">
					<input type="text"
						   id="postcode"
						   name="postcode"
						   size=20
						   style="height: 20px" 
						   readonly />
				</td>
				
			</tr>
			<!------------------ 우편번호 끝 ------------------->

			<!------------------ 주소 ------------------->
			<tr>
				<th scope="row" align="center">주소</th>
				<td colspan="2">
					<input type="text"
						   id="address"
						   name="address"
						   size=50 
						   maxlength="300" 
						   style="height: 20px"
						   ng-required = "true" 
						   readonly /> &nbsp;
						  	
						  	<!-- readonly -->
					
					<input type="button" 
						   value="주소 찾기" 
						   onClick="getPostcodeAddress()" /> <br> 
					
					<input type="text"
						   id="address2"
						   name="address2"
						   size=50 
						   maxlength="300"
						   style="height: 20px; margin-top: 5px;"
						   ng-required = "true" /> &nbsp;
				
							<font id="address_msg" size="2" style="display: none"> 
								상세 주소를 입력해주세요.
							</font>

				</td>
			</tr>
			<!------------------ 주소 끝 ------------------->
			
			<!------------------ 이메일 ------------------->
			<tr>
				<th scope="row" align="center">이메일</th>
				<td colspan="2">
					<input type="text" 
						   id="email" 
						   name="email"
						   size=15 
						   maxlength="20" 
						   style="height: 20px"
						   ng-required = "true" /> 
						   
					<font size=2 style="color: black;"> @ </font>
					
					<select name="email2"
							id="email2"
							style="height: 25px">
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="google.com">google.com</option>
						<option value="empal.com">empal.com</option>
                    	<option value="nate.com">nate.com</option>
                    	<option value="paran.com">paran.com</option>
						<option value="0">사용자 직접 입력</option>
					</select>
					
					<input type="text"  
						   id="email3" 
						   name="email3" 
						   size=15 
						   maxlength="20"
					       style="height: 20px; display:none;"
					       ng-model="email3"
              			   ng-required = "true"
                 	       ng-pattern="/^[A-Za-z0-9]+[.]+[a-zA-Z]+$/" /> 
                 	
                	<br>
                	<div id="email_msg" 
                		 style="padding-left: 290px"
                		 ng-model="email_msg" 
                		 ng-show="join.email3.$error.pattern">
						<font size="2"> 
							이메일 형식을 제대로 입력하세요.
						</font>
					</div>
					
				</td>
				
				<!------------------ 이메일 끝 ------------------->
				
				
				
				
			</tr>
		</table>

		<!------------------ 버튼 ------------------->
		<br><br>
		<input type="submit" 
					value="회원가입" 
					style="margin-left: 350px" onclick="alert('2')"/> &nbsp;&nbsp; 
			
		<input type="button" 
				   value="취소"
				   onclick="history.back()" />
					  <!-- "history.go(-1)" -->
	</form>
</body>
</html>
