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

<!-- bootstrap CSS : 3.3.7 -->
<link rel="stylesheet"
	href="<c:url value='/js/bootstrap/3.3.7/css/bootstrap.min.css' />">

<!-- jQuery : 3.2.1 -->
<script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>
<%-- 
<!-- jQuery : 3.3.1 -->
<script src="<c:url value='/js/jQuery/3.3.1/jquery-3.3.1.min.js' />"></script>
 --%>
<!-- bootstrap JS : 3.3.7 -->
<script src="<c:url value='/js/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>

<!-- 천단위 가격표시 -->
<script>
/* window.onLoad=function numberFormat() {
	   alert('1');
	   var id, num;
	   
	   id = "pricedetail";
// 	   num = document.getElementById(id)[board].innerHTML.trim();
//	   num = numberWithCommas(num);
//	   document.all(id).innerHTML = num+ " 원"; 
	   num = document.all[id].innerHTML.trim();
	   num = numberWithCommas(num);
	   document.all[id].innerHTML = num+ " 원";
	   alert('2');
	 } //

	 window.onLoad=function numberWithCommas(x) {
	     x = x.toString();
	     var pattern = /(-?\d+)(\d{3})/;
	     while (pattern.test(x))
	         x = x.replace(pattern, "$1,$2");
	     return x;
	 } */
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


</style>

</head>
<body onload="numberFormat()">
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<!-- 인자들 -->
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<div style="padding-left: 30px">
			총 게시글 수 : ${pageInfo.listCount}<br> 현재 페이지 : ${pageInfo.page}<br>
			총 페이지 : ${pageInfo.maxPage}<br> 시작 페이지 : ${pageInfo.startPage}<br>
			끝 페이지 : ${pageInfo.endPage}
		</div>
		<!-- 상품 올리기 -->
		<button type="button" class="btn btn-info btn-lg" style="padding-left: 30px"
			onclick="location.href='${pageContext.request.contextPath}/admin/mouseBoardwrite'">상품
			올리기</button>

		<!-- 		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog">

				Modal content
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Modal Header</h4>
					</div>
					<div class="modal-body">
						<p>Some text in the modal.</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
 -->
		</div>
		</div>
	</sec:authorize>
	<!-- 게시글정보 보기(팝업) 끝 -->


	<br>

	<!-- 게시판 리스트 시작 -->
	<section id="listForm" style="width: 700px; margin: auto;">

		<c:if test="${not empty articleList && pageInfo.listCount > 0}">

			<!-- 게시글 부분 시작 -->
			<table id="board_tbl">

				<c:forEach var="article" items="${articleList}" varStatus="st">
					<c:if test="${(st.count + (pageInfo.page-1)*10)%2 eq 1 }">
						<tr>
					</c:if>
					<td style="padding-right: 200px; padding-bottom: 150px"><c:choose>
							<c:when test="${article.boardReLev != 0}">
								<c:forEach var="a" begin="0" end="${article.boardReLev * 2}"
									step="1" varStatus="st">
	                                        &nbsp;
	                                    </c:forEach>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose> <a
						href="../boardDetail.do/boardNum/${article.boardNum}/page/${pageInfo.page}">
							<img src="<c:url value='/image/${article.boardFile}' />"
							width=250 height=250 style="padding: 30px" />
					</a>
						<p>${article.boardSubject}</p>
						<p id=pricedetail>
						<fmt:formatNumber type="number" value="${article.boardPrice}"/> 원</p> 
						<sec:authorize
							access="hasRole('ROLE_ADMIN')">
							<button type="button" class="btn btn-info btn-lg"
								onclick="location.href='${pageContext.request.contextPath}/admin/mouseBoardwrite'"
								style="margin-left: 50px">수정</button>
							<button type="button" class="btn btn-info btn-lg"
								onclick="location.href='${pageContext.request.contextPath}/admin/mouseBoardwrite'">삭제
							</button>
						</sec:authorize></td>
					<c:if test="${(st.count + (pageInfo.page-1)*10)%2 eq 0}">
						</tr>
					</c:if>
				</c:forEach>

			</table>
			<!-- 게시글 부분 끝 -->

			<!-- 페이징(paging) -->
			<section id="pageList">

				<ul class="pagination">

					<c:choose>
						<c:when test="${pageInfo.page <= 1}">
							<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->
							<li><a href="../mouse/1">이전</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="../mouse/${pageInfo.page - 1}">이전</a></li>
						</c:otherwise>
					</c:choose>

					<c:forEach var="a" begin="${pageInfo.startPage}"
						end="${pageInfo.endPage}">

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

					<c:choose>
						<c:when test="${pageInfo.page >= pageInfo.maxPage}">
							<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨.
                                                  링크 교정 => page=${pageInfo.page} -->
							<li><a href="../mouse/${pageInfo.page}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="../mouse/${pageInfo.page + 1}">다음</a></li>
						</c:otherwise>
					</c:choose>

				</ul>

			</section>
			<!-- 페이징 끝 -->

		</c:if>

		<!-- 등록글 없을 경우 -->
		<c:if test="${empty articleList || pageInfo.listCount==0}">
			<section id="emptyArea">등록된 글이 없습니다.</section>
		</c:if>


	</section>
	<!-- 게시판 리스트 끝 -->

</body>
</html>
