<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 1:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>MY UNIVERSE</title>
    <link rel="stylesheet" href="/resources/css/index.css">
</head>
<body class="after-login">
<c:choose>
    <c:when test="${sessionScope.loginEmail == 'admin'}">
        <%@include file="../components/navAdmin.jsp" %>
    </c:when>
    <c:otherwise>
        <%@include file="../components/navLogin.jsp" %>
    </c:otherwise>
</c:choose>
<h2>어서와~</h2>
</body>
<script>
    const sign_up = () => {
        location.href = "/member/save"

    }
</script>
</html>
