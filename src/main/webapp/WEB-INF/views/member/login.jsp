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
            </table>
            <button type="button" onclick="location.href='/member/register'">회원가입</button>&emsp;
            <button type="submit">로그인</button>
        </form>
    </div>
</section>
<jsp:include page="../layouts/footer.jsp"/>