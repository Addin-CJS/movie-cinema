<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="../layouts/header.jsp"/>
<style>
    .announceDetail-container {
        max-width: 800px;
        margin: 20px auto;
        border: 1px solid #070707;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        border-radius: 8px;
        overflow: hidden;
    }

    .announceDetail-header {
        background-color: #f7f7f7;
        padding: 10px 15px;
        border-bottom: 1px solid #eeeeee;
        font-weight: bold;
        color: #333;
    }

    .announceDetail-content {
        padding: 15px;
        background-color: #ffffff;
        color: #000000;
    }

    .announceDetail-item {
        margin-bottom: 10px;
        padding-bottom: 10px;
        border-bottom: 1px solid #eeeeee;
    }

    .announceDetail-item:last-child {
        border-bottom: none;
    }

    .announcement-action-editLink, .announcement-delete-button {
        background-color: #e0052d;
        color: #ffffff;
        text-decoration: none;
        padding: 10px 15px;
        border-radius: 4px;
        font-weight: bold;
        font-size: 16px;
        display: inline-flex;
        justify-content: center;
        align-items: center;
        margin: 0 5px;
        border: none;
        cursor: pointer;
        box-sizing: border-box;
    }

    .announcement-action-editLink:hover, .announcement-delete-button:hover {
        background-color: #f10909;
    }

    .center-content {
        display: flex;
        justify-content: center;
        margin: 20px 0;
    }
</style>

<sec:authentication var="me" property="principal"/>

<div class="announceDetail-container">
    <div class="announceDetail-header">공지사항 세부정보</div>
    <div class="announceDetail-content">
        <div class="announceDetail-item">ID: ${announcement.id}</div>
        <div class="announceDetail-item">사용자 이름: ${announcement.username}</div>
        <div class="announceDetail-item">제목: ${announcement.title}</div>
        <div class="announceDetail-item" id="announcement-content2">내용: ${announcement.content}</div>
    </div>
</div>

<sec:authorize access="hasRole('ROLE_ADMIN')">
    <div class="center-content">
        <a href="/editAnnounce?id=${announcement.id}" class="announcement-action-editLink">수정하기</a>
        <form action="deleteAnnounce" method="post" onsubmit="return confirmDelete();" style="display: inline;">
            <input type="hidden" name="id" value="${announcement.id}">
            <button type="submit" class="announcement-delete-button">삭제하기</button>
        </form>
    </div>
</sec:authorize>

<script>
    function confirmDelete() {
        return confirm("정말 삭제하시겠습니까?");
    }

    function displayAnnouncementWithEnter() {
        document.querySelectorAll('#announcement-content2').forEach(function(content) {
            var originalText = content.textContent || content.innerText;
            var EnterText = originalText.replace(/\n/g, '<br>');
            content.innerHTML = EnterText;
        });
    }

    $(document).ready(function() {
        displayAnnouncementWithEnter()
    });
</script>


<jsp:include page="../layouts/footer.jsp"/>