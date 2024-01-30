<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/style.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<html>
<head>
    <title>Ticketing</title>
</head>
<body>
<section id="section">
    <div id="test"></div>
    <div class="container">
        <div class="confirmCont">
            <div class="rightTopCont">
                <!-- moviename -->

                <div class="movieInfo">
                    <div class="movieName">
                        <p>영화 제목</p>
                        <h1 id="movieName">${movie.mvTitle}</h1>
                    </div>
                    <div class="moviePrice">
                        <p>영화 가격</p>
                        <h1 id="moviePrice">1,300원</h1>
                    </div>
                    <div class="dateCont">
                        <p>상영 일자</p>
                        <p id="dateOn" class="dateOn">Wed , 31th march</p>
                    </div>
                </div>
            </div>
            <div class="rightBottomCont">
                <div class="selectedSeatCont">
                    <p>선택 좌석</p>
                    <div class="selectedSeatsHolder" id="selectedSeatsHolder">
                    </div>
                </div>
                <!-- Seat number and price -->

                <div class="numberOfSeatsCont">
                    <div class="numberOfSeatEl">
                        <p>선택 좌석 수 : <span id="numberOfSeat">0</span></p>
                    </div>
                    <div class="priceCont">
                        <p id="totalPrice">0원</p>
                    </div>
                </div>
                <!-- button Cont -->

                <div class="buttonCont">
                    <div class="cancelBtn">
                        <button id="cancelBtn">취소</button>
                    </div>
                    <div class="proceedBtnEl">
                        <button id="proceedBtn">결제하기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>

<script>
    // function redirectParent() {
    //     if (window.opener) {
    //         window.opener.location.href = 'http://localhost:8080/movieHome';
    //     }
    // }
    $(() => {
        const selectedSeatsHolderEl = $("#selectedSeatsHolder");
        const moviePrice = 1300;

        // 점유된 좌석 리스트에 넣기(좌석 클릭 이벤트)
        let takenSeats = JSON.parse(localStorage.getItem("takenSeats"));

        $(takenSeats).each((idx, seat) => {
            $('<div></div>')
                .addClass("selectedSeat")
                .text(seat)
                .appendTo(selectedSeatsHolderEl);
        });

        // 가격 업데이트
        updatePrice(moviePrice, takenSeats.length);

        function updatePrice(price, seats) {
            const totalPriceEl = $("#totalPrice");
            let total = seats * price;
            localStorage.setItem("ticketedPrice",total);
            total = AddComma(total);
            price = AddComma(price);
            totalPriceEl.html(`${"${total}"}원`);
        }

        function AddComma(num) {
            var regexp = /\B(?=(\d{3})+(?!\d))/g;
            return num.toString().replace(regexp, ',');
        }

        // 좌석 수 업데이트
        $("#numberOfSeat").text(takenSeats.length);

        // 취소 버튼
        $("#cancelBtn").click(()=>{
            window.close();
        });

        // 결제하기
        $("#proceedBtn").click(() => {
            $.ajax({
                url: "ticketing",
                type: "POST",
                data: {
                    takenSeats: localStorage.getItem("takenSeats"),
                    selectedTime: localStorage.getItem("selectedTime"),
                    selectedDate: localStorage.getItem("selectedDate"),
                    ticketPrice: localStorage.getItem("ticketedPrice"),
                    movieId: ${movie.movieId}
                },
                success: function (response) {
                    alert("성공");

                },
                error: function (xhr, status, error) {
                    alert(status, error, xhr);
                }
            });
        });

        // 일자 업데이트
        let dateOn = $("#dateOn");
        function updateDate(){
            dateOn.text(localStorage.getItem("selectedDate")+" "+localStorage.getItem("selectedTime"));
        };
        updateDate();

    });
</script>
</html>
