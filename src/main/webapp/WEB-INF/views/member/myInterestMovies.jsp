    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <section>
    <div class="myInterest">
        <table>
            <thead>
                <tr id="myInterestTitle">
                    <th colspan="5">나의 관심영화 리스트</th>
                </tr>
            </thead>
    <tbody>
    <c:if test="${not empty interestMoviesPage}">

            <c:forEach var="movie" items="${interestMoviesPage.content}">
            <tr>
                <td>${moviesInfo[movie.movieId].mvTitle} - <img  width="50" src="${moviesInfo[movie.movieId].mvImg}" alt="Movie Image"/></td>
            </tr>
            </c:forEach>

    </c:if>
    </tbody>
        </table>
        <a href="javascript:loadInterestMoviesPage(0)">처음</a>

        <c:if test="${nowPage > 1}">
            <a href="javascript:loadInterestMoviesPage(${nowPage - 2})">이전</a>
        </c:if>

        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <a href="javascript:loadInterestMoviesPage(${i - 1})">${i}</a>
        </c:forEach>

        <c:if test="${nowPage < totalPages}">
            <a href="javascript:loadInterestMoviesPage(${nowPage})">다음</a>
        </c:if>

        <a href="javascript:loadInterestMoviesPage(${totalPages - 1})">마지막</a>
    </div>
    </section>