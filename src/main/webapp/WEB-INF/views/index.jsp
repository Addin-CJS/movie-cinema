<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: jckim
  Date: 1/15/24
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="layouts/header.jsp"/>
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
                        <p class="time">11:30 <span>14:45<span class="d3">3D</span> 16:05<span
                                class="d3">3D</span></span>
                            18:40 21:00 23:15</p>
                    </div>
                </div>
            </div>
        </c:forEach>
        <div class="pagination">
            <a href="/show?page=1">처음으로</a>
            <a href="/show?page=${startPage - pageGroupSize}" ${startPage == 1 ? 'style="display:none;"' : ''}>이전</a>
            <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                <a href="/show?page=${pageNum}" ${pageNum == nowPage ? 'class="active"' : ''}>${pageNum}</a>
            </c:forEach>
            <a href="/show?page=${startPage + pageGroupSize}" ${endPage >= movieList.getTotalPages() ? 'style="display:none;"' : ''}>다음</a>
        </div>
    </div>
    <div class="show">
        <div class="show-bar">
            <div class="bar"></div>
        </div>
        <button>Show more</button>
    </div>
</section>
<jsp:include page="layouts/footer.jsp"/>


