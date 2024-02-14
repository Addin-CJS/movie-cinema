<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../layouts/header.jsp"/>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<section>

    <sec:authentication var="me" property="principal"/>

    <div class="popular-movie-slider">
        <img src="${movie.mvImg}" alt="영화 이미지" class="poster">

        <div class="popular-movie-slider-content">
            <p class="release">${movie.mvReleaseDate}</p>
            <h2 class="movie-name">${movie.mvTitle}</h2>
            <ul class="category선택된 좌석 수 : ">
                <p>${movie.mvGenre}</p>
            </ul>
            <p class="desc">${movie.mvDescription}</p>
            <div class="movie-info">
                <i class="fa fa-clock-o"> &nbsp;&nbsp;&nbsp;<span>${movie.mvRuntime}min</span></i>
                <i class="fa fa-volume-up"> &nbsp;&nbsp;&nbsp;<span>Subtitles</span></i>
                <i class="fa fa-circle"> &nbsp;&nbsp;&nbsp;<span>Imdb: <b>${movieRating}</b></span></i>
            </div>
            <div class="movie-btns">
                <button onclick="window.open('${movie.mvVideo}', '_blank');">▶ 예고편 보기</button>
            </div>

            <sec:authorize access="isAuthenticated()">
                <!-- 관심 영화 추가 또는 제거 버튼 -->
                <c:choose>
                    <c:when test="${isInterested}">
                        <!-- 관심 영화 취소 버튼 -->
                        <form action="/removeInterestMovie" method="post">
                            <input type="hidden" name="movieId" value="${movie.movieId}">
                            <button type="submit" class="interest-button">
                                <span class="emoji">🎬👀</span> 관심 영화 취소
                            </button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <!-- 관심 영화 추가 버튼 -->
                        <form action="/interestMovie" method="post">
                            <input type="hidden" name="movieId" value="${movie.movieId}">
                            <button type="submit" class="interest-button">
                                <span class="emoji">🎬👀</span> 관심 영화 추가
                            </button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </sec:authorize>

            <sec:authorize access="!isAuthenticated()">
                <button type="button"  class="interest-button" onclick="promptLogin()">
                    <span class="emoji">🎬👀</span> 관심 영화 추가
                </button>
            </sec:authorize>

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

        </div>
    </div>
</section>

<jsp:include page="../movie/booking.jsp"/>
<jsp:include page="../movie/reviews.jsp"/>