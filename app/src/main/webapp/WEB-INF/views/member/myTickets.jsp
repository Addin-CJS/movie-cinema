<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<section>
    <div class="myTicket">
        <h2>나의 예매 내역</h2>
        <div class="myTicketList">
            <c:forEach var="myTicket" items="${myTicketList}">
                <div class="ticketHeader">
                    <span class="titleAndId">Movie Ticket [${myTicket.ticketId}]</span>
                    <span class="ticketBuyDate">${fn:substringBefore(myTicket.createdAt.toString(), 'T')}</span>
                </div>
                <div class="ticketContent">
                    <div class="tickedMvImg">
                        <p class="movieImg">
                            <a href="/showDetail?movieId=${myTicket.movieId}">
                                 <img src="${movieImgs[myTicket.movieId]}"
                                     onerror="this.src='https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';">
                            </a>
                        </p>
                    </div>
                    <div class="ticketedTotalInfo">
                        <div class="ticketInfo">
                            <div id="movieTitle">
                                <a href="/showDetail?movieId=${myTicket.movieId}">
                                     <p class="movieTitle">${movieTitle[myTicket.movieId]}</p>
                                </a>
                            </div>
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
                    <div id="moviePrice">
                        <p class="moviePrice"><fmt:formatNumber value="${myTicket.ticketPrice}" pattern="#,##0원"/></p>
                    </div>
                </div>
            </c:forEach>
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
    </div>
</section>