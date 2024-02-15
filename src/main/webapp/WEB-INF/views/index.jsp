<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="layouts/header.jsp"/>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<section>
    <div class="main-posters">
        <div class="swiper main-posters-slide">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <img src="/img/posters/aquaman.jpg" alt="aquaman">
                </div>
                <div class="swiper-slide">
                    <img src="/img/posters/marvels.jpg" alt="marvels">
                </div>
                <div class="swiper-slide">
                    <img src="/img/posters/heron.jpg" alt="heron">
                </div>
                <div class="swiper-slide">
                    <img src="/img/posters/napoleon.jpg" alt="napoleon">
                </div>
                <div class="swiper-slide">
                    <img src="/img/posters/lift.jpg" alt="lift">
                </div>
            </div>

            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
            <div class="swiper-pagination"></div>
        </div>
    </div>
    <div class="main-pages">
        <div class="movie-chart">
            <h1>TOP5 관심 영화</h1>
            <div class="movie-chartList">
                <c:forEach var="topMovie" items="${top5Movies}" varStatus="i">
                    <div class="chartList">
                        <c:set var="movie" value="${moviesInfo[topMovie.movieId]}"/>
                        <a href="/showDetail?movieId=${movie.movieId}">
                            <img src="${movie.mvImg}"
                                 onerror="this.src='https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';">
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
            <div class="announce">
                <h4>공지사항</h4>
                <div class="announce-wrapper">
                    <c:forEach var="announcement" items="${announcements}">
                        <div class="announcement-item">
                            <div class="announcement-title2">
                                <div class="announceTitle1">
                                        ${announcement.title}
                                </div>
                                <div class="announceTitle2">
                                    <span class="toggle-content">+</span>
                                </div>
                            </div>
                            <div class="announcement-content2" style="display: none;">
                                    ${announcement.content}
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    var reviewSwiper = new Swiper(".best_review_slide", {
        direction: "vertical",
        slidesPerView: 9,
        loop: true,
        spaceBetween: 0,
        autoplay: {
            delay: 2500,
            disableOnInteraction: false,
        }
    });

    var posterSwiper = new Swiper(".main-posters-slide", {
        cssMode: true,
        autoplay: {
            delay: 3000,
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        pagination: {
            el: ".swiper-pagination",
        },
        mousewheel: true,
        keyboard: true,
    });

    $(document).ready(function () {
        displayAnnouncementWithEnter();
    });

    $(document).ready(function () {
        $('.toggle-content').click(function () {
            var content = $(this).closest('.announcement-item').find('.announcement-content2');
            if (content.is(':hidden')) {
                content.slideDown(500);
                $(this).text('-');
            } else {
                content.slideUp(500);
                $(this).text('+');
            }

        });
    });

    function displayAnnouncementWithEnter() {
        document.querySelectorAll('.announcement-content2').forEach(function (content) {
            var originalText = content.textContent || content.innerText;
            var EnterText = originalText.replace(/\n/g, '<br>');
            content.innerHTML = EnterText;
        });
    }

</script>

<jsp:include page="layouts/footer.jsp"/>