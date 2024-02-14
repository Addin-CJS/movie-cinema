<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../layouts/header.jsp"/>

<section id="section">
    <div id="test"></div>
    <div class="container">
        <!-- leftCont -->
        <div class="leftCont">
            <div class="leftMainCont">
                <div class="legendContainer">
                    <ul>
                        <li>
                            <div class="seat legend"></div>
                            <small>선택가능</small>
                        </li>
                        <li>
                            <div class="seat legend selected"></div>
                            <small>선택좌석</small>
                        </li>
                        <li>
                            <div class="seat legend occupied"></div>
                            <small>예매완료</small>
                        </li>
                    </ul>
                </div>
                <!-- seat Container -->
                <div class="mainSeatCont">
                    <div class="screen">
                        <small>SCREEN</small>
                    </div>
                    <div class="seatCont" id="seatCont">
                        <div class="seatRowCont1 seatRowCont">
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                        </div>
                        <div class="seatRowCont2 seatRowCont">
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                        </div>
                        <div class="seatRowCont3 seatRowCont">
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Right Cont -->
        <div class="rightCont">
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
                            <p id="dateOn" class="dateOn"></p>
                        </div>
                    </div>
                </div>
                <div class="rightBottomCont">
                    <div class="selectedSeatCont">
                        <p>선택 좌석</p>
                        <div class="selectedSeatsHolder" id="selectedSeatsHolder">
                            <span class="noSelected">No Seat Selected</span>
                        </div>
                    </div>
                    <!-- Seat number and price -->

                    <div class="numberOfSeatsCont">
                        <div class="numberOfSeatEl">
                            <p>선택 좌석 수 : <span id="numberOfSeat">0</span></p>
                        </div>
                        <div class="priceCont">
                            <p id="totalPrice">0 원</p>
                        </div>
                    </div>
                    <!-- button Cont -->

                    <div class="buttonCont">
                        <div class="cancelBtn">
                            <button id="cancelBtn">선택취소</button>
                        </div>
                        <div class="proceedBtnEl">
                            <button id="proceedBtn">결제하기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="../layouts/footer.jsp"/>

<script>

    $(function (){
        const allSeatCont = $("#seatCont .seat");
        const allSeatRows = $("#seatCont .row");
        const selectedSeatsHolderEl = $("#selectedSeatsHolder");
        const moviePriceEl = $("#moviePrice");
        const cancelBtnEL = $("#cancelBtn");
        const proceedBtnEl = $("#proceedBtn");
        const seatContEl = $("#seatCont .seat:not(.occupied)");
        const moviePrice = 1300;

        // 각 좌석에 번호 매기기
        let initialSeatValue = 0;
        $(allSeatCont).each(function () {
            $(this).attr("data-seatid", ++initialSeatValue)
        });

        // 점유된 좌석 리스트에 넣기(좌석 클릭 이벤트)
        let takenSeats = [];

        $(seatContEl).each(function () {
            $(this).click(function (e) {
                let isSelected = $(this).hasClass("selected");
                let seatId = $(this).data("seatid");

                if (!isSelected) {
                    $(this).addClass("selected");
                    takenSeats.push(seatId);
                    takenSeats = [...new Set(takenSeats)]; // 중복 제거
                } else if (isSelected) {
                    $(this).removeClass("selected");
                    takenSeats = takenSeats.filter(function (id) {
                        return id !== seatId;
                    }); // 클릭된 좌석을 list에서 빼기
                }
                ;
                updateSeats();
                updatePrice(moviePrice, takenSeats.length);
            });
        });

        // 일자 업데이트
        let dateOn = $("#dateOn");

        function updateDate() {
            dateOn.text(localStorage.getItem("selectedDate") + " " + localStorage.getItem("selectedTime"));
        };
        updateDate();

        // 오른쪽 좌석 html 업데이트
        function updateSeats() {
            $(selectedSeatsHolderEl).empty();

            if (takenSeats.length > 0) {
                $(takenSeats).each((idx, seat) => {
                    $('<div></div>')
                        .addClass("selectedSeat")
                        .text(seat)
                        .appendTo(selectedSeatsHolderEl);
                });
            } else {
                $('<span></span>')
                    .addClass("noSelected")
                    .text("NO SEAT SELECTED")
                    .appendTo(selectedSeatsHolderEl);
            }
            seatCount();
        }

        function seatCount() {
            const numberOfSeatEl = $("#numberOfSeat");
            $(numberOfSeatEl).html(takenSeats.length);
        }

        function updatePrice(price, seats) {
            const totalPriceEl = $("#totalPrice");
            let total = seats * price;
            total = AddComma(total);
            price = AddComma(price);
            totalPriceEl.html(`${"${total}"}원`);
            moviePriceEl.html(`${"${price}"}원`);
        }

        function AddComma(num) {
            var regexp = /\B(?=(\d{3})+(?!\d))/g;
            return num.toString().replace(regexp, ',');
        }

        function removeComma(str) {
            n = parseInt(str.replace(/,/g, ""));
            return n;
        }

        function numberWithCommas(x) {
            x = x.replace(/[^0-9]/g, '');   // 입력값이 숫자가 아니면 공백
            x = x.replace(/,/g, '');          // ,값 공백처리
            $('input[name="so_use_point"]').val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가
        }

        //취소 버튼 구현
        $(cancelBtnEL).click(() => {
            cancelSeats();
        });

        function cancelSeats() {
            takenSeats = [];
            $(seatContEl).each(function () {
                $(this).removeClass("selected");
            });
            updatePrice(0, 0);
            updateSeats();
        };

        // 제출 버튼 이벤트
        $(proceedBtnEl).click(() => {
            localStorage.setItem('takenSeats', JSON.stringify(takenSeats));
            var url = "ticketing?movieId=" + ${movie.movieId};
            var windowFeatures = "width=800,height=516,resizable=no,status=yes";

            // 좌석 선택 안할시 alert
            if (takenSeats.length === 0) {
                alert("좌석을 선택해주세요");
                return;
            }

            window.open(url, "ticketingWindow", windowFeatures);
        });

        // AJAX로 점유된 좌석 가져오기
        $.ajax({
            url: '/api/seats/getTakenSeats',
            type: 'GET',
            data: {
                movieId: ${movie.movieId},
                theaterId: localStorage.getItem("selectedTheaterId"),
                selectedDate: localStorage.getItem("selectedDate"),
                selectedTime: localStorage.getItem("selectedTime")
            },
            success: function (reservedSeats) {
                $(seatContEl).each(function () {
                    let seatId = $(this).data("seatid");
                    if (reservedSeats.includes(seatId)) {
                        $(this).addClass("occupied").off('click');
                    }
                });
            },
            error: function (error) {
                console.error('Error:', error);
            }
        });
    });

</script>