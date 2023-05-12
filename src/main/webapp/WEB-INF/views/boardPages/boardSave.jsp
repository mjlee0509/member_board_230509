<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-11
  Time: 오전 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/form.css">
    <link rel="stylesheet" href="/resources/css/index.css">
    <link rel="stylesheet" href="/resources/bootstrap.min.css">
    <script src="/resources/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@include file="../components/navLogin.jsp" %>
<div class="main">
    <form action="/board/save" method="post" enctype="multipart/form-data" class="form-board">
        <h2>글쓰기</h2>
        <input type="text" name="boardWriter" id="board-writer" class="form-control" value="${sessionScope.loginEmail}"
               readonly> <br>
        <input type="text" name="boardTitle" id="board-title" class="form-control" placeholder="제목"> <br>
        <textarea type="text" name="boardContents" id="board-contents" class="form-control"
                  placeholder="내용" cols="30" rows="10"></textarea>

        <img id="board-file-box" src="#" alt="" width="100" height="100" style="border: 1px dashed #c2c1c1; border-radius: 5px" multiple type="file"><br>
        <input type="file" name="boardFile" class="btn-light"
               accept=".*" onchange="preview()" id="board-file-save" multiple>
        <div class="button-area">
            <input type="submit" class="button-black" value="업로드">
        </div>

    </form>
</div>

</body>
<script>
    const preview = () => {
        const preview = new FileReader();
        preview.onload = function (e) {
            document.getElementById("board-file-box").src = e.target.result;
        }
        preview.readAsDataURL(document.getElementById("board-file-save").files[0])
    };
</script>
</html>
