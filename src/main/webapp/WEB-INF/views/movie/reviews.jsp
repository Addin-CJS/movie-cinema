 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

    <div class="review">
        <table class="reviewList">
            <thead>
                <tr id="reviewTitle">
                    <th colspan="2">영화후기</th>
                    <th><textarea cols="100" rows="4" id="reviewContent"> </textarea></th>
                    <th colspan="2">
                        <button onclick="insertReview();">평점 및 리뷰작성</button>
                    </th>
                </tr>
                <tr id="reviewEditForm" style="display : none;">
                    <th colspan="2">영화후기 수정</th>
                    <th><textarea cols="100" rows="4" id="editReviewContent"> </textarea></th>
                    <th colspan="2">
                        <button onclick="updateReview();">수정 완료</button>
                        <button onclick="cancelEdit();">수정 취소</button>
                    </th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="review" items="${reviewList.content}">
                    <tr id="reviewItem">
                        <td>${review.reviewId}</td>
                        <td>${review.reviewWriter}</td>
                        <td>${review.reviewContent}</td>
                        <td>${fn:substringBefore(review.createReviewDate.toString(), 'T')}</td>
                        <td>
                            <button onclick="updateReview(${review.reviewId});">수정</button>
                            <button onclick="deleteReview(${review.reviewId});">삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="pagination"></div>
    </div>
    </section>

 <script>
       var movieId = ${movie.movieId};
       var loginUsername = "<c:out value='${loginUser.username}'/>";
       var currentPage = 0;

      $(document).ready(function() {
             updateReviewList(movieId);
         });

     function insertReview() {
        var reviewContent =  $("#reviewContent").val();
        if (!reviewContent.trim()) {
                alert('리뷰 내용 작성은 필수입니다.');
                $("#reviewContent").focus();
                return;
            } else if (reviewContent.trim().length < 10) {
                alert('리뷰는 최소 10글자 이상 작성해야 합니다.');
                $("#reviewContent").focus();
                return;
            }
         $.ajax({
             url: "reviewInsert",
             data: {
                 movieNo: movieId,
                 reviewWriter: loginUsername,
                 reviewContent: $("#reviewContent").val()
             },
             type: "post",
             success: function (result) {
                if(result === "fail") {
                    const yn = confirm('로그인 후에 리뷰 작성 가능합니다. 로그인 창으로 이동할까요 ?');
                        if(yn) {
                                returnUrl = '/showDetail?movieId=${movie.movieId}'
                                location.href='/member/login?returnUrl=' + returnUrl;
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

    function updateReviewList(movieId, currentPage) {
        $.ajax({
            url: "reviewList",
            data: { movieNo: movieId,
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
                    response.content.forEach(function(review) {
                        var displayDate = review.updateReviewDate ? review.updateReviewDate : review.createReviewDate;
                        reviewsHtml += '<tr><td>'
                                    + review.reviewId + '</td><td>'
                                    + review.reviewWriter + '</td><td>'
                                    + review.reviewContent + '</td><td>'
                                    + displayDate.substring(0, 10) + '</td><td>'

                                    if(loginUsername === review.reviewWriter) {
                                        reviewsHtml += '<a href="javascript:void(0);" onclick="editReview('+ review.reviewId +')">[수정]</a>'
                                        reviewsHtml += '<a href="javascript:void(0);" class="delete-review" reviewNo="' + review.reviewId + '">[삭제]</a>'
                                    }
                                    reviewsHtml += '</td></tr>';
                    });

                    var paginationHtml = '';
                    if (response.totalPages > 1) {
                        if (response.number > 0) {
                            paginationHtml += '<a href="javascript:void(0);" onclick="updateReviewList(' + movieId + ',' + (response.number - 1) + ');">이전</a>';
                        }

                        for (var pageNum = 0; pageNum < response.totalPages; pageNum++) {
                            paginationHtml += '<a href="javascript:void(0);" onclick="updateReviewList(' + movieId + ',' + pageNum + ');" ' + (pageNum === response.number ? 'class="active"' : '') + '>' + (pageNum + 1) + '</a>';
                        }

                        if (response.number + 1 < response.totalPages) { // 현재 페이지가 총 페이지 수보다 작으면 "다음" 링크 생성
                            paginationHtml += '<a href="javascript:void(0);" onclick="updateReviewList(' + movieId + ',' + (response.number + 1) + ');">다음</a>';
                        }
                    }
                }
                 $('.pagination').html(paginationHtml);
                $('.reviewList tbody').html(reviewsHtml); // 후기 목록 업데이트
            },
            error: function() {
                console.log("리뷰 목록 불러오기 실패");
            }
        });
    }

    function editReview(reviewId) {
        const yn = confirm(reviewId + "번 리뷰를 수정하시겠습니까?");

        if(yn) {
            var review = reviews.find(review => review.reviewId == reviewId);
            if (review) {
                $("#editReviewContent").val(review.reviewContent);
                $("#reviewEditForm").data("reviewId", reviewId);
                $("#reviewTitle").hide();
                $("#reviewEditForm").show();
            }
        }
    }

    function cancelEdit() {
          $(".reviewList").show();
          $("#reviewEditForm").hide();
    }

     function updateReview() {
         var reviewId = $("#reviewEditForm").data("reviewId"); // 수정 중인 리뷰 ID 저장 필요
         var reviewContent = $("#editReviewContent").val();
            $.ajax({
                url: "updateReview",
                data: {
                    movieNo: movieId,
                    reviewId: reviewId,
                    reviewWriter: loginUsername,
                    reviewContent: reviewContent
                },
                type: "post",
                success: function(result) {
                  if(result === "success") {
                      alert('리뷰가 수정되었습니다!');
                      $("#reviewTitle").show();
                      $("#reviewEditForm").hide();

                      updateReviewList(movieId,currentPage);
                  }else{
                        alert('리뷰 수정 실패!');
                  }
                },
                error: function() {
                    console.log("댓글 수정 실패")
                },
            })
     }

    $(".reviewList").on("click", ".delete-review", function(event) {
            const reviewNo = $(this).attr("reviewNo");
            const yn = confirm(reviewNo + "번 댓글을 삭제할까요?");
            if(yn) {
                $.ajax({
                    url: "deleteReview",
                    data: {
                        reviewId: reviewNo
                    },
                    type: "get",
                    success: function(result) {
                      if(result === "success") {
                          updateReviewList(movieId,currentPage);
                      }
                    },
                    error: function() {
                        console.log("댓글 삭제 실패")
                    },
                })
            }
    })
 </script>

 <jsp:include page="../layouts/footer.jsp"/>