<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<title>Home</title>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Colo Shop Template">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/categories_styles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/categories_responsive.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/bootstrap4/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.css">


<script src="${pageContext.request.contextPath}/resources/js/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/styles/bootstrap4/popper.js"></script>
<script src="${pageContext.request.contextPath}/resources/styles/bootstrap4/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/Isotope/isotope.pkgd.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/easing/easing.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/jquery-ui-1.12.1.custom/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/categories_custom.js"></script>

<%-- <!-- jQuery : 3.2.1 -->
<script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>

<!-- jQuery : 3.3.1 -->
<script src="<c:url value='/js/jQuery/3.3.1/jquery-3.3.1.min.js' />"></script>

<!-- bootstrap JS : 3.3.7 -->
<script src="<c:url value='/js/bootstrap/3.3.7/js/bootstrap.min.js' />"></script> --%>

<script>

// 할인 모달 라디오 버튼
function display(str){
	if(str=='sale') {
		$('#price').css("display","");
	} else {
		$('#price').css("display","none");
	}
}

function radioCheck(num) {
	
 	if(num == '1') {
		$("input:radio[name='disImage']:input[value='sale']").prop("checked", true);
		$('#price').css("display","");

	} else {
		$("input:radio[name='disImage']:input[value='new']").prop("checked", true);
		$('#price').css("display","none");
		
	} 
}

$(document).ready(function(){
    $('.modal-footer a').click(function(){
    	$('#discountForm').submit();
	});

});

function onModal(boardNum) {
	document.getElementById('discountForm').action = "${pageContext.request.contextPath}/admin/discount.do/"+boardNum;
	$('#myModal').modal('show');
}
    

function deleteBtn(boardNum) {
	 if (confirm("정말 삭제 하시겠습니까?")){ 
		 location.href='${pageContext.request.contextPath}/admin/deleteAction.do/boardNum/'+boardNum+'/page/${pageInfo.page}';
		}else{ 
			return; 
		} 
 	
	   
}; // deleteBtn 




