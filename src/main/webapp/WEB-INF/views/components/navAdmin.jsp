<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 1:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="nav-admin">
    <a href="/member/">홈</a>
    <a href="/board/list">게시판</a>
    <a href="/member/list">회원목록</a>
    <div class="right">
        <%--        <a href="/member/detail?id=${id}">${sessionScope.loginEmail}님 환영합니다!</a>--%>
        <a href="/member/detail">관리자 페이지입니다</a>
        <a href="/member/logout">로그아웃</a>
        <%--        <input type="button" class="button-black mypage-button" onclick="sign_up()" value="회원가입">--%>
    </div>
</div>
