<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-11
  Time: 오후 1:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>게시판</title>
    <link rel="stylesheet" href="/resources/css/form.css">
    <link rel="stylesheet" href="/resources/css/index.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>
<body>
<c:choose>
    <c:when test="${sessionScope.loginEmail == 'admin'}">
        <%@include file="../components/navAdmin.jsp" %>
    </c:when>
    <c:otherwise>
        <%@include file="../components/navLogin.jsp" %>
    </c:otherwise>
</c:choose>
<div class="main">
    <%--    검색창    --%>
    <div class="container" id="search-area">
        <form action="/board/list" method="get">
            <select name="type">
                <option value="boardTitle">제목</option>
                <option value="boardWriter">작성자</option>
                <option value="boardContents">내용</option>
            </select>
            <input type="text" name="q" placeholder="검색어">
            <input type="submit" value="검색">
        </form>
    </div>

    <%--    리스트     --%>
    <div class="container" id="list">
        <h2>자유게시판</h2>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th></th>
                <th>제목</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>작성일자</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${boardList}" var="board">
                <tr>
                    <td>${board.id}</td>
                    <c:choose>
                        <c:when test="${board.fileAttached == 1}">
                            <td><i class="bi bi-file-earmark-check-fill" style="color: #ff0053"></i></td>
                        </c:when>
                        <c:otherwise>
                            <td><i class="bi bi-file-earmark" style="color: #afafaf"></i></td>
                        </c:otherwise>
                    </c:choose>
                    <td>
                        <a href="/board?id=${board.id}&page=${paging.page}&q=${q}&type=${type}">${board.boardTitle}</a>
                    </td>
                    <td>${board.boardWriter}</td>
                    <td>${board.boardHits}</td>
                    <td><fmt:formatDate value="${board.boardCreatedDate}"
                                        pattern="yyyy-MM-dd hh:mm"></fmt:formatDate></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <%--    자, 여기서부터 페이지 리스트다    --%>
    <div class="container">
        <ul class="">
            <%--1. [이전] 버튼 --%>
            <c:choose>
                <%--1-1. 현재 페이지가 1일 경우 [이전] 리스트는 글자만 보여준다--%>
                <c:when test="${paging.page<=1}">
                    <li class="page-item disabled">
                        <a class="page-link">[이전]</a>
                    </li>
                </c:when>

                <%--1-2. 그렇지 않은 경우 현재 페이지보다 1 전의 페이지 요청--%>
                <c:otherwise>
                    <li>
                        <a class="page-link" href="/board/list?page=${paging.page-1}&q=${q}&type=${type}">[이전[</a>
                    </li>
                </c:otherwise>
            </c:choose>

            <%-- 2. [1 2 3 4 5 ... ]; 반복문 처리 필요 --%>
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                <%-- 2-1. 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보임 --%>
                <c:choose>
                    <c:when test="${i eq paging.page}">
                        <li class="page-item-active">
                            <a class="page-ling">${i}</a>
                        </li>
                    </c:when>
                    <%-- 2-2. 아니면 링크 처리--%>
                    <c:otherwise>
                        <li class="page-item-active">
                            <a class="page-link" href="/board/list?page=${i}&q=${q}&type=${type}">${i}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <%-- 3. [다음] 버튼 --%>
            <c:choose>
                <c:when test="${paging.page>=paging.maxPage}">
                    <li class="page-item disabled">
                        <a class="page-link">[다음]</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link" href="/board/list?page=${paging.page+1}&q=${q}&type=${type}">[다음]</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</div>
</body>
<script>
</script>
</html>
