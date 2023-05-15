<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-11
  Time: 오후 5:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>자유게시판</title>
    <link rel="stylesheet" href="/resources/css/index.css">
    <link rel="stylesheet" href="/resources/css/form.css">
    <link rel="stylesheet" href="/resources/css/comment.css">
    <link rel="stylesheet" href="/resources/bootstrap.min.css">
    <script src="/resources/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
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
    <form action="/board/update" method="post" enctype="multipart/form-data" class="form-board">
        <h2>자유게시판</h2>
        ID <input type="text" name="id" id="board-id" class="form-control" value="${board.id}" readonly>

        글쓴이 <input type="text" name="boardWriter" id="board-writer" class="form-control" value="${board.boardWriter}"
                   disabled>
        제목 <input type="text" name="boardTitle" id="board-title" class="form-control" value="${board.boardTitle}"
                  disabled>
        조회수 <input type="text" name="boardHits" id="board-hits" class="form-control" value="${board.boardHits}"
                   disabled>
        게시일자 <input type="text" name="boardCreatedDate" id="board-created-date" class="form-control"
                    value="<fmt:formatDate value="${board.boardCreatedDate}" pattern="yyyy-MM-dd hh:mm"></fmt:formatDate>"
                    disabled> <br>
        내용
        <textarea name="boardContents" id="board-contents" class="form-control" cols="30" rows="10"
                  disabled>${board.boardContents}</textarea>
        <br>
        이미지
        <br>
        <c:if test="${board.fileAttached==1}">
            <c:forEach items="${boardFileList}" var="boardFile">
                <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}" alt="" width="100"
                     height="100">
            </c:forEach>
        </c:if> <br>
        <%--  5.11 여기까지!  --%>
        <div class="button-area">
            <c:if test="${board.boardWriter == sessionScope.loginEmail}">
                <input type="button" value="수정" class="btn btn-dark" onclick="board_update()">
                <input type="button" value="삭제" class="btn btn-danger" onclick="board_delete()">
            </c:if>
            <c:if test="${sessionScope.loginEmail == 'admin'}">
                <input type="button" value="삭제" class="btn btn-danger" onclick="board_delete()">
            </c:if>
            <input type="button" value="목록" class="btn btn-success" onclick="list()">
        </div>
    </form>
    <form class="form-comment">
        <input type="text" id="comment-writer" name="commentWriter" value="${sessionScope.loginEmail}" class="form-control">
        <textarea id="comment-contents" placeholder="내용을 입력하세요" class="form-control" cols="30" rows="5"></textarea>
        <div class="button-area">
            <input type="button" onclick="comment_write()" value="댓글작성" class="btn btn-dark">
        </div>
    </form>
    <div id="comment-list" class="comment-list">
        <c:choose>
            <c:when test="${commentList == null}">
                <h3>작성된 댓글이 없습니다.</h3>
            </c:when>
            <c:otherwise>
                <table>
                    <tr>
<%--                        <th>id</th>--%>
                        <th>작성자</th>
                        <th>작성시간</th>
                        <th></th>
                    </tr>
                    <c:forEach items="${commentList}" var="comment">
                        <tr>
<%--                            <td>${comment.id}</td>--%>
                            <td>${comment.commentWriter}</td>
                            <td>
                                <fmt:formatDate value="${comment.commentCreatedDate}" pattern="yyyy-MM-dd HH:mm"></fmt:formatDate>
                            </td>
                            <td>${comment.commentContents}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</div>
</body>
<script>
    const list = () => {
        const type = '${type}'
        const q = '${q}'
        const page = '${page}'
        location.href = "/board/list?page="+page+"&type="+type+"&q="+q;
    }

    const board_update = () => {
        const id = '${board.id}';
        location.href = "/board/update?id=" + id;
    }

    const board_delete = () => {
        const id = '${board.id}';
        location.href = "/board/delete?id=" + id;

    }

    const comment_write = () => {
        const commentWriter = document.getElementById("comment-writer").value;
        const commentContents = document.getElementById("comment-contents").value;
        const boardId = '${board.id}';
        const result = document.getElementById("comment-list");
        $.ajax({
            type: "post",
            url: "/comment/save",
            data: {

                "commentWriter": commentWriter,
                "commentContents": commentContents,
                "boardId": boardId
            },
            success: function (res) {
                let output = "<table>";
                output += "<tr>";
                output += "<th>id</th>"
                output += "<th>작성자</th>";
                output += "<th>작성시간</th>";
                output += "<th></th>";
                output += "</tr>";
                for(let i in res) {
                    output += "<tr>";
                    output += "<td>" + res[i].id + "</td>";
                    output += "<td>" + res[i].commentWriter + "</td>";
                    output += "<td>" + moment(res[i].commentCreatedDate).format("YYYY-MM-DD HH:mm") + "</td>";
                    output += "<td>" + res[i].commentContents + "</td>";
                }
                output += "</table>"
                result.innerHTML = output;
                document.getElementById("comment-writer").value = "";
                document.getElementById("comment-contents").value = "";

            },
            error: function () {
                alert("어ㅓ.. 왜 안되지?")
            }
        });
    }


</script>
</html>
