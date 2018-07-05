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
<title>order complete</title>

<!-- jQuery : 3.2.1 -->
<script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>

<!-- myCss -->
<link rel="stylesheet" href="<c:url value='/js/custom/myCompl.css' />">

<!-- bootstrap JS : 3.3.7 -->
<script src="<c:url value='/js/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>

</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<br><br>
	<section id="listForm" style="width: 700px; margin: auto;">
		<div align="center">
			<h2>구매 목록</h2>
		</div>
		<br>
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
					map.key : ${map.key}
					<tr style="border-bottom: 1px solid #369;">
								
						<td style="width: 200px;">
							<c:set var="setNum" value="${(setNum + map.value)}" />
							<a href="../boardDetail.do/boardNum/${map.key}/page/${pageInfo.page}">
													<img src="<c:url value='/image/${complArticleList[fn:length(complArticleList)-setNum].boardFile}' />" 
													width=50 height=50 style="padding: 30px" /> 
							</a>
						</td>
						<td colspan="4">
							<table>
								<c:forEach var="article" items="${complArticleList}" varStatus="st">
									<c:if test="${article.paymentNum eq map.key}">
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
			
			<!-- 페이징(paging) -->
			<section id="pageList">

				<ul class="pagination">

					<c:choose>
						<c:when test="${pageInfo.page <= 1}">
							<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->
							<li><a href="../orderList/1?username=${orderArticleList[0].username}">이전</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="../orderList/${pageInfo.page - 1}?username=${orderArticleList[0].username}">이전</a></li>
						</c:otherwise>
					</c:choose>

					<c:forEach var="a" begin="${pageInfo.startPage}"
						end="${pageInfo.endPage}">

						<c:choose>
							<c:when test="${a == pageInfo.page}">
								<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->
								<li class="active"><a href="../orderList/${a}?username=${orderArticleList[0].username}">${a}</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="../orderList/${a}?username=${orderArticleList[0].username}">${a}</a></li>
							</c:otherwise>
						</c:choose>

					</c:forEach>

					<c:choose>
						<c:when test="${pageInfo.page >= pageInfo.maxPage}">
							<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨.
                                                  링크 교정 => page=${pageInfo.page} -->
							<li><a href="../orderList/${pageInfo.page}?username=${orderArticleList[0].username}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="../orderList/${pageInfo.page + 1}?username=${orderArticleList[0].username}">다음</a></li>
						</c:otherwise>
					</c:choose>

				</ul>

			</section>
			<!-- 페이징 끝 -->
			
			<br>
			<div align="center">
				<button class="whiteBtn" type="button" onclick="location.href='${pageContext.request.contextPath}/'"><span>돌아가기</span></button>
			</div>
			
		</section>
	
</body>
</html>