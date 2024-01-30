<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="../layouts/header.jsp"/>

<section>
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

        </div>
    </div>
    <div class="movie-ticket-book">
        <div class="choose-date">
            <p>상영 일자</p>
            <div class="slick-date">
            </div>
        </div>
        <div class="choose-time">
            <p>상영 시간</p>
            <div class="slick-time">
            </div>
        </div>
        <button type="button" onclick="location.href='movieSeats?movieId=${movie.movieId}'">좌석선택하기</button>
    </div>
    <!---movie-ticket-book-->

    <script>
        $(document).ready(function() {
            addDatesToSlick();
            addTimeToSlick();
            $('.slick-date').slick({
                centerPadding: '30px',
                slidesToShow: 5,
                arrows: true,
                prevArrow: '<button type="button" class="slick-prev"><</button>',
                nextArrow: '<button type="button" class="slick-next">></button>',
                responsive: [
                    {
                        breakpoint: 768,
                        settings: {
                            arrows: false,
                            centerMode: true,
                            centerPadding: '40px',
                            slidesToShow: 3
                        }
                    },
                    {
                        breakpoint: 480,
                        settings: {
                            arrows: false,
                            centerMode: true,
                            centerPadding: '40px',
                            slidesToShow: 1
                        }
                    }
                ]
            });

            $('.slick-time').slick({
                centerPadding: '30px',
                slidesToShow: 5,
                arrows: true,
                prevArrow: '<button type="button" class="slick-prev"><</button>',
                nextArrow: '<button type="button" class="slick-next">></button>',
                responsive: [
                    {
                        breakpoint: 768,
                        settings: {
                            arrows: false,
                            centerMode: true,
                            centerPadding: '40px',
                            slidesToShow: 3
                        }
                    },
                    {
                        breakpoint: 480,
                        settings: {
                            arrows: false,
                            centerMode: true,
                            centerPadding: '40px',
                            slidesToShow: 1
                        }
                    }
                ]
            });

            // 날짜 생성
            function createDateList() {
                const today = new Date();
                today.setHours(0, 0, 0, 0);
                const dates = [];
                const weekDays = ["일", "월", "화", "수", "목", "금", "토"];

                for (let i = 0; i < 15; i++) {
                    const futureDate = new Date(today);
                    futureDate.setDate(futureDate.getDate() + i);
                    const dayOfWeek = weekDays[futureDate.getDay()];
                    const formattedDate = `${"${futureDate.getMonth() + 1}"}월 ${"${futureDate.getDate()}일"}`;

                    // 오늘 날짜와 비교
                    let label = "("+dayOfWeek+")";
                    if (futureDate.getTime() === today.getTime()) {
                        label = "(오늘)";
                    }

                    dates.push({ date: formattedDate, day: label });
                }
                return dates;
            }

            // 날짜 목록 추가
            function addDatesToSlick() {
                const dates = createDateList();
                const $slickDateDiv = $('.slick-date');

                dates.forEach(({ date, day }) => {
                    const $dateContainer = $('<div>').addClass('date-container');
                    const $dateDiv = $('<div>').text(date).addClass('date');
                    const $dayDiv = $('<div>').text(day).addClass('day');

                    $dateContainer.append($dateDiv).append($dayDiv);
                    $slickDateDiv.append($dateContainer);
                });
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

            // 시간대 목록 추가
            function addTimeToSlick() {
                const times = createTimeList();
                const $slickTimeDiv = $('.slick-time');

                times.forEach(time => {
                    const $timeDiv = $('<div>').text(time).addClass("time");
                    $slickTimeDiv.append($timeDiv);
                });
            }
        });

    </script>

<jsp:include page="../movie/reviews.jsp"/>