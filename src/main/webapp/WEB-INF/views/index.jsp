<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="layouts/header.jsp"/>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<section>
    <div class="movie-chart">
        <h1>TOP5 관심 영화</h1>
        <div class="movie-chartList">
            <c:forEach var="topMovie" items="${top5Movies}">
                <div class="chartList">
                    <c:set var="movie" value="${moviesInfo[topMovie.movieId]}" />
                    <a href="/showDetail?movieId=${movie.movieId}">
                         <img src="${movie.mvImg}" onerror="this.src='https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';">
                    </a>
                        <p class="movie-name">
                            <a href="/showDetail?movieId=${movie.movieId}">${movie.mvTitle}</a>
                        </p>
                </div>
            </c:forEach>

        </div>
    </div>
</section>


<jsp:include page="layouts/footer.jsp"/>
