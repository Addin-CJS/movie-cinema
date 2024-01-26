<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div id="search-results-count"></div>

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

<script>


    $(document).ready(function() {
        // 검색 버튼 클릭 이벤트
        $("#search-icon").click(function() {
            var searchKeyword = $("#search-input").val(); // 검색어 입력값 가져오기
            fetchMovies(1, searchKeyword); // 검색어를 인자로 넘겨 영화 목록 가져오기
        });
    });

    function fetchMovies(page=1, searchKeyword = '') {
        $.ajax({
            url: 'moviesList',
            type: 'GET',
            data: {
                page: page,
                size: 8,
                searchKeyword: searchKeyword
            },
            dataType: 'json',
            success: function(data) {
                console.log("통신성공")
                searchMovieList(data); // 영화 목록 업데이트
                updatePagination(data, searchKeyword);
            },
            error: function(error) {
                console.error('Error:', error);
            }
        });
    }

    function searchMovieList(data) {
        var movieListSection = $('.movie-card-section').empty();

        data.content.forEach(function(movie) {
            // 각 영화 정보에 대한 card 요소 생성 및 추가
            var cardHtml = '<div class="card">' +
                '<img src="' + movie.mvImg + '">' +
                '<div class="card-content">' +
                '<p class="movie-name">' +
                '<a href="/showDetail?movieId=' + movie.movieId + '">' + movie.mvTitle + '</a>' +
                '</p></div></div>';

            movieListSection.append(cardHtml);
        });
    }


</script>

