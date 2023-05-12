<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오전 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MJ UNIVERSE</title>
    <link rel="stylesheet" href="/resources/css/index.css">
</head>
<body>
<%@include file="components/nav.jsp"%>
<div class="main">

</div>
<%@include file="components/footer.jsp"%>
</body>
<script>
    const sign_up = () => {
        location.href = "/member/save"

    }
</script>
</html>
