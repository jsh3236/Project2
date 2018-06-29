<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko-kr">
<head>
<title>Home</title>


<!-- jQuery : 3.2.1 -->
<script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>

<!-- bootstrap JS : 3.3.7 -->
<script src="<c:url value='/js/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>

<!-- 성공 팝업창 뜨기 -->
<script>


function deleteBtn(boardNum) {
	 if (confirm("정말 삭제 하시겠습니까?")){ 
		 location.href='${pageContext.request.contextPath}/admin/deleteAction.do/boardNum/'+orderNum+'/page/${pageInfo.page}';
		}else{ 
			return; 
		} 
 	
	   
}; // deleteBtn 


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

.mytable { border-collapse:collapse; width: 1000px; text-align: center;}  
.mytable td { border: none; }
.mytable th { border: none; border-bottom: 3px solid #369; border-top: 1px solid #369; }


</style>

</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<br>
	<div style="padding-left: 30px">
			총 게시글 수 : ${pageInfo.listCount}<br> 현재 페이지 : ${pageInfo.page}<br>
			총 페이지 : ${pageInfo.maxPage}<br> 시작 페이지 : ${pageInfo.startPage}<br>
			끝 페이지 : ${pageInfo.endPage}
	</div>
	<!-- 장바구니 리스트 시작 -->
	<section id="listForm" style="width: 1000px; margin: auto;">
		<c:if test="${not empty orderArticleList && pageInfo.listCount > 0}">
			<!-- 장바구니 부분 시작 -->
			<table id="board_tbl" class="mytable">
				<tr style="height: 50px; text-align: center; ">
					<th>
						선택
					</th>
					<th>
					 	이미지
					</th>
					<th>
					 	상품명
					</th>
					<th>
						옵션
					</th>
					<th>
						수량
					</th>
					<th>
						가격
					</th>
					<th>
						합계
					</th>
				</tr>
			<c:forEach items="${boardNumMap}" var="map" varStatus="mapSt">
		<%-- 		<c:set var="setNum" value="${article.boardNum}" /> <br> --%>
				<tr style="border-bottom: 1px solid #369;">
					<td rowspan="${map.value+2}">
						<input type="checkbox" id="checkBox" name="checkBox" />
					</td>
							
					<%-- <c:if test="${boardNumMap.get(article.boardNum)}" /> --%>
					<td rowspan="${map.value+2}">
						<c:set var="setNum" value="${(setNum + map.value)}" />
						<a href="../boardDetail.do/boardNum/${map.key}/page/${pageInfo.page}">
												<img src="<c:url value='/image/${orderArticleList[fn:length(orderArticleList)-setNum].boardFile}' />" 
												width=100 height=100 style="padding: 30px" /> 
						</a>
					</td>
						<tr>
						</tr>
						<c:forEach var="article" items="${orderArticleList}" varStatus="st">
							<c:if test="${article.boardNum eq map.key}">
								<tr valign="top" >
									<td>	
										${article.boardSubject}
									</td>
									<td>
										${article.orderOption}
									</td>
									<td>	
										<input type="number" value="${article.orderCount}" id="orderCount" name="orderCount" min=1 style="height: 25px;	 width: 50px;"/>
										<button type="button" onclick="location.href='${pageContext.request.contextPath}/admin/update/boardNum/${article.boardNum}'"">수정</button>
											<%-- <button type="button" id="deleteBtn" onclick="deleteBtn(${article.boardNum})">삭제</button> --%>
										
									</td>
									<td>
										<fmt:formatNumber type="number" value="${article.boardPrice}"/> 원 &nbsp;
									</td>
									<td>
										<fmt:formatNumber type="number" value="125650"/> 원 &nbsp;
									</td>
								</tr>
							</c:if>
						</c:forEach>
				</c:forEach>
			</table>
			<!-- 장바구니 부분 끝 -->
			
			
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

		</c:if>

		<!-- 상품이 없을 경우 -->
		<c:if test="${empty orderArticleList || pageInfo.listCount==0}">
			<section id="emptyArea">등록된 글이 없습니다.</section>
		</c:if>


	</section>
	<!-- 장바구니 리스트 끝 -->

</body>
</html>
