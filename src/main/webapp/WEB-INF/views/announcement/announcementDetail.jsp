<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="../layouts/header.jsp"/>
<style>
    #announcementDetails {
        list-style: none;
        padding: 0;
        background-color: #ffffff;
        border: 1px solid #dddddd;
        border-radius: 8px;
        padding: 15px;
        margin-bottom: 10px;
    }

    #announcementDetails li {
        margin-bottom: 8px;
        color: #333333;
    }

    .announcement-action-editLink, .announcement-delete-button {
        display: inline-block;
        margin-right: 10px;
        text-decoration: none;
        padding: 10px 15px;
        border-radius: 4px;
        color: white;
        font-weight: bold;
        text-align: center;
        background-color: #e0052d;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
        min-width: 100px;
        box-sizing: border-box;
        font-size: 14px;
    }


    .announcement-action-editLink:hover, .announcement-delete-button:hover {
        background-color: #0056b3;
    }
</style>


<sec:authentication var="me" property="principal"/>

<ul id="announcementDetails">
    <li>ID: ${announcement.id}</li>
    <li>사용자 이름: ${announcement.username}</li>
    <li>제목: ${announcement.title}</li>
    <li>내용: ${announcement.content}</li>
</ul>

<a href="/editAnnounce?id=${announcement.id}" class="announcement-action-editLink">수정하기</a>

<form action="deleteAnnounce" method="post" style="display: inline;">
    <input type="hidden" name="id" value="${announcement.id}">
    <button type="submit" class="announcement-delete-button">삭제</button>
</form>

<jsp:include page="../layouts/footer.jsp"/>