<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="layouts/header.jsp"/>

<section>
    <div class="popular-movie-slider">
        <img src="https://imageio.forbes.com/blogs-images/scottmendelson/files/2014/10/2v00kg8.jpg?format=jpg&width=1200"
             class="poster">
        <div class="popular-movie-slider-content">
            <p class="release">2017</p>
            <h2 class="movie-name">${movie.mvTitle}</h2>
            <ul class="category">
                <p>${movie.mvGenre}</p>
            </ul>
            <p class="desc">${movie.mvDescription}</p>

            <div class="movie-info">
                <i class="fa fa-clock-o"> &nbsp;&nbsp;&nbsp;<span>164 min.</span></i>
                <i class="fa fa-volume-up"> &nbsp;&nbsp;&nbsp;<span>Subtitles</span></i>
                <i class="fa fa-circle"> &nbsp;&nbsp;&nbsp;<span>Imdb: <b>9.1/10</b></span></i>
            </div>

            <div class="movie-btns">
                <button> ▶ 예고편 보기</button>
            </div>
        </div>
    </div>
    <div class="movie-ticket-book">
        <div class="choose-date">
            <p class="heading">
                choose date:
            </p>
            <div class="wrapper">
                <div class="carousel owl-carousel">

                    <div class="card card-1">
                        <p>JUN 1t</p>
                        <p>MON</p>
                    </div>
                    <div class="card card-2">
                        <p>JUN 2nd</p>
                        <p>TUE</p>
                    </div>
                    <div class="card card-3">
                        <p>JUN 3nd</p>
                        <p>wed</p>
                    </div>
                    <div class="card card-4">
                        <p>JUN 4nd</p>
                        <p>thu</p>
                    </div>
                </div>
                <div class="marker"></div>
            </div>
        </div>
        <div class="choose-time">
            <p class="heading">
                avalible times:
            </p>
            <div class="wrapper">
                <div class="carousel owl-carousel">

                    <div class="card card-1">
                        <p>3D</p>
                        <p>14:45</p>
                    </div>
                    <div class="card card-2">
                        <p>3D</p>
                        <p>11:45</p>
                    </div>
                    <div class="card card-3">
                        <p>2D</p>
                        <p>12:15</p>
                    </div>
                    <div class="card card-4">
                        <p>3D</p>
                        <p>13:00</p>
                    </div>
                </div>
                <div class="marker"></div>
            </div>
        </div>
        <button type="button" onclick="location.href='movieSeats?movieId=${movie.movieId}'">좌석선택하기</button>
    </div>
    <!---movie-ticket-book-->

<jsp:include page="movie/reviews.jsp"/>