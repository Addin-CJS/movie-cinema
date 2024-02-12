<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal.member" var="loginUser"/>
</sec:authorize>
<html>
<head>
    <title>Movie Ticketing</title>
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
        <jsp:include page="../notification/notification.jsp" />
        <i class="fa fa-bars" id="menu"></i>

        <ul id="menu-box">
            <div class="marker"></div>
            <li data-path="/" onclick="location.href='/'">메인</li>
            <li data-path="/movieHome" onclick="location.href='/movieHome?page=0'">영화</li>
            <sec:authorize access="isAnonymous()">
                <li data-path="/member/login" onclick="location.href='/member/login'">로그인</li>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
                <li data-path="/member/myPage" onclick="location.href='/member/myPage'">마이페이지</li>
            </sec:authorize>
            <sec:authorize access="hasAnyRole('ADMIN')">
                <li data-path="/admin/main" onclick="location.href='/admin/main'">
                    관리자
                </li>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
                <li><a href="/logout" id="logout">로그아웃</a></li>
            </sec:authorize>

            <sec:authorize access="isAuthenticated()">
                <div class="notification-icon">
                    <a href="/notifications" id="notification-link">
                        <img src="../img/icons/notification.png" alt="Notifications" />
                        <span class="notification-count" id="notification-count">0</span>
                    </a>
                </div>
            </sec:authorize>
        </ul>

    </nav>
</header>
<script>
    //indicator
    let marker = $('.marker');
    marker.css('left', localStorage.getItem('markerLeft'));
    marker.css('width', localStorage.getItem('markerRight'));

    $(document).ready(function () {
        //indicator
        let marker = $('.marker');
        let items = $('#menu-box li');
        let currentPath = window.location.pathname;

        initializeIndicator();

        function initializeIndicator() {
            items.each(function() {
                let path = $(this).data("path");
                if (path && (currentPath === path)) {
                    updateIndicator(this);
                }
            });
        }

        function updateIndicator(element) {
            marker.css('left', element.offsetLeft + 'px');
            localStorage.setItem('makerLeft', element.offsetLeft);
            marker.css('width', element.offsetWidth + 'px');
            localStorage.setItem('markerRight', element.offsetWidth);
        }

        //scroll
        let nav = $('nav');

        $(window).scroll(function () {
            if ($(this).scrollTop() >= 20) {
                nav.addClass('nav');
            } else {
                nav.removeClass('nav');
            }
        });

        // 햄버거 메뉴
        let menuBx = $('#menu-box');
        let a = true;

        $('#menu').click(function () {
            // 클릭 이벤트 핸들러
            if (a == true) {
                menuBx.css('display', 'block');
                $(this).removeClass('fa-bars').addClass('fa-remove');
                a = false;
            } else {
                menuBx.css('display', 'none');
                $(this).removeClass('fa-remove').addClass('fa-bars');
                a = true;
            }
        });

        // 로그아웃
        $('#logout').click(function(event) {
            event.preventDefault(); // 기본 동작 방지
            let confirmLogout = confirm('로그아웃 하시겠습니까?');
            if (confirmLogout) {
                window.location.href = this.href; // 사용자가 '예'를 선택한 경우, 로그아웃
            }
        });

    });

</script>