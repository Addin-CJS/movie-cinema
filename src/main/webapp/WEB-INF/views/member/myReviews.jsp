<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<section>
    <div class="myReview">
        <table class="myReviewList">
            <thead>
                <tr id="myReviewTitle">
                    <th colspan="7">나의 영화 리뷰 리스트</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="myReview" items="${myReviewList}">
                    <tr id="myReviewItem">
                        <td>${myReview.reviewId}</td>
                        <td>${myReview.reviewWriter}</td>
                        <td>
                            <!-- 별점 표시 부분 -->
                            <c:forEach var="i" begin="1" end="${myReview.starRating}">
                                <span class="yellow-star">★</span>
                            </c:forEach>
                            <c:forEach var="i" begin="${myReview.starRating + 1}" end="5">
                                <span class="gray-star">★</span>
                            </c:forEach>
                        </td>
                        <td id="myReviewContent"><a href="/showDetail?movieId=${myReview.movieNo}">${myReview.reviewContent}</a></td>
                        <td>${fn:substringBefore(myReview.createReviewDate.toString(), 'T')}</td>
                   </tr>
                </c:forEach>
             </tbody>
        </table>
        <div class="myReviewPagination">
            <c:if test="${nowPage > 0}">
                <a href="javascript:loadReviewPage(${nowPage - 1})">이전</a>
            </c:if>
            <c:forEach begin="${startPage}" end="${endPage}" var="page">
                <a href="javascript:loadReviewPage(${page})" class="${page == nowPage ? 'active' : ''}">[${page + 1}]</a>
            </c:forEach>
            <c:if test="${nowPage + 1 < totalPages}">
                <a href="javascript:loadReviewPage(${nowPage + 1})">다음</a>
            </c:if>
        </div>
</div>
</section>