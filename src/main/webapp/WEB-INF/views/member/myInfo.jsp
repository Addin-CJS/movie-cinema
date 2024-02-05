<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<section>
    <div class="myPage">
        <h3>내 정보</h3>
        <sec:authentication var="me" property="principal.member"/>

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
        </form>
    </div>
</section>