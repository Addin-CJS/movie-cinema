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
    <div id="notificationArea">
        알림개수: <span id="notification-count"></span>
    </div>


    <sec:authentication var="me" property="principal"/>

</section>
<script>
    <sec:authorize access="isAuthenticated()">
    var username = "<c:out value='${me.member.username}'/>";
    </sec:authorize>

    function fetchInitialUnreadNotificationCount() {
        fetch('/unread-count/' + encodeURIComponent(username))
            .then(response => response.json())
            .then(data => {
                console.log("알림숫자", data)
                document.getElementById("notification-count").innerText = data.count;
            })
            .catch(error => console.error('읽지 않은 알림 수 조회 중 오류 발생:', error));
    }


    window.onload = function () {
        fetchInitialUnreadNotificationCount();

        var eventSourceUrl = '/connect/' + encodeURIComponent(username);
        var source = new EventSource(eventSourceUrl);

        source.onopen = function (event) {
            console.log("SSE 연결이 열렸습니다.", event);
        };

        source.onerror = function (event) {
            console.error("SSE 연결에 오류가 발생했습니다.", event);
        };

        source.onmessage = function (event) {
            console.log("알림 message: ", event.data);

        };


        var receivedNotifications = {}; // 이미 받은 알림을 추적하는 객체

        source.addEventListener('notification', function (e) {
            console.log(" function(e) 알림: ", e.data);
            try {
                var data = JSON.parse(e.data);
                console.log("JSON.parse ", data);
            } catch (error) {
                console.error("JSON.parse 오류 알림: ", error);
            }
            if (data.type === "UNREAD_NOTIFICATION_COUNT") {
                // 읽지 않은 알림의 수만 업데이트
                document.getElementById("notification-count").innerText = data.count;
            } else {
                // 다른 타입의 알림은 팝업으로 표시
                displayNotification(data);
            }

        });

        function displayNotification(data) {
            if (!receivedNotifications[data.id]) {
                console.log("알림 데이터: ", data);
                receivedNotifications[data.id] = true;

                var notification = document.createElement('div');
                notification.className = 'notification-popup';
                notification.innerText = data.message;
                document.body.appendChild(notification);
                notification.style.display = 'block';

                setTimeout(function () {
                    notification.style.display = 'none';
                    document.body.removeChild(notification);
                }, 10000);

                notification.onclick = function () {
                    notification.style.display = 'none';
                    document.body.removeChild(notification);
                };
            }
        }
    };
</script>
