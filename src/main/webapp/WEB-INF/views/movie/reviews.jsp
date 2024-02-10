<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<section>
    <div class="review">
        <sec:authentication var="me" property="principal"/>
        <div class="latest-likes">
            <div class="likesWrap">
                <div class="sort-options">
                    <a href="#" onclick="updateReviewList(movieId, 0, 'latest'); return false;">최신순</a>
                </div>
            </div>
            <div class="likesWrap">
                <div class="sort-options">
                    <a href="#" onclick="updateReviewList(movieId, 0, 'likes'); return false;">좋아요순</a>
                </div>
            </div>
        </div>

        <div class="reviewHeader">
            <div class="reviewTitleRow">
                <div class="reviewTitle">영화후기</div>
                <div class="reviewRating">
                    <form name="stars" id="starForm" method="post">
                        <fieldset>
                            <input type="radio" name="reviewStar" value="5" id="rate5"><label for="rate5">★</label>
                            <input type="radio" name="reviewStar" value="4" id="rate4"><label for="rate4">★</label>
                            <input type="radio" name="reviewStar" value="3" id="rate3"><label for="rate3">★</label>
                            <input type="radio" name="reviewStar" value="2" id="rate2"><label for="rate2">★</label>
                            <input type="radio" name="reviewStar" value="1" id="rate1"><label for="rate1">★</label>
                        </fieldset>
                    </form>
                </div>
                <div class="reviewInput">
                    <textarea cols="80" rows="4" id="reviewContent"></textarea>
                </div>
                <div class="reviewSubmit">
                    <button class="review-btn" onclick="insertReview();">평점 및 리뷰작성</button>
                </div>
            </div>

            <div id="reviewEditForm" class="reviewEditRow" style="display: none;">
                <div class="reviewEditTitle">영화후기 수정</div>
                <div class="reviewEditRating">
                    <form name="stars" id="starEditForm" method="post">
                        <fieldset>
                            <input type="radio" name="reviewStar" value="5" id="rate5"><label for="rate5">★</label>
                            <input type="radio" name="reviewStar" value="4" id="rate4"><label for="rate4">★</label>
                            <input type="radio" name="reviewStar" value="3" id="rate3"><label for="rate3">★</label>
                            <input type="radio" name="reviewStar" value="2" id="rate2"><label for="rate2">★</label>
                            <input type="radio" name="reviewStar" value="1" id="rate1"><label for="rate1">★</label>
                        </fieldset>
                    </form>
                </div>
                <div class="reviewEditInput">
                    <textarea cols="80" rows="4" id="editReviewContent"></textarea>
                </div>
                <div class="reviewEditSubmit">
                    <button onclick="updateReview();">수정</button>
                    <button onclick="cancelEdit();">취소</button>
                </div>
            </div>
        </div>

        <div class="reviewList">
            <div class="reviewContent">
                <c:forEach var="review" items="${reviewList.content}">
                    <div class="reviewItem">
                        <div class="reviewWrapper1">
                            <div class="reviewWrapper2">
                                <div>${review.reviewId}</div>
                                <div>${review.reviewWriter}</div>
                            </div>
                            <div class="reviewStar">별점</div>
                            <div class="reviewText">${review.reviewContent}</div>
                            <div>${fn:substringBefore(review.createReviewDate.toString(), 'T')}</div>
                            <div>
                                <sec:authorize access="isAuthenticated()">
                                    <c:if test="${not empty me and not empty me.member and me.member.username == review.reviewWriter}">
                                        <button onclick="updateReview(${review.reviewId});">수정</button>
                                        <button onclick="deleteReview(${review.reviewId});">삭제</button>
                                    </c:if>
                                </sec:authorize>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="pagination"></div>
    </div>
</section>

