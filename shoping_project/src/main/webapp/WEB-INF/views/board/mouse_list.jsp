<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVC 게시판</title>
 
    <!-- bootstrap CSS : 3.3.7 -->
    <link rel="stylesheet"
          href="<c:url value='/js/bootstrap/3.3.7/css/bootstrap.min.css/' />">
   
    <!-- jQuery : 3.2.1 -->
    <script src="<c:url value='/js/jQuery/3.2.1/jquery-3.2.1.min.js' />"></script>
   
    <!-- bootstrap JS : 3.3.7 -->
    <script src="<c:url value='/js/bootstrap/3.3.7/js/bootstrap.min.js' />"></script>
   
    <style type="text/css">
    /* 등록된 글이 없을 경우, 페이징 처리 */
    #emptyArea, #pageList  
    {
        margin: auto;
        text-align: center;
    }
    </style>
</head>
 
<body>
 
    <!-- 인자들 -->
    <div>
        총 게시글 수 : ${pageInfo.listCount}<br>
        현재 페이지 : ${pageInfo.page}<br>
        총 페이지 : ${pageInfo.maxPage}<br>
        시작 페이지 : ${pageInfo.startPage}<br>
        끝 페이지 : ${pageInfo.endPage}
    </div>
   
    <!-- 게시글정보 보기(팝업) 시작 -->
      <button type="button" class="btn btn-info btn-lg"
              data-toggle="modal" data-target="#myModal">Open Modal</button>
   
    <div class="modal fade" id="myModal" role="dialog">
      <div class="modal-dialog">
     
        <!-- Modal content-->
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
       
      </div>
    </div>
    <!-- 게시글정보 보기(팝업) 끝 -->
   
    <h3 align="center">
        글 목록   &nbsp;<a href="boardWriteForm.bo">게시판글쓰기</a>
    </h3>
    <br>
   
    <!-- 게시판 리스트 시작 -->
    <section id="listForm" style="width:800px; margin:auto;">
       
        <c:if test="${not empty articleList && pageInfo.listCount > 0}">
       
            <!-- 게시글 부분 시작 -->
            <table id="board_tbl" class="table table-striped table-hover">
           
                <tr id="tr_top">
                    <td>번호</td>
                    <td>글번호</td>
                    <td>제목</td>
                    <td>작성자</td>
                    <td>날짜</td>
                    <td>조회수</td>
                </tr>
   
                <c:forEach var="article" items="${articleList}" varStatus="st">
                   
                    <tr>
                        <td>${st.count + (pageInfo.page-1)*10}</td>
                        <td>${article.boardNum}</td>
       
                        <td>
                            <c:choose>
                                <c:when test="${article.boardReLev != 0}">
                                    <c:forEach var="a"
                                               begin="0"
                                               end="${article.boardReLev * 2}"
                                               step="1"
                                               varStatus="st">
                                        &nbsp;
                                    </c:forEach>
                                        ▶
                                </c:when>
                                <c:otherwise>
                                    ▶
                                </c:otherwise>
                            </c:choose>
                           
                            <a href="boardDetail.bo?boardnum=${article.boardNum}&page=${pageInfo.page}">
                                ${article.boardSubject}
                            </a>
                        </td>
       
                        <td>${article.boardName}</td>
                        <td>${article.boardDate}</td>
                        <td>${article.boardReadCount}</td>
                    </tr>
                   
                </c:forEach>
                   
            </table>
            <!-- 게시글 부분 끝 -->
       
            <!-- 페이징(paging) -->
            <section id="pageList">
               
                <ul class="pagination">
               
                    <c:choose>
                        <c:when test="${pageInfo.page <= 1}">
                            <!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->
                            <li><a href="boardList.bo?page=1">이전</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="boardList.bo?page=${pageInfo.page - 1}">이전</a></li>
                        </c:otherwise> 
                    </c:choose>
                   
                    <c:forEach var="a"
                               begin="${pageInfo.startPage}"
                               end="${pageInfo.endPage}">
   
                        <c:choose>
                            <c:when test="${a == pageInfo.page}">
                                <!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨. -->    
                                <li class="active"><a href="boardList.bo?page=${a}">${a}</a></li>
                            </c:when>  
                            <c:otherwise>
                                <li><a href="boardList.bo?page=${a}">${a}</a></li>
                            </c:otherwise>
                        </c:choose>
                       
                    </c:forEach>
           
                    <c:choose>
                        <c:when test="${pageInfo.page >= pageInfo.maxPage}">
                             <!-- 주의) 이 부분에서 bootstrap 페이징 적용시 불가피하게 <a> 기입. <a>없으면 적용 안됨.
                                                  링크 교정 => page=${pageInfo.page} -->
                            <li><a href="boardList.bo?page=${pageInfo.page}">다음</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="boardList.bo?page=${pageInfo.page + 1}">다음</a></li>
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