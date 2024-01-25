<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="layouts/header.jsp"/>

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
                            <small>Available</small>
                        </li>
                        <li>
                            <div class="seat legend selected"></div>
                            <small>Selected</small>
                        </li>
                        <li>
                            <div class="seat legend occupied"></div>
                            <small>Occupied</small>
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
                                <div class="seat occupied"></div>
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
                                <div class="seat occupied"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat occupied"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat occupied"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat occupied"></div>
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
                                <div class="seat occupied"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                                <div class="seat"></div>
                            </div>
                            <div class="row">
                                <div class="seat"></div>
                                <div class="seat occupied"></div>
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
                            <p>MOVIE NAME</p>
                            <h1 id="movieName">${movie.mvTitle}</h1>
                        </div>
                        <div class="moviePrice">
                            <p>MOVIE PRICE</p>
                            <h1 id="moviePrice">15,000</h1>
                        </div>
                        <div class="dateCont">
                            <p>Date</p>
                            <p class="dateOn">Wed , 31th march</p>

                        </div>
                    </div>
                </div>
                <div class="rightBottomCont">
                    <div class="selectedSeatCont">
                        <p>SELECTED SEATS</p>
                        <div class="selectedSeatsHolder" id="selectedSeatsHolder">
                            <span class="noSelected">No Seat Selected</span>
                        </div>
                    </div>
                    <!-- Seat number and price -->

                    <div class="numberOfSeatsCont">
                        <div class="numberOfSeatEl">
                            <p><span id="numberOfSeat">0</span> Seats(s)</p>
                        </div>
                        <div class="priceCont">
                            <p id="totalPrice">$ 0</p>
                        </div>
                    </div>
                    <!-- button Cont -->

                    <div class="buttonCont">
                        <div class="cancelBtn">
                            <button id="cancelBtn">Cancel</button>
                        </div>
                        <div class="proceedBtnEl">
                            <button id="proceedBtn">Continue</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="layouts/footer.jsp"/>

<script>
    $(() => {

        const allSeatCont = $("#seatCont .seat");

        const selectedSeatsHolderEl = $("#selectedSeatsHolder");

        const moviePriceEl = $("#moviePrice");

        const cancelBtnEL = $("#cancelBtn");

        const proceedBtnEl = $("#proceedBtn");

        const seatContEl = $("#seatCont .seat:not(.occupied)");

        let moviePrice = 1300;
        let currentMovieName = `Tom and Jerry 2021`;

        // 각 좌석에 번호 매기기
        let initialSeatValue = 0;
        $(allSeatCont).each(function (){
            $(this).attr("data-seatid", ++initialSeatValue)
        });

        // 점유된 좌석 리스트에 넣기(좌석 클릭 이벤트)
        let takenSeats = [];

        $(seatContEl).each(function() {
            $(this).click(function(e) {
                let isSelected = $(this).hasClass("selected");
                let seatId = $(this).data("seatid");

                if (!isSelected) {
                    $(this).addClass("selected");
                    takenSeats.push(seatId);
                    takenSeats = [...new Set(takenSeats)]; // 중복 제거
                } else if (isSelected) {
                    $(this).removeClass("selected");
                    takenSeats = takenSeats.filter(function(id) {
                        return id !== seatId;
                    });
                };

                updateSeats();
                updatePrice(moviePrice, takenSeats.length);
            });
        });

        // 좌석 html 업데이트
        function updateSeats() {
            $(selectedSeatsHolderEl).empty();

            if(takenSeats.length > 0) {
                $(takenSeats).each((seat) => {
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
            moviePriceEl.html(`${"${price}"}원`)
        }

        function AddComma(num) {
            var regexp = /\B(?=(\d{3})+(?!\d))/g;
            return num.toString().replace(regexp, ',');
        }

        function removeComma(str) {
            n = parseInt(str.replace(/,/g,""));
            return n;
        }

        function numberWithCommas(x) {
            x = x.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
            x = x.replace(/,/g,'');          // ,값 공백처리
            $('input[name="so_use_point"]').val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가
        }

        //취소 버튼 구현
        $(cancelBtnEL).click(()=> {
            cancelSeats();
        });

        function cancelSeats() {
            takenSeats = [];
            $(seatContEl).each(function (){
                $(this).removeClass("selected");
            });
            updatePrice(0, 0);
            updateSeats();
        };

        // 성공 하면 티켓 발행하는 ajax 구현
        $(proceedBtnEl).click(()=>{
            console.log(takenSeats);
        });

    });

</script>