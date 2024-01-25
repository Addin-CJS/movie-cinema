<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



<!----filter-search-box ---->
<div class="movie-card-section">
    <c:forEach var="movie" items="${movieList.content}">
        <div class="card">
            <img src="${movie.mvImg}">
            <div class="card-content">
                <p class="movie-name">
                    <a href="/showDetail?movieId=${movie.movieId}"> ${movie.mvTitle}</a>
                </p>
                <div class="movie-info">
                    <p class="time">11:30 <span>14:45<span class="d3">3D</span> 16:05<span
                            class="d3">3D</span></span>
                        18:40 21:00 23:15</p>
                </div>
            </div>
        </div>
    </c:forEach>
</div>




<%--<script>--%>
<%--    document.getElementById("search-icon").addEventListener("click", function() {--%>

<%--        console.log("검색 버튼이 클릭되었습니다.");--%>


<%--    });--%>

<%--    document.addEventListener("DOMContentLoaded", function() {--%>
<%--        fetchMovies(); // 페이지 로딩 시 영화 목록 불러오기--%>
<%--    });--%>

<%--    function fetchMovies() {--%>
<%--        $.ajax({--%>
<%--            url: 'moviesList', // 서버 엔드포인트 주소--%>
<%--            type: 'GET', // HTTP 메소드--%>
<%--            dataType: 'json', // 응답 데이터 타입--%>
<%--            success: function(data) {--%>
<%--                console.log(data);--%>
<%--                updateMovieList(data);--%>
<%--            },--%>
<%--            error: function(error) {--%>
<%--                console.error('Error:', error);--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>

<%--    function updateMovieList(data) {--%>
<%--        var movieListSection = document.querySelector('.movie-card-section');--%>

<%--        while (movieListSection.firstChild) {--%>
<%--            movieListSection.removeChild(movieListSection.firstChild);--%>
<%--        }--%>

<%--        data.content.forEach(movie => {--%>
<%--            // 각 영화 정보에 대한 card 요소 생성--%>
<%--            var card = document.createElement('div');--%>
<%--            card.className = 'card';--%>

<%--            // 영화 이미지--%>
<%--            var img = document.createElement('img');--%>
<%--            img.src = movie.mvImg;--%>
<%--            card.appendChild(img);--%>

<%--            // 콘텐츠 영역--%>
<%--            var content = document.createElement('div');--%>
<%--            content.className = 'card-content';--%>

<%--            // 영화 제목--%>
<%--            var title = document.createElement('p');--%>
<%--            title.className = 'movie-name';--%>

<%--            var link = document.createElement('a');--%>
<%--            link.href = `/showDetail?movieId=${"${movie.movieId}"}`;--%>

<%--            console.log("Movie ID:", movie.movieId);--%>
<%--            link.textContent = movie.mvTitle;--%>
<%--            title.appendChild(link);--%>


<%--            var info = document.createElement('div');--%>
<%--            info.className = 'movie-info';--%>



<%--            content.appendChild(title);--%>
<%--            content.appendChild(info);--%>
<%--            card.appendChild(content);--%>

<%--            movieListSection.appendChild(card);--%>
<%--        });--%>
<%--    }--%>
<%--</script>--%>


