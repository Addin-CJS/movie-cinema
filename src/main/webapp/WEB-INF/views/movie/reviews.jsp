 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

 <div class="review">
        <table class="reviewList">
            <thead>
                <tr id="reviewTitle">
                    <th>영화후기</th>
                    <th><textarea cols="100" rows="4" id="reviewContent"> </textarea></th>
                    <th>
                        <button onclick="insertReview();">평점 및 리뷰작성</button>
                    </th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="review" items="${reviews}">
                    <tr id="reviewItem">
                        <td>${review.reviewWriter}</td>
                        <td>${review.reviewContent}</td>
                        <td>${fn:substringBefore(review.createReviewDate.toString(), 'T')}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    </section>

 <script>
       var movieId = ${movie.movieId};

      $(document).ready(function() {
             updateReviewList(movieId);
         });

     function insertReview() {
         $.ajax({
             url: "reviewInsert",
             data: {
                 movieNo: movieId,
                 reviewContent: $("#reviewContent").val()
             },
             type: "post",
             success: function (result) {
                 updateReviewList(movieId);
                 $("#reviewContent").val("");
             },
             error: function () {
                 console.log("리뷰 등록 ajax통신 실패");
             }
         });
     }

     function updateReviewList(movieId) {
         $.ajax({
             url: "reviewList",
             data: { movieId: movieId },
             type: "get",
             dataType: "json",
             success: function (reviews) {
                 var reviewsHtml = '';
                 reviews.forEach(function(review) {
                     reviewsHtml += '<tr><td>'
                                 + review.reviewWriter + '</td><td>'
                                 + review.reviewContent + '</td><td>'
                                 + review.createReviewDate.substring(0, 10) + '</td></tr>';
                 });
                 $('.reviewList tbody').html(reviewsHtml); // 후기 목록 업데이트
             },
             error: function() {
                 console.log("리뷰 목록 불러오기 실패");
             }
         });
     }
 </script>

    <jsp:include page="../layouts/footer.jsp"/>