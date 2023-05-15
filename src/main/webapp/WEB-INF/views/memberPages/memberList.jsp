<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-15
  Time: 오전 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>회원목록</title>
    <link rel="stylesheet" href="/resources/css/index.css">
    <link rel="stylesheet" href="/resources/bootstrap.min.css">
    <script src="/resources/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
</head>
<body>
<%@include file="../components/navAdmin.jsp" %>
<div class="main">
    <h2>회원목록</h2>
    <table>
        <tr>
            <th>ID</th>
            <th></th>
            <th>이메일</th>
            <th>비밀번호</th>
            <th>이름</th>
            <th>연락처</th>
            <th>비고</th>
        </tr>
        <c:forEach items="${memberList}" var="member">
            <tr>
                <td id="member-id">${member.id}</td>
                <c:choose>
                    <c:when test="${member.memberProfile == 1}">
                        <td><i class="bi bi-image-fill" style="color: #ff0053"></i></td>
                    </c:when>
                    <c:otherwise>
                        <td><i class="bi bi-image" style="color: #afafaf"></i></td>
                    </c:otherwise>
                </c:choose>
                <td>${member.memberEmail}</td>
                <td>${member.memberPassword}</td>
                <td>${member.memberName}</td>
                <td>${member.memberMobile}</td>
                <td>
                    <input type="button" onclick="member_delete('${member.id}')" class="btn btn-danger" value="삭제">
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
<script>
    const member_delete = (id) => {
        location.href = "/member/delete?id="+id;
    }
</script>
</html>
