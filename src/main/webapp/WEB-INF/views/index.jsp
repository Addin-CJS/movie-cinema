<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="layouts/header.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<section>
    <div class="movie-chart">
        <h1>TOP5 관심 영화</h1>
        <div class="movie-chartList">
            <c:forEach var="topMovie" items="${top5Movies}" varStatus="i">
                <div class="chartList">
                    <c:set var="movie" value="${moviesInfo[topMovie.movieId]}" />
                    <a href="/showDetail?movieId=${movie.movieId}">
                         <img src="${movie.mvImg}" onerror="this.src='https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';">
                        <span class="movierank">${i.count}</span>
                    </a>
                        <p class="movie-name">
                            <a href="/showDetail?movieId=${movie.movieId}">${movie.mvTitle}</a>
                        </p>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="bottom-section">
        <div class="best-review">
            <h4>베스트 리뷰</h4>
            <div class="swiper best_review_slide">
                <div class="swiper-wrapper">
                    <c:forEach var="bestReview" items="${bestReviews}">
                        <div class="bestReviewItem swiper-slide">
                            <div class="bestReviewId">${bestReview.reviewId}</div>
                            <div class="bestReviewWriter">${bestReview.reviewWriter}</div>
                            <div class="bestReviewContent" id="myReviewContent">
                                <a href="/showDetail?movieId=${bestReview.movieNo}">${bestReview.reviewContent}</a>
                            </div>
                            <div class="bestReviewCreateReviewDate">
                                    ${fn:substringBefore(bestReview.createReviewDate.toString(), 'T')}
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    var swiper = new Swiper(".best_review_slide", {
        direction: "vertical",
        slidesPerView: 9,
        loop:true,
        spaceBetween: 0,
        autoplay: {
            delay: 2500,
            disableOnInteraction: false,
        }
    });
</script>

<jsp:include page="layouts/footer.jsp"/>
