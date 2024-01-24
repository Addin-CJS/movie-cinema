<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="js/script.js"></script>
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
            <li onclick="location.href='/'">메인</li>
            <li>영화</li>
            <li>예매</li>

            <%-- 로그인 후 --%>
            <c:if test="${not empty loginUser}">
                <div align="right">
                    <table>
                        <tr>
                            <td colspan="2">
                                <h3>${loginUser.name}님 환영합니다.</h3>
                            </td>
                        </tr>
                        <tr>
                            <td><a href="">마이페이지</a> /</td>
                            <td><a href="<c:url value='/logout' />">로그아웃</a></td>
                        </tr>
                    </table>
                </div>
            </c:if>

            <!--
            <li><span>ooo님<img
                    src="https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg"> <i
                    class="fa fa-angle-down"></i></span></li>
            <li><b>sign out</b></li> -->
            <li onclick="location.href='/member/login'">로그인</li>
        </ul>
    </nav>
</header>