</script>



 
</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>

	
<div class="super_container">
<div class="container product_section_container">
	<!-- 인자들 -->
	<!-- 게시글정보 보기(팝업) -->
	<sec:authorize access="hasRole('ROLE_ADMIN')">
	
		<!-- 페이지 확인 -->
		<div style="padding-left: 30px">
			총 게시글 수 : ${pageInfo.listCount}<br> 현재 페이지 : ${pageInfo.page}<br>
			총 페이지 : ${pageInfo.maxPage}<br> 시작 페이지 : ${pageInfo.startPage}<br>
			끝 페이지 : ${pageInfo.endPage}
		</div>
		
		<!-- 상품 올리기 -->
		<div style="padding-left: 30px">
			<button type="button" class="btn btn-info btn-lg"
				onclick="location.href='${pageContext.request.contextPath}/admin/mouseBoardwrite'">상품
				올리기</button>
		</div>
		
	</sec:authorize>
	<!-- 게시글정보 보기(팝업) 끝 -->
	

	
		<div class="row">
			<div class="col product_section clearfix">

				<!-- Breadcrumbs -->

				<div class="breadcrumbs d-flex flex-row align-items-center">
					<ul>
						<li><a href="${pageContext.request.contextPath}/">Home</a></li>
						<li class="active"><a href="${pageContext.request.contextPath}/board/mouse/1"><i class="fa fa-angle-right" aria-hidden="true"></i>Mouse's</a></li>
					</ul>
				</div>

				<!-- Sidebar -->

				<div class="sidebar">
					<div class="sidebar_section">
						<div class="sidebar_title">
							<h5>Product Category</h5>
						</div>
						<ul class="sidebar_categories">
							<li class="active"><a href="${pageContext.request.contextPath}/board/mouse/1"><span><i class="fa fa-angle-double-right" aria-hidden="true"></i></span>Mouse</a></li>
							<li><a href="#">Keyboard</a></li>
							<li><a href="#">Monitor</a></li>
						</ul>
					</div>

					<!-- Price Range Filtering -->
					<div class="sidebar_section">
						<div class="sidebar_title">
							<h5>Filter by Price</h5>
						</div>
						<p>
							<input type="text" id="amount" readonly style="border:0; color:#f6931f; font-weight:bold;">
						</p>
						<div id="slider-range"></div>
						<div class="filter_button"><span>filter</span></div>
					</div>


				</div>

				<!-- Main Content -->

				<div class="main_content">

					<!-- Products -->

					<div class="products_iso">
						<div class="row">
							<div class="col">
								
								<div>
									<a class="jsh_red_button" href="#">상품 올리기</a>
								</div>
	
								<!-- Product Sorting -->
								
									<div class="product_sorting_container product_sorting_container_top">
									<div class="pages d-flex flex-row align-items-center">
										<div class="page_current">
											<span>${pageInfo.page}</span>
											<ul class="page_selection">
												<c:forEach var="a" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			
													<c:choose>
														<c:when test="${a == pageInfo.page}">
															<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->
															<li class="active"><a href="../mouse/${a}">${a}</a></li>
														</c:when>
														<c:otherwise>
															<li><a href="../mouse/${a}">${a}</a></li>
														</c:otherwise>
													</c:choose>
							
												</c:forEach>
											</ul>
										</div>
										<div class="page_total"><span>of</span> ${pageInfo.maxPage}</div>
										<c:choose>
											<c:when test="${pageInfo.page >= pageInfo.maxPage}">
												<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨.
					                                                  링크 교정 => page=${pageInfo.page} -->
												<div id="next_page_1" class="page_next"><a href="../mouse/${pageInfo.page}"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a></div>
											</c:when>
											<c:otherwise>
												<div id="next_page_1" class="page_next"><a href="../mouse/${pageInfo.page + 1}"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a></div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
				

								<!-- Product Grid -->

								<div class="product-grid">

									<!-- Product -->
									
									<table id="board_tbl" style="text-align: center">
								
										<c:forEach var="article" items="${articleList}" varStatus="st">
										
											<sec:authorize access="hasRole('ROLE_ADMIN')">
												<div class="product-item men" style="height: 420px">
											</sec:authorize>
											<sec:authorize access="hasRole('ROLE_USER')">
												<div class="product-item men">
											</sec:authorize>
											<sec:authorize access="!isAuthenticated()">
												<div class="product-item men">
											</sec:authorize>
											
												<div class="product discount product_filter">
													<div class="product_image" style="padding-top: 60px">
														<a href="../boardDetail.do/boardNum/${article.boardNum}"><img src="<c:url value='/image/${article.boardFile}' />" alt=""></a>
													</div>
													
													<c:choose>
												      	<c:when test="${article.boardDflag eq 'sale'}">
												      	
												            <div class="favorite favorite_left"></div>
															<div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span>-${article.boardSale}</span></div>
															<div class="product_info">
																<h6 class="product_name"><a href="../boardDetail.do/boardNum/${article.boardNum}">${article.boardSubject}</a></h6>
																<div class="product_price">${article.boardPrice}원<span>${article.boardPrice+article.boardSale}원</span></div>
															</div>
															
												      	</c:when>
												       	<c:when test="${article.boardDflag eq 'new'}">
												       	
												        	<div class="favorite"></div>
															<div class="product_bubble product_bubble_left product_bubble_green d-flex flex-column align-items-center"><span>new</span></div>
															<div class="product_info">
																<h6 class="product_name"><a href="../boardDetail.do/boardNum/${article.boardNum}">${article.boardSubject}</a></h6>
																<div class="product_price">${article.boardPrice}원</div>
															</div>
													
												      	</c:when>
												      	<c:otherwise>
												      	
												        	<div class="favorite"></div>
													        <div class="product_info">
																<h6 class="product_name"><a href="../boardDetail.do/boardNum/${article.boardNum}">${article.boardSubject}</a></h6>
																<div class="product_price">${article.boardPrice}원</div>
															</div>
															
													    </c:otherwise>
												    </c:choose>

												</div>
												
												<div class="red_button add_to_cart_button"><a href="../boardDetail.do/boardNum/${article.boardNum}">go buy</a></div>
												<sec:authorize access="hasRole('ROLE_ADMIN')">
													<div class="jsh_center">
															<a class="jsh_red_button jsh_button" href="${pageContext.request.contextPath}/admin/update/boardNum/${article.boardNum}">수정</a>
															<a class="jsh_red_button jsh_button" id="deleteBtn" href="#" onclick='deleteBtn(${article.boardNum});'>삭제</a>
															<a class="jsh_red_button jsh_button" data-toggle="modal" href="#" onclick="onModal(${article.boardNum})">할인</a>
													</div>
													
													<!-- 할인 Modal -->
													
													<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
														<div class="modal-dialog">
															<div class="modal-content">
													
																<div class="modal-header">
																	<h4 class="modal-title" id="myModalLabel">Discount Select</h4>
																	<button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="">×</button>
																</div> <!-- /.modal-header -->
																
																
																<form id="discountForm" 
																  name="discountForm" 
																  action=""
																  method="POST">
																  
																<input type="hidden" id="page" name="page" value="${pageInfo.page}" />
																  
																<div class="modal-body">
																<input type="radio" id="disImage" name="disImage" value="sale" onclick="display(this.value);" checked="checked"><img onclick="radioCheck('1');" src="<c:url value='/image/css_image/sale.jpg' />" >&nbsp;&nbsp;&nbsp;&nbsp;
																<input type="radio" id="disImage" name="disImage" value="new" onclick="display(this.value);"><img onclick="radioCheck('2');" src="<c:url value='/image/css_image/new.jpg' />" >
																
																		<div class="form-group">
																			<div class="input-group">
																				<input type="text" class="form-control" id="price" name="price" placeholder="할인 금액 ">
																			</div>
																		</div> <!-- /.form-group -->
																
																</div> <!-- /.modal-body -->
													
																<div class="modal-footer">
																	<!-- <button type="submit" id="login" name="login" class="form-control btn btn-primary">Ok</button> -->
																	<div class="jshblack_button login_button"><a id="Confirm" href="#">Confirm</a></div>
																				   
																	<div class="progress">
																		<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="1" aria-valuemin="1" aria-valuemax="100" style="width: 0%;">
																			<span class="sr-only">progress</span>
																		</div>
																	</div>
																</div> <!-- /.modal-footer -->
																
																</form>
																
															</div><!-- /.modal-content -->
														</div><!-- /.modal-dialog -->
													</div><!-- / 할인 modal -->
													
												</sec:authorize>
											</div>
											
											
										</c:forEach>
								
									</table>
							

							</div>
							
							
							<div class="product_sorting_container product_sorting_container_bottom clearfix">
								<div class="pages d-flex flex-row align-items-center">
									<div class="page_current">
										<span>${pageInfo.page}</span>
										<ul class="page_selection">
											<c:forEach var="a" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
		
												<c:choose>
													<c:when test="${a == pageInfo.page}">
														<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->
														<li class="active"><a href="../mouse/${a}">${a}</a></li>
													</c:when>
													<c:otherwise>
														<li><a href="../mouse/${a}">${a}</a></li>
													</c:otherwise>
												</c:choose>
						
											</c:forEach>
										</ul>
									</div>
									<div class="page_total"><span>of</span> ${pageInfo.maxPage}</div>
									<c:choose>
										<c:when test="${pageInfo.page >= pageInfo.maxPage}">
											<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨.
				                                                  링크 교정 => page=${pageInfo.page} -->
											<div id="next_page_1" class="page_next"><a href="../mouse/${pageInfo.page}"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a></div>
										</c:when>
										<c:otherwise>
											<div id="next_page_1" class="page_next"><a href="../mouse/${pageInfo.page + 1}"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a></div>
										</c:otherwise>
									</c:choose>
								</div>
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
</div>


</body>
</html>
