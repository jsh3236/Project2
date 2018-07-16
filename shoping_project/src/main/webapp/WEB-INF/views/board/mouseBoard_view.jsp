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

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Colo Shop Template">
<meta name="viewport" content="width=device-width, initial-scale=1">


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/bootstrap4/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/themify-icons/themify-icons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/single_styles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/single_responsive.css">

<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/styles/bootstrap4/popper.js"></script>
<script src="${pageContext.request.contextPath}/resources/styles/bootstrap4/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/easing/easing.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/single_custom.js"></script>

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
				 $("#orderCount").val($("#orderCountSpan").text());
				 document.getElementById('orderlistform').submit();
				// location.href = "${pageContext.request.contextPath}/user/orderList";
				}else{ 
					$('#flag').val(no);
					$("#orderCount").val($("#orderCountSpan").text());
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
 				$("#orderCount").val($("#orderCountSpan").text());
				 document.getElementById('orderlistform').submit();
				 
		 } else {
			 
			 alert('옵션을 선택해 주세요.');
			 
		 }
	 });
 }
 
 $(document).ready( function() {

	 	var plus = $('.plus');
		var minus = $('.minus');
		var value = $('#orderCountSpan');

		plus.on('click', function()
		{
			var x = parseInt(value.text());
			value.text(x + 1);
		});

		minus.on('click', function()
		{
			var x = parseInt(value.text());
			if(x > 1)
			{
				value.text(x - 1);
			}
		});
	 
 })
 

 
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
	
