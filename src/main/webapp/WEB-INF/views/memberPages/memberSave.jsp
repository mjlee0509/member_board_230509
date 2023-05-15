<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 1:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="/resources/css/form.css">
    <link rel="stylesheet" href="/resources/bootstrap.min.css">
    <script src="/resources/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>
<body>
<div class="main">
    <form action="/member/save" method="post" enctype="multipart/form-data" id="save-form" class="form-member">
        <h2>회원가입</h2> <br>
        <div id="profile-area">
            <h6>프로필 이미지</h6>
            <img id="profile-img-box" src="#" alt="" width="200" height="200" style="border: 2px solid black; border-radius: 50%"><br>
            <input type="file" name="profileFile" class="btn-light"
            accept=".*" onchange="preview()" id="profile-img">
        </div>
        <div id="input-area">
            <label for="member-name">이름</label>
            <input type="text" name="memberName" id="member-name" class="form-control" placeholder="이름">

            <label for="member-email">이메일</label>
            <input type="text" name="memberEmail" id="member-email" class="form-control" placeholder="이메일" onblur="email_check()">
            <p id="email-check-result"></p>

            <label for="member-password">비밀번호</label>
            <input type="text" name="memberPassword" id="member-password" class="form-control" placeholder="비밀번호" onblur="pass_check()">
            <p id="pass-check-result"></p>
            
            <label for="member-password-confirm">비밀번호 확인</label>
            <input type="text" name="memberPasswordConfirm" id="member-password-confirm" class="form-control" placeholder="비밀번호를 다시 입력해주세요">
            <p id="pass-confirm-result"></p>

            <label for="member-mobile">연락처</label>
            <input type="text" name="memberMobile" id="member-mobile" class="form-control" placeholder="연락처">
        </div>
        <div id="button-area">
            <input type="submit" class="btn btn-dark" value="가입하기">
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

    const email_check = () => {
        const email = document.getElementById("member-email").value;
        const result = document.getElementById("email-check-result");
        $.ajax({
            type: "post",
            url: "/member/email-check",
            data: {
                "memberEmail": email
            },
            success: function () {
                result.innerHTML = "사용 가능한 이메일입니다";
                result.style.color = "green";
            },
            error: function (err) {
                if(err.status == "409") {
                    result.innerHTML = "이미 사용중인 이메일입니다";
                    result.style.color = "red";
                } else if(err.status == "404") {
                    result.innerHTML = "사용하실 이메일을 입력해주세요";
                    result.style.color = "red";
                }
            }
        })
    };

    const memberPassword = document.getElementById("member-password");
    const passCheckResult = document.getElementById("pass-check-result");
    const memberPasswordConfirm = document.getElementById("member-password-confirm");
    const passConfirmResult = document.getElementById("pass-confirm-result");

    memberPassword.addEventListener("blur", function (e) {
        e.preventDefault();
        const password = memberPassword.value;
        const expPassword = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_-])[A-Za-z\d!@#$%^&*()_-]{8,20}$/
        if (password.length == 0) {
            passCheckResult.innerHTML = "필수 입력사항입니다";
            passCheckResult.style.color = "red";
        } else if (!password.match(expPassword)) {
            passCheckResult.innerHTML = "영문(대+소문자),특수문자, 숫자 포함 8~20자";
            passCheckResult.style.color = "red";
        } else if (password.match(expPassword)) {
            passCheckResult.innerHTML = "안전한 비밀번호입니다";
            passCheckResult.style.color = "green";
            memberPassword.blur();
        }
    })

    memberPasswordConfirm.addEventListener("blur", function (e) {
        e.preventDefault();
        const password = memberPassword.value;
        const passConfirm = memberPasswordConfirm.value;
        if (passConfirm.length == 0) {
            passConfirmResult.innerHTML = "비밀번호를 다시 입력해주세요";
            passConfirmResult.style.color = "red";
        } else if (passConfirm != password) {
            passConfirmResult.innerHTML = "비밀번호가 일치하지 않습니다";
            passConfirmResult.style.color = "red";
        } else if (passConfirm == password) {
            passConfirmResult.innerHTML = "확인되었습니다";
            passConfirmResult.style.color = "green";
            memberPasswordConfirm.blur();
        }
    })










</script>
</html>
