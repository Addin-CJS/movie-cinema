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
    <div class="movie-ticket-book">
        <div class="choose-date">
            <p>상영 일자</p>
            <div class="swiper-date sw_con swiper-container snbSwiper">
                <ul class="swtab conlist swiper-wrapper">
                </ul>
            </div>
        </div>
        <div class="choose-time">
            <p>상영 시간</p>
            <div class="swiper-time sw_con swiper-container snbSwiper">
                <ul class="swtab conlist swiper-wrapper">
                </ul>
            </div>
        </div>
        <div class="choose-theater">
            <p>영화관</p>
            <div class="swiper-theater sw_con swiper-container snbSwiper">
                <ul class="swtab conlist swiper-wrapper">
                </ul>
            </div>
        </div>
        <sec:authorize access="isAuthenticated()">
            <button class="movie-btns" type="button" onclick="selectSeat()">좌석선택</button>
        </sec:authorize>
        <sec:authorize access="isAnonymous()">
            <button class="off-btns" type="button" onclick="location.href='/member/login'">로그인 해주세요</button>
        </sec:authorize>
    </div>
</section>

<script>
    $(document).ready(function () {

        addDatesToSlick();
        addTimeToSlick();
        addTheaterToSlick();

        // 날짜 생성 및 목록 추가
        function addDatesToSlick() {
            const dates = createDateList();
            const $slickDateDiv = $('.swiper-date ul');

            dates.forEach(({date, day}) => {
                const $dateLi = $('<li>').addClass('swiper-slide');
                const $dateLink = $('<a>').attr('href', 'javascript:void(0)').text(date + ' ' + day);
                $dateLi.append($dateLink);
                $slickDateDiv.append($dateLi);
            });
        }

        // 시간대 생성 및 목록 추가
        function addTimeToSlick() {
            const times = createTimeList();
            const $slickTimeDiv = $('.swiper-time ul');

            times.forEach(time => {
                const $timeLi = $('<li>').addClass('swiper-slide');
                const $timeLink = $('<a>').attr('href', 'javascript:void(0)').text(time);
                $timeLi.append($timeLink);
                $slickTimeDiv.append($timeLi);
            });
        }

        // 영화관 목록 추가
        function addTheaterToSlick() {
            $.ajax({
                type: "POST",
                url: "/api/theaters",
                data: {
                    movieId: ${movie.movieId}
                },
                success: function (res) {
                    const $swiperTheaterDiv = $('.swiper-theater ul');

                    res.forEach(theater => {
                        const $theaterLi = $('<li>').addClass('swiper-slide');
                        const $theaterLink = $('<a>').attr('href', 'javascript:void(0)').text(theater.theaterName).data('theaterId', theater.theaterId);
                        $theaterLi.append($theaterLink);
                        $swiperTheaterDiv.append($theaterLi);
                    });

                    // AJAX 실행후 이벤트 추가
                    updateSwiperEvent();
                    // 선택 상태 업데이트
                    updateSelectState();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    console.log("통신 실패.");
                }
            });
        };

        function updateSwiperEvent() {
            var snbSwiperDateItem = $('.choose-date .snbSwiper .swiper-wrapper .swiper-slide a');
            var snbSwiperTimeItem = $('.choose-time .snbSwiper .swiper-wrapper .swiper-slide a');
            var snbSwiperTheaterItem = $('.choose-theater .snbSwiper .swiper-wrapper .swiper-slide a');

            $('.movie-ticket-book .snbSwiper .swiper-wrapper .swiper-slide a').on("click", function () {
                var target = $(this).parent(); // a위의 li 선택

                if (target.closest('.snbSwiper').hasClass('swiper-date')) {
                    snbSwiperDateItem.parent().removeClass('on');
                    target.addClass('on');
                    muCenter(target);
                    localStorage.setItem("selectedDate", target.text());
                }

                if (target.closest('.snbSwiper').hasClass('swiper-time')) {
                    snbSwiperTimeItem.parent().removeClass('on');
                    target.addClass('on');
                    muCenter(target);
                    localStorage.setItem("selectedTime", target.text());
                }

                if (target.closest('.snbSwiper').hasClass('swiper-theater')) {
                    snbSwiperTheaterItem.parent().removeClass('on');
                    target.addClass('on');
                    muCenter(target);
                    localStorage.setItem("selectedTheater", target.text());
                    localStorage.setItem("theaterId", target.find('a').data('theaterId'));
                }
            });
        }

        //스와이퍼 설정
        var swiper = new Swiper('.snbSwiper', {
            slidesPerView: 2,
            preventClicks: true,
            preventClicksPropagation: false,
            observer: true,
            observeParents: true,
            breakpoints: {
                768: {
                    slidesPerView: 3,
                },
                1024: {
                    slidesPerView: 5,
                }
            }
        });

        // 선택 상태 업데이트
        function updateSelectState() {
            let dateList = $('.choose-date .swiper-slide a');
            let timeList = $('.choose-time .swiper-slide a');
            let theaterList = $('.choose-theater .swiper-slide a');

            dateList.each(function () {
                if ($(this).text() == localStorage.getItem("selectedDate")) {
                    $(this).parent().addClass('on');
                }
            });
            timeList.each(function () {
                if ($(this).text() == localStorage.getItem("selectedTime")) {
                    $(this).parent().addClass('on');
                }
            });
            theaterList.each(function () {
                console.log($(this).text(), localStorage.getItem("selectedTheater"));
                if ($(this).text() == localStorage.getItem("selectedTheater")) {
                    $(this).parent().addClass('on');
                }
            });
        };
    });

    // 중앙에 위치 시키기
    function muCenter(target) {
        if (target.closest('.snbSwiper').hasClass('swiper-date')) {
            var snbwrap = $('.choose-date .snbSwiper .swiper-wrapper');
        }
        if (target.closest('.snbSwiper').hasClass('swiper-time')) {
            var snbwrap = $('.choose-time .snbSwiper .swiper-wrapper');
        }
        if (target.closest('.snbSwiper').hasClass('swiper-theater')) {
            var snbwrap = $('.choose-theater .snbSwiper .swiper-wrapper');
        }
        var targetPos = target.position();
        var box = $('.snbSwiper');
        var boxHarf = box.width() / 2;
        var pos;
        var listWidth = 0;

        snbwrap.find('.swiper-slide').each(function () {
            listWidth += $(this).outerWidth();
        })

        var selectTargetPos = targetPos.left + target.outerWidth() / 2;

        if (selectTargetPos <= boxHarf) { // left
            pos = 0;
        } else if ((listWidth - selectTargetPos) <= boxHarf) {     //right
            pos = listWidth - box.width();
        } else {
            pos = selectTargetPos - boxHarf;
        }

        setTimeout(function () {
            snbwrap.css({
                "transform": "translate3d(" + (pos * -1) + "px, 0, 0)",
                "transition-duration": "500ms"
            })
        }, 200);
    };

    function selectSeat() {
        if (!localStorage.getItem("selectedTime")) {
            alert("시간을 선택해주세요");
            return;
        }
        if (!localStorage.getItem("selectedDate")) {
            alert("일자를 선택해주세요");
            return;
        }
        if (!localStorage.getItem("selectedTheater")) {
            alert("영화관을 선택해주세요");
            return;
        }
        location.href = 'movieSeats?movieId=${movie.movieId}';
    }

    // 날짜 생성
    function createDateList() {
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const dates = [];
        const weekDays = ["일", "월", "화", "수", "목", "금", "토"];

        for (let i = 0; i < 30; i++) {
            const futureDate = new Date(today);
            futureDate.setDate(futureDate.getDate() + i);
            const dayOfWeek = weekDays[futureDate.getDay()];
            const formattedDate = `${"${futureDate.getMonth() + 1}"}월 ${"${futureDate.getDate()}일"}`;

            // 오늘 날짜와 비교
            let label = "(" + dayOfWeek + ")";
            if (futureDate.getTime() === today.getTime()) {
                label = "(오늘)";
            }

            dates.push({date: formattedDate, day: label});
        }
        return dates;
    }

    // 시간대 생성
    function createTimeList() {
        const times = [];
        const now = new Date();
        let currentHour = now.getHours();
        let currentMinutes = now.getMinutes();

        if (currentMinutes >= 30) {
            currentMinutes = 30;
        } else {
            currentMinutes = 0;
        }

        // 30분 단위로 24시간을 배열
        for (let i = 0; i < 48; i++) {
            const formattedTime = `${"${currentHour.toString().padStart(2, '0')}"}:${"${currentMinutes.toString().padStart(2, '0')}"}`;
            times.push(formattedTime);

            if (currentMinutes === 30) {
                currentHour++;
                currentMinutes = 0;
            } else {
                currentMinutes = 30;
            }

            // 24시간을 초과하는 경우에 대한 처리
            if (currentHour >= 24) {
                currentHour -= 24;
            }
        }
        return times;
    }

    function promptLogin() {
        if (confirm("로그인이 필요한 기능입니다. 로그인 하시겠습니까?")) {
            window.location.href = "/member/login";
        }
    }

</script>

<jsp:include page="../movie/reviews.jsp"/>