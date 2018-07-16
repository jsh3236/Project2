<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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

<!-- <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script> -->



<script>

$(document).ready(function(){
    $('.modal-footer button').click(function(){
		var button = $(this);

		if ( button.attr("data-dismiss") != "modal" ){
			var inputs = $('form input');
			var title = $('.modal-title');
			var progress = $('.progress');
			var progressBar = $('.progress-bar');

			inputs.attr("disabled", "disabled");

			button.hide();

			progress.show();

			progressBar.animate({width : "100%"}, 100);

			progress.delay(1000)
					.fadeOut(600);

			button.text("Close")
					.removeClass("btn-primary")
					.addClass("btn-success")
    				.blur()
					.delay(1600)
					.fadeIn(function(){
						title.text("Log in is successful");
						button.attr("data-dismiss", "modal");
					});
		}
	});

	$('#myModal').on('hidden.bs.modal', function (e) {
		var inputs = $('form input');
		var title = $('.modal-title');
		var progressBar = $('.progress-bar');
		var button = $('.modal-footer button');

		inputs.removeAttr("disabled");

		title.text("Log in");

		progressBar.css({ "width" : "0%" });

		button.removeClass("btn-success")
				.addClass("btn-primary")
				.text("Ok")
				.removeAttr("data-dismiss");
                
	});
});
    
    
// 로그인 관리

$(document).ready(function() {
		
		 // 필드 공백 제거
		 $("#username").val().replace(/\s/g, "");
		 $("#password").val().replace(/\s/g, "");
		 
		 $("#login").click(function() {
			
			// 공백 여부 점검
			if ($.trim($("#username").val()) == "" || 
				$.trim($("#password").val()) == "")   {
				
				alert("공백이 입력되었습니다. 다시 입력하십시오.");
				$("#username").val("");
				$("#password").val("");
				
			} else {
				
				$.ajax({
		    		url : "${pageContext.request.contextPath}/idCheck",
		    	    type: "get",
		    	    dataType: "text",
		        	data : {
		        		username : $("#username").val()
		        	},
		        	success : function(data) {
		        		
		        		if (data.trim() == "true") {
			           		 /* alert("로그인에 성공하셨습니다."); */
			       			 document.loginForm.submit();
			           	} else 
			       			alert("아이디가 존재하지 않습니다.");
		        			 $("#username").focus();
			        	}
		        	
		    	}); // $.ajax
			} // if
	    	
	    }) // login
	    
	}) //

	
	
// 주문 수량 가져오기
	$(document).ready(function() {
		
		$.ajax({
    		url : "${pageContext.request.contextPath}/getCount",
    	    type: "post",
    	    /*dataType: "json", 
    	     async: false,*/
        	data : {
        		username : $("#userID").val()
        	},
        	success : function(data) {
        		
        		
        		$('#checkout_items').text(data);
        		
        		
			}
        	
    	}); // $.ajax

	    
	}) //
</script>
	
<style>

body{
    padding: 50px;
}
.modal-dialog {
    width: 300px;
}
.modal-footer {
    height: 70px;
    margin: 0;
}
.modal-footer .btn {
    font-weight: bold;
}
.modal-footer .progress {
    display: none;
    height: 32px;
    margin: 0;
}
.input-group-addon {
    color: #fff;
    background: #3276B1;
}


</style>
</head>
<body>

