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

// 전체선택 함수
var check = false;
function checkAll(){
	var chk = document.getElementsByName("checkBox");
	if(check == false){
		check = true;
		for(var i=0; i<chk.length;i++){                                                                    
		chk[i].checked = true;     //모두 체크
		}
	}else{
		check = false;
		for(var i=0; i<chk.length;i++){                                                                    
		chk[i].checked = false;     //모두 해제
		}
	}
}




//삭제 함수
function deleteBtn(orderNum) {
	 if (confirm("정말 삭제 하시겠습니까?")){  //물어보기
		 location.href='${pageContext.request.contextPath}/user/deleteAction.do/orderNum/'+orderNum+'/page/${pageInfo.page}';
		}else{ 
			return; 
		} 
	   
}; // deleteBtn 
	
function updateBtn(orderNum) {
	$(document).ready( function(){
		 if (confirm($("#"+orderNum).val()+"개로 수정 하시겠습니까?")){  // 물어보기
		 	location.href='${pageContext.request.contextPath}/user/update/ordercount/'+orderNum+'/'+$("#"+orderNum).val()+'/${pageInfo.page }';
		 } else {
			 location.reload();
			 return;
		 }
	});
};// updateBtn
	
	
// 전체 상품 구매
function allOrder() {
	var chk = document.getElementsByName("checkBox"); // 체크박스객체를 담는다
	var checkList = new Array(); //체크된 체크박스의 모든 value 값을 담는다

	for(var i=0; i<chk.length;  i++){
			checkList.push(chk[i].value);
	}

	location.href='${pageContext.request.contextPath}/user/orderPage/'+checkList+"/${orderArticleList[0].username}";
	
}
// 선택상품 구매
function selectOrder() {
	var chk = document.getElementsByName("checkBox"); // 체크박스객체를 담는다
	var checkList = new Array(); //체크된 체크박스의 모든 value 값을 담는다


	for(var i=0; i<chk.length;  i++){
		if(chk[i].checked == true){  //체크가 되어있는 값 구분
			checkList.push(chk[i].value);
		}
	}

	location.href='${pageContext.request.contextPath}/user/orderPage/'+checkList+"/${orderArticleList[0].username}";
	
}


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

a:active,
a:HOVER,
a:VISITED,
a:LINK
{
	color: black;
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

.mytable { border-collapse:collapse; width: 1200px; text-align: center; }  
.mytable td { border: none; }
.mytable th { border: none; border-bottom: 3px solid #369; border-top: 1px solid #369; }

.redfont {
	font-size: 18px;
	color: red;
}

.whiteBtn {
  display: inline-block;
  border-radius: 4px;
  background-color: #51A4CC;
  border: none;
  color: white;
  text-align: center;
  font-size: 15px;
  font-weight:800;
  padding: 20px;
  width: 180px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
}

.whiteBtn span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.whiteBtn span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.whiteBtn:hover span {
  padding-right: 25px;
}

.whiteBtn:hover span:after {
  opacity: 1;
  right: 0;
}

</style>

</head>
<body>
	<c:set var="total" value="0" />
	<c:set var="totalstotal" value="0" />
	<div><jsp:include page="../include.jsp" flush="false" /></div>
	<br>
	<!-- 장바구니 리스트 시작 -->
	<section id="listForm" style="width: 1200px; margin: auto;">
		<c:if test="${not empty orderArticleList && pageInfo.listCount > 0}">
			<!-- 장바구니 부분 시작 -->
			<table id="board_tbl" class="mytable">
				<tr style="height: 50px; text-align: center; ">
					<th style="width: 70px;">
						<a style="text-decoration: none;" href="javascript:checkAll();">전체선택</a>
					</th>
					<th style="width: 200px;">
					 	이미지
					</th>
					<th style="width: 310px;">
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
						<button type="button" id="deleteBtn" >전체삭제</button>
					</th>
					<th style="width: 150px;">
						합계
					</th>
				</tr>
			<c:forEach items="${boardNumMap}" var="map" varStatus="mapSt">
		<%-- 		<c:set var="setNum" value="${article.boardNum}" /> <br> --%>
				<tr style="border-bottom: 1px solid #369;">
					<td  style="width: 70px;">
						<input type="checkbox" id="checkBox" name="checkBox" value="${map.key}" />
					</td>
							
					<%-- <c:if test="${boardNumMap.get(article.boardNum)}" /> --%>
					<td style="width: 200px;">
						<c:set var="setNum" value="${(setNum + map.value)}" />
						<a href="../boardDetail.do/boardNum/${map.key}/page/${pageInfo.page}">
												<img src="<c:url value='/image/${orderArticleList[fn:length(orderArticleList)-setNum].boardFile}' />" 
												width=100 height=100 style="padding: 30px" /> 
						</a>
					</td>
					<td colspan="5">
						<table>
							<c:forEach var="article" items="${orderArticleList}" varStatus="st">
								<c:if test="${article.boardNum eq map.key}">
								 	<c:set var="boardTotal" value="${(article.boardPrice*article.orderCount)}" />
									<c:set var="total" value="${total+boardTotal}" /> 
									<tr align="center">
										<td style="width: 300px;">	
											${article.boardSubject}
										</td>
										<td style="width: 100px;">
											${article.orderOption}
										</td>
										<td style="width: 100px;">	
											<input type="number" value="${article.orderCount}" id="${article.orderNum}" name="${article.orderNum}" min=1 style="height: 20px;	 width: 40px;"/>
											<%-- <button type="button" onclick="location.href='${pageContext.request.contextPath}/user/update/ordercount/${article.orderNum}/${orderCount}/${pageInfo.page }'"">수정</button> --%>
												<button type="button" onclick="updateBtn(${article.orderNum});">수정</button>
										</td>
										<td style="width: 150px;">
											<fmt:formatNumber type="number" value="${article.boardPrice}"/> 원 &nbsp;
										</td>
										<td style="width: 150px;">
											<button type="button" id="deleteBtn" onclick="deleteBtn(${article.orderNum});">x</button>
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
				<td colspan="7" style="text-align: right;padding-right: 65px;">
					합계
				</td>
				<td style="text-align: center; margin-right: ">
					<strong class="redfont"><fmt:formatNumber type="number" value="${totalstotal}"/></strong> 원 
				</td>
				<td>
				</td>
			</tr>
			
		</table>
			<!-- 장바구니 부분 끝 -->
			
			<div align="right">
				<button class="whiteBtn" type="button" onclick="allOrder();"><span>전체상품구매</span></button>
				<button class="whiteBtn" type="button" onclick="selectOrder();"><span>선택상품구매</span></button>
				<button class="whiteBtn" type="button" onclick="history.go(-1);"><span>쇼핑계속하기</span></button>
			</div>
			
			
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
