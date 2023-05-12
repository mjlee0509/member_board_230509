<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 4:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" href="/resources/css/form.css">
    <link rel="stylesheet" href="/resources/bootstrap.min.css">
    <script src="/resources/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>
<body>
<a href="/">홈으로</a>

<div class="main">
    <form action="/member/login" method="post" class="form-member">
        <h2>로그인</h2>
        <div>
            <label for="member-email">이메일</label>
            <input type="text" name="memberEmail" id="member-email" class="form-control" placeholder="이메일">
            <p id="email-check-result"></p>

            <label for="member-password">비밀번호</label>
            <input type="text" name="memberPassword" id="member-password" class="form-control" placeholder="비밀번호">
            <p id="pass-check-result"></p>
        </div>
        <div>
            <input type="submit" class="btn btn-dark" value="로그인">
        </div>

    </form>
    >
</div>
</body>
</html>
