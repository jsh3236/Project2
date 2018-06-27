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

<!-- jQuery : 3.2.1 -->
<script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>
<%-- 
<!-- jQuery : 3.3.1 -->
<script src="<c:url value='/js/jQuery/3.3.1/jquery-3.3.1.min.js' />"></script>
 --%>
<!-- bootstrap JS : 3.3.7 -->
<script src="<c:url value='/js/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>

<!-- 성공 팝업창 뜨기 -->
<script>


function deleteBtn(boardNum) {
	 if (confirm("정말 삭제 하시겠습니까?")){ 
		 location.href='${pageContext.request.contextPath}/admin/deleteAction.do/boardNum/'+boardNum+'/page/${pageInfo.page}';
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


</style>

</head>
<body>
	<div><jsp:include page="../include.jsp" flush="false" /></div>
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
								onclick="location.href='${pageContext.request.contextPath}/admin/update/boardNum/${article.boardNum}'"
								style="margin-left: 50px">수정</button>
							<button type="button" id="deleteBtn" class="btn btn-info btn-lg"
								onclick="deleteBtn(${article.boardNum})">삭제
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
