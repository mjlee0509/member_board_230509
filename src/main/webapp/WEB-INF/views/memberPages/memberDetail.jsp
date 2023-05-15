<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-10
  Time: 오후 4:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/form.css">
    <link rel="stylesheet" href="/resources/css/index.css">
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
    <form action="/member/update" method="get">
        <h2></h2>
        <div class="img-area">
            <%--            <c:if test="${member.memberProfile == 1}">--%>
            <img src="${pageContext.request.contextPath}/upload/${memberProfile.storedFileName}"
                 alt="" width="300"
                 height="300" style="border-radius: 50%; border: 2px solid black; margin: auto">
            <%--            </c:if> <br>--%>
        </div>
        <div class="info-area">
            <c:choose>
                <c:when test="${sessionScope.loginEmail == 'admin'}">
                    이름
                    <input type="text" name="memberName" id="member-name" value="${member1.memberName}"
                           class="form-control" disabled>
                    이메일
                    <input type="text" name="memberEmail" id="member-email" value="${member1.memberEmail}"
                           class="form-control" disabled>
                    연락처
                    <input type="text" name="memberName" id="member-mobile" value="${member1.memberMobile}"
                           class="form-control" disabled>
                </c:when>
                <c:otherwise>
                    이름
                    <input type="text" name="memberName" id="member-name" value="${member.memberName}"
                           class="form-control" disabled>
                    이메일
                    <input type="text" name="memberEmail" id="member-email" value="${sessionScope.loginEmail}"
                           class="form-control" disabled>
                    연락처
                    <input type="text" name="memberName" id="member-mobile" value="${member.memberMobile}"
                           class="form-control" disabled>
                </c:otherwise>
            </c:choose>

        </div>
        <div class="button-area">
            <input type="button" onclick="update()" class="btn btn-dark" value="개인정보수정">
        </div>
    </form>
</div>
</body>
<script>
    const update = () => {
        location.href = "/member/update?id=${member.id}"

    }
</script>
</html>
