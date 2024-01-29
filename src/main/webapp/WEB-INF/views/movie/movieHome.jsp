<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="../layouts/header.jsp"/>
<section>
    <div class="filter-search-box">
        <div class="filters-box">
            <div class="all-filters filters">
                All formats <i class="fa fa-angle-down"></i>
            </div>

            <div class="date-filters filters">
                By Date <i class="fa fa-angle-down"></i>
            </div>

            <div class="category-filters filters">
                By category <i class="fa fa-angle-down"></i>
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
                    <li><a href="/movieHome?category=Thriller">Western</a></li>
                </ul>
            </div>

            <div class="category-filters filters">
                Coming soon
            </div>
        </div>

       <form name="searchForm" method="get" action="${pageContext.request.contextPath}/movieHome">
           <div class="search-filters">
               <input type="text" id="search-input" name="searchKeyword" placeholder="검색어를 입력해주세요" value="${fn:escapeXml(searchKeyword)}">
               <i class="fa fa-search" id="search-icon" onclick="submitSearchForm()"></i>
           </div>
       </form>

        <div class="search-bar">
          <div class="bar"></div>
        </div>
    </div>

    <div id="search-results-count">
    </div>

    <!----filter-search-box ---->
    <div class="movie-card-section">
        <c:forEach var="movie" items="${movieList.content}">
            <div class="card">
                <img src="${movie.mvImg}" onerror="this.src='https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';">
                <div class="card-content">
                    <p class="movie-name">
                        <a href="/showDetail?movieId=${movie.movieId}"> ${movie.mvTitle}</a>
                    </p>
                    <div class="movie-info">
                        <!-- 내용 생략 -->
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${movieList.totalElements == 0}">
            <!-- 검색 결과가 없는 경우 -->
            <p>검색 결과가 없습니다.</p>
        </c:if>
    </div>


    <div class="pagination">
        <c:choose>

            <c:when test="${not empty searchKeyword}">
                <a href="${pageContext.request.contextPath}/movieHome?page=0&searchKeyword=${fn:escapeXml(searchKeyword)}">처음으로</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage - 1}&searchKeyword=${fn:escapeXml(searchKeyword)}" ${nowPage <= 0 ? 'style="display:none;"' : ''}>이전</a>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <a href="${pageContext.request.contextPath}/movieHome?page=${pageNum}&searchKeyword=${fn:escapeXml(searchKeyword)}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum + 1}</a>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage + 1}&searchKeyword=${fn:escapeXml(searchKeyword)}" ${nowPage >= totalPages - 1 ? 'style="display:none;"' : ''}>다음</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${totalPages - 1}&searchKeyword=${fn:escapeXml(searchKeyword)}">마지막으로</a>
            </c:when>


            <c:when test="${not empty selectedCategory}">
                <a href="${pageContext.request.contextPath}/movieHome?page=0&category=${fn:escapeXml(selectedCategory)}">처음으로</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage - 1}&category=${fn:escapeXml(selectedCategory)}" ${nowPage <= 0 ? 'style="display:none;"' : ''}>이전</a>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <a href="${pageContext.request.contextPath}/movieHome?page=${pageNum}&category=${fn:escapeXml(selectedCategory)}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum + 1}</a>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage + 1}&category=${fn:escapeXml(selectedCategory)}" ${nowPage >= totalPages - 1 ? 'style="display:none;"' : ''}>다음</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${totalPages - 1}&category=${fn:escapeXml(selectedCategory)}">마지막으로</a>
            </c:when>


            <c:otherwise>
                <a href="${pageContext.request.contextPath}/movieHome?page=0">처음으로</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage - 1}" ${nowPage <= 0 ? 'style="display:none;"' : ''}>이전</a>
                <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                    <a href="${pageContext.request.contextPath}/movieHome?page=${pageNum}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum + 1}</a>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage + 1}" ${nowPage >= totalPages - 1 ? 'style="display:none;"' : ''}>다음</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${totalPages - 1}">마지막으로</a>
            </c:otherwise>
        </c:choose>
    </div>


    <!---- pagination ---->
</section>

<script>
     function submitSearchForm() {
        document.searchForm.submit();
     }

     document.querySelector('.category-filters').addEventListener('click', function() {
         var genreList = document.getElementById('genre-list');
         if(genreList.style.display === 'none') {
             genreList.style.display = 'block';
         } else {
             genreList.style.display = 'none';
         }
     });
     function filterByCategory(category) {
         window.location.href = '/movieHome?category=' + category;
     }


</script>

<jsp:include page="../layouts/footer.jsp"/>


