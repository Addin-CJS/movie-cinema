<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layouts/header.jsp"/>
<section>
    <div class="login">
        <h4>로그인</h4>
        <form action="login" method="post">
            <table>
                <tr>
                    <th><label for="userId" class="form-label">ID</label></th>
                    <td>
                        <div class="mb-3">
                            <input name="username" class="form-control" id="userId" placeholder="아이디를 입력해주세요">
                        </div>
                    </td>
                </tr>
                <tr>
                    <th><label for="password" class="form-label">PW</label></th>
                    <td>
                        <div class="mb-3">
                            <input type="password" name="password" class="form-control" id="password"
                                   placeholder="비밀번호를 입력해주세요">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <c:if test="${not empty loginError}">
                            <div class="error-text">${loginError}</div>
                        </c:if>
                    </td>
                </tr>
            </table>
            <button type="submit">로그인</button>
            <button type="button" onclick="location.href='/member/register'">회원가입</button>&emsp;
            <div id="findIdAndPw">
                <a href="/member/findId">아이디 찾기 |</a><a href="/member/resetPw"> 비밀번호 재설정</a>
            <div>
        </form>
    </div>
</section>
<jsp:include page="../layouts/footer.jsp"/>