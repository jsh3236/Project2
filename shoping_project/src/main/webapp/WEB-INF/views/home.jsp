<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>Home</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Colo Shop Template">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/bootstrap4/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/styles/responsive.css">

<script src="<c:url value="resources/js/jquery-3.2.1.min.js" />"></script>
<script src="<c:url value="resources/styles/bootstrap4/popper.js" /> "></script>
<script src="<c:url value="resources/styles/bootstrap4/bootstrap.min.js" />"></script>
<script src="<c:url value="resources/plugins/Isotope/isotope.pkgd.min.js" />"></script>
<script src="<c:url value="resources/plugins/OwlCarousel2-2.2.1/owl.carousel.js" />"></script>
<script src="<c:url value="resources/plugins/easing/easing.js" />"></script>
<script src="<c:url value="resources/js/custom.js" />"></script>
	
</head>
<body>
	<jsp:include page="include.jsp" flush="false" />
<%-- 	<table style="width: 1300px;">
		<tr>
			<td>
				<h2>New 마우스</h2>
				<c:forEach var="board" items="${boardlist}" varStatus="st">
					<a href="${pageContext.request.contextPath}/board/boardDetail.do/boardNum/${board.boardNum}">
						<img src="<c:url value='/image/${board.boardFile}' />" width=300 height=300 />
					</a>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td>
				<h2>New 키보드</h2>
			</td>
		</tr>
	</table> --%>


	<!-- Slider -->
	<div class="main_slider" style="background-image:url(${pageContext.request.contextPath}/resources/used-image/css_image/maintop.jpg)">
		<div class="container fill_height">
			<div class="row align-items-center fill_height">
				<div class="col">
					<div class="main_slider_content">
						<h6>Summer Collection 2018</h6>
						<h1>삼성컴퓨터<br> 여름맞이즉시할인!!</h1>
						<div class="red_button shop_now_button"><a href="${pageContext.request.contextPath}/board/mouse/1">shop now</a></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Banner -->

	<div class="banner">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<div class="banner_item align-items-center" style="background-image:url(${pageContext.request.contextPath}/resources/used-image/css_image/mouse2.jpg)">
						<div class="banner_category">
							<a href="${pageContext.request.contextPath}/board/mouse/1">Mouse</a>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="banner_item align-items-center" style="background-image:url(${pageContext.request.contextPath}/resources/used-image/css_image/keyboard.jpg)">
						<div class="banner_category">
							<a href="${pageContext.request.contextPath}/board/keyBoard">Keyboard</a>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="banner_item align-items-center" style="background-image:url(${pageContext.request.contextPath}/resources/used-image/css_image/monitor.jpg)">
						<div class="banner_category">
							<a href="${pageContext.request.contextPath}/board/monitorBoard">Monitor</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- New Arrivals -->

	<div class="new_arrivals">
		<div class="container">
			<div class="row">
				<div class="col text-center">
					<div class="section_title new_arrivals_title">
						<h2>New Arrivals</h2>
					</div>
				</div>
			</div>
			<div class="row align-items-center">
				<div class="col text-center">
					<div class="new_arrivals_sorting">
						<ul class="arrivals_grid_sorting clearfix button-group filters-button-group">
							<li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center active is-checked" data-filter="*">all</li>
							<li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".MOUSE">MOUSE</li>
							<li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".KEYBOARD">KEYBOARD</li>
							<li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".MONITOR">MONITOR</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="product-grid" data-isotope='{ "itemSelector": ".product-item", "layoutMode": "fitRows" }'>

					<%-- 	<c:forEach var="board" items="${boardlist}" varStatus="st">
							<div class="product-item MOUSE">
								<div class="product discount product_filter">
									<div class="product_image">
										<a href="${pageContext.request.contextPath}/board/boardDetail.do/boardNum/${board.boardNum}">
											<img src="<c:url value='/image/${board.boardFile}' />" alt=""/>
										</a>
									</div>
									<div class="favorite favorite_left"></div>
									<!-- <div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span></span></div> -->
									<div class="product_info">
										<h6 class="product_name"><a href="single.html">${board.boardSubject}</a></h6>
										<div class="product_price">${board.boardPrice}<span>${board.boardPrice+2000}</span></div>
									</div>
								</div>
								<div class="red_button add_to_cart_button"><a href="${pageContext.request.contextPath}/board/boardDetail.do/boardNum/${board.boardNum}">go buy</a></div>
							</div>
						</c:forEach> --%>
						
						<c:forEach var="board" items="${boardlist}" varStatus="st">
								<div class="product-item MOUSE">
									<div class="product discount">
										<div class="product_image">
											<img src="<c:url value='/image/${board.boardFile}' />" alt=""/>
										</div>
										<c:choose>
									      	<c:when test="${board.boardDflag eq 'sale'}">
									      	
									            <div class="favorite favorite_left"></div>
												<div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span>-${board.boardSale}</span></div>
												<div class="product_info">
													<h6 class="product_name"><a href="${pageContext.request.contextPath}/board/boardDetail.do/boardNum/${board.boardNum}">${board.boardSubject}</a></h6>
													<div class="product_price">${board.boardPrice}원<span>${board.boardPrice+board.boardSale}원</span></div>
												</div>
												
									      	</c:when>
									       	<c:when test="${board.boardDflag eq 'new'}">
									       	
									        	<div class="favorite"></div>
												<div class="product_bubble product_bubble_left product_bubble_green d-flex flex-column align-items-center"><span>new</span></div>
												<div class="product_info">
													<h6 class="product_name"><a href="${pageContext.request.contextPath}/board/boardDetail.do/boardNum/${board.boardNum}">${board.boardSubject}</a></h6>
													<div class="product_price">${board.boardPrice}원</div>
												</div>
										
									      	</c:when>
									      	<c:otherwise>
									      	
									        	<div class="favorite"></div>
										        <div class="product_info">
													<h6 class="product_name"><a href="${pageContext.request.contextPath}/board/boardDetail.do/boardNum/${board.boardNum}">${board.boardSubject}</a></h6>
													<div class="product_price">${board.boardPrice}원</div>
												</div>
												
										    </c:otherwise>
									    </c:choose>
									</div>
								</div>
						</c:forEach>
						
						<!-- product 6 -->
						<div class="product-item MONITOR">
							<div class="product product_filter">
								<div class="product_image">
									<img src="<c:url value='/image/css_image/monitor2.jpg' />" alt="">
								</div>
								<div class="favorite"></div>
								<div class="product_info">
									<h6 class="product_name"><a href="single.html">BenQ ZOWIE XL2540</a></h6>
									<div class="product_price">629980<span>680000</span></div>
								</div>
							</div>
							<div class="red_button add_to_cart_button"><a href="#">go buy</a></div>
						</div>
						
						<!-- product 7 -->
						<div class="product-item KEYBOARD">
							<div class="product product_filter">
								<div class="product_image">
									<img src="<c:url value='/image/css_image/keyboard2.jpg' />" alt="">
								</div>
								<div class="favorite"></div>
								<div class="product_info">
									<h6 class="product_name"><a href="single.html">Corsair K68 적축 기계식키보드</a></h6>
									<div class="product_price">129000<span>140000</span></div>
								</div>
							</div>
							<div class="red_button add_to_cart_button"><a href="#">go buy</a></div>
						</div>
						
						
				</div>
			</div>
		</div>
	</div>

	<!-- Deal of the week -->

	<div class="deal_ofthe_week">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6">
					<div class="deal_ofthe_week_img">
						<img src="<c:url value='/image/css_image/g903.jpg' />" alt="">
					</div>
				</div>
				<div class="col-lg-6 text-right deal_ofthe_week_col">
					<div class="deal_ofthe_week_content d-flex flex-column align-items-center float-right">
						<div class="section_title">
							<h2>이번주 할인</h2>
						</div>
						<ul class="timer">
							<li class="d-inline-flex flex-column justify-content-center align-items-center">
								<div id="day" class="timer_num">03</div>
								<div class="timer_unit">Day</div>
							</li>
							<li class="d-inline-flex flex-column justify-content-center align-items-center">
								<div id="hour" class="timer_num">15</div>
								<div class="timer_unit">Hours</div>
							</li>
							<li class="d-inline-flex flex-column justify-content-center align-items-center">
								<div id="minute" class="timer_num">45</div>
								<div class="timer_unit">Mins</div>
							</li>
							<li class="d-inline-flex flex-column justify-content-center align-items-center">
								<div id="second" class="timer_num">23</div>
								<div class="timer_unit">Sec</div>
							</li>
						</ul>
						<div class="red_button deal_ofthe_week_button"><a href="#">shop now</a></div>
					</div>
				</div>
			</div>
		</div>
	</div>
