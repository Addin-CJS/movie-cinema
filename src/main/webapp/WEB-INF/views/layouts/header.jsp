<%@ page import="org.apache.tomcat.util.net.openssl.ciphers.Authentication" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="/js/script.js"></script>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<header>
    <nav>
        <h1 class="logo">
            <a href="/">영화<span>예매</span></a>
        </h1>

        <i class="fa fa-bars" id="menu"></i>

        <ul id="menu-box">
            <div class="marker"></div>
            <li data-path="/" onclick="location.href='/'">메인</li>
            <li data-path="/movieHome" onclick="location.href='/movieHome?page=0'">영화</li>
            <li data-path="/ticketing">예매</li>
            <li data-path="/member/login" onclick="location.href='/member/login'">로그인</li>
        </ul>

    </nav>
</header>
<script>
    $(document).ready(function () {
        <sec:authorize access="isAuthenticated()">
        $("#menu-box li:contains('로그인')").hide();
        $("#menu-box").append("<h4><sec:authentication property="principal.member.username"/>님 환영합니다!</h4>")
            .append("<li><a href='/member/myPage'>마이페이지</a></li>")
            .append("<li><a href='/logout'>로그아웃</a></li>");
        </sec:authorize>
    });
</script>