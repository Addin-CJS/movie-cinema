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
    <nav>
        <p class="logo">
            multi<span>flex<span>
        </p>

        <i class="fa fa-bars" id="menu"></i>

        <ul id="menu-box">
            <div class="marker"></div>
            <li>main</li>
            <li>schedlues</li>
            <li>tickets</li>
            <li>news</li>
            <li>contact</li>
            <li><span>mr.john doe <img
                    src="https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?cs=srgb&dl=pexels-pixabay-220453.jpg&fm=jpg"> <i
                    class="fa fa-angle-down"></i></span></li>
            <li><b>sign out</b></li>
        </ul>

    </nav>

    <div class="popular-movie-slider">

        <img src="https://imageio.forbes.com/blogs-images/scottmendelson/files/2014/10/2v00kg8.jpg?format=jpg&width=1200"
             class="poster">

        <div class="popular-movie-slider-content">
            <p class="release">2017</p>
            <h2 class="movie-name">Interstellar</h2>
            <ul class="category">
                <p>Science fiction</p>
                <li>drama</li>
                <li>action</li>
            </ul>
            <p class="desc">Interstellar is a 2014 epic science fiction film co-written, directed, and produced by
                Christopher Nolan. It stars Matthew McConaughey, Anne Hathaway, Jessica Chastain, Bill Irwin, Ellen
                Burstyn, Matt Damon, and Michael Caine. Set in a dystopian future where humanity is embroiled in a
                catastrophic blight and famine, the film follows a group of astronauts who travel through a wormhole
                near Saturn in search of a new home for humankind.</p>

            <div class="movie-info">
                <i class="fa fa-clock-o"> &nbsp;&nbsp;&nbsp;<span>164 min.</span></i>
                <i class="fa fa-volume-up"> &nbsp;&nbsp;&nbsp;<span>Subtitles</span></i>
                <i class="fa fa-circle"> &nbsp;&nbsp;&nbsp;<span>Imdb: <b>9.1/10</b></span></i>
            </div>

            <div class="movie-btns">
                <button><i class="fa fa-play"></i> &nbsp; Watch trailer</button>
                <button class="read-more"><i class="fa fa-circle"></i> <i class="fa fa-circle"></i> <i
                        class="fa fa-circle"></i>&nbsp; Read more
                </button>
            </div>

        </div>

    </div>
    <!---slider--->

</header>

<section>

    <div class="movie-ticket-book">
        <div class="choose-date">
            <p class="heading">
                choose date:
            </p>
            <div class="wrapper">
                <div class="carousel owl-carousel">

                    <div class="card card-1">
                        <p>JUN 1t</p>
                        <p>MON</p>
                    </div>
                    <div class="card card-2">
                        <p>JUN 2nd</p>
                        <p>TUE</p>
                    </div>
                    <div class="card card-3">
                        <p>JUN 3nd</p>
                        <p>wed</p>
                    </div>
                    <div class="card card-4">
                        <p>JUN 4nd</p>
                        <p>thu</p>
                    </div>
                </div>
                <div class="marker"></div>
            </div>
        </div>
        <div class="choose-time">
            <p class="heading">
                avalible times:
            </p>
            <div class="wrapper">
                <div class="carousel owl-carousel">

                    <div class="card card-1">
                        <p>3D</p>
                        <p>14:45</p>
                    </div>
                    <div class="card card-2">
                        <p>3D</p>
                        <p>11:45</p>
                    </div>
                    <div class="card card-3">
                        <p>2D</p>
                        <p>12:15</p>
                    </div>
                    <div class="card card-4">
                        <p>3D</p>
                        <p>13:00</p>
                    </div>
                </div>
                <div class="marker"></div>
            </div>
        </div>
        <button>Buy ticket</button>
    </div>
    <!---movie-ticket-book-->


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

<footer>

    <div class="logo-box">
        <p class="logo">
            multi<span>flex</span>
        </p>
        <p><i class="fa fa-copyright"></i> 2001-2017, SIA Multiflex</p>
    </div>

    <ul>
        <li>main</li>
        <li>schedlues</li>
        <li>tickets</li>
        <li>news</li>
        <li>contact</li>
    </ul>


    <div class="socail-box">
        <i class="fa fa-facebook-f"></i>
        <i class="fa fa-twitter"></i>
        <i class="fa fa-instagram"></i>
    </div>

</footer>

</body>
</html>