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
                <img src="${movie.mvImg}">
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
            <c:when test="${empty searchKeyword}">
                   <a href="${pageContext.request.contextPath}/movieHome?page=0">처음으로</a>
                   <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage - 1}" ${nowPage <= 1 ? 'style="display:none;"' : ''}>이전</a>
                   <c:forEach begin="${startPage-1}" end="${endPage}" var="pageNum">
                       <a href="${pageContext.request.contextPath}/movieHome?page=${pageNum}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum+1}</a>
                   </c:forEach>
                   <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage + 1}" ${nowPage >= movieList.getTotalPages()-1 ? 'style="display:none;"' : ''}>다음</a>
                   <a href="${pageContext.request.contextPath}/movieHome?page=${totalPages-1}">마지막으로</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/movieHome?page=0&searchKeyword=${fn:escapeXml(searchKeyword)}">처음으로</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage}&searchKeyword=${fn:escapeXml(searchKeyword)}" ${nowPage <= 1 ? 'style="display:none;"' : ''}>이전</a>
                <c:forEach begin="${startPage-1}" end="${endPage}" var="pageNum">
                    <a href="${pageContext.request.contextPath}/movieHome?page=${pageNum}&searchKeyword=${fn:escapeXml(searchKeyword)}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum+1}</a>
                </c:forEach>
                <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage + 1}&searchKeyword=${fn:escapeXml(searchKeyword)}" ${nowPage >= movieList.getTotalPages() ? 'style="display:none;"' : ''}>다음</a>
                <a href="${pageContext.request.contextPath}/movieHome?page=${totalPages}&searchKeyword=${fn:escapeXml(searchKeyword)}" ${not empty searchKeyword ? 'style="display:none;"' : ''}>마지막으로</a>
            </c:otherwise>
        </c:choose>
    </div>
    <!---- pagination ---->
</section>

<script>
     function submitSearchForm() {
        document.searchForm.submit();
     }
</script>

<jsp:include page="../layouts/footer.jsp"/>


