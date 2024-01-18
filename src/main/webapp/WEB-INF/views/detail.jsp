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
       <jsp:include page="layouts/header.jsp" />
    </header>
    <section>
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
    </section>
</body>
</html>