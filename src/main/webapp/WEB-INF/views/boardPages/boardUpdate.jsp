<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-11
  Time: 오후 9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>게시물 수정</title>
    <link rel="stylesheet" href="/resources/css/index.css">
    <link rel="stylesheet" href="/resources/css/form.css">
    <link rel="stylesheet" href="/resources/bootstrap.min.css">
    <script src="/resources/bootstrap.bundle.min.js"></script>
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
    <form action="/board/update" method="post" enctype="multipart/form-data" class="form-board" id="save-form">
        <h2>자유게시판</h2>
        ID <input type="text" name="id" id="board-id" class="form-control" value="${board.id}" readonly>

        글쓴이 <input type="text" name="boardWriter" id="board-writer" class="form-control" value="${board.boardWriter}"
                   disabled>
        제목 <input type="text" name="boardTitle" id="board-title" class="form-control" value="${board.boardTitle}">
        조회수 <input type="text" name="boardHits" id="board-hits" class="form-control" value="${board.boardHits}"
                   disabled>
        게시일자 <input type="text" name="boardCreatedDate" id="board-created-date" class="form-control"
                    value="<fmt:formatDate value="${board.boardCreatedDate}" pattern="yyyy-MM-dd hh:mm"></fmt:formatDate>"
                    disabled> <br>
        내용
        <textarea name="boardContents" id="board-contents" class="form-control" cols="30"
                  rows="10">${board.boardContents}</textarea>
        <div class="button-area">
            <input type="submit" class="btn btn-success" value="수정">
        </div>
</div>
</body>
</html>
