<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<section>
    <div class="myReview">
        <div class="myReviewList">
            <h2>나의 영화 후기</h2>
            <div>
                <c:forEach var="myReview" items="${myReviewList}">
                    <div id="myReviewItem">
                        <div class="reviewId">${myReview.reviewId}</div>
                        <div class="reviewWriter">${myReview.reviewWriter}</div>
                        <div class="starRating">
                            <c:forEach var="i" begin="1" end="${myReview.starRating}">
                                <span class="yellow-star">★</span>
                            </c:forEach>
                            <c:forEach var="i" begin="${myReview.starRating + 1}" end="5">
                                <span class="gray-star">★</span>
                            </c:forEach>
                        </div>
                        <div class="myReviewContent"><a href="/showDetail?movieId=${myReview.movieNo}">${myReview.reviewContent}</a></div>
                        <div class="reviewDate">${fn:substringBefore(myReview.createReviewDate.toString(), 'T')}</div>
                   </div>
                </c:forEach>
             </div>
        </div>
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