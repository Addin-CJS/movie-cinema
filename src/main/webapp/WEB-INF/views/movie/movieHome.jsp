<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

            <div class="search-filters">
                <input type="text" id="search-input" name="movieTitle" placeholder="Search by name...">
                <i class="fa fa-search" id="search-icon"></i>
            </div>



        <div class="search-bar">
          <div class="bar"></div>
        </div>
    </div>

    <jsp:include page="movieList.jsp"/>


    <div class="pagination">
        <a href="${pageContext.request.contextPath}/movieHome?page=1">처음으로</a>
        <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage - 1}" ${nowPage <= 1 ? 'style="display:none;"' : ''}>이전</a>
        <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
            <a href="${pageContext.request.contextPath}/movieHome?page=${pageNum}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum}</a>
        </c:forEach>
        <a href="${pageContext.request.contextPath}/movieHome?page=${nowPage + 1}" ${nowPage >= movieList.getTotalPages() ? 'style="display:none;"' : ''}>다음</a>
        <a href="${pageContext.request.contextPath}/movieHome?page=${movieList.getTotalPages()}">마지막으로</a>
    </div>
    <!---- pagination ---->
</section>



<jsp:include page="../layouts/footer.jsp"/>