<sec:authorize access="!isAuthenticated()">
	<header class="header trans_300">

		<!-- Top Navigation -->

		<div class="top_nav">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<div class="top_nav_left">Online Computer ShoppingMall</div>
					</div>
					<div class="col-md-6 text-right">
						<div class="top_nav_right">
							<ul class="top_nav_menu">

								<!-- Currency / Language / My Account -->

								<li class="language">
									<a href="#">
										한국어
										<i class="fa fa-angle-down"></i>
									</a>
									<ul class="language_selection">
										<li><a href="#">French</a></li>
										<li><a href="#">Italian</a></li>
										<li><a href="#">German</a></li>
										<li><a href="#">Spanish</a></li>
									</ul>
								</li>
								<li class="account">
									<a data-toggle="modal" href="#myModal">
										My Account
										<i class="fa fa-angle-down"></i>
									</a>
									<ul class="account_selection">
										<li><a data-toggle="modal" href="#myModal"><i class="fa fa-sign-in" aria-hidden="true"></i>Sign In</a></li>
										<li><a href="${pageContext.request.contextPath}/join"><i class="fa fa-user-plus" aria-hidden="true"></i>Register</a></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Main Navigation -->

		<div class="main_nav_container">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 text-right">
						<div class="logo_container">
							<a href="${pageContext.request.contextPath}/">smart<span>com</span></a>
						</div>
						<nav class="navbar">
							<ul class="navbar_menu">
								<li><a href="${pageContext.request.contextPath}/">home</a></li>
								<li><a href="${pageContext.request.contextPath}/board/mouse/1">shop</a></li>
								<li><a href="#">promotion</a></li>
								<li><a href="#">pages</a></li>
								<li><a href="#">blog</a></li>
								<li><a href="#">contact</a></li>
							</ul>
							<ul class="navbar_user">
								<li><a href="#"><i class="fa fa-search" aria-hidden="true"></i></a></li>
								<li><a data-toggle="modal" href="#myModal"><i class="fa fa-user" aria-hidden="true"></i></a></li>
								<li class="checkout">
									<a data-toggle="modal" href="#myModal">
										<i class="fa fa-shopping-cart" aria-hidden="true"></i>
									</a>
								</li>
							</ul>
							<div class="hamburger_container">
								<i class="fa fa-bars" aria-hidden="true"></i>
							</div>
						</nav>
					</div>
				</div>
			</div>
		</div>

	</header>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Log in</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="">×</button>
			</div> <!-- /.modal-header -->
			
			
			<form id="loginForm" 
			  name="loginForm" 
			  action="${pageContext.request.contextPath}/j_spring_security_check"
			  method="POST">
			
			
			<div class="modal-body">
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control" id="username" name="username" placeholder="ID">
							<label for="username" class="input-group-addon fa fa-user"></label>
						</div>
					</div> <!-- /.form-group -->

					<div class="form-group">
						<div class="input-group">
							<input type="password" class="form-control" id="password" name="password" placeholder="Password">
							<label for="password" class="input-group-addon fa fa-lock"></label>
						</div> <!-- /.input-group -->
					</div> <!-- /.form-group -->

			
			</div> <!-- /.modal-body -->

			<div class="modal-footer">
				<!-- <button type="submit" id="login" name="login" class="form-control btn btn-primary">Ok</button> -->
				<div class="jshblack_button login_button"><a id="login" href="#">Login</a></div>
				<!-- <input id="login" class="red_button shop_now_button" 
							   name="login" 
							   type="button"
							   value="login" /> -->
							   
				<div class="progress">
					<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="1" aria-valuemin="1" aria-valuemax="100" style="width: 0%;">
						<span class="sr-only">progress</span>
					</div>
				</div>
			</div> <!-- /.modal-footer -->
			
			</form>
			
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</sec:authorize>

