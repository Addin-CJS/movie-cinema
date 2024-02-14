<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="../layouts/header.jsp"/>

    <style>
        .notification-item {
            margin-bottom: 10px;
            border: 1px solid #ddd;
            padding: 10px;
            border-radius: 5px;
        }
    </style>
<sec:authentication var="me" property="principal"/>

<section>
    <h2>알림 목록</h2>
<sec:authorize access="isAuthenticated()">
    <button onclick="checkReadAllNotifications()">모든 알림 확인 체크하기</button>
</sec:authorize>
    <div id="notificationList">
        <sec:authorize access="isAuthenticated()">
            <c:forEach var="notification" items="${notifications}">
                <div class="notification-item">
                    <p><b>알림번호:</b> ${notification.id}</p>
                    <p><b>메시지:</b> ${notification.message}</p>
                    <p><b>알림 유형:</b> ${notification.type}</p>
                    <p><b>날짜:</b> <c:out value="${notification.createdDateTime}"/></p>
                    <button onclick="checkReadNotification(${notification.id})">알림 확인 체크하기</button>


                </div>
            </c:forEach>
        </sec:authorize>
    </div>
</section>

<script>
    function checkReadNotification(notificationId) {

        var confirmCheck = confirm("알림 확인버튼을 누르겠습니까 ? 읽은상태로 변경됩니다");
        if (confirmCheck) {
            $.ajax({
                type: 'POST',
                url: '/notifications/' + notificationId + '/readNotification',
                success: function (response) {
                    alert('알림을 확인하였습니다.');
                    location.reload();
                },
                error: function (xhr, status, error) {
                    alert('알림 읽기 중 오류가 발생했습니다.');
                    console.error(xhr.responseText);
                }
            });
        } else {

        }
    }

    function checkReadAllNotifications(){
        var confirmCheck = confirm("모든 알림을 읽음 상태로 변경하시겠습니까?");
        if(confirmCheck){
            $.ajax({
                type: 'POST',
                url: '/notifications/readAll',
                success: function (response) {
                    alert('모든 알림이 확인되었습니다.');
                    location.reload();
                },
                error: function (xhr, status, error){
                    alert('모든 알림 읽기중 오류가 발생했습니다');
                    console.error(xhr.responseText);
                }


            });

        }
    }

</script>


<jsp:include page="../layouts/footer.jsp"/>