<script>
    var movieId = ${movie.movieId};
    var loginUsername = "";
    <sec:authorize access="isAuthenticated()">
    loginUsername = "<c:out value='${me.member.username}'/>";
    </sec:authorize>
    var currentPage = 0;
    var currentSortType = 'latest';
    $(document).ready(function () {
        updateReviewList(movieId, 0, currentSortType);
    });

    function insertReview() {
        var reviewContent = $("#reviewContent").val();
        var starRating = $('input[name="reviewStar"]:checked').val();

        if (!reviewContent.trim()) {
            alert('리뷰 내용 작성은 필수입니다.');
            $("#reviewContent").focus();
            return;
        } else if (reviewContent.trim().length < 10) {
            alert('리뷰는 최소 10글자 이상 작성해야 합니다.');
            $("#reviewContent").focus();
            return;
        }
        if (!starRating) {
            alert('별점을 선택해주세요.');
            return;
        }

        $.ajax({
            url: "reviewInsert",
            data: {
                movieNo: movieId,
                reviewWriter: loginUsername,
                reviewContent: $("#reviewContent").val(),
                starRating: starRating
            },
            type: "post",
            success: function (result) {
                if (result === "fail") {
                    const yn = confirm('로그인 후에 리뷰 작성 가능합니다. 로그인 창으로 이동할까요 ?');
                    if (yn) {
                        returnUrl = '/showDetail?movieId=${movie.movieId}'
                        location.href = '/member/login?returnUrl=' + returnUrl;
                    }
                } else {
                    updateReviewList(movieId);
                    $("#reviewContent").val("");
                }
            },
            error: function () {
                console.log("리뷰 등록 ajax통신 실패");
            }
        });
    }

    function updateReviewList(movieId, currentPage, sortType = currentSortType) {
        currentSortType = sortType;
        console.log("movieId:", movieId, "currentPage:", currentPage, "sortType:", sortType);
        if (currentPage === undefined || currentPage === null) {
            currentPage = 0;
        }

        $.ajax({
            url: "reviewList",
            data: {
                movieNo: movieId,
                page: currentPage,
                sortType: sortType
            },
            type: "get",
            dataType: "json",
            success: function (response) {
                reviews = response.content;

                console.log("Sorted by:", sortType, "First item:", response.content[0]);

                console.log("Received response:", response);

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

                        reviewsHtml += '<div class="reviewWrapper1">' +
                            '<div class="reviewItem">' +
                            '<div class="reviewWrapper2">' +
                            '<div>' + review.reviewId + '</div>' +
                            '<div>' + review.reviewWriter + '</div>' +
                            '<div class=reviewBtns>' +
                            (loginUsername === review.reviewWriter ? '<button onclick="editReview(' + review.reviewId + ')">[수정]</button>' +
                                '<button class="delete-review" reviewNo="' + review.reviewId + '">[삭제]</button>' : '') +
                            '</div>' +
                            '</div>' +
                            '<div class="reviewStar">' + stars + '</div>' +
                            '<div class="reviewText">' + review.reviewContent + '</div>' +
                            '<div class="reviewWrapper3">' +
                            '<div class="reviewDate">' + displayDate + '</div>' +
                            '<div class="reviewLike"><a href="javascript:void(0);" onclick="likeReview(' + review.reviewId + ');" id="heart-' + review.reviewId + '">🩵</a>' +
                            '<span id="like-count-' + review.reviewId + '">' + (review.likeCount !== null ? review.likeCount : 0) + '</span></div>' +
                            '</div>' +
                            '</div>' +
                            '</div>';
                    });
                }

                var totalPages = response.totalPages;
                var pageGroupSize = 5;
                var currentPageGroup = Math.floor(currentPage / pageGroupSize);
                var startPage = currentPageGroup * pageGroupSize;
                var endPage = Math.min(startPage + pageGroupSize - 1, totalPages - 1);

                var paginationHtml = '';
                if (totalPages > 1) {

                    if (currentPage > 0) {
                        paginationHtml += '<a href="javascript:void(0);" onclick="updateReviewList(' + movieId + ',0);">처음</a> ';
                    }

                    if (currentPage > 0) {
                        paginationHtml += '<a href="javascript:void(0);" onclick="updateReviewList(' + movieId + ',' + (currentPage - 1) + ');">이전</a> ';
                    }

                    for (var pageNum = startPage; pageNum <= endPage; pageNum++) {
                        paginationHtml += '<a href="javascript:void(0);" onclick="updateReviewList(' + movieId + ',' + pageNum + ');" ' + (pageNum === currentPage ? 'class="active"' : '') + '>' + (pageNum + 1) + '</a>';
                    }

                    if (currentPage < totalPages - 1) {
                        paginationHtml += '<a href="javascript:void(0);" onclick="updateReviewList(' + movieId + ',' + (currentPage + 1) + ');">다음</a> ';
                    }

                    if (currentPage < totalPages - 1) {
                        paginationHtml += '<a href="javascript:void(0);" onclick="updateReviewList(' + movieId + ',' + (totalPages - 1) + ');">마지막</a>';
                    }
                }

                $('.pagination').html(paginationHtml);
                $('.reviewList').html(reviewsHtml);

                loadUserLikes(); //좋아요 세션에 담아서
            },
            error: function () {
                console.log("리뷰 목록 불러오기 실패");
            }
        });
    }


    function loadUserLikes() {
        $.ajax({
            url: "/getUserLikes",
            type: "GET",
            success: function (likedReviews) {
                likedReviews.forEach(function (reviewId) {
                    $("#heart-" + reviewId).addClass('liked').html('🩷');
                });
            },
            error: function (error) {
                console.error("에러다", error);
            }
        });
    }

    function editReview(reviewId) {
        const yn = confirm(reviewId + "번 리뷰를 수정하시겠습니까?");

        if (yn) {
            var review = reviews.find(review => review.reviewId == reviewId);
            if (review) {
                $("#editReviewContent").val(review.reviewContent);
                $("#reviewEditForm").data("reviewId", reviewId);
                $(".reviewTitleRow").hide();
                $("#reviewEditForm").show();
            }
        }
    }

    function cancelEdit() {
        $(".reviewTitleRow").show();
        $("#reviewEditForm").hide();
    }

    function updateReview() {
        var reviewId = $("#reviewEditForm").data("reviewId"); // 수정 중인 리뷰 ID 저장 필요
        var reviewContent = $("#editReviewContent").val();
        var starRating = $('input[name="reviewStar"]:checked').val();
        $.ajax({
            url: "updateReview",
            data: {
                movieNo: movieId,
                reviewId: reviewId,
                reviewWriter: loginUsername,
                reviewContent: reviewContent,
                starRating: starRating
            },
            type: "post",
            success: function (result) {
                if (result === "success") {
                    alert('리뷰가 수정되었습니다!');
                    $("#reviewTitle").show();
                    $("#reviewEditForm").hide();

                    updateReviewList(movieId, currentPage);
                } else {
                    alert('리뷰 수정 실패!');
                }
            },
            error: function () {
                console.log("댓글 수정 실패")
            },
        })
    }

    $(".reviewList").on("click", ".delete-review", function (event) {
        const reviewNo = $(this).attr("reviewNo");
        const yn = confirm(reviewNo + "번 댓글을 삭제할까요?");
        if (yn) {
            $.ajax({
                url: "deleteReview",
                data: {
                    reviewId: reviewNo
                },
                type: "get",
                success: function (result) {
                    if (result === "success") {
                        updateReviewList(movieId, currentPage);
                    }
                },
                error: function () {
                    console.log("댓글 삭제 실패")
                },
            })
        }
    })


    function likeReview(reviewId) {
        var likeCountElementId = "like-count-" + reviewId;
        var heartElementId = "heart-" + reviewId;
        var isLiked = $("#" + heartElementId).hasClass('liked');

        var confirmMessage = isLiked ? '좋아요를 취소하시겠습니까?' : '좋아요를 하시겠습니까?';
        if (!confirm(confirmMessage)) {
            return;
        }
        $.ajax({
            url: "like",
            type: 'POST',
            data: {reviewId: reviewId, likeAction: isLiked ? 'unlike' : 'like'},
            success: function (response) {
                if (response === "success") {
                    var currentLikeCount = parseInt($("#" + likeCountElementId).text());
                    if (isLiked) {
                        $("#" + heartElementId).html('🩵').removeClass('liked');
                        $("#" + likeCountElementId).text(currentLikeCount - 1);
                    } else {
                        $("#" + heartElementId).html('🩷').addClass('liked');
                        $("#" + likeCountElementId).text(currentLikeCount + 1);
                    }
                } else if (response === "fail") {
                    alert('로그인해주세여~');
                }
            },
            error: function () {
                alert('좋아요 처리 중 오류 발생');
            }
        });

    }

</script>

<jsp:include page="../layouts/footer.jsp"/>