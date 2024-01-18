<%--
  Created by IntelliJ IDEA.
  User: jckim
  Date: 1/15/24
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <header>
       <jsp:include page="layouts/header.jsp" />
    </header>

    <section>
        <div class="filter-search-box">

            <div class="filters-box">

                <div class="all-filters filters">
                    All formats <i class="fa fa-angle-down"></i>
                </div>

                <div class="date-filters filters">
                    By Date <i class="fa fa-angle-down"></i>
                </div>

                <div class="category-filters filters">
                    By category <i class="fa fa-angle-down"></i>
                </div>

                <div class="category-filters filters">
                    Coming soon
                </div>

            </div>

            <div class="search-filters">
                <input type="text" placeholder="Search by name...">
                <i class="fa fa-search"></i>
            </div>

            <div class="search-bar">
                <div class="bar"></div>
            </div>

        </div>
        <!----filter-search-box---->


        <div class="movie-card-section">
            <c:forEach var="movies" items="${movies}">
                <div class="card">
                    <img src="https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTCXgCV-ZNb3InBCTaLdED58dF6iZJxIvCOBurktiWxXrwGc8DB">

                    <div class="card-content">
                        <p class="movie-name">
                           <a href="/showDetail?movieId=${movies.movieId}"> ${movies.mvTitle}</a>
                        </p>

                        <div class="movie-info">
                            <p class="time">11:30 <span>14:45<span class="d3">3D</span> 16:05<span class="d3">3D</span></span>
                                18:40 21:00 23:15</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <!---movie-card--->

        <div class="show">
            <div class="show-bar">
                <div class="bar"></div>
            </div>
            <button>Show more</button>
        </div>
        <!---bar--->


    </section>
    <jsp:include page="layouts/footer.jsp" />
</body>
</html>