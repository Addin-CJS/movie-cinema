<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layouts/header.jsp"/>
<section>
    <div class="login">
        <h2>로그인</h2>
        <div class="loginInfo">
            <form action="login" method="post">
                <li class="loginInput">
                    <input name="username" class="form-control" id="userId" placeholder="아이디를 입력해주세요">
                </li>
                <c:if test="${param.error == 'true'}">
                    ${SPRING_SECURITY_LAST_EXCEPTION}
                </c:if>
                <li class="loginInput">
                    <input type="password" name="password" class="form-control" id="password"
                           placeholder="비밀번호를 입력해주세요">
                </li>
                <c:if test="${not empty loginError}">
                    <div class="error-text">${loginError}</div>
                </c:if>
                <div class="loginBtns">
                    <div class="loginBtn1">
                        <button type="submit">로그인</button>
                        <button type="button" onclick="location.href='/member/register'">회원가입</button>
                    </div>
                    <div class="loginBtn2">
                        <a href="/oauth2/authorization/google"><img src="/img/google.png"/></a>
                        <a href="#"><img src="/img/naver.png"/></a>
                        <a href="#"><img src="/img/kakao.png"/></a>
                    </div>
                </div>
                <div id="findIdAndPw">
                    <a href="/member/findId">아이디 찾기 |</a><a href="/member/resetPw"> 비밀번호 재설정</a>
                <div>
            </form>
        </div>
    </div>
</section>
<jsp:include page="../layouts/footer.jsp"/>