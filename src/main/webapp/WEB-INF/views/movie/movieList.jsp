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

        // 검색 아이콘 클릭 이벤트 바인딩
        $("#search-icon").click(function() {
            var searchKeyword = $("#search-input").val();
            fetchMovies(searchKeyword, 0);
        });


        $(document).on('click', '.page-num', function(e) {
            e.preventDefault();
            var page = parseInt($(this).data('page'));
            fetchMovies(currentSearchKeyword, page);

            window.scrollTo(0, 0);
        });
    });

    // AJAX를 통해 영화 데이터를 가져오는 함수
    function fetchMovies(searchKeyword, page) {
        currentSearchKeyword = searchKeyword; // 현재 검색어를 전역 변수에 저장
        $.ajax({
            url: 'moviesList',
            type: 'GET',
            data: { searchKeyword: searchKeyword, page: page },
            dataType: 'json',
            success: function(data) {
                console.log("통신성공", data);
                searchMovieList(data, page);
            },
            error: function(error) {
                console.error('Error:', error);
            }
        });
    }

    // 영화 목록과 페이지네이션을 화면에 표시하는 함수
    function searchMovieList(data, currentPage) {
        var movieListSection = $('.movie-card-section').empty();
        var paginationSection = $('.pagination').empty();

        data.content.forEach(function(movie) {
            var cardHtml = '<div class="card">' +
                '<img src="' + movie.mvImg + '">' +
                '<div class="card-content">' +
                '<p class="movie-name">' +
                '<a href="/showDetail?movieId=' + movie.movieId + '">' + movie.mvTitle + '</a>' +
                '</p></div></div>';
            movieListSection.append(cardHtml);
        });

        addPagination(paginationSection, currentPage, data.totalPages);
    }

    // 페이지네이션을 생성하는 함수
    function addPagination(paginationSection, currentPage, totalPages) {
        paginationSection.empty();



        //처음페이지 하는 부분
        if (currentPage > 0) {
            paginationSection.append('<a href="#" class="page-num" data-page="0">ajax 처음으로</a>');
        } else {
            paginationSection.append('<a href="#" class="page-num" data-page="0">ajax 처음으로</a>');
        }


        //이전페이지 하는부분
        if (currentPage > 0) {
            paginationSection.append('<a href="#" class="page-num" data-page="' + (currentPage - 1) + '">Prev</a>');
        }

        var pageGroupSize = 5;
        var currentPageGroup = Math.floor(currentPage / pageGroupSize);
        var startPage = currentPageGroup * pageGroupSize;
        var endPage = Math.min(startPage + pageGroupSize, totalPages);



        //페이지 결과에 따라 페이지 블럭 추가
        for (let i = startPage; i < endPage; i++) {
            var activeClass = currentPage === i ? 'active' : '';
            paginationSection.append(`<a href="#" class="page-num ${"${activeClass}"}" data-page="${"${i}"}">${"${i + 1}"}</a>`);
        }

        // 다음 추가 버튼
        if (currentPage + 1 < totalPages) {
            paginationSection.append('<a href="#" class="page-num" data-page="' + (currentPage + 1) + '">Next</a>');
        } else {
            paginationSection.append('<span class="disabled">Next</span>');
        }

        //마지막으로 버튼
        if (currentPage + 1 < totalPages) {
            paginationSection.append('<a href="#" class="page-num" data-page="' + (totalPages - 1) + '">ajax 마지막으로</a>');
        } else {
            paginationSection.append('<a href="#" class="page-num" data-page="' + (totalPages - 1) + '">ajax 마지막으로</a>');
        }



    }


</script>


