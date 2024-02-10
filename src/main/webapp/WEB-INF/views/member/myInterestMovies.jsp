<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link href="style.css" rel="stylesheet">

<section>
    <div class="myInterestMovies">
        <h2>나의 관심 영화</h2>
        <div class="movieListContainer">
            <c:if test="${not empty interestMoviesPage}">
                <c:forEach var="movie" items="${interestMoviesPage.content}">
                    <div class="movieContainer">
                        <div class="interestMovieImg">
                            <a href="/showDetail?movieId=${movie.movieId}">
                                <img class="interestMovie-img" src="${moviesInfo[movie.movieId].mvImg}" alt="${moviesInfo[movie.movieId].mvTitle}"/>
                            </a>
                        </div>
                        <div class="myInterestMovieInfo1">
                            <div class="interestMovieWrap">
                                <span class="interestMovieTitle">${moviesInfo[movie.movieId].mvTitle}</span>
                            </div>
                            <div class="myInterestMovieInfo2">
                                <div class="interestMovieWrap">
                                    <span class="interestMovieDate">${moviesInfo[movie.movieId].mvReleaseDate}</span>
                                </div>
                                <div class="interestMovieWrap">
                                    <span class="interestMovieGenre">${moviesInfo[movie.movieId].mvGenre}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
        </div>
    </div>

    <div class="myInterestMoviePagination">
            <a href="javascript:loadInterestMoviesPage(0)" class="page-link">처음</a>
            <c:if test="${nowPage > 1}">
                <a href="javascript:loadInterestMoviesPage(${nowPage - 2})" class="page-link">이전</a>
            </c:if>
            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                <a href="javascript:loadInterestMoviesPage(${i - 1})" class="page-link">[${i}]</a>
            </c:forEach>
            <c:if test="${nowPage < totalPages}">
                <a href="javascript:loadInterestMoviesPage(${nowPage})" class="page-link">다음</a>
            </c:if>
            <a href="javascript:loadInterestMoviesPage(${totalPages - 1})" class="page-link">마지막</a>
        </div>
    </div>
</section>