<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="../layouts/header.jsp"/>

<sec:authentication var="me" property="principal"/>
<style>
    .form-header {
        text-align: center;
        color: rgba(255, 255, 255, 0.79);
    }

    #insertAnnounceForm {
        max-width: 500px;
        margin: 20px auto;
        padding: 20px;
        background: #f9f9f9;
        border-radius: 8px;
    }

    .form-group {
        margin-bottom: 15px;
    }

    .form-label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #333;
    }

    .form-input,
    .form-textarea {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        color: #333;
    }

    .form-textarea {
        height: 150px;
        resize: vertical;
    }

    .form-button {
        display: block;
        width: 100%;
        padding: 10px;
        background-color: #d9534f;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
    }

    .form-button:hover {
        background-color: #c9302c; /
    }
</style>



<h1 class="form-header">공지사항 작성</h1>
<form action="insertAnnounce" method="post" id="insertAnnounceForm">
    <div class="form-group">
        <label for="username" class="form-label">작성자:</label><br>
        <input type="text" id="username" name="username" class="form-input" value='<c:out value="${me.member.username}"/>' readonly><br>
    </div>

    <div class="form-group">
        <label for="title" class="form-label">제목:</label><br>
        <input type="text" id="title" name="title" class="form-input"><br>
    </div>

    <div class="form-group">
        <label for="content" class="form-label">내용:</label><br>
        <textarea id="content" name="content" class="form-textarea"></textarea><br>
    </div>

    <button type="submit" class="form-button">작성</button>
</form>


<jsp:include page="../layouts/footer.jsp"/>