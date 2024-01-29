<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" ></script>
    <script src="/js/script.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
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
            var loginOk = ${not empty sessionScope.loginUser};

            if (loginOk) {
                $("#menu-box li:contains('로그인')").hide();
                $("#menu-box").append("<h4>${sessionScope.loginUser.username}님 환영합니다! </h4> <li>마이페이지</li> <li>로그아웃</li>");
            }
        });
</script>