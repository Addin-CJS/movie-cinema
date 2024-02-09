<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link href="style.css" rel="stylesheet"> <!-- CSS 파일 경로를 확인해주세요 -->

<section id="interest-movies-section">
    <div class="interestContainer">
        <div id="movies-list">
            <c:if test="${not empty interestMoviesPage}">
                <c:forEach var="movie" items="${interestMoviesPage.content}">
                    <div class="interestMove-row">
                        <a href="/showDetail?movieId=${movie.movieId}">
                            <img class="interestMovie-img" src="${moviesInfo[movie.movieId].mvImg}" alt="${moviesInfo[movie.movieId].mvTitle}"/>
                        </a>
                        <span class="interestMovie-title">${moviesInfo[movie.movieId].mvTitle}</span>
                    </div>
                </c:forEach>
            </c:if>
        </div>
        <div id="interest-movies-pagination">
            <a href="javascript:loadInterestMoviesPage(0)" class="page-link">처음</a>
            <c:if test="${nowPage > 1}">
                <a href="javascript:loadInterestMoviesPage(${nowPage - 2})" class="page-link">이전</a>
            </c:if>
            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                <a href="javascript:loadInterestMoviesPage(${i - 1})" class="page-link">${i}</a>
            </c:forEach>
            <c:if test="${nowPage < totalPages}">
                <a href="javascript:loadInterestMoviesPage(${nowPage})" class="page-link">다음</a>
            </c:if>
            <a href="javascript:loadInterestMoviesPage(${totalPages - 1})" class="page-link">마지막</a>
        </div>
    </div>
</section>