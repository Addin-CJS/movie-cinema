<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="layouts/header.jsp"/>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<section>
    <div id="img" class="carousel-slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#img" data-slide-to="0" class="active"></li>
            <li data-target="#img" data-slide-to="1" class="active"></li>
            <li data-target="#img" data-slide-to="2" class="active"></li>
            <li data-target="#img" data-slide-to="4" class="active"></li>
        </ol>

        <div class="carousel-inner text-center">
        </div>
    </div>

</section>

<jsp:include page="layouts/footer.jsp"/>