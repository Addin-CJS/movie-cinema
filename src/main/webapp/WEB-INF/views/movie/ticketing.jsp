<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Ticketing</title>
</head>
<body>
<input type="button" value="Redirect Parent" onclick="redirectParent()">
</body>

<script>
    function redirectParent() {
        if (window.opener) {
            window.opener.location.href = 'http://localhost:8080/movieHome';
        }
    }
</script>
</html>