<div class="super_container">
	
	<div class="container single_product_container">
		<div class="row">
			<div class="col">

				<!-- Breadcrumbs -->

				<div class="breadcrumbs d-flex flex-row align-items-center">
					<ul>
						<li><a href="${pageContext.request.contextPath}/">Home</a></li>
						<li><a href="${pageContext.request.contextPath}/board/mouse/1"><i class="fa fa-angle-right" aria-hidden="true"></i>Mouse's</a></li>
						<li class="active"><a href="${pageContext.request.contextPath}/board/boardDetail.do/boardNum/${article.boardNum}"><i class="fa fa-angle-right" aria-hidden="true"></i>${article.boardSubject}</a></li>
					</ul>
				</div>

			</div>
		</div>
		
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
				<input type="hidden" id="orderCount" name="orderCount" value="" />
				<input type="hidden" id="flag" name="flag" value="0"/>

		<div class="row">
			<div class="col-lg-7">
				<div class="single_product_pics">
					<div class="row">
						<div class="col-lg-9 image_col order-lg-2 order-1">
							<div class="single_product_image">
								<div class="single_product_image_background" style="background-image:url(${pageContext.request.contextPath}/resources/used-image/${article.boardFile})"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-5">
				<div class="product_details">
					<div class="product_details_title">
						<h2>${article.boardSubject}</h2>
						<table>
							<tr>
								<td style="width: 300px">
									<p>${article.boardContent}</p>
								</td>
								<td>
									 <p>조회수 : ${article.boardReadCount}</p>
								</td>
							</tr>
						</table>
						
					</div>
					<div class="free_delivery d-flex flex-row align-items-center justify-content-center">
						<span class="ti-truck"></span><span>free delivery</span>
					</div>
					<c:if test="${!(article.boardSale eq 0)}">
						<div class="original_price">${article.boardPrice+article.boardSale}</div>
						<div class="product_price" style="font-size: 20px">${article.boardPrice} 원</div>
					</c:if>
					<c:if test="${(article.boardSale eq 0)}">
						<div class="product_price" style="font-size: 20px; margin-top: 51px">${article.boardPrice} 원</div>
					</c:if>
					<div class="user_rating">
						<ul class="star_rating">
							<c:choose>
							
								<c:when test="${totalScore eq 1}">
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								</c:when>
								<c:when test="${totalScore eq 2}">
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								</c:when>
								<c:when test="${totalScore eq 3}">
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								</c:when>
								<c:when test="${totalScore eq 4}">
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								</c:when>
								<c:when test="${totalScore eq 5}">
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
									<li><i class="fa fa-star" aria-hidden="true"></i></li>
								</c:when>
							</c:choose>
							
						</ul>
					</div>
					<div class="product_color">
						<span>Option:</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select id="orderOption" name="orderOption" style="height: 25px; width: 150px">
         					  <option value="optionVal">textVal</option>
						</select>
					</div>
					<div class="quantity d-flex flex-column flex-sm-row align-items-sm-center">
						<span>Quantity:</span>
						<div class="quantity_selector">
							<span class="minus"><i class="fa fa-minus" aria-hidden="true"></i></span>
							<span id="orderCountSpan">1</span>
							<span class="plus"><i class="fa fa-plus" aria-hidden="true"></i></span>
						</div>
						<!-- <div class="red_button2 add_to_cart_button2"><a href="#">add to cart</a></div> !-->
						<div class="product_favorite d-flex flex-column align-items-center justify-content-center"></div>
					</div>
					<div class="quantity d-flex flex-column flex-sm-row align-items-sm-center red_button2">
						<a class="" href="#" onclick="directOrder();"> 구매하기 </a> 
						<a class="" href="#" onclick="orderlist();" > 장바구니 </a>
					</div>
				</div>
			</div>
		</div>
		
		</form:form>

	</div>
	

	<!-- Tabs -->

	<div class="tabs_section_container">

		<div class="container">
			<div class="row">
				<div class="col">
					<div class="tabs_container">
						<ul class="tabs d-flex flex-sm-row flex-column align-items-left align-items-md-center justify-content-center">
							<li class="tab active" data-active-tab="tab_1"><span>상세정보</span></li>
							<li class="tab" data-active-tab="tab_2"><span>상품평 (${reviewCount})</span></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">

					<!-- Tab Description -->

					<div id="tab_1" class="tab_container active" style="text-align: center;">
						<img  src="<c:url value='/image/${article.boardFileContent}' />" /> 
					</div>


					<!-- Tab Reviews -->

					<div id="tab_2" class="tab_container">
						<div class="row">

							<!-- User Reviews -->

							<div class="col-lg-6 reviews_col">
							
								<div class="tab_title reviews_title">
									<h4>상품평 (${reviewCount})</h4>
								</div>
								
								<c:forEach var="re" items="${review}" varStatus="st">
								
									<!-- User Review -->
	
									<div class="user_review_container d-flex flex-column flex-sm-row">
										<div class="user" style="margin-top: auto; text-align: center">
											<div class="review_date">${reviewDate[st.index]}</div>
											<div class="user_name">${re.username}</div>
										</div>
										<div class="review" style="margin-bottom: 1px;">
											
											<div class="user_rating">
												${re.reviewSubject}
												<ul class="star_rating">
													<c:choose>
														<c:when test="${re.reviewScore eq 1}">
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
														</c:when>
														<c:when test="${re.reviewScore eq 2}">
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
														</c:when>
														<c:when test="${re.reviewScore eq 3}">
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
														</c:when>
														<c:when test="${re.reviewScore eq 4}">
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
														</c:when>
														<c:when test="${re.reviewScore eq 5}">
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
															<li><i class="fa fa-star" aria-hidden="true"></i></li>
														</c:when>
													</c:choose>
													
												</ul>
											</div>
											<p>${re.reviewContent}</p>
										</div>
									</div>
								
								</c:forEach>

							</div>

							

						</div>
					</div>

				</div>
			</div>
		</div>
		
		

	</div>
	
		<!-- Benefit -->

	<div class="benefit">
		<div class="container">
			<div class="row benefit_row">
				<div class="col-lg-3 benefit_col">
					<div class="benefit_item d-flex flex-row align-items-center">
						<div class="benefit_icon"><i class="fa fa-truck" aria-hidden="true"></i></div>
						<div class="benefit_content">
							<h6>무료 배송</h6>
							<p>Suffered Alteration in Some Form</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 benefit_col">
					<div class="benefit_item d-flex flex-row align-items-center">
						<div class="benefit_icon"><i class="fa fa-money" aria-hidden="true"></i></div>
						<div class="benefit_content">
							<h6>현금 환불</h6>
							<p>The Internet Tend To Repeat</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 benefit_col">
					<div class="benefit_item d-flex flex-row align-items-center">
						<div class="benefit_icon"><i class="fa fa-undo" aria-hidden="true"></i></div>
						<div class="benefit_content">
							<h6>45일 이전 반품</h6>
							<p>Making it Look Like Readable</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 benefit_col">
					<div class="benefit_item d-flex flex-row align-items-center">
						<div class="benefit_icon"><i class="fa fa-clock-o" aria-hidden="true"></i></div>
						<div class="benefit_content">
							<h6>언제든 오픈</h6>
							<p>8AM - 06PM</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- Newsletter -->

	<div class="newsletter">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="newsletter_text d-flex flex-column justify-content-center align-items-lg-start align-items-md-center text-center">
						<h4>구독하기</h4>
						<p>구독하면 매 주 열리는 할인 쿠폰을 드립니다.</p>
					</div>
				</div>
				<div class="col-lg-6">
					<form action="post">
						<div class="newsletter_form d-flex flex-md-row flex-column flex-xs-column align-items-center justify-content-lg-end justify-content-center">
							<input id="newsletter_email" type="email" placeholder="Your email" required="required" data-error="Valid email is required.">
							<button id="newsletter_submit" type="submit" class="newsletter_submit_btn trans_300" value="Submit">subscribe</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->

	<footer class="footer">
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="footer_nav_container d-flex flex-sm-row flex-column align-items-center justify-content-lg-start justify-content-center text-center">
						<ul class="footer_nav">
							<li><a href="#">Blog</a></li>
							<li><a href="#">FAQs</a></li>
							<li><a href="contact.html">Contact us</a></li>
						</ul>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="footer_social d-flex flex-row align-items-center justify-content-lg-end justify-content-center">
						<ul>
							<li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
							<li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
							<li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
							<li><a href="#"><i class="fa fa-skype" aria-hidden="true"></i></a></li>
							<li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12">
					<div class="footer_nav_container">
						<div class="cr">©2018 All Rights Reserverd. This template is made by <a href="#">JSH</a></div>
					</div>
				</div>
			</div>
		</div>
	</footer>
</div>

<%-- 						
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
    <br><br><br>
	<div class="btn-group" style="">
	  <button class="button">상세 정보</button>
	  <button class="button">상품평</button>
	</div>
    
    <!-- 제품 상세정보 -->
    <div id="info">
           <img  src="<c:url value='/image/${article.boardFileContent}' />" /> 
	</div>
	 <!-- 제품 상세정보 끝 -->
	 
	 <!-- 리뷰 보기 -->
	 <div id="rev">
	 	<table>
	 		<tr>
	 		</tr>
	 	</table>
	 </div>
     --%>
     
     
     
     
    <!-- 옵션 추가 스크립트 -->
    <script>
            getOption("${optionList}", "${optionList.size()}");
    </script>
    <!-- 옵션 추가 스크립트 끝 -->
    
    
    

    
</body>
</html>