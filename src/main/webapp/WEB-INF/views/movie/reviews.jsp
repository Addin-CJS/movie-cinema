 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

 <div class="review">
        <table class="reviewList">
            <tr id="reviewTitle">
                <th>영화후기</th>
                <th><textarea cols="100" rows="4" id="reviewContent"> </textarea></th>
                <th>
                    <button onclick="insertReview();">평점 및 리뷰작성</button>
                </th>
            </tr>

            <c:forEach var="review" items="${reviews}">
                <tr id="reviewItem">
                    <td>${review.reviewWriter}</td>
                    <td>${review.reviewContent}</td>
                    <td>${fn:substringBefore(review.createReviewDate.toString(), 'T')}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    </section>

    <script>
       function insertReview() {
           $.ajax({
               url: "reviewInsert",
               data: {
                   movieNo: ${movie.movieId},
                   reviewContent: $("#reviewContent").val()
               },
               type: "post",
               success: function (result) {
                   // 리뷰 목록을 업데이트
                   updateReviewList(${movie.movieId});
               },
               error: function () {
                   console.log("리뷰 등록 ajax통신 실패");
               }
           });
       }

       function updateReviewList(movieId) {
           $.ajax({
               url: "reviewList", // 리뷰 목록을 불러오는 서버의 URL
               data: {
                    movieNo: ${movie.movieId},
                    reviewContent: $("#reviewContent").val()
               },
               type: "get",
               success: function (response) {
                   // 리뷰 목록을 페이지에 표시하는 로직
                    $('#reviewList').html(response);
               },
               error: function () {
                   console.log("리뷰 목록 불러오기 실패");
               }
           });
       }
    </script>

    <jsp:include page="../layouts/footer.jsp"/>