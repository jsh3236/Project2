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
<title>admin complete</title>

<!-- jQuery : 3.2.1 -->
<script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>

<!-- myCss -->
<link rel="stylesheet" href="<c:url value='/js/custom/myCompl.css' />">

<!-- bootstrap JS : 3.3.7 -->
<script src="<c:url value='/js/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>
<script>

function openDetail(num){  
	//form 이름
	var frm = "detailform"+num;
	
	//새 창 크기
	cw=700;
	ch=250;

	//스크린의 크기
	sw=screen.availWidth;
	sh=screen.availHeight;
	
	//열 창의 포지션
	px=(sw-cw)/2;
	py=(sh-ch)/2;
	
    window.open("detail", "detailWindow",'left='+px+',top='+py+',width='+cw+',height='+ch+', toolbar=no, menubar=no, scrollbars=no,titlebar = no, resizable=no' );
    document.getElementById(frm).submit();
}

function progress(complNum) {
	
	document.getElementById('progressBtn'+complNum).style.display = 'none';
	
	location.href='${pageContext.request.contextPath}/admin/progressAction.do/'+complNum;
	
}

</script>

</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<br><br><br><br><br><br>
	
	<!-- 페이지 확인(팝업) -->
	<div style="padding-left: 30px">
		총 게시글 수 : ${pageInfo.listCount}<br> 현재 페이지 : ${pageInfo.page}<br>
		총 페이지 : ${pageInfo.maxPage}<br> 시작 페이지 : ${pageInfo.startPage}<br>
		끝 페이지 : ${pageInfo.endPage}
	</div>
	
	<c:set var="count" value="-1" /> 

	<section id="listForm" style="width: 1000px; margin: auto;">
		<div align="center">
			<h2>구매 목록</h2>
		</div>
		<br>
			<table id="payment_tbl" class="mytable">
				<tr style="height: 35px; text-align: center; ">
					<th style="width: 300px;">
					 	주문일(결제번호)
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
						진행상태
					</th>
					<th style="width: 150px;">
						합계
					</th>
					<th style="width: 150px;">
						구매자
					</th>
					
				</tr>
				<c:forEach items="${boardNumMap}" var="map" varStatus="mapSt">
					<tr style="border-bottom: 1px solid #369;">
					
						<td style="width: 310px;">
							${datefront[mapSt.index]}<br>${dateback[mapSt.index]}(${complArticleList[mapSt.index].complNum})
						</td>
						
						<td colspan="5">
							<table>
								<c:forEach var="article" items="${complArticleList}" varStatus="st">
									<c:if test="${article.paymentNum eq map.key}">
									 	<c:set var="boardTotal" value="${(article.boardPrice*article.orderCount)}" />
										<c:set var="total" value="${total+boardTotal}" /> 
										<c:set var="count" value="${count+1}" />
										<tr align="center" style="height: 50px">
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
											<td style="width: 150px;">
												 ${article.complProgress} <br>
												 <c:if test="${article.complProgress eq '결제완료'}">
												 	<input type="button" id="progressBtn${article.complNum}" name="progressBtn${article.complNum}" onclick="progress(${article.complNum});" value="다음단계" /> 
												 </c:if>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</table>
						</td>
						<!-- 상품 금액 -->
						<td style="width: 150px;">
							<fmt:formatNumber type="number" value="${total}" /> 원 
							<c:set var="totalstotal" value="${totalstotal+total}" />
							<c:set var="total" value="0" />
						</td>
						
						<td style="width: 150px;">
							
							${userID[mapSt.index]}<br>
							
							<form action="${pageContext.request.contextPath}/user/complDetail/${paymentNum[mapSt.index]}"
								method="post" name="detailform${count}" id="detailform${count}" target="detailWindow">
									
								<input type="button" id="detailBtn" name="detailBtn" onclick="openDetail(${count});" value="상세정보" /> 
								
							</form>
						</td>
						
						
		
					</tr>
					
					
				</c:forEach>
				
				
			</table>
			
			<!-- 페이징(paging) -->
			<section id="pageList">

				<ul class="pagination">
					<c:choose>
						<c:when test="${pageInfo.page <= 1}">
							<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->
							<li><a href="${pageContext.request.contextPath}/admin/paymentComplete/1">이전</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${pageContext.request.contextPath}/admin/paymentComplete/${pageInfo.page - 1}">이전</a></li>
						</c:otherwise>
					</c:choose>

					<c:forEach var="a" begin="${pageInfo.startPage}"
						end="${pageInfo.endPage}">

						<c:choose>
							<c:when test="${a == pageInfo.page}">
								<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->
								<li class="active"><a href="${pageContext.request.contextPath}/admin/paymentComplete/${a}">${a}</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="${pageContext.request.contextPath}/admin/paymentComplete/${a}">${a}</a></li>
							</c:otherwise>
						</c:choose>

					</c:forEach>

					<c:choose>
						<c:when test="${pageInfo.page >= pageInfo.maxPage}">
							<!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨.
                                                  링크 교정 => page=${pageInfo.page} -->
							<li><a href="${pageContext.request.contextPath}/admin/paymentComplete/${pageInfo.page}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="${pageContext.request.contextPath}/admin/paymentComplete/${pageInfo.page + 1}">다음</a></li>
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