<%--
  Created by IntelliJ IDEA.
  User: jckim
  Date: 1/18/24
  Time: 16:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>

<body>
<form action="/upload" method="post" enctype="multipart/form-data">
    <input type="file" name="image">
    <input type="submit" value="업로드">
</form>
    <h1>test</h1>
    <c:forEach items="${movies}" var="movie">
        <p>${movie}</p>
    </c:forEach>
</body>
</html>
