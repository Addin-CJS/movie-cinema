<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>
<section>
    <div class="filter-search-box">
        <div class="filters-box">
            <div class="filter-box">
                <div class="all-filters filters">
                    <a href="/movieHome?page=0">무비차트 <i class="fa fa-film"></i></a>
                </div>
                <div class="date-filters filters">
                    개봉일 <i class="fa fa-angle-down"></i>
                    <ul id="release-list" style="display: none;">
                        <li><a href="/movieHome?releaseDate=1990">1990년대</a></li>
                        <li><a href="/movieHome?releaseDate=2000">2000년대</a></li>
                        <li><a href="/movieHome?releaseDate=2010">2010년대</a></li>
                        <li><a href="/movieHome?releaseDate=2020~">2020년 이후</a></li>
                    </ul>
                </div>
                <div class="category-filters filters">
                    장르별 <i class="fa fa-angle-down"></i>
                    <ul id="genre-list" style="display: none;">
                        <li><a href="/movieHome?category=Action">Action</a></li>
                        <li><a href="/movieHome?category=Adventure">Adventure</a></li>
                        <li><a href="/movieHome?category=Animation">Animation</a></li>
                        <li><a href="/movieHome?category=Comedy">Comedy</a></li>
                        <li><a href="/movieHome?category=Crime">Crime</a></li>
                        <li><a href="/movieHome?category=Documentary">Documentary</a></li>
                        <li><a href="/movieHome?category=Drama">Drama</a></li>
                        <li><a href="/movieHome?category=Fantasy">Fantasy</a></li>
                        <li><a href="/movieHome?category=History">History</a></li>
                        <li><a href="/movieHome?category=Horror">Horror</a></li>
                        <li><a href="/movieHome?category=Romance">Romance</a></li>
                        <li><a href="/movieHome?category=Science Fiction">Science Fiction</a></li>
                        <li><a href="/movieHome?category=Thriller">Thriller</a></li>
                        <li><a href="/movieHome?category=Western">Western</a></li>
                    </ul>
                </div>
                <div class="category-filters filters">
                    <a href="/movieHome?comingSoon">상영예정작 </a>
                </div>
            </div>
            <form name="searchForm" method="get" action="${pageContext.request.contextPath}/movieHome">
                <div class="search-filters">
                    <input type="text" id="search-input" name="searchKeyword" placeholder="검색어를 입력해주세요"
                           value="${fn:escapeXml(searchKeyword)}">
                    <i class="fa fa-search" id="search-icon" onclick="submitSearchForm()"></i>
                </div>
            </form>
        </div>
        <div class="search-bar">
            <div class="bar"></div>
        </div>
    </div>
    <!----filter-search-box ---->
    <div class="movie-card-section">
        <c:forEach var="movie" items="${movieList.content}">
            <div class="card">
                <a href="/showDetail?movieId=${movie.movieId}">
                    <img src="${movie.mvImg}"
                         onerror="this.src='https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';">
                </a>
                <div class="card-content">
                    <p class="movie-name">
                        <a href="/showDetail?movieId=${movie.movieId}"> ${movie.mvTitle}</a>
                    </p>
                    <div class="movie-info">
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${movieList.totalElements == 0}">
            <p>검색 결과가 없습니다.</p>
        </c:if>
    </div>

    <div class="pagination">
        <c:choose>
            <c:when test="${not empty searchKeyword}">
                <a href="${pageContext.request.contextPath}/movieHome?page=0&searchKeyword=${fn:escapeXml(searchKeyword)}"><<</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage - 1}&searchKeyword=${fn:escapeXml(searchKeyword)}" ${nowPage <= 0 ? 'style="display:none;"' : ''}><</a>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <a href="${pageContext.request.contextPath}/movieHome?page=${pageNum}&searchKeyword=${fn:escapeXml(searchKeyword)}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum + 1}</a>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage + 1}&searchKeyword=${fn:escapeXml(searchKeyword)}" ${nowPage >= totalPages - 1 ? 'style="display:none;"' : ''}>></a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${totalPages - 1}&searchKeyword=${fn:escapeXml(searchKeyword)}">>></a>
            </c:when>

            <c:when test="${not empty selectedCategory}">
                <a href="${pageContext.request.contextPath}/movieHome?page=0&category=${fn:escapeXml(selectedCategory)}"><<</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage - 1}&category=${fn:escapeXml(selectedCategory)}" ${nowPage <= 0 ? 'style="display:none;"' : ''}><</a>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <a href="${pageContext.request.contextPath}/movieHome?page=${pageNum}&category=${fn:escapeXml(selectedCategory)}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum + 1}</a>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage + 1}&category=${fn:escapeXml(selectedCategory)}" ${nowPage >= totalPages - 1 ? 'style="display:none;"' : ''}>></a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${totalPages - 1}&category=${fn:escapeXml(selectedCategory)}">>></a>
            </c:when>

            <c:when test="${not empty selectedReleaseDate}">
                <a href="${pageContext.request.contextPath}/movieHome?page=0&releaseDate=${fn:escapeXml(selectedReleaseDate)}"><<</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage - 1}&releaseDate=${fn:escapeXml(selectedReleaseDate)}" ${nowPage <= 0 ? 'style="display:none;"' : ''}><</a>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <a href="${pageContext.request.contextPath}/movieHome?page=${pageNum}&releaseDate=${fn:escapeXml(selectedReleaseDate)}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum + 1}</a>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage + 1}&releaseDate=${fn:escapeXml(selectedReleaseDate)}" ${nowPage >= totalPages - 1 ? 'style="display:none;"' : ''}>></a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${totalPages - 1}&releaseDate=${fn:escapeXml(selectedReleaseDate)}">>></a>
            </c:when>

            <c:when test="${not empty comingSoon}">
                <a href="${pageContext.request.contextPath}/movieHome?page=0&comingSoon=${fn:escapeXml(comingSoon)}"><<</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage - 1}&comingSoon=${fn:escapeXml(comingSoon)}" ${nowPage <= 0 ? 'style="display:none;"' : ''}><</a>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <a href="${pageContext.request.contextPath}/movieHome?page=${pageNum}&comingSoon=${fn:escapeXml(comingSoon)}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum + 1}</a>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage + 1}&comingSoon=${fn:escapeXml(comingSoon)}" ${nowPage >= totalPages - 1 ? 'style="display:none;"' : ''}>></a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${totalPages - 1}&comingSoon=${fn:escapeXml(comingSoon)}">>></a>
            </c:when>

            <c:otherwise>
                <a href="${pageContext.request.contextPath}/movieHome?page=0"><<</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage - 1}" ${nowPage <= 0 ? 'style="display:none;"' : ''}><</a>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <a href="${pageContext.request.contextPath}/movieHome?page=${pageNum}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum + 1}</a>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage + 1}" ${nowPage >= totalPages - 1 ? 'style="display:none;"' : ''}>></a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${totalPages - 1}">>></a>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<script>
    function submitSearchForm() {
        document.searchForm.submit();
    }
    document.querySelector('.date-filters').addEventListener('click', function () {
        var releaseList = document.getElementById('release-list');
        if (releaseList.style.display === 'none') {
            releaseList.style.display = 'block';
        } else {
            releaseList.style.display = 'none';
        }
    });

    document.querySelector('.category-filters').addEventListener('click', function () {
        var genreList = document.getElementById('genre-list');
        if (genreList.style.display === 'none') {
            genreList.style.display = 'block';
        } else {
            genreList.style.display = 'none';
        }
    });

    $(document).ready(function () {
        let totalPages = ${totalPages};
        let nowPage = ${nowPage}+1;
        $(".bar").css("width", nowPage * 100 / totalPages + "%");
    });
</script>

<jsp:include page="../layouts/footer.jsp"/>