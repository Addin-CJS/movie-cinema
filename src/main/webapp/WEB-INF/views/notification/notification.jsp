<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<sec:authentication var="me" property="principal"/>

<style>
    .notification-popup {
        position: fixed;
        bottom: 20px;
        right: 20px;
        background-color: #324A5F;
        color: #FFFFFF;
        padding: 20px;
        padding-bottom: 45px;
        border-radius: 8px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        display: none;
        z-index: 1000;
        font-size: 14px;
        line-height: 1.6;
        box-sizing: border-box;
        max-width: 320px;
        word-wrap: break-word;
    }

    .notification-confirm-btn {
        background-color: #5C6BC0;
        color: #FFFFFF;
        padding: 6px 12px;
        border-radius: 4px;
        border: none;
        cursor: pointer;
        font-size: 12px;
        position: absolute;
        bottom: 10px;
        left: 30px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .notification-close-btn {
        position: absolute;
        top: 10px;
        right: 10px;
        background-color: transparent;
        color: #B0BEC5;
        border: none;
        cursor: pointer;
        font-size: 16px;
    }

</style>

<section>
    <div id="notificationArea">
    </div>
</section>


<script>
    <sec:authorize access="isAuthenticated()">
    var username = "<c:out value='${me.member.username}'/>";


    function fetchInitialUnreadNotificationCount() {
        fetch('/unread-count/' + encodeURIComponent(username))
            .then(response => response.json())
            .then(data => {

                document.getElementById("notification-count").innerText = data.count;
            })
            .catch(error => console.error('읽지 않은 알림 수 조회 중 오류 발생:', error));
    }

    function checkReadNotification(notificationId, btn) {
        if (confirm("알림을 확인하시겠습니까? 확인을 누르면 더이상 해당 알림은 확인할 수 없습니다.")) {
            $.ajax({
                type: 'POST',
                url: '/notifications/' + notificationId + '/readNotification',
                success: function (response) {

                    var countElement = document.getElementById("notification-count");
                    var count = parseInt(countElement.textContent) || 0;
                    if (count > 0) {
                        countElement.textContent = count - 1;
                    }

                    if (btn && btn.parentNode) {
                        btn.parentNode.style.display = 'none';
                        document.body.removeChild(btn.parentNode);
                    }

                    document.getElementById("notification-item-" + notificationId).remove();
                },
                error: function (xhr, status, error) {
                    alert('알림 읽기 중 오류가 발생했습니다.');
                    console.error(xhr.responseText);
                }
            });
        }
    }

    window.onload = function () {
        fetchInitialUnreadNotificationCount();

        document.getElementById("notification-link").href = "/notifications/" + encodeURIComponent(username);

        var eventSourceUrl = '/connect/' + encodeURIComponent(username);
        var source = new EventSource(eventSourceUrl);

        var receivedNotifications = {}; // 이미 받은 알림을 추적하는 객체

        source.addEventListener('notification', function (e) {

            try {
                var data = JSON.parse(e.data);

            } catch (error) {

            }
            if (data.type === "UNREAD_NOTIFICATION_COUNT") {

                document.getElementById("notification-count").innerText = data.count;
            } else {

                displayNotification(data);
            }

        });

        function parseShowtime(showtimeStr) {
            const [date, time] = showtimeStr.split(' ');
            const [year, month, day] = date.split('-').map(num => parseInt(num, 10));
            const [hour, minute] = time.split(':').map(num => parseInt(num, 10));
            return new Date(year, month - 1, day, hour, minute);
        }

        function displayNotification(data) {
            if (!receivedNotifications[data.id]) {
                var messageContent = data.message;

                if (data.type === "MOVIE_BOOKED" && data.showtime) {
                    var showtime = parseShowtime(data.showtime);
                    var now = new Date();
                    var diff = showtime - now;
                    var minutesLeft = Math.round(diff / 60000);

                    if (!isNaN(minutesLeft) && minutesLeft > 0) {

                        messageContent += "<br> ->상영까지 남은 시간: " + minutesLeft + "분 남았습니다";
                    } else {
                        console.error("Invalid showtime received:", data.showtime);
                  }
                }

                receivedNotifications[data.id] = true;

                var notification = document.createElement('div');
                notification.className = 'notification-popup';

                notification.innerHTML = `
                <div>${"${messageContent}"}</div>
                <button class="notification-close-btn" onclick="this.parentNode.style.display='none';">&#x2715;</button>
                <button class="notification-confirm-btn" onclick="checkReadNotification(${"${data.id}"}, this)">확인</button>
                `;
                //2x2715는 x표시

                document.body.appendChild(notification);
                notification.style.display = 'block';

                setTimeout(function () {
                    notification.style.display = 'none';
                    document.body.removeChild(notification);
                }, 30000);

                notification.onclick = function () {
                    notification.style.display = 'none';
                    document.body.removeChild(notification);
                };
            }
        }
    };
    </sec:authorize>
</script>
