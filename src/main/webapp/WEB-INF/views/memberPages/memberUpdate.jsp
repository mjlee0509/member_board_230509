<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-10
  Time: 오후 7:37
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
    <form action="/member/update" method="post" name="updateForm">
        <h2></h2>
        <div class="img-area">
            <%--            <c:if test="${member.memberProfile == 1}">--%>
            <img src="${pageContext.request.contextPath}/upload/${memberProfile.storedFileName}" alt="" width="300"
                 height="300" style="border-radius: 50%; border: 2px solid black; margin: auto" id="profile-img-box">
            <%--            <input type="file" name="profileFile" class="btn-light"--%>
            <%--                   accept=".*" value="${member.profileFile}" onchange="preview()" id="profile-img">--%>
            <%--            </c:if> <br>--%>
        </div>
        <div class="info-area">
            ID
            <input type="text" name="id" id="id" value="${member.id}" class="form-control" readonly>
            이름
            <input type="text" name="memberName" id="member-name" value="${member.memberName}" class="form-control">
            이메일
            <input type="text" name="memberEmail" id="member-email" value="${member.memberEmail}" class="form-control">
            연락처
            <input type="text" name="memberMobile" id="member-mobile" value="${member.memberMobile}"
                   class="form-control">
            비밀번호
            <input type="text" name="memberPassword" id="member-password" placeholder="비밀번호" class="form-control">
        </div>
        <div class="button-area">
            <input type="button" onclick="update_request()" class="btn btn-dark" value="개인정보수정">
        </div>
    </form>
</div>
</body>
<script>
    const preview = () => {
        const preview = new FileReader();
        preview.onload = function (e) {
            document.getElementById("profile-img-box").src = e.target.result;
        }
        preview.readAsDataURL(document.getElementById("profile-img").files[0])
    };

    const update_request = () => {
        const passInput = document.getElementById("member-password").value;
        const passDB = '${member.memberPassword}';
        if (passInput == passDB) {
            document.updateForm.submit();
            console.log('${member.id}');
        } else {
            alert("비밀번호가 일치하지 않습니다")
        }

    }
</script>
</html>