<sec:authorize access="hasRole('ROLE_ADMIN')">
<input type="hidden" id="userID" name="userID" value="<sec:authentication property='principal.username' />">
	<header class="header trans_300">

		<!-- Top Navigation -->

		<div class="top_nav">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<div class="top_nav_left">Online Computer ShoppingMall</div>
					</div>
					<div class="col-md-6 text-right">
						<div class="top_nav_right">
							<ul class="top_nav_menu">

								<!-- Currency / Language / My Account -->

								<li class="currency">
									<a href="#">
										usd
										<i class="fa fa-angle-down"></i>
									</a>
									<ul class="currency_selection">
										<li><a href="#">cad</a></li>
										<li><a href="#">aud</a></li>
										<li><a href="#">eur</a></li>
										<li><a href="#">gbp</a></li>
									</ul>
								</li>
								<li class="language">
									<a href="#">
										한국어
										<i class="fa fa-angle-down"></i>
									</a>
									<ul class="language_selection">
										<li><a href="#">French</a></li>
										<li><a href="#">Italian</a></li>
										<li><a href="#">German</a></li>
										<li><a href="#">Spanish</a></li>
									</ul>
								</li>
								<li class="account">
									<a href="${pageContext.request.contextPath}/admin/home">
										관리자 님
										<i class="fa fa-angle-down"></i>
									</a>
									<ul class="account_selection" style="width: ">
										<li><a href="${pageContext.request.contextPath}/admin/home"><i class="fa fa-sign-in" aria-hidden="true"></i>Manage</a></li>
										<li><a href="${pageContext.request.contextPath}/logoutForm"><i class="fa fa-sign-out" aria-hidden="true"></i>Logout</a></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Main Navigation -->

		<div class="main_nav_container">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 text-right">
						<div class="logo_container">
							<a href="${pageContext.request.contextPath}/">smart<span>com</span></a>
						</div>
						<nav class="navbar">
							<ul class="navbar_menu">
								<li><a href="${pageContext.request.contextPath}/">home</a></li>
								<li><a href="${pageContext.request.contextPath}/board/mouse/1">shop</a></li>
								<li><a href="#">promotion</a></li>
								<li><a href="#">pages</a></li>
								<li><a href="#">blog</a></li>
								<li><a href="#">contact</a></li>
							</ul>
							<ul class="navbar_user">
								<li><a href="#"><i class="fa fa-search" aria-hidden="true"></i></a></li>
								<li><a href="${pageContext.request.contextPath}/admin/home"><i class="fa fa-user" aria-hidden="true"></i></a></li>
								<li class="checkout">
									<a href="${pageContext.request.contextPath}/user/orderList/1?username=<sec:authentication property='principal.username' />">
										<i class="fa fa-shopping-cart" aria-hidden="true"></i>
										<span id="checkout_items" class="checkout_items"></span>
									</a>
								</li>
							</ul>
							<div class="hamburger_container">
								<i class="fa fa-bars" aria-hidden="true"></i>
							</div>
						</nav>
					</div>
				</div>
			</div>
		</div>

	</header>


<%-- <h1>
	<header class="myHeader">
		<div class="wrapper">
			<h1 class="myH1"><a href="${pageContext.request.contextPath}/">SuperCom</a></h1>
			<nav>
				<ul class="menu">
					<li><a href="${pageContext.request.contextPath}/board/mouse/1">Mouse</a></li>
					<li><a href="${pageContext.request.contextPath}/keyboard">KeyBoard</a></li>
					<li><a href="${pageContext.request.contextPath}/head">Headphone</a></li>
					<li><a href="${pageContext.request.contextPath}/monitor">Monitor</a></li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
					<li><a href="${pageContext.request.contextPath}/logoutForm">logout</a></li>
					<li><a style="padding-left: 0px;" href="${pageContext.request.contextPath}/admin/home"> 관리자 님</a></li>
						
					<li><a style="padding-right: 30px"href="${pageContext.request.contextPath}/join">join</a></li>
				</ul>			
			</nav>
		</div>
	</header>
</h1> --%>
</sec:authorize>


