<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="layouts/header.jsp"/>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<section>
    <div>
        <h1>무비차트</h1>
        <div class="movie-card-section">
            <c:forEach var="topMovie" items="${top5Movies}">
                <div class="card">
                    <c:set var="movie" value="${moviesInfo[topMovie.movieId]}" />
                    <img src="${movie.mvImg}" onerror="this.src='https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';">
                    <div class="card-content">
                        <p class="movie-name">
                            <a href="/showDetail?movieId=${topMovie.movieId}">${movie.mvTitle}</a>
                        </p>
                        <div class="movie-info">
                        </div>
                    </div>
                </div>
            </c:forEach>

        </div>
    </div>
</section>


<jsp:include page="layouts/footer.jsp"/>
