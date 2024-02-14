<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="../layouts/header.jsp"/>

<style>
    #listNotificationContainer {
        max-width: 600px;
        margin: 20px auto;
        padding: 15px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .listNotification-item {
        margin-bottom: 15px;
        border: 1px solid #d9534f;
        padding: 10px;
        border-radius: 5px;
        background-color: #ffffff;
        color: #333;
    }

    .listNotification-item p {
        margin: 5px 0;
    }

    .listNotification-header {
        color: #d9534f;
        text-align: center;
        margin-bottom: 20px;
    }

    .listNotification-button {
        background-color: #d9534f;
        color: #ffffff;
        border: none;
        padding: 8px 12px;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .listNotification-button:hover {
        background-color: #c9302c;
    }
</style>
<sec:authentication var="me" property="principal"/>

<section>
    <h2 class="listNotification-header">알림 목록</h2>
    <div id="listNotificationContainer">
        <sec:authorize access="isAuthenticated()">
            <button onclick="checkReadAllNotifications()" class="listNotification-button">모든 알림 확인 체크하기</button>
            <div id="notificationList">
                <sec:authorize access="isAuthenticated()">
                    <c:forEach var="notification" items="${notifications}">
                        <div class="listNotification-item">
                            <p><b>알림번호:</b> ${notification.id}</p>
                            <p><b>메시지:</b> ${notification.message}</p>
                            <p><b>알림 유형:</b> ${notification.type}</p>
                            <p><b>예매 날짜:</b>
                                    ${fn:substringBefore(notification.createdDateTime.toString(), 'T')}
                                   (${fn:substring(fn:substringAfter(notification.createdDateTime.toString(), 'T'), 0, 5)})
                            </p>
                            <button onclick="checkReadNotification(${notification.id})" class="listNotification-button">알림 확인 체크하기</button>
                        </div>
                    </c:forEach>
                </sec:authorize>
            </div>
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