<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    <div class="review">
        <table class="myReviewList">
            <thead>
                <tr id="reviewTitle">
                    <th colspan="7">나의 영화 후기 목록</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="review" items="${reviewList.content}">
                    <tr id="reviewItem">
                        <td>${review.reviewId}</td>
                        <td>${review.reviewWriter}</td>
                        <td>별점</td>
                        <td>${review.reviewContent}</td>
                        <td>${fn:substringBefore(review.createReviewDate.toString(), 'T')}</td>
                   </tr>
                </c:forEach>
        </tbody>
    </table>
    <div class="pagination"></div>
</div>
</section>

<script>
    const memberId = "<c:out value='${loginUser.memberId}'/>";
    const loginUsername = "<c:out value='${loginUser.username}'/>";
    let currentPage = 0;

    $(document).ready(function () {
        updateMyReviewList(memberId, 0);


    });


    function updateMyReviewList(memberId, currentPage) {

        if (currentPage === undefined || currentPage === null) {
            currentPage = 0;
        }

        $.ajax({
            url: "MyReviewList",
            data: {
                reviewWriter: memberId,
                page: currentPage
            },
            type: "get",
            dataType: "json",
            success: function (response) {
                reviews = response.content;

                reviews.sort(function (a, b) {
                    return b.reviewId - a.reviewId;
                });

                var reviewsHtml = '';
                if (response.content && Array.isArray(response.content)) {
                    response.content.forEach(function (review) {
                        var displayDate = review.updateReviewDate ? review.updateReviewDate : review.createReviewDate;

                        var stars = '';

                        for (var i = 0; i < review.starRating; i++) {
                            stars += '<span class="yellow-star">★</span>';
                        }

                        for (var i = review.starRating; i < 5; i++) {
                            stars += '<span class="gray-star">★</span>';
                        }

                        reviewsHtml += '<tr><td>'
                            + review.reviewId + '</td><td>'
                            + review.reviewWriter + '</td><td>'
                            + stars + '</td>'
                            + '<td class="review-content">'
                            + review.reviewContent + '</td><td>'
                            + '<a href="javascript:void(0);" onclick="likeReview(' + review.reviewId + ');" id="heart-' + review.reviewId + '">🩶</a>'
                            + '<span id="like-count-' + review.reviewId + '">'
                            + (review.likeCount !== null ? review.likeCount : 0)
                            + '</span></td><td>'
                            + displayDate.substring(0, 10) + '</td><td>'


                        if (loginUsername === review.reviewWriter) {
                            reviewsHtml += '<a href="javascript:void(0);" onclick="editReview(' + review.reviewId + ')">[수정]</a>'
                            reviewsHtml += '<a href="javascript:void(0);" class="delete-review" reviewNo="' + review.reviewId + '">[삭제]</a>'
                        }
                        reviewsHtml += '</td></tr>';
                    });

                    var totalPages = response.totalPages;
                    var pageGroupSize = 5;
                    var currentPageGroup = Math.floor(currentPage / pageGroupSize);
                    var startPage = currentPageGroup * pageGroupSize;
                    var endPage = Math.min(startPage + pageGroupSize - 1, totalPages - 1);


                    var paginationHtml = '';
                    if (totalPages > 1) {
                        console.log("생성 시작: 페이지네이션 링크");

                        if (currentPage > 0) {
                            paginationHtml += '<a href="javascript:void(0);" onclick="updateMyReviewList(' + movieId + ',0);">처음</a> ';
                        }


                        if (currentPage > 0) {
                            paginationHtml += '<a href="javascript:void(0);" onclick="updateMyReviewList(' + movieId + ',' + (currentPage - 1) + ');">이전</a> ';
                        }

                        for (var pageNum = startPage; pageNum <= endPage; pageNum++) {
                            paginationHtml += '<a href="javascript:void(0);" onclick="updateMyReviewList(' + movieId + ',' + pageNum + ');" ' + (pageNum === currentPage ? 'class="active"' : '') + '>' + (pageNum + 1) + '</a>';
                            console.log("페이지 링크 추가됨:", pageNum + 1);
                        }

                        if (currentPage < totalPages - 1) {
                            paginationHtml += '<a href="javascript:void(0);" onclick="updateMyReviewList(' + movieId + ',' + (currentPage + 1) + ');">다음</a> ';
                        }


                        if (currentPage < totalPages - 1) {
                            paginationHtml += '<a href="javascript:void(0);" onclick="updateMyReviewList(' + movieId + ',' + (totalPages - 1) + ');">마지막</a>';
                        }
                    }
                }
                $('.pagination').html(paginationHtml);
                $('.reviewList tbody').html(reviewsHtml);

                loadUserLikes(); //좋아요 세션에 담아서
            },
            error: function () {
                console.log("리뷰 목록 불러오기 실패");
            }
        });



</script>

 <jsp:include page="../layouts/footer.jsp"/>
