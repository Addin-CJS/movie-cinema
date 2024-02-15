<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="../layouts/header.jsp"/>

<sec:authentication var="me" property="principal"/>

<style>


    #announceForm {
        background-color: #ffffff;
        border: 1px solid #dddddd;
        padding: 20px;
        border-radius: 8px;
    }

    .announceLabel {
        display: block;
        margin: 10px 0 5px;
    }

    .announceInput,
    .announceTextarea {
        width: 100%;
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #cccccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .announceTextarea {
        height: 100px;
        resize: vertical;
    }

    .announceButton {
        background-color: #f62a2a;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }

    .announceButton:hover {
        background-color: #ee0000;
    }

    .announceReadOnly {
        background-color: #e9ecef;
        cursor: not-allowed;
    }
</style>




<form action="editAnnounce" method="post" id="announceForm">
    <input type="hidden" name="id" value="${announcement.id}">
    <label for="title" class="announceLabel">제목:</label>
    <input type="text" id="title" name="title" class="announceInput" value="${announcement.title}">
    <br>
    <label for="content" class="announceLabel">내용:</label>
    <textarea id="content" name="content" class="announceTextarea">${announcement.content}</textarea>
    <br>
    <label for="username" class="announceLabel">작성자:</label>
    <input type="text" id="username" name="username" class="announceInput announceReadOnly" value="${announcement.username}" readonly>
    <br>
    <button type="submit" class="announceButton">수정</button>
</form>