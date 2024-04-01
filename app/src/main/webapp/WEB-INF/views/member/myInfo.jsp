<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<section>
    <div class="myPage">
        <h2>내 정보</h2>
        <sec:authentication var="me" property="principal.member"/>
        <form action="myPage" id="myPageForm">
            <div class="myPageForm">
                <div class="myPageTitle">
                    <label for="username">ID</label>
                    <label for="name">NAME</label>
                    <label for="email">EMAIL</label>
                    <label for="phoneNumber">PHONE</label>
                    <label for="kakaoAddress">ADDRESS</label>
                </div>
                <div class="myPageInfo">
                    <div>
                        <input name="username" id="username" value="${me.username}" readonly>
                    </div>
                    <div>
                        <input name="name" id="name" value="${me.name}" readonly>
                    </div>
                    <div>
                        <input id="email" name="email" value="${me.email}" readonly>
                    </div>
                    <div>
                        <input name="phoneNumber" id="phoneNumber" value="${me.phoneNumber}" readonly>
                    </div>
                    <div>
                        <input type="text" name="homeAddress" id="kakaoAddress" value="${me.homeAddress}" readonly>
                    </div>
                </div>
            </div>
        </form>
    </div>
</section>