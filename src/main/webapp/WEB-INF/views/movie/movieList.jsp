<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="movie-card-section">
    <c:forEach var="movie" items="${movieList.content}">
        <div class="card">
            <img src="${movie.mvImg}">
            <div class="card-content">
                <p class="movie-name">
                    <a href="/showDetail?movieId=${movie.movieId}"> ${movie.mvTitle}</a>
                </p>
                <div class="movie-info">
                    <p class="time">11:30 <span>14:45<span class="d3">3D</span> 16:05<span
                            class="d3">3D</span></span>
                        18:40 21:00 23:15</p>
                </div>
            </div>
        </div>
    </c:forEach>
</div>