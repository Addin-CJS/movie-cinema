<%--
  Created by IntelliJ IDEA.
  User: jckim
  Date: 1/15/24
  Time: 15:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="js/script.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="css/style.css">


</head>
<body>
    <header>
       <jsp:include page="layouts/nav-top.jsp" />
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

            <div class="card">
                <img src="https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTCXgCV-ZNb3InBCTaLdED58dF6iZJxIvCOBurktiWxXrwGc8DB">

                <div class="card-content">
                    <p class="movie-name">
                        the mummy
                    </p>

                    <div class="movie-info">
                        <p class="time">11:30 <span>14:45<span class="d3">3D</span> 16:05<span class="d3">3D</span></span>
                            18:40 21:00 23:15</p>
                    </div>
                </div>
            </div>
            <div class="card">
                <img src="https://m.media-amazon.com/images/M/MV5BMTYzODQzYjQtNTczNC00MzZhLTg1ZWYtZDUxYmQ3ZTY4NzA1XkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_.jpg">

                <div class="card-content">
                    <p class="movie-name">
                        Wonder Woman
                    </p>

                    <div class="movie-info">
                        <p class="time">11:30 <span>14:45 16:05</span> 18:40 21:00</p>
                    </div>
                </div>
            </div>
            <div class="card">
                <img src="https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSZeZdWD3S9rSzfwlSsnqBWERtgBHR4h_6kHb_fR_6J-BObyxfK">

                <div class="card-content">
                    <p class="movie-name">
                        Alien: Covenant
                    </p>

                    <div class="movie-info">
                        <p class="time">11:30<span class="d3">3D</span> <span>14:45 16:05<span class="d3">3D</span></span>
                            18:40 21:00 23:15</p>
                    </div>
                </div>
            </div>
            <div class="card">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTX2TBaWUUMpmbhcnr0zypXQltqtQmW9wED_Y8bYrynL98MM1Wq">

                <div class="card-content">
                    <p class="movie-name">
                        Baywatch
                    </p>

                    <div class="movie-info">
                        <p class="time"><span>11:30 16:05<span class="d3">3D</span></span> 18:40 21:00 23:15</p>
                    </div>
                </div>
            </div>

            <div class="card">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXhEeDOpouHNg3A75Ngkgl-pQdWrr8ErxSuYCbb8-Tn7KcuD79">

                <div class="card-content">
                    <p class="movie-name">
                        Pirates of the Caribbean
                    </p>

                    <div class="movie-info">
                        <p class="time">11:30 <span>14:45<span class="d3">3D</span> 16:05<span class="d3">3D</span></span>
                            18:40 21:00</p>
                    </div>
                </div>
            </div>
            <div class="card">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6NX1HzM5IkUhkwR1Yq7vkd9j5dqv0_Zaz5FCa2bzyJaUx9zOa">

                <div class="card-content">
                    <p class="movie-name">
                        transformers 5
                    </p>

                    <div class="movie-info">
                        <p class="time">11:30 <span>14:45 16:05</span> 18:40 21:00</p>
                    </div>
                </div>
            </div>
            <div class="card">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJ8wYlRSHxcAyi7TijH8FjeTLKcYsKi3qCzI8r_X0xKU8LkAn_">

                <div class="card-content">
                    <p class="movie-name">
                        Planet of the Apes
                    </p>

                    <div class="movie-info">
                        <p class="time">11:30<span class="d3">3D</span> <span>14:45 16:05<span class="d3">3D</span></span>
                            18:40 21:00 23:15</p>
                    </div>
                </div>
            </div>
            <div class="card">
                <img src="https://www.movienewsletters.net/photos/NZL_105934R1.jpg">

                <div class="card-content">
                    <p class="movie-name">
                        Dark Tower
                    </p>

                    <div class="movie-info">
                        <p class="time"><span>11:30 16:05<span class="d3">3D</span></span> 18:40 21:00 23:15</p>
                    </div>
                </div>
            </div>

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