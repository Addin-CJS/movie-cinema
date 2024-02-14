<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<div class="chooseInfo">
    <div class="stepWrapper">
        <!-- Step 1 -->
        <div class="step" id="step1">
            <h4>STEP1<br>지역/영화관 선택</h4>
            <div class="chooseRegion">
            </div>
            <div class="chooseTheater">
            </div>
        </div>

        <!-- Step 2 -->
        <div class="step" id="step2">
            <h4>STEP2<br>날짜 선택</h4>
            <div class="chooseDate">
                <div class="datepicker"></div>
            </div>
        </div>

        <!-- Step 3 -->
        <div class="step" id="step3">
            <h4>STEP3<br>시간 선택</h4>
            <div>
                <div class="chooseTime"></div>
            </div>
        </div>

        <!-- Step 4 -->
        <div class="step" id="step4">
            <h4>STEP4<br>좌석 선택</h4>
            <div>
                <div class="chooseSeat">
                    <sec:authorize access="isAuthenticated()">
                        <button class="seatBtn" type="button" onclick="selectSeat()">좌석선택하기</button>
                    </sec:authorize>
                    <sec:authorize access="isAnonymous()">
                        <button class="off-btns" type="button" onclick="location.href='/member/login'">로그인 해주세요</button>
                    </sec:authorize>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $.ajax({
            url: '/region',
            type: 'GET',
            success: function(response) {
                displayRegions(response);
            },
            error: function() {
                console.error('지역 조회 ajax통신 실패');
            }
        });

        $('.chooseRegion').on('click', 'button', function() {
            $('.chooseRegion button').removeClass('selected');
            $(this).addClass('selected');

            var selectedRegionId = $(this).data('region-id');
            var selectedRegionName = $(this).text();
            localStorage.setItem("selectedRegion", selectedRegionName);
            loadTheaters(selectedRegionId);
        });
        $('.chooseTheater').on('click', 'button', function() {
            $('.chooseTheater button').removeClass('selected');
            $(this).addClass('selected');

            var selectedTheaterName = $(this).text();
            localStorage.setItem("selectedTheater", selectedTheaterName);
        });
        $('.datepicker').datepicker({
            dateFormat: 'yy-mm-dd',
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
            dayNames: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
            showMonthAfterYear: true,
            yearSuffix: '년',
            minDate: 0, // 오늘 날짜를 최소 선택 가능 날짜로 설정
            onSelect: function(dateText) {
                localStorage.setItem("selectedDate", dateText);
            }
        });

        var timeList = createTimeList();
        var timeContainer = $('.chooseTime');
        timeContainer.empty();

        timeList.forEach(function(time) {
            var timeOption = $('<div>', {
                'class': 'time-option',
                'text': time,
                'click': function() {
                    localStorage.setItem("selectedTime", time);

                    $('.time-option').removeClass('selected');
                    $(this).addClass('selected');
                }
            });
            timeContainer.append(timeOption);
        });
        updateSelectedState();
    });

    function displayRegions(regions) {
        var regionList = $('.chooseRegion');
        regionList.empty();

        regions.forEach(function(region) {
            var button = $('<button class="region-btn" data-region-id="' + region.regionId + '">' + region.regionName + '</button>');
            regionList.append(button);
        });
    }

    function loadTheaters(regionId) {
        $.ajax({
            url: '/theater?regionId=' + regionId,
            type: 'GET',
            success: function(response) {
                displayTheaters(response);
            },
            error: function() {
                console.error('영화관 조회 ajax통신 실패');
            }
        });
    }

    function displayTheaters(theaters) {
        var theaterList = $('.chooseTheater');
        theaterList.empty();

        theaters.forEach(function(theater) {
            var button = $('<button class="theater-btn" data-theater-id="' + theater.theaterId + '">' + theater.theaterName + '</button>');
            theaterList.append(button);
        });
    }

    // 시간대 생성
    function createTimeList() {
        const times = [];
        const now = new Date();
        let currentHour = now.getHours();
        let currentMinutes = now.getMinutes();

        if (currentMinutes >= 30) {
            currentMinutes = 30;
        } else {
            currentMinutes = 0;
        }

        // 30분 단위로 24시간을 배열
        for (let i = 0; i < 48; i++) {
            const formattedTime = `${"${currentHour.toString().padStart(2, '0')}"}:${"${currentMinutes.toString().padStart(2, '0')}"}`;
            times.push(formattedTime);

            if (currentMinutes === 30) {
                currentHour++;
                currentMinutes = 0;
            } else {
                currentMinutes = 30;
            }

            // 24시간을 초과하는 경우에 대한 처리
            if (currentHour >= 24) {
                currentHour -= 24;
            }
        }
        return times;
    }

    var timeList = createTimeList();
    var timeDropdown = $('.chooseTime');

    timeList.forEach(function(time) {
        var option = $('<option>' + time + '</option>');
        timeDropdown.append(option);
    });


    function updateSelectedState() {
        let selectedRegion = localStorage.getItem("selectedRegion");
        let selectedTheater = localStorage.getItem("selectedTheater");
        let selectedDate = localStorage.getItem("selectedDate");
        let selectedTime = localStorage.getItem("selectedTime");

        $('.chooseRegion option').each(function () {
            if($(this).text() == selectedRegion) {
                $(this).prop('selected', true).parent().addClass('on');
            }
        });
        $('.chooseTheater option').each(function () {
            if($(this).text() == selectedTheater) {
                $(this).prop('selected', true).parent().addClass('on');
            }
        });
        $('.chooseDate option').each(function () {
            if($(this).text() == selectedDate) {
                $(this).prop('selected', true).parent().addClass('on');
            }
        });
        $('.chooseTime option').each(function () {
            if($(this).text() == selectedTime) {
                $(this).prop('selected', true).parent().addClass('on');
            }
        });
    }

    function selectSeat() {
        if (!localStorage.getItem("selectedTime")) {
            alert("시간을 선택해주세요");
            return;
        }
        if (!localStorage.getItem("selectedDate")) {
            alert("일자를 선택해주세요");
            return;
        }
        if (!localStorage.getItem("selectedTheater")) {
            alert("영화관을 선택해주세요");
            return;
        }
        location.href = 'movieSeats?movieId=${movie.movieId}';
    }

</script>