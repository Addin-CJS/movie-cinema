<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<section>
    <div class="myPage">
        <h4>마이페이지</h4>
        <c:set var="me" value="${loginUser}" />

        <form action="myPage" id="myPageForm">
            <table>
                <tr>
                    <th><label for="username">ID</label></th>
                    <td>
                            <input name="username" id="username" value="${me.username}" readonly>
                    </td>
                </tr>
                <tr>
                    <th><label for="name">NAME</label></th>
                    <td>
                        <input name="name" id="name" value="${me.name}" readonly>
                    </td>
                </tr>
                <tr>
                    <th><label for="email">EMAIL</label></th>
                    <td>
                        <input id="email" name="email" value="${me.email}" readonly>
                    </td>
                </tr>

                <tr>
                    <th><label for="phoneNumber">PHONE</label></th>
                    <td>
                            <input name="phoneNumber" id="phoneNumber" value="${me.phoneNumber}" readonly>
                    </td>
                </tr>
                <tr>
                    <th><label for="kakaoAddress">ADDRESS</label></th>
                    <td>
                        <input type="text" name="homeAddress" id="kakaoAddress" value="${me.homeAddress}" readonly>
                    </td>
                </tr>
            </table>
            <button><a href="/member/myPageEdit">내정보 수정하기</a></button>
        </form>
    </div>
</section>

<jsp:include page="../layouts/footer.jsp"/>