<sec:authorize access="hasRole('ROLE_USER')">
<input type="hidden" id="userID" name="userID" value="<sec:authentication property='principal.username' />">

	<header class="header trans_300">

		<!-- Top Navigation -->

		<div class="top_nav">
			<div class="container">
				<div class="row">
					<div class="col-md-6">
						<div class="top_nav_left">Online Computer ShoppingMall</div>
					</div>
					<div class="col-md-6 text-right">
						<div class="top_nav_right">
							<ul class="top_nav_menu">

								<!-- Currency / Language / My Account -->

								<li class="currency">
									<a href="#">
										usd
										<i class="fa fa-angle-down"></i>
									</a>
									<ul class="currency_selection">
										<li><a href="#">cad</a></li>
										<li><a href="#">aud</a></li>
										<li><a href="#">eur</a></li>
										<li><a href="#">gbp</a></li>
									</ul>
								</li>
								<li class="language">
									<a href="#">
										한국어
										<i class="fa fa-angle-down"></i>
									</a>
									<ul class="language_selection">
										<li><a href="#">French</a></li>
										<li><a href="#">Italian</a></li>
										<li><a href="#">German</a></li>
										<li><a href="#">Spanish</a></li>
									</ul>
								</li>
								<li class="account">
									<a href="${pageContext.request.contextPath}/user/myPage">
										<sec:authentication property="principal.username" />&nbsp;님
										<i class="fa fa-angle-down"></i>
									</a>
									<ul class="account_selection" style="width: ">
										<li><a href="${pageContext.request.contextPath}/user/myPage"><i class="fa fa-home" aria-hidden="true"></i>My Page</a></li>
										<li><a href="${pageContext.request.contextPath}/logoutForm"><i class="fa fa-sign-out" aria-hidden="true"></i>Logout</a></li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Main Navigation -->

		<div class="main_nav_container">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 text-right">
						<div class="logo_container">
							<a href="${pageContext.request.contextPath}/">smart<span>com</span></a>
						</div>
						<nav class="navbar">
							<ul class="navbar_menu">
								<li><a href="${pageContext.request.contextPath}/">home</a></li>
								<li><a href="${pageContext.request.contextPath}/board/mouse/1">shop</a></li>
								<li><a href="#">promotion</a></li>
								<li><a href="#">pages</a></li>
								<li><a href="#">blog</a></li>
								<li><a href="#">contact</a></li>
							</ul>
							<ul class="navbar_user">
								<li><a href="#"><i class="fa fa-search" aria-hidden="true"></i></a></li>
								<li><a href="${pageContext.request.contextPath}/user/myPage"><i class="fa fa-user" aria-hidden="true"></i></a></li>
								<li class="checkout">
									<a href="${pageContext.request.contextPath}/user/orderList/1?username=<sec:authentication property='principal.username' />">
										<i class="fa fa-shopping-cart" aria-hidden="true"></i>
										<span id="checkout_items" class="checkout_items"></span>
									</a>
								</li>
							</ul>
							<div class="hamburger_container">
								<i class="fa fa-bars" aria-hidden="true"></i>
							</div>
						</nav>
					</div>
				</div>
			</div>
		</div>

	</header>


<%-- <h1>
	<header class="myHeader">
		<div class="wrapper">
			<h1 class="myH1"><a href="${pageContext.request.contextPath}/">SuperCom</a></h1>
			<nav>
				<ul class="menu">
					<li><a href="${pageContext.request.contextPath}/board/mouse/1">Mouse</a></li>
					<li><a href="${pageContext.request.contextPath}/keyboard">KeyBoard</a></li>
					<li><a href="${pageContext.request.contextPath}/head">Headphone</a></li>
					<li><a href="${pageContext.request.contextPath}/monitor">Monitor</a></li>
					<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
					<li><a href="${pageContext.request.contextPath}/logoutForm">logout</a></li>
					<li><a style="padding-left: 0px;" href="${pageContext.request.contextPath}/user/myPage">
					<sec:authentication property="principal.username" />님</a></li>
						
					<li><a style="padding-right: 30px"href="${pageContext.request.contextPath}/join">join</a></li>
				</ul>			
			</nav>
		</div>
	</header>
</h1> --%>

</sec:authorize>



</body>
</html>



