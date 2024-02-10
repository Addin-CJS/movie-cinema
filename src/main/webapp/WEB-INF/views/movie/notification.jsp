<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
    .notification-popup {
        position: fixed;
        bottom: 20px;
        right: 20px;
        background-color: yellow;
        color: blue;
        padding: 10px;
        border-radius: 5px;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
        display: none;
        z-index: 1000;
    }
</style>

<section>
    <div id="notificationArea"></div>
    <sec:authentication var="me" property="principal"/>

</section>
<script>
    window.onload = function () {
        <sec:authorize access="isAuthenticated()">
        var username = "<c:out value='${me.member.username}'/>";
        </sec:authorize>

        var eventSourceUrl = '/connect/' + encodeURIComponent(username);
        var source = new EventSource(eventSourceUrl);

        source.onopen = function (event) {
            console.log("SSE 연결이 열렸습니다.", event);
        };

        source.onerror = function (event) {
            console.error("SSE 연결에 오류가 발생했습니다.", event);
        };

        source.onmessage = function (event) {
            console.log("Received message: ", event.data);

        };

        var receivedNotifications = {}; // 이미 받은 알림을 추적하는 객체

        source.addEventListener('notification', function (e) {
            console.log("Received data 알림 : ", e.data);
            try {
                var data = JSON.parse(e.data);
                console.log("Parsed data: ", data);
            } catch (error) {
                console.error("JSON parsing error: ", error);
            }
            if (!receivedNotifications[data.id]) {
                console.log("New notification received: ", data);
                receivedNotifications[data.id] = true; // 알림 ID를 추적 객체에 추가

                // 알림 메시지 표시
                var notification = document.createElement('div');
                notification.className = 'notification-popup';
                notification.innerText = data.message;
                document.body.appendChild(notification);
                notification.style.display = 'block';

                // 알림 자동 숨김
                setTimeout(function () {
                    notification.style.display = 'none';
                    document.body.removeChild(notification);
                }, 10000);

                // 알림 클릭 시 숨김
                notification.onclick = function () {
                    notification.style.display = 'none';
                    document.body.removeChild(notification);
                };
            }
        });
    };
</script>
