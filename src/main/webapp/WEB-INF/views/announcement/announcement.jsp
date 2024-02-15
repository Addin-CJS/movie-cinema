<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="../layouts/header.jsp"/>

<style>
    #announcementList {
        list-style: none;
        padding: 0;
        max-width: 600px;
        margin: 20px auto;
        color: #333;
    }

    #announcementList li {
        background-color: #ffffff;
        border: 1px solid #d9534f;
        border-radius: 8px;
        margin-bottom: 10px;
        padding: 10px;
        transition: transform 0.2s;
        display: flex;
        flex-direction: column;
    }

    #announcementList li:hover {
        transform: scale(1.03);
        box-shadow: 0 2px 4px rgba(217, 83, 79, .5);
    }

    .announcement-id {
        color: #d9534f;
        margin-bottom: 5px;
    }

    .announcement-title {
        font-weight: bold;
    }

    .announcement-title a {
        text-decoration: none;
        color: #070707;
    }

    .announcement-header {
        text-align: center;
        color: #d9534f;
        margin-bottom: 20px;
    }

    .announcement-link-container {
        text-align: center;
        margin-top: 30px;
    }

    .announcement-create-link {
        display: inline-block;
        background-color: #d9534f;
        color: white;
        text-align: center;
        padding: 14px 20px;
        border-radius: 4px;
        text-decoration: none;
        font-weight: bold;
        width: 200px;
        margin: 0 auto;
        transition: background-color 0.3s ease, box-shadow 0.3s ease;
    }

    .announcement-create-link:hover {
        background-color: #c9302c;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
</style>

<h2 class="announcement-header">공지사항 목록</h2>
<ul id="announcementList">
    <c:forEach var="announcement" items="${announceList}">
        <li>
            <span class="announcement-id">글번호: ${announcement.id}</span>
            <span class="announcement-title">제목: <a href="/detailAnnounce?id=${announcement.id}">${announcement.title}</a></span>
        </li>
    </c:forEach>
</ul>
<div class="announcement-link-container">
    <a href="/writeAnnounce" class="announcement-create-link">공지사항 작성</a>
</div>








<jsp:include page="../layouts/footer.jsp"/>