<%-- 
	<!-- Best Sellers -->

	<div class="best_sellers">
		<div class="container">
			<div class="row">
				<div class="col text-center">
					<div class="section_title new_arrivals_title">
						<h2>Best Sellers</h2>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="product_slider_container">
						<div class="owl-carousel owl-theme product_slider">
						
							<!-- Slide Product -->
						<c:forEach var="board" items="${boardlist}" varStatus="st">
							<div class="owl-item product_slider_item">
								<div class="product-item women">
									<div class="product discount">
										<div class="product_image">
											<img src="<c:url value='/image/${board.boardFile}' />" alt=""/>
										</div>
										<c:choose>
									      	<c:when test="${board.boardDflag eq 'sale'}">
									      	
									            <div class="favorite favorite_left"></div>
												<div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span>-${board.boardSale}</span></div>
												<div class="product_info">
													<h6 class="product_name"><a href="../boardDetail.do/boardNum/${board.boardNum}">${board.boardSubject}</a></h6>
													<div class="product_price">${board.boardPrice}원<span>${board.boardPrice+board.boardSale}원</span></div>
												</div>
												
									      	</c:when>
									       	<c:when test="${board.boardDflag eq 'new'}">
									       	
									        	<div class="favorite"></div>
												<div class="product_bubble product_bubble_left product_bubble_green d-flex flex-column align-items-center"><span>new</span></div>
												<div class="product_info">
													<h6 class="product_name"><a href="../boardDetail.do/boardNum/${board.boardNum}">${board.boardSubject}</a></h6>
													<div class="product_price">${board.boardPrice}원</div>
												</div>
										
									      	</c:when>
									      	<c:otherwise>
									      	
									        	<div class="favorite"></div>
										        <div class="product_info">
													<h6 class="product_name"><a href="../boardDetail.do/boardNum/${board.boardNum}">${board.boardSubject}</a></h6>
													<div class="product_price">${board.boardPrice}원</div>
												</div>
												
										    </c:otherwise>
									    </c:choose>
									</div>
								</div>
							</div>
						</c:forEach>

							<!-- Slide 1 -->

							<div class="owl-item product_slider_item">
								<div class="product-item">
									<div class="product discount">
										<div class="product_image">
											<img src="images/product_1.png" alt="">
										</div>
										<div class="favorite favorite_left"></div>
										<div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span>-$20</span></div>
										<div class="product_info">
											<h6 class="product_name"><a href="single.html">Fujifilm X100T 16 MP Digital Camera (Silver)</a></h6>
											<div class="product_price">$520.00<span>$590.00</span></div>
										</div>
									</div>
								</div>
							</div>

							<!-- Slide 2 -->

							<div class="owl-item product_slider_item">
								<div class="product-item women">
									<div class="product">
										<div class="product_image">
											<img src="images/product_2.png" alt="">
										</div>
										<div class="favorite"></div>
										<div class="product_bubble product_bubble_left product_bubble_green d-flex flex-column align-items-center"><span>new</span></div>
										<div class="product_info">
											<h6 class="product_name"><a href="single.html">Samsung CF591 Series Curved 27-Inch FHD Monitor</a></h6>
											<div class="product_price">$610.00</div>
										</div>
									</div>
								</div>
							</div>

							<!-- Slide 3 -->

							<div class="owl-item product_slider_item">
								<div class="product-item women">
									<div class="product">
										<div class="product_image">
											<img src="images/product_3.png" alt="">
										</div>
										<div class="favorite"></div>
										<div class="product_info">
											<h6 class="product_name"><a href="single.html">Blue Yeti USB Microphone Blackout Edition</a></h6>
											<div class="product_price">$120.00</div>
										</div>
									</div>
								</div>
							</div>

							<!-- Slide 4 -->

							<div class="owl-item product_slider_item">
								<div class="product-item accessories">
									<div class="product">
										<div class="product_image">
											<img src="images/product_4.png" alt="">
										</div>
										<div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span>sale</span></div>
										<div class="favorite favorite_left"></div>
										<div class="product_info">
											<h6 class="product_name"><a href="single.html">DYMO LabelWriter 450 Turbo Thermal Label Printer</a></h6>
											<div class="product_price">$410.00</div>
										</div>
									</div>
								</div>
							</div>

							<!-- Slide 5 -->

							<div class="owl-item product_slider_item">
								<div class="product-item women men">
									<div class="product">
										<div class="product_image">
											<img src="images/product_5.png" alt="">
										</div>
										<div class="favorite"></div>
										<div class="product_info">
											<h6 class="product_name"><a href="single.html">Pryma Headphones, Rose Gold & Grey</a></h6>
											<div class="product_price">$180.00</div>
										</div>
									</div>
								</div>
							</div>

							<!-- Slide 6 -->

							<div class="owl-item product_slider_item">
								<div class="product-item accessories">
									<div class="product discount">
										<div class="product_image">
											<img src="images/product_6.png" alt="">
										</div>
										<div class="favorite favorite_left"></div>
										<div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span>-$20</span></div>
										<div class="product_info">
											<h6 class="product_name"><a href="single.html">Fujifilm X100T 16 MP Digital Camera (Silver)</a></h6>
											<div class="product_price">$520.00<span>$590.00</span></div>
										</div>
									</div>
								</div>
							</div>

							<!-- Slide 7 -->

							<div class="owl-item product_slider_item">
								<div class="product-item women">
									<div class="product">
										<div class="product_image">
											<img src="images/product_7.png" alt="">
										</div>
										<div class="favorite"></div>
										<div class="product_info">
											<h6 class="product_name"><a href="single.html">Samsung CF591 Series Curved 27-Inch FHD Monitor</a></h6>
											<div class="product_price">$610.00</div>
										</div>
									</div>
								</div>
							</div>

							<!-- Slide 8 -->

							<div class="owl-item product_slider_item">
								<div class="product-item accessories">
									<div class="product">
										<div class="product_image">
											<img src="images/product_8.png" alt="">
										</div>
										<div class="favorite"></div>
										<div class="product_info">
											<h6 class="product_name"><a href="single.html">Blue Yeti USB Microphone Blackout Edition</a></h6>
											<div class="product_price">$120.00</div>
										</div>
									</div>
								</div>
							</div>

							<!-- Slide 9 -->

							<div class="owl-item product_slider_item">
								<div class="product-item men">
									<div class="product">
										<div class="product_image">
											<img src="images/product_9.png" alt="">
										</div>
										<div class="product_bubble product_bubble_right product_bubble_red d-flex flex-column align-items-center"><span>sale</span></div>
										<div class="favorite favorite_left"></div>
										<div class="product_info">
											<h6 class="product_name"><a href="single.html">DYMO LabelWriter 450 Turbo Thermal Label Printer</a></h6>
											<div class="product_price">$410.00</div>
										</div>
									</div>
								</div>
							</div>

							<!-- Slide 10 -->

							<div class="owl-item product_slider_item">
								<div class="product-item men">
									<div class="product">
										<div class="product_image">
											<img src="images/product_10.png" alt="">
										</div>
										<div class="favorite"></div>
										<div class="product_info">
											<h6 class="product_name"><a href="single.html">Pryma Headphones, Rose Gold & Grey</a></h6>
											<div class="product_price">$180.00</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Slider Navigation -->

						<div class="product_slider_nav_left product_slider_nav d-flex align-items-center justify-content-center flex-column">
							<i class="fa fa-chevron-left" aria-hidden="true"></i>
						</div>
						<div class="product_slider_nav_right product_slider_nav d-flex align-items-center justify-content-center flex-column">
							<i class="fa fa-chevron-right" aria-hidden="true"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> --%>

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
	
</body>
</html>
