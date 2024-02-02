<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<section>
    <div class="myTicket">
        <h1>나의 예매 내역</h1>
        <div class="myTicketList">
            <c:forEach var="myTicket" items="${myTicketList}">
                <div class="ticketHeader">
                    <span class="titleAndId">Movie Ticket [${myTicket.ticketId}]</span>
                    <span class="ticketBuyDate">${fn:substringBefore(myTicket.createdAt.toString(), 'T')}</span>
                </div>
                <div class="ticketContent">
                    <div class="ticketInfo">
                        <p class="movieTitle">${movieTitle[myTicket.movieId]}</p>
                        <p class="moviePrice"><fmt:formatNumber value="${myTicket.ticketPrice}" pattern="0원" /></p>
                    </div>
                    <div class="TicketDetailInfo">
                        <p class="movieDetailInfo">
                            상영일자 : ${fn:substringBefore(myTicket.ticketedDate.toString(), 'T')}
                            ${fn:substringAfter(myTicket.ticketedDate.toString(), 'T')}~
                            ${fn:substringAfter(myTicket.ticketedDate.plusMinutes(movieRuntimes[myTicket.movieId]).toString(), 'T')} |
                            런타임: ${movieRuntimes[myTicket.movieId]} |
                            상영관: ${myTicket.theaterId} |
                            좌석번호: ${myTicket.ticketedSeat} |
                            인원: ${fn:length(fn:split(myTicket.ticketedSeat, ','))}명
                        </p>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="myTicketPagination">
            <c:if test="${nowPage > 0}">
                <a href="javascript:loadTicketPage(${nowPage - 1})">이전</a>
            </c:if>
            <c:forEach begin="${startPage}" end="${endPage}" var="page">
                <a href="javascript:loadTicketPage(${page})" class="${page == nowPage ? 'active' : ''}">[${page + 1}]</a>
            </c:forEach>
            <c:if test="${nowPage + 1 < totalPages}">
                <a href="javascript:loadTicketPage(${nowPage + 1})">다음</a>
            </c:if>
        </div>
    </div>
        <%--<table class="myTicketList">
                <c:forEach var="myTicket" items="${myTicketList}">
                    <tr id="myTicketItem">
                        <td>${myTicket.ticketId}</td>
                        <td>${username[myTicket.memberId]}</td>
                        <td>${movieTitle[myTicket.movieId]}</td>
                        <td>${myTicket.theaterId}</td>
                        <td><fmt:formatNumber value="${myTicket.ticketPrice}" pattern="0원" /></td>
                        <td>
                            ${fn:substringBefore(myTicket.ticketedDate.toString(), 'T')}
                            ${fn:substringAfter(myTicket.ticketedDate.toString(), 'T')}
                        </td>
                        <td>${myTicket.ticketedTheater}</td>
                        <td>${myTicket.ticketedSeat}</td>
                        <td>${fn:substringBefore(myTicket.createdAt.toString(), 'T')}</td>
                   </tr>
                </c:forEach>
        </table>--%>
